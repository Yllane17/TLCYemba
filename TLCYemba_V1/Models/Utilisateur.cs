namespace TLCYemba.Models
{
    /// <summary>
    /// Modele representant un utilisateur inscrit sur la plateforme TLC Yemba.
    /// Supporte : compte local (email + mot de passe) ET compte OAuth (Google/GitHub/Apple).
    /// Couche Models : aucune logique, que des proprietes.
    /// </summary>
    public class Utilisateur
    {
        public int    UtilisateurID   { get; set; }
        public string Nom             { get; set; }
        public string Prenom          { get; set; }
        public string Email           { get; set; }

        /// <summary>Hash SHA-256 du mot de passe. NULL si compte OAuth uniquement.</summary>
        public string MotDePasseHash  { get; set; }

        /// <summary>Provider OAuth : "google" | "github" | "apple" | null</summary>
        public string ProviderExterne { get; set; }

        /// <summary>Identifiant unique chez le provider OAuth.</summary>
        public string IdExterne       { get; set; }

        /// <summary>URL de la photo de profil (fournie par le provider OAuth).</summary>
        public string PhotoUrl        { get; set; }

        // ── Proprietes calculees ────────────────────────────────────────
        public string NomComplet  => (Prenom + " " + Nom).Trim();
        public bool   EstOAuth    => !string.IsNullOrEmpty(ProviderExterne);
        public bool   HasPassword => !string.IsNullOrEmpty(MotDePasseHash);
    }
}
