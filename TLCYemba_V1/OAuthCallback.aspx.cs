using System;
using TLCYemba.BLL;
using TLCYemba.Models;

namespace TLCYemba
{
    /// <summary>
    /// Page de callback OAuth2.
    /// Recoit le code d'autorisation depuis Google, GitHub ou Apple
    /// et echange-le contre un token pour identifier l'utilisateur.
    /// </summary>
    public partial class OAuthCallback : System.Web.UI.Page
    {
        private readonly OAuthService  _oauth = new OAuthService();
        private readonly AuthService   _auth  = new AuthService();

        protected void Page_Load(object sender, EventArgs e)
        {
            string provider = Request.QueryString["provider"] ?? "";
            string code     = Request.QueryString["code"]     ?? "";
            string state    = Request.QueryString["state"]    ?? "";
            string idToken  = Request.Form["id_token"]        ?? "";  // Apple (form_post)
            string userJson = Request.Form["user"]            ?? "";  // Apple (premier login)
            string error    = Request.QueryString["error"]    ?? "";

            litMessage.Text = "<p>Connexion en cours, veuillez patienter...</p>";

            // Verifier le state CSRF
            string sessionState = Session["OAuthState"]?.ToString() ?? "";
            if (!string.IsNullOrEmpty(sessionState) &&
                !string.IsNullOrEmpty(state)       &&
                state != sessionState)
            {
                litMessage.Text = "<p style='color:#C53030'>Erreur de securite. Veuillez reessayer.</p>";
                return;
            }

            if (!string.IsNullOrEmpty(error))
            {
                litMessage.Text = "<p style='color:#C53030'>Connexion annulee.</p>";
                Response.Redirect("Connexion.aspx"); return;
            }

            try
            {
                Utilisateur u = null;

                switch (provider.ToLower())
                {
                    case "google":
                        if (string.IsNullOrEmpty(code)) goto case "_error";
                        u = _oauth.HandleGoogleCallback(code);
                        break;
                    case "github":
                        if (string.IsNullOrEmpty(code)) goto case "_error";
                        u = _oauth.HandleGitHubCallback(code);
                        break;
                    case "apple":
                        if (string.IsNullOrEmpty(idToken)) goto case "_error";
                        u = _oauth.HandleAppleCallback(idToken, userJson);
                        break;
                    case "_error":
                    default:
                        litMessage.Text = "<p style='color:#C53030'>Provider OAuth non reconnu.</p>";
                        return;
                }

                if (u != null)
                {
                    _auth.ConnecterOAuth(Session, u);
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    litMessage.Text = "<p style='color:#C53030'>Impossible de vous identifier. Reessayez.</p>";
                    Response.Redirect("Connexion.aspx");
                }
            }
            catch (Exception ex)
            {
                // En dev : afficher l'erreur. En prod : logger seulement.
                litMessage.Text = string.Format(
                    "<p style='color:#C53030'>Erreur OAuth : {0}</p>", ex.Message);
            }
        }
    }
}
