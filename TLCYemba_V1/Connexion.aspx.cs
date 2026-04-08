using System;
using TLCYemba.BLL;

namespace TLCYemba
{
    public partial class Connexion : System.Web.UI.Page
    {
        private readonly AuthService  _auth  = new AuthService();
        private readonly OAuthService _oauth = new OAuthService();

        // Identifiants admin — jamais visibles par l'utilisateur
        private const string ADMIN_EMAIL = "yougo@gmail.com";
        private const string ADMIN_PASS  = "yougo19";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Deja connecte comme admin
            if (Session["IsAdmin"] != null && (bool)Session["IsAdmin"])
            { Response.Redirect("AdminDashboard.aspx"); return; }

            // Deja connecte comme utilisateur
            if (_auth.EstConnecte(Session))
            { Response.Redirect("Dashboard.aspx"); return; }

            if (!IsPostBack)
            {
                if (Request.QueryString["inscrit"] == "1") pnlSucces.Visible = true;
                if (Request.QueryString["reset"]   == "1") pnlReset.Visible  = true;

                // URLs OAuth avec state anti-CSRF
                string state = Guid.NewGuid().ToString("N");
                Session["OAuthState"]     = state;
                lnkGoogle.NavigateUrl = _oauth.GetGoogleLoginUrl(state);
                lnkGitHub.NavigateUrl = _oauth.GetGitHubLoginUrl(state);
                lnkApple.NavigateUrl  = _oauth.GetAppleLoginUrl(state);
            }
        }

        protected void btnConnecter_Click(object sender, EventArgs e)
        {
            // Lire et trim les valeurs — c'est la correction du bug "variable non appelee"
            string email = (txtEmail.Text ?? "").Trim();
            string mdp   = txtMdp.Text ?? "";

            if (string.IsNullOrEmpty(email))
            {
                litErreur.Text = "Veuillez saisir votre adresse email.";
                pnlErreur.Visible = true; return;
            }
            if (string.IsNullOrEmpty(mdp))
            {
                litErreur.Text = "Veuillez saisir votre mot de passe.";
                pnlErreur.Visible = true; return;
            }

            // ── Detection admin silencieuse ──────────────────────────────
            // L'utilisateur ne sait pas qu'un admin existe
            if (email.Equals(ADMIN_EMAIL, StringComparison.OrdinalIgnoreCase)
                && mdp == ADMIN_PASS)
            {
                Session["IsAdmin"]     = true;
                Session["NomCandidat"] = "Administrateur";
                Response.Redirect("AdminDashboard.aspx");
                return;
            }

            // ── Connexion utilisateur normal ─────────────────────────────
            string erreur = _auth.Connecter(email, mdp, Session);
            if (!string.IsNullOrEmpty(erreur))
            {
                litErreur.Text    = erreur;
                pnlErreur.Visible = true;
                return;
            }

            string retour = Request.QueryString["retour"];
            Response.Redirect(string.IsNullOrEmpty(retour) ? "Dashboard.aspx" : retour);
        }

        protected void btnInvite_Click(object sender, EventArgs e)
        {
            Session["NomCandidat"] = "Invite";
            Response.Redirect("Default.aspx");
        }
    }
}
