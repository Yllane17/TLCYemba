using System;

namespace TLCYemba.Models
{
    /// <summary>
    /// Modele Question — POCO complet.
    /// ImageUrl : chemin image pour la section ImageDescription.
    /// TexteLecture : texte de passage pour la section Reading.
    /// </summary>
    public class Question
    {
        public int    QuestionID   { get; set; }
        public string Section      { get; set; }
        public string Enonce       { get; set; }
        public string ChoixA       { get; set; }
        public string ChoixB       { get; set; }
        public string ChoixC       { get; set; }
        public string ChoixD       { get; set; }
        public string BonneReponse { get; set; }
        // Audio pour Listening
        public string FichierAudio { get; set; }
        // Image pour ImageDescription
        public string ImageUrl     { get; set; }
        // Texte de lecture pour Reading
        public string TexteLecture { get; set; }

        public bool HasAudio  => !string.IsNullOrEmpty(FichierAudio);
        public bool HasImage  => !string.IsNullOrEmpty(ImageUrl);
        public bool HasTexte  => !string.IsNullOrEmpty(TexteLecture);
    }
}
