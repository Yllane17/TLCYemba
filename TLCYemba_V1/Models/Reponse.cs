namespace TLCYemba.Models
{
    /// <summary>
    /// Modele de la table Reponses (detail par question).
    /// </summary>
    public class Reponse
    {
        public int    ReponseID     { get; set; }
        public int    ResultatID    { get; set; }
        public int    QuestionID    { get; set; }
        public string ReponseDonnee { get; set; }  // A | B | C | D | (vide)
        public bool   EstCorrecte   { get; set; }
    }
}
