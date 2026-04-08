using System;
using System.Collections.Specialized;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Configuration;
using TLCYemba.DAL;
using TLCYemba.Models;

namespace TLCYemba.BLL
{
    /// <summary>
    /// Service BLL — OAuth2 (Google, GitHub, Apple).
    /// Gere les redirections et les echanges de tokens.
    /// Les clés OAuth sont dans Web.config AppSettings.
    /// </summary>
    public class OAuthService
    {
        private readonly UtilisateurRepository _repo = new UtilisateurRepository();
        private readonly JavaScriptSerializer   _json = new JavaScriptSerializer();

        // ── URLs OAuth ──────────────────────────────────────────────────
        private static string BaseUrl =>
            ConfigurationManager.AppSettings["AppBaseUrl"] ?? "http://localhost:60000";

        private static string CallbackUrl(string provider) =>
            BaseUrl + "/OAuthCallback.aspx?provider=" + provider;

        // ══════════════════════════════════════════════════════════════
        // GOOGLE
        // ══════════════════════════════════════════════════════════════
        public string GetGoogleLoginUrl(string state)
        {
            string clientId = ConfigurationManager.AppSettings["Google_ClientId"];
            string scope    = Uri.EscapeDataString("openid email profile");
            string redirect = Uri.EscapeDataString(CallbackUrl("google"));
            return string.Format(
                "https://accounts.google.com/o/oauth2/v2/auth" +
                "?client_id={0}&redirect_uri={1}&response_type=code" +
                "&scope={2}&state={3}&access_type=offline",
                clientId, redirect, scope, state);
        }

        public Utilisateur HandleGoogleCallback(string code)
        {
            // 1. Echanger code contre token
            string clientId     = ConfigurationManager.AppSettings["Google_ClientId"];
            string clientSecret = ConfigurationManager.AppSettings["Google_ClientSecret"];
            string tokenUrl     = "https://oauth2.googleapis.com/token";

            var tokenParams = new NameValueCollection {
                {"code",          code},
                {"client_id",     clientId},
                {"client_secret", clientSecret},
                {"redirect_uri",  CallbackUrl("google")},
                {"grant_type",    "authorization_code"}
            };
            string tokenResp = PostForm(tokenUrl, tokenParams);
            dynamic tokenObj = _json.Deserialize<dynamic>(tokenResp);
            string accessToken = tokenObj["access_token"];

            // 2. Recuperer le profil
            string profileResp = GetWithToken(
                "https://www.googleapis.com/oauth2/v2/userinfo", accessToken);
            dynamic profile = _json.Deserialize<dynamic>(profileResp);

            return _repo.GetOrCreateOAuth(
                "google",
                profile["id"].ToString(),
                profile["email"]?.ToString(),
                profile["given_name"]?.ToString() ?? "",
                profile["family_name"]?.ToString() ?? "",
                profile["picture"]?.ToString());
        }

        // ══════════════════════════════════════════════════════════════
        // GITHUB
        // ══════════════════════════════════════════════════════════════
        public string GetGitHubLoginUrl(string state)
        {
            string clientId = ConfigurationManager.AppSettings["GitHub_ClientId"];
            string redirect = Uri.EscapeDataString(CallbackUrl("github"));
            return string.Format(
                "https://github.com/login/oauth/authorize" +
                "?client_id={0}&redirect_uri={1}&scope=user:email&state={2}",
                clientId, redirect, state);
        }

