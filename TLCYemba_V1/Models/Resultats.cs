using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TLCYemba.Models
{
    public class Resultats
    {
        public int ResultatID { get; set; }
        public int UtilisateurID { get; set; }
        public string TypeTest { get; set; }
        public int ScoreListening { get; set; }
        public int ScoreStructure { get; set; }
        public int ScoreReading { get; set; }
        public int ScoreTotal { get; set; }
        public string Niveau { get; set; }
        public DateTime DateTest { get; set; }
    }
}