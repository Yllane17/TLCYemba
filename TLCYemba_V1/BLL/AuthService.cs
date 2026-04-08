using System;
using System.Web.SessionState;
using TLCYemba.DAL;
using TLCYemba.Models;

namespace TLCYemba.BLL
{
    public class AuthService
    {
        private readonly UtilisateurRepository _repo      = new UtilisateurRepository();
        private readonly ResetCodeRepository   _resetRepo = new ResetCodeRepository();
        private readonly EmailService          _email     = new EmailService();

        // Email admin — si quelqu'un essaie de s'inscrire avec, message neutre
        private const string ADMIN_EMAIL = "yougo@gmail.com";

        // ── Inscription ──────────────────────────────────────────────────
        public string Inscrire(string nom, string prenom, string email,
                               string mdp, string mdpConfirm)
        {
            // Trim systematique — correction du bug "variable non appelee"
            nom    = (nom    ?? "").Trim();
            prenom = (prenom ?? "").Trim();
            email  = (email  ?? "").Trim();
            mdp    =  mdp    ?? "";
            mdpConfirm = mdpConfirm ?? "";

            if (string.IsNullOrEmpty(nom))    return "Le nom est obligatoire.";
            if (string.IsNullOrEmpty(prenom)) return "Le prenom est obligatoire.";
            if (string.IsNullOrEmpty(email))  return "L'adresse email est obligatoire.";
            if (mdp.Length < 6)
                return "Le mot de passe doit comporter au moins 6 caracteres.";
            if (mdp != mdpConfirm)
                return "Les mots de passe ne correspondent pas.";

            // Si email identique a l'admin, message generique — aucune info sur l'admin
            if (email.Equals(ADMIN_EMAIL, StringComparison.OrdinalIgnoreCase) ||
                _repo.EmailExiste(email))
                return "Impossible de creer ce compte. Veuillez essayer avec un autre email.";

            _repo.Inserer(new Utilisateur {
                Nom            = nom,
                Prenom         = prenom,
                Email          = email,
                MotDePasseHash = UtilisateurRepository.HashMotDePasse(mdp)
            });
            return null; // succes
        }

        // ── Connexion ────────────────────────────────────────────────────
        public string Connecter(string email, string mdp, HttpSessionState session)
        {
            email = (email ?? "").Trim();
            mdp   =  mdp   ?? "";

            if (string.IsNullOrEmpty(email)) return "L'adresse email est obligatoire.";
            if (string.IsNullOrEmpty(mdp))   return "Le mot de passe est obligatoire.";

            string hash = UtilisateurRepository.HashMotDePasse(mdp);
            var u = _repo.GetByEmailEtHash(email, hash);
            if (u == null) return "Email ou mot de passe incorrect.";

            SetSession(session, u);
            return null;
        }

        // ── OAuth ────────────────────────────────────────────────────────
        public void ConnecterOAuth(HttpSessionState session, Utilisateur u)
            => SetSession(session, u);

        // ── Reset MDP etape 1 ────────────────────────────────────────────
        public string EnvoyerCodeReset(string email)
        {
            email = (email ?? "").Trim();
            if (string.IsNullOrEmpty(email)) return "Veuillez saisir votre adresse email.";
            if (_repo.EmailExiste(email))
            {
                string code = GenererCode6Chiffres();
                _resetRepo.InsererCode(email, code);
                _email.EnvoyerCodeReset(email, code);
            }
            return null; // message neutre meme si email inconnu
        }

        // ── Reset MDP etape 2 ────────────────────────────────────────────
        public bool VerifierCodeReset(string email, string code)
            => _resetRepo.VerifierCode((email??"").Trim(), (code??"").Trim());

        // ── Reset MDP etape 3 ────────────────────────────────────────────
        public string ResetMotDePasse(string email, string code,
                                       string nouveauMdp, string confirm)
        {
            email      = (email ?? "").Trim();
            code       = (code  ?? "").Trim();
            nouveauMdp =  nouveauMdp ?? "";
            confirm    =  confirm    ?? "";

            if (nouveauMdp.Length < 6) return "Le mot de passe doit comporter au moins 6 caracteres.";
            if (nouveauMdp != confirm)  return "Les mots de passe ne correspondent pas.";
            if (!_resetRepo.VerifierCode(email, code)) return "Code invalide ou expire.";

            _repo.UpdateMotDePasse(email, UtilisateurRepository.HashMotDePasse(nouveauMdp));
            _resetRepo.MarquerUtilise(email, code);
            return null;
        }

        // ── Session ──────────────────────────────────────────────────────
        public bool EstConnecte(HttpSessionState session)
            => session?["UtilisateurID"] != null;

        public void Deconnecter(HttpSessionState session)
            => session?.Clear();

        private void SetSession(HttpSessionState session, Utilisateur u)
        {
            session["UtilisateurID"] = u.UtilisateurID;
            session["NomCandidat"]   = u.NomComplet;
            session["EmailCandidat"] = u.Email;
            if (!string.IsNullOrEmpty(u.PhotoUrl))
                session["PhotoUrl"]  = u.PhotoUrl;
        }

        private static string GenererCode6Chiffres()
            => new Random().Next(100000, 999999).ToString();
    }
}
