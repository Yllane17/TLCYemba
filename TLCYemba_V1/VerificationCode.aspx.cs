using System;
using TLCYemba.BLL;

namespace TLCYemba
{
    public partial class VerificationCode : System.Web.UI.Page
    {
        private readonly AuthService _auth = new AuthService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ResetEmail"] == null)
            { Response.Redirect("MotDePasseOublie.aspx"); return; }
            if (!IsPostBack)
                litEmail.Text = Session["ResetEmail"].ToString();
        }

        protected void btnVerifier_Click(object sender, EventArgs e)
        {
            string email = Session["ResetEmail"]?.ToString() ?? "";
            string code  = hfCode.Value.Trim();

            if (code.Length != 6)
            {
                litErreur.Text = "Veuillez saisir les 6 chiffres du code.";
                pnlErreur.Visible = true; return;
            }
            if (!_auth.VerifierCodeReset(email, code))
            {
                litErreur.Text = "Code incorrect ou expire. Veuillez reessayer ou demander un nouveau code.";
                pnlErreur.Visible = true; return;
            }
            // Code valide : sauvegarder en session et passer a l'etape 3
            Session["ResetCode"] = code;
            Response.Redirect("NouveauMotDePasse.aspx");
        }

        protected void lbRenvoyer_Click(object sender, EventArgs e)
        {
            string email = Session["ResetEmail"]?.ToString() ?? "";
            _auth.EnvoyerCodeReset(email);
            litErreur.Text = "Un nouveau code a ete envoye a votre adresse email.";
            pnlErreur.CssClass = "alert alert-success";
            pnlErreur.Visible  = true;
        }
    }
}
