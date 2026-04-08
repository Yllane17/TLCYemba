using System;
using TLCYemba.BLL;
using TLCYemba.Models;

namespace TLCYemba
{
    /// <summary>
    /// Page de correction automatique et affichage des resultats.
    /// Couche UI : appelle uniquement la BLL.
    /// </summary>
    public partial class Resultat : System.Web.UI.Page
    {
        private readonly ScoreService _scoreService = new ScoreService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Securite : verifier que le test a bien ete passe
            if (Session["TypeTest"] == null || Session["Reponses"] == null)
            {
                Response.Redirect("ChoixTest.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Calculer, persister, afficher
                ScoreResult score = _scoreService.CalculerEtPersister(Session);
                AfficherResultat(score);
            }
        }

        protected void btnNouveauTest_Click(object sender, EventArgs e)
        {
            // Nettoyer la session (garder DernierResultatID/Score pour Partie 5)
            Session.Remove("Reponses");
            Session.Remove("TypeTest");
            Session.Remove("QuestionActuelle");
            Session.Remove("NbQuestions");
            Session.Remove("DureeMinutes");
            Session.Remove("Sections");
            Response.Redirect("ChoixTest.aspx");
        }

        protected void btnVoirHistorique_Click(object sender, EventArgs e)
        {
            Response.Redirect("Historique.aspx");
        }

        // ── Helpers prive ────────────────────────────────────────
        private void AfficherResultat(ScoreResult s)
        {
            // Score total
            litScoreTotal.Text  = s.ScoreTotal.ToString();
            litNiveau.Text      = s.Niveau;
            litPourcentage.Text = s.PourcentageGlobal.ToString();
            litTypeTest.Text    = GetLibelleTypeTest(s.TypeTest);

            // Couleur niveau
            pnlNiveauBadge.Style["background-color"] = s.CouleurNiveau + "20";
            pnlNiveauBadge.Style["border-color"]     = s.CouleurNiveau + "60";
            pnlNiveauBadge.Style["color"]            = s.CouleurNiveau;

            // Score par section (Listening)
            litScoreL.Text = s.ScoreListening.ToString();
            litBrutL.Text  = s.BrutListening.ToString();
            int pctL = s.BrutListening > 0 ? (int)(s.BrutListening * 100.0 / 50) : 0;
            progressL.Style["width"] = pctL + "%";

            // Score par section (Structure)
            litScoreS.Text = s.ScoreStructure.ToString();
            litBrutS.Text  = s.BrutStructure.ToString();
            int pctS = s.BrutStructure > 0 ? (int)(s.BrutStructure * 100.0 / 40) : 0;
            progressS.Style["width"] = pctS + "%";

            // Score par section (Reading)
            litScoreR.Text = s.ScoreReading.ToString();
            litBrutR.Text  = s.BrutReading.ToString();
            int pctR = s.BrutReading > 0 ? (int)(s.BrutReading * 100.0 / 50) : 0;
            progressR.Style["width"] = pctR + "%";

            // Barre progression globale
            progressGlobal.Style["width"] = s.PourcentageGlobal + "%";

            // Couleur barre selon niveau
            progressGlobal.Style["background"] =
                string.Format("linear-gradient(90deg, {0}, {0}88)", s.CouleurNiveau);

            // Message personnalise
            litMessage.Text = GetMessage(s.Niveau, s.PourcentageGlobal);

            // Date
            litDate.Text = DateTime.Now.ToString("dd/MM/yyyy a HH:mm");
        }

        private string GetLibelleTypeTest(string type)
        {
            switch (type)
            {
                case "Listening": return "Listening - Comprehension Orale";
                case "Structure": return "Structure - Grammaire";
                case "Reading":   return "Reading - Comprehension Ecrite";
                case "FullTest":  return "Test Complet TLC";
                default:          return type;
            }
        }

        private string GetMessage(string niveau, int pct)
        {
            switch (niveau)
            {
                case "Courant":
                    return "Felicitations ! Vous maitrisez la langue Yemba a un niveau exceptionnel.";
                case "Avance":
                    return "Tres bien ! Votre niveau en Yemba est avance. Continuez ainsi !";
                case "Intermediaire":
                    return "Bon travail ! Vous avez un niveau intermediaire solide en Yemba.";
                case "Elementaire":
                    return "Continuez vos efforts ! Vous progressez bien en langue Yemba.";
                default:
                    return "Ne vous decouragez pas ! Continuez a pratiquer la langue Yemba.";
            }
        }
    }
}
