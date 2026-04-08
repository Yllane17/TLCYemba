using System;
using TLCYemba.BLL;

namespace TLCYemba
{
    public partial class NouveauMotDePasse : System.Web.UI.Page
    {
        private readonly AuthService _auth = new AuthService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Securite : les deux etapes precedentes doivent etre completes
            if (Session["ResetEmail"] == null || Session["ResetCode"] == null)
                Response.Redirect("MotDePasseOublie.aspx");
        }

        protected void btnEnregistrer_Click(object sender, EventArgs e)
        {
            string email   = Session["ResetEmail"].ToString();
            string code    = Session["ResetCode"].ToString();

            string erreur = _auth.ResetMotDePasse(
                email, code, txtMdp.Text, txtConfirm.Text);

            if (!string.IsNullOrEmpty(erreur))
            {
                litErreur.Text    = erreur;
                pnlErreur.Visible = true;
                return;
            }

            // Nettoyer la session de reset
            Session.Remove("ResetEmail");
            Session.Remove("ResetCode");

            // Rediriger vers connexion avec message de succes
            Response.Redirect("Connexion.aspx?reset=1");
        }
    }
}
