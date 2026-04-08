using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;
using TLCYemba.DAL;
using TLCYemba.Models;

namespace TLCYemba.BLL
{
    /// <summary>
    /// Service BLL : calcul du score TLC, persistance, niveaux.
    /// Ne contient aucun acces direct a la base de donnees.
    /// Toutes les operations BDD passent par les repositories DAL.
    /// </summary>
    public class ScoreService
    {
        private readonly ResultatRepository  _resultRepo  = new ResultatRepository();
        private readonly ReponseRepository   _repRepo     = new ReponseRepository();
        private readonly QuestionRepository  _qRepo       = new QuestionRepository();

        // ── Grille de conversion TLC (inspiree TOEFL ITP) ──────
        // Formule simplifiee : score_converti = 31 + (brut / total) * plage
        private const int PLAGE_LISTENING = 37;  // 31 a 68
        private const int PLAGE_STRUCTURE = 37;  // 31 a 68
        private const int PLAGE_READING   = 36;  // 31 a 67
        private const int BASE_SECTION    = 31;

        // ── Seuils de niveau ────────────────────────────────────
        // Score total max = 677
        private static readonly (int Min, int Max, string Niveau, string Couleur)[] Niveaux =
        {
            (310, 397, "Debutant",       "#E53E3E"),
            (398, 467, "Elementaire",    "#DD6B20"),
            (468, 527, "Intermediaire",  "#D69E2E"),
            (528, 587, "Avance",         "#38A169"),
            (588, 677, "Courant",        "#3AAFA9"),
        };

        // ────────────────────────────────────────────────────────
        /// <summary>
        /// Calcule le score, persiste en BDD, retourne ScoreResult.
        /// </summary>
        public ScoreResult CalculerEtPersister(HttpSessionState session)
        {
            if (session == null) throw new ArgumentNullException("session");

            string typeTest  = session["TypeTest"]?.ToString() ?? "Listening";
            int    nbQ       = session["NbQuestions"] != null ? (int)session["NbQuestions"] : 0;
            var    reponses  = session["Reponses"] as Dictionary<int, string>
                               ?? new Dictionary<int, string>();

            // 1. Charger toutes les questions dans l'ordre
            var questions = new List<Question>();
            if (typeTest == "FullTest")
            {
                questions.AddRange(_qRepo.GetBySection("Listening", nbQ));
                questions.AddRange(_qRepo.GetBySection("Structure", nbQ));
                questions.AddRange(_qRepo.GetBySection("Reading", nbQ));
            }
            else
            {
                questions.AddRange(_qRepo.GetBySection(typeTest, nbQ));
            }

            // 2. Compter bruts par section
            int brutL = 0, brutS = 0, brutR = 0;
            int totalL = 0, totalS = 0, totalR = 0;

            var detailReponses = new List<Reponse>();

            for (int i = 0; i < questions.Count; i++)
            {
                var q = questions[i];
                string repDonnee = reponses.ContainsKey(i) ? reponses[i] : "";
                bool   correct   = !string.IsNullOrEmpty(repDonnee) &&
                                   repDonnee.Equals(q.BonneReponse,
                                       StringComparison.OrdinalIgnoreCase);

                detailReponses.Add(new Reponse
                {
                    QuestionID    = q.QuestionID,
                    ReponseDonnee = repDonnee,
                    EstCorrecte   = correct
                });

                switch (q.Section)
                {
                    case "Listening": totalL++; if (correct) brutL++; break;
                    case "Structure": totalS++; if (correct) brutS++; break;
                    case "Reading":   totalR++; if (correct) brutR++; break;
                }
            }

            // 3. Convertir en scores TLC
            int scL = ConvertirScore(brutL, totalL > 0 ? totalL : 50, PLAGE_LISTENING);
            int scS = ConvertirScore(brutS, totalS > 0 ? totalS : 40, PLAGE_STRUCTURE);
            int scR = ConvertirScore(brutR, totalR > 0 ? totalR : 50, PLAGE_READING);

            // Pour les tests sections uniques, multiplier pour avoir
            // un score total representatif
            int scTotal;
            switch (typeTest)
            {
                case "Listening": scTotal = scL * 3 + 100; break;
                case "Structure": scTotal = scS * 3 + 100; break;
                case "Reading":   scTotal = scR * 3 + 100; break;
                default:          scTotal = scL + scS + scR; break; // FullTest
            }

            // Clamper dans les bornes
            scTotal = Math.Max(310, Math.Min(677, scTotal));

            // 4. Determiner le niveau
            string niveau  = "Debutant";
            string couleur = "#E53E3E";
            foreach (var n in Niveaux)
            {
                if (scTotal >= n.Min && scTotal <= n.Max)
                { niveau = n.Niveau; couleur = n.Couleur; break; }
            }

            // 5. Persister en BDD
            int uid = session["UtilisateurID"] != null ? (int)session["UtilisateurID"] : 0;

            var resultat = new Resultats
            {
                UtilisateurID  = uid,
                TypeTest       = typeTest,
                ScoreListening = scL,
                ScoreStructure = scS,
                ScoreReading   = scR,
                ScoreTotal     = scTotal,
                Niveau         = niveau,
                DateTest       = DateTime.Now
            };

            int resultatId = _resultRepo.InsererResultat(resultat);

            // 6. Persister les reponses detaillees
            detailReponses.ForEach(r => r.ResultatID = resultatId);
            _repRepo.InsererReponses(detailReponses);

            // 7. Sauvegarder en session pour Partie 5
            session["DernierResultatID"] = resultatId;
            session["DernierScore"]      = scTotal;

            // Calcul pourcentage
            int total = (totalL + totalS + totalR);
            int bruts = brutL + brutS + brutR;
            int pct   = total > 0 ? (int)Math.Round((double)bruts / total * 100) : 0;

            return new ScoreResult
            {
                BrutListening    = brutL,
                BrutStructure    = brutS,
                BrutReading      = brutR,
                ScoreListening   = scL,
                ScoreStructure   = scS,
                ScoreReading     = scR,
                ScoreTotal       = scTotal,
                Niveau           = niveau,
                CouleurNiveau    = couleur,
                TypeTest         = typeTest,
                PourcentageGlobal = pct
            };
        }

        // ── Helpers prive ────────────────────────────────────────
        private int ConvertirScore(int brut, int total, int plage)
        {
            if (total == 0) return BASE_SECTION;
            double ratio = (double)brut / total;
            return BASE_SECTION + (int)Math.Round(ratio * plage);
        }
    }
}
