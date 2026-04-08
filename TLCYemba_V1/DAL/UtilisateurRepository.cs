using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using TLCYemba.Models;

namespace TLCYemba.DAL
{
    /// <summary>
    /// DAL — Table Utilisateurs.
    /// Responsabilites : creation de compte local, connexion locale,
    ///                   gestion OAuth (Google/GitHub/Apple),
    ///                   mise a jour du mot de passe.
    /// Seule couche autorisee a ecrire du SQL.
    /// </summary>
    public class UtilisateurRepository
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;

        // ─────────────────────────────────────────────────────────────────
        // HASH SHA-256
        // ─────────────────────────────────────────────────────────────────

        /// <summary>
        /// Calcule le hash SHA-256 d'un mot de passe en clair.
        /// Methode statique utilisable sans instancier le repository.
        /// </summary>
        public static string HashMotDePasse(string mdp)
        {
            using (var sha = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(mdp);
                byte[] hash  = sha.ComputeHash(bytes);
                var sb = new StringBuilder();
                foreach (byte b in hash) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        // ─────────────────────────────────────────────────────────────────
        // COMPTE LOCAL — Creation
        // ─────────────────────────────────────────────────────────────────

        /// <summary>Insere un nouvel utilisateur (compte local).</summary>
        public int Inserer(Utilisateur u)
        {
            const string sql = @"
                INSERT INTO Utilisateurs (Nom, Prenom, Email, MotDePasseHash)
                OUTPUT INSERTED.UtilisateurID
                VALUES (@Nom, @Prenom, @Email, @Hash)";

            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@Nom",   SqlDbType.NVarChar, 100).Value = u.Nom;
                cmd.Parameters.Add("@Prenom",SqlDbType.NVarChar, 100).Value = u.Prenom;
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 200).Value = u.Email;
                cmd.Parameters.Add("@Hash",  SqlDbType.NVarChar, 256).Value =
                    u.MotDePasseHash ?? (object)DBNull.Value;
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        // ─────────────────────────────────────────────────────────────────
        // COMPTE LOCAL — Connexion
        // ─────────────────────────────────────────────────────────────────

        /// <summary>
        /// Retrouve un utilisateur par email et hash de mot de passe.
        /// Retourne null si non trouve.
        /// </summary>
        public Utilisateur GetByEmailEtHash(string email, string hash)
        {
            const string sql = @"
                SELECT UtilisateurID, Nom, Prenom, Email, MotDePasseHash,
                       ProviderExterne, IdExterne, PhotoUrl
                FROM   Utilisateurs
                WHERE  Email = @Email AND MotDePasseHash = @Hash";

            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 200).Value = email;
                cmd.Parameters.Add("@Hash",  SqlDbType.NVarChar, 256).Value = hash;
                conn.Open();
                using (var r = cmd.ExecuteReader())
                    return r.Read() ? MapRow(r) : null;
            }
        }

        /// <summary>Verifie si un email est deja enregistre.</summary>
        public bool EmailExiste(string email)
        {
            const string sql = "SELECT COUNT(1) FROM Utilisateurs WHERE Email = @Email";
            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 200).Value = email;
                conn.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        // ─────────────────────────────────────────────────────────────────
        // OAUTH — Recuperer ou creer un compte
        // ─────────────────────────────────────────────────────────────────

