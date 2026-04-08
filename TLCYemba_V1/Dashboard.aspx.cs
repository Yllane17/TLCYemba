using System;
using System.Collections.Generic;
using TLCYemba.BLL;
using TLCYemba.Models;

namespace TLCYemba
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly AuthService       _auth    = new AuthService();
        private readonly HistoriqueService _histo   = new HistoriqueService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) ChargerDashboard();
        }

        protected void btnDeconnecter_Click(object sender, EventArgs e)
        {
            _auth.Deconnecter(Session);
            Response.Redirect("Connexion.aspx");
        }

        private void ChargerDashboard()
        {
            // Nom candidat (connecte ou invite)
            string nom = Session["NomCandidat"]?.ToString() ?? "Invite";
            string[] parts = nom.Split(' ');
            string prenom  = parts[0];
            string initiale= prenom.Length > 0 ? prenom[0].ToString().ToUpper() : "?";

            litInitiale.Text = initiale;
            litNomNav.Text   = nom;
            litPrenom.Text   = prenom;

            // Historique
            var liste = _histo.GetHistorique(Session);
            litNbTests.Text = liste.Count.ToString();

            if (liste.Count > 0)
            {
                // Meilleur score
                int best = 0, total = 0;
                foreach (var r in liste)
                {
                    if (r.ScoreTotal > best) best = r.ScoreTotal;
                    total += r.ScoreTotal;
                }
                litMeilleurScore.Text = best.ToString();
                litScoreMoyen.Text    = (total / liste.Count).ToString();
                litNiveau.Text        = liste[0].Niveau; // tri DESC par date

                // Dernier test
                var dernier = liste[0];
                litDernierScore.Text  = dernier.ScoreTotal.ToString();
                litDernierNiveau.Text = dernier.Niveau;
                litDernierType.Text   = dernier.TypeTest;
                litDernierDate.Text   = dernier.DateTest.ToString("dd/MM/yyyy");

                pnlDernierScore.Visible = true;
                pnlPasDeScore.Visible   = false;
            }
            else
            {
                pnlDernierScore.Visible = false;
                pnlPasDeScore.Visible   = true;
            }
        }
    }
}