        public Utilisateur HandleGitHubCallback(string code)
        {
            string clientId     = ConfigurationManager.AppSettings["GitHub_ClientId"];
            string clientSecret = ConfigurationManager.AppSettings["GitHub_ClientSecret"];

            // 1. Token
            var tokenParams = new NameValueCollection {
                {"client_id",     clientId},
                {"client_secret", clientSecret},
                {"code",          code},
                {"redirect_uri",  CallbackUrl("github")}
            };
            string tokenResp = PostFormWithHeader(
                "https://github.com/login/oauth/access_token",
                tokenParams, "application/json");
            dynamic tokenObj = _json.Deserialize<dynamic>(tokenResp);
            string accessToken = tokenObj["access_token"];

            // 2. Profil
            string profileResp = GetWithTokenGitHub(
                "https://api.github.com/user", accessToken);
            dynamic profile = _json.Deserialize<dynamic>(profileResp);

            // GitHub peut ne pas exposer l'email -> appel supplementaire
            string email = profile["email"]?.ToString();
            if (string.IsNullOrEmpty(email))
            {
                string emailsResp = GetWithTokenGitHub(
                    "https://api.github.com/user/emails", accessToken);
                dynamic emails = _json.Deserialize<dynamic>(emailsResp);
                foreach (dynamic e in emails)
                {
                    if ((bool)e["primary"]) { email = e["email"].ToString(); break; }
                }
            }

            // Decomposer le nom
            string fullName = profile["name"]?.ToString() ?? "";
            string[] parts  = fullName.Split(' ');
            string prenom   = parts.Length > 0 ? parts[0] : fullName;
            string nom      = parts.Length > 1 ? string.Join(" ", parts, 1, parts.Length-1) : "";

            return _repo.GetOrCreateOAuth(
                "github",
                profile["id"].ToString(),
                email,
                prenom, nom,
                profile["avatar_url"]?.ToString());
        }

        // ══════════════════════════════════════════════════════════════
        // APPLE (Sign in with Apple — flux simplifie)
        // Note : necessite un compte Apple Developer + cle privee
        // ══════════════════════════════════════════════════════════════
        public string GetAppleLoginUrl(string state)
        {
            string clientId = ConfigurationManager.AppSettings["Apple_ClientId"];
            string redirect = Uri.EscapeDataString(CallbackUrl("apple"));
            return string.Format(
                "https://appleid.apple.com/auth/authorize" +
                "?client_id={0}&redirect_uri={1}&response_type=code id_token" +
                "&scope=name email&response_mode=form_post&state={2}",
                clientId, redirect, state);
        }

        public Utilisateur HandleAppleCallback(string idToken, string userJson)
        {
            // Decoder le JWT id_token (partie payload, base64url)
            string[] parts   = idToken.Split('.');
            string payload   = parts[1];
            // Padding base64
            int pad = payload.Length % 4;
            if (pad > 0) payload += new string('=', 4 - pad);
            payload = payload.Replace('-','+').Replace('_','/');
            string decoded   = Encoding.UTF8.GetString(Convert.FromBase64String(payload));
            dynamic claims   = _json.Deserialize<dynamic>(decoded);

            string sub       = claims["sub"].ToString();
            string email     = claims["email"]?.ToString();
            string prenom = "", nom = "";

            // Apple envoie le nom seulement a la premiere connexion
            if (!string.IsNullOrEmpty(userJson))
            {
                dynamic userObj = _json.Deserialize<dynamic>(userJson);
                prenom = userObj?["name"]?["firstName"]?.ToString() ?? "";
                nom    = userObj?["name"]?["lastName"]?.ToString()  ?? "";
            }
            if (string.IsNullOrEmpty(prenom)) prenom = "Apple";
            if (string.IsNullOrEmpty(nom))    nom    = "User";

            return _repo.GetOrCreateOAuth("apple", sub, email, prenom, nom, null);
        }

        // ── Helpers HTTP ────────────────────────────────────────────────
        private string PostForm(string url, NameValueCollection data)
        {
            using (var wc = new WebClient())
            {
                wc.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";
                var result = wc.UploadValues(url, "POST", data);
                return Encoding.UTF8.GetString(result);
            }
        }

        private string PostFormWithHeader(string url, NameValueCollection data, string accept)
        {
            using (var wc = new WebClient())
            {
                wc.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";
                wc.Headers[HttpRequestHeader.Accept]      = accept;
                var result = wc.UploadValues(url, "POST", data);
                return Encoding.UTF8.GetString(result);
            }
        }

        private string GetWithToken(string url, string token)
        {
            using (var wc = new WebClient())
            {
                wc.Headers[HttpRequestHeader.Authorization] = "Bearer " + token;
                return wc.DownloadString(url);
            }
        }

        private string GetWithTokenGitHub(string url, string token)
        {
            using (var wc = new WebClient())
            {
                wc.Headers[HttpRequestHeader.Authorization] = "token " + token;
                wc.Headers["User-Agent"] = "TLCYembaApp/1.0";
                wc.Headers[HttpRequestHeader.Accept] = "application/json";
                return wc.DownloadString(url);
            }
        }
    }
}
