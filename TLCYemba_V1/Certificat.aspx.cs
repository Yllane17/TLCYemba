using System;
using TLCYemba.BLL;
using TLCYemba.DAL;
using TLCYemba.Models;

namespace TLCYemba
{
    public partial class Certificat : System.Web.UI.Page
    {
        private readonly HistoriqueService _svc = new HistoriqueService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) ChargerCertificat();
        }

        private void ChargerCertificat()
        {
            Resultats r = null;

            // Depuis QueryString (Historique) ou Session (apres le test)
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                int id;
                if (int.TryParse(Request.QueryString["id"], out id))
                    r = new HistoriqueRepository().GetById(id);
            }
            else if (Session["DernierResultatID"] != null)
            {
                r = _svc.GetDernierResultat(Session);
            }

            if (r == null) { Response.Redirect("Historique.aspx"); return; }

            // Nom du candidat (depuis session ou anonyme)
            string nom = Session["NomCandidat"] != null
                ? Session["NomCandidat"].ToString()
                : "Candidat TLC N° " + r.UtilisateurID;

            litNomCandidat.Text   = nom;
            litTypeTestCert.Text  = GetLibelle(r.TypeTest);
            litDateCert.Text      = r.DateTest.ToString("dd MMMM yyyy");
            litDateFooter.Text    = r.DateTest.ToString("dd/MM/yyyy");
            litScoreCert.Text     = r.ScoreTotal.ToString();
            litNiveauCert.Text    = r.Niveau;
            litIdCert.Text        = r.ResultatID.ToString("D6");

            // Sections scores
            litScoreLCert.Text = r.ScoreListening.ToString();
            litScoreSCert.Text = r.ScoreStructure.ToString();
            litScoreRCert.Text = r.ScoreReading.ToString();

            // Masquer les sections inutilisees pour les tests partiels
            pnlScoreL.Visible = (r.TypeTest == "Listening" || r.TypeTest == "FullTest");
            pnlScoreS.Visible = (r.TypeTest == "Structure" || r.TypeTest == "FullTest");
            pnlScoreR.Visible = (r.TypeTest == "Reading"   || r.TypeTest == "FullTest");

            // Couleur niveau
            string couleur = GetCouleur(r.Niveau);
            pnlNiveauCert.Style["color"]        = couleur;
            pnlNiveauCert.Style["border-color"] = couleur + "66";
            pnlNiveauCert.Style["background"]   = couleur + "14";
        }

        private string GetLibelle(string type)
        {
            switch (type)
            {
                case "Listening": return "Test Listening &#8212; Comprehension Orale";
                case "Structure": return "Test Structure &#8212; Grammaire";
                case "Reading":   return "Test Reading &#8212; Comprehension Ecrite";
                default:          return "Test Complet TLC Yemba";
            }
        }

        private string GetCouleur(string n)
        {
            switch (n)
            {
                case "Courant":       return "#3AAFA9";
                case "Avance":        return "#38A169";
                case "Intermediaire": return "#D69E2E";
                case "Elementaire":   return "#DD6B20";
                default:              return "#E53E3E";
            }
        }
    }
}

// Note : HistoriqueRepository est dans le namespace TLCYemba.DAL
// Cet acces direct depuis UI est acceptable UNIQUEMENT pour GetById appele ici.
// Dans une version plus stricte, passer par HistoriqueService.