        /// <summary>
        /// Retrouve ou cree un utilisateur depuis un provider OAuth (Google/GitHub/Apple).
        /// Logique :
        ///   1. Cherche par IdExterne + Provider → retourne si trouve.
        ///   2. Cherche par Email → lie le provider si compte local existant.
        ///   3. Cree un nouveau compte OAuth si rien trouve.
        /// </summary>
        public Utilisateur GetOrCreateOAuth(
            string provider,
            string idExterne,
            string email,
            string prenom,
            string nom,
            string photoUrl)
        {
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                // ── Etape 1 : chercher par IdExterne + Provider ──────────
                const string sqlByProvider = @"
                    SELECT UtilisateurID, Nom, Prenom, Email, MotDePasseHash,
                           ProviderExterne, IdExterne, PhotoUrl
                    FROM   Utilisateurs
                    WHERE  ProviderExterne = @Provider AND IdExterne = @IdExt";

                using (var cmd = new SqlCommand(sqlByProvider, conn))
                {
                    cmd.Parameters.Add("@Provider", SqlDbType.NVarChar,  20).Value = provider;
                    cmd.Parameters.Add("@IdExt",    SqlDbType.NVarChar, 200).Value = idExterne;
                    using (var r = cmd.ExecuteReader())
                        if (r.Read()) return MapRow(r);
                }

                // ── Etape 2 : chercher par Email (compte local existant) ──
                Utilisateur existant = null;
                if (!string.IsNullOrEmpty(email))
                {
                    const string sqlByEmail = @"
                        SELECT UtilisateurID, Nom, Prenom, Email, MotDePasseHash,
                               ProviderExterne, IdExterne, PhotoUrl
                        FROM   Utilisateurs WHERE Email = @Email";
                    using (var cmd = new SqlCommand(sqlByEmail, conn))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 200).Value = email;
                        using (var r = cmd.ExecuteReader())
                            if (r.Read()) existant = MapRow(r);
                    }
                }

                if (existant != null)
                {
                    // Lier le provider OAuth au compte existant
                    const string sqlLier = @"
                        UPDATE Utilisateurs
                        SET    ProviderExterne = @Provider,
                               IdExterne       = @IdExt,
                               PhotoUrl        = @Photo
                        WHERE  UtilisateurID   = @UID";
                    using (var cmd = new SqlCommand(sqlLier, conn))
                    {
                        cmd.Parameters.Add("@Provider", SqlDbType.NVarChar,  20).Value = provider;
                        cmd.Parameters.Add("@IdExt",    SqlDbType.NVarChar, 200).Value = idExterne;
                        cmd.Parameters.Add("@Photo",    SqlDbType.NVarChar, 500).Value =
                            (object)photoUrl ?? DBNull.Value;
                        cmd.Parameters.Add("@UID", SqlDbType.Int).Value = existant.UtilisateurID;
                        cmd.ExecuteNonQuery();
                    }
                    existant.ProviderExterne = provider;
                    existant.IdExterne       = idExterne;
                    existant.PhotoUrl        = photoUrl;
                    return existant;
                }

                // ── Etape 3 : creer un nouveau compte OAuth ──────────────
                const string sqlCreer = @"
                    INSERT INTO Utilisateurs
                        (Nom, Prenom, Email, MotDePasseHash,
                         ProviderExterne, IdExterne, PhotoUrl)
                    OUTPUT INSERTED.UtilisateurID
                    VALUES
                        (@Nom, @Prenom, @Email, NULL,
                         @Provider, @IdExt, @Photo)";

                int newId;
                using (var cmd = new SqlCommand(sqlCreer, conn))
                {
                    cmd.Parameters.Add("@Nom",      SqlDbType.NVarChar, 100).Value = nom    ?? "Utilisateur";
                    cmd.Parameters.Add("@Prenom",   SqlDbType.NVarChar, 100).Value = prenom ?? "";
                    cmd.Parameters.Add("@Email",    SqlDbType.NVarChar, 200).Value = email  ?? "";
                    cmd.Parameters.Add("@Provider", SqlDbType.NVarChar,  20).Value = provider;
                    cmd.Parameters.Add("@IdExt",    SqlDbType.NVarChar, 200).Value = idExterne;
                    cmd.Parameters.Add("@Photo",    SqlDbType.NVarChar, 500).Value =
                        (object)photoUrl ?? DBNull.Value;
                    newId = (int)cmd.ExecuteScalar();
                }

                return new Utilisateur
                {
                    UtilisateurID   = newId,
                    Nom             = nom    ?? "Utilisateur",
                    Prenom          = prenom ?? "",
                    Email           = email  ?? "",
                    MotDePasseHash  = null,
                    ProviderExterne = provider,
                    IdExterne       = idExterne,
                    PhotoUrl        = photoUrl
                };
            }
        }

        // ─────────────────────────────────────────────────────────────────
        // RESET MOT DE PASSE
        // ─────────────────────────────────────────────────────────────────

        /// <summary>
        /// Met a jour le hash du mot de passe pour un utilisateur identifie par email.
        /// Retourne true si la mise a jour a reussi (1 ligne affectee).
        /// </summary>
        public bool UpdateMotDePasse(string email, string nouveauHash)
        {
            const string sql = @"
                UPDATE Utilisateurs
                SET    MotDePasseHash = @Hash
                WHERE  Email          = @Email";

            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@Hash",  SqlDbType.NVarChar, 256).Value = nouveauHash;
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 200).Value = email;
                conn.Open();
                return cmd.ExecuteNonQuery() > 0;
            }
        }

        // ─────────────────────────────────────────────────────────────────
        // HELPER PRIVE
        // ─────────────────────────────────────────────────────────────────

        private static Utilisateur MapRow(SqlDataReader r)
        {
            return new Utilisateur
            {
                UtilisateurID   = (int)r["UtilisateurID"],
                Nom             = r["Nom"].ToString(),
                Prenom          = r["Prenom"].ToString(),
                Email           = r["Email"].ToString(),
                MotDePasseHash  = r["MotDePasseHash"]  == DBNull.Value
                                    ? null : r["MotDePasseHash"].ToString(),
                ProviderExterne = r["ProviderExterne"] == DBNull.Value
                                    ? null : r["ProviderExterne"].ToString(),
                IdExterne       = r["IdExterne"]       == DBNull.Value
                                    ? null : r["IdExterne"].ToString(),
                PhotoUrl        = r["PhotoUrl"]        == DBNull.Value
                                    ? null : r["PhotoUrl"].ToString(),
            };
        }
    }
}
