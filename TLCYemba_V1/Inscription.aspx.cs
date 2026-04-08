using System;
using TLCYemba.BLL;

namespace TLCYemba
{
    public partial class Inscription : System.Web.UI.Page
    {
        private readonly AuthService _auth = new AuthService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Si deja connecte, aller au profil
            if (_auth.EstConnecte(Session))
                Response.Redirect("Dashboard.aspx");
        }

        protected void btnInscrire_Click(object sender, EventArgs e)
        {
            string erreur = _auth.Inscrire(
                txtNom.Text.Trim(),
                txtPrenom.Text.Trim(),
                txtEmail.Text.Trim(),
                txtMdp.Text,
                txtMdpConfirm.Text);

            if (!string.IsNullOrEmpty(erreur))
            {
                litErreur.Text    = erreur;
                pnlErreur.Visible = true;
                return;
            }

            // Inscription OK -> rediriger vers la connexion
            Response.Redirect("Connexion.aspx?inscrit=1");
        }
    }
}
