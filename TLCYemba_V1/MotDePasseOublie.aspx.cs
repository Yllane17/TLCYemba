using System;
using TLCYemba.BLL;

namespace TLCYemba
{
    public partial class MotDePasseOublie : System.Web.UI.Page
    {
        private readonly AuthService _auth = new AuthService();

        protected void Page_Load(object sender, EventArgs e) {}

        protected void btnEnvoyer_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            // Valider format
            if (string.IsNullOrWhiteSpace(email))
            {
                litErreur.Text = "Veuillez saisir votre adresse email.";
                pnlErreur.Visible = true; return;
            }
            // Appel BLL (message neutre même si email inconnu)
            _auth.EnvoyerCodeReset(email);
            Session["ResetEmail"] = email;

            pnlForm.Visible    = false;
            pnlSucces.Visible  = true;
            pnlSuite.Visible   = true;
        }

        protected void btnVersCode_Click(object sender, EventArgs e)
            => Response.Redirect("VerificationCode.aspx");
    }
}
