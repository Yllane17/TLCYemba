using System;

namespace TLCYemba.Models
{
    /// <summary>Code de reinitialisation de mot de passe.</summary>
    public class ResetCode
    {
        public int      ResetCodeID { get; set; }
        public string   Email       { get; set; }
        public string   Code        { get; set; }
        public DateTime DateExpire  { get; set; }
        public bool     Utilise     { get; set; }

        public bool EstValide => !Utilise && DateTime.Now < DateExpire;
    }
}
