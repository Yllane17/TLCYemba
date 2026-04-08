namespace TLCYemba.Models
{
    /// <summary>
    /// Modele representant le resultat calcule d'un test TLC Yemba.
    /// Couche Models : pas de logique, que des proprietes.
    /// </summary>
    public class ScoreResult
    {
        // Scores bruts (nombre de bonnes reponses par section)
        public int BrutListening  { get; set; }
        public int BrutStructure  { get; set; }
        public int BrutReading    { get; set; }

        // Scores convertis (echelle TLC)
        public int ScoreListening  { get; set; }  // 31 - 68
        public int ScoreStructure  { get; set; }  // 31 - 68
        public int ScoreReading    { get; set; }  // 31 - 67

        // Score total
        public int ScoreTotal { get; set; }       // 310 - 677

        // Niveau de competence
        public string Niveau      { get; set; }
        public string CouleurNiveau{ get; set; }  // hex pour l'UI

        // Type de test passe
        public string TypeTest    { get; set; }

        // Pourcentage global
        public int PourcentageGlobal { get; set; }
    }
}
