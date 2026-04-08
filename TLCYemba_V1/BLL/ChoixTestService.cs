using System;
using System.Collections.Generic;
using System.Web.SessionState;

namespace TLCYemba.BLL
{
    public class ChoixTestService
    {
        // ── Types valides (incluant ImageDescription) ────────────────────
        private static readonly string[] TypesValides =
        {
            "Listening", "Structure", "Reading", "FullTest", "ImageDescription"
        };

        public string ValiderChoix(string typeTest)
        {
            if (string.IsNullOrEmpty(typeTest)) return "Veuillez selectionner un type de test.";
            foreach (var v in TypesValides) if (v == typeTest) return null;
            return "Type de test invalide.";
        }

        public void EnregistrerChoixEnSession(string typeTest, HttpSessionState session)
        {
            session["TypeTest"] = typeTest;
            switch (typeTest)
            {
                case "Listening":
                    session["NbQuestions"]  = 50;
                    session["DureeMinutes"] = 30;
                    session["Sections"]     = new[] { "Listening" };
                    break;
                case "Structure":
                    session["NbQuestions"]  = 40;
                    session["DureeMinutes"] = 25;
                    session["Sections"]     = new[] { "Structure" };
                    break;
                case "Reading":
                    session["NbQuestions"]  = 50;
                    session["DureeMinutes"] = 55;
                    session["Sections"]     = new[] { "Reading" };
                    break;
                case "ImageDescription":
                    session["NbQuestions"]  = 20;
                    session["DureeMinutes"] = 40;
                    session["Sections"]     = new[] { "ImageDescription" };
                    break;
                default: // FullTest
                    session["NbQuestions"]  = 140;
                    session["DureeMinutes"] = 115;
                    session["Sections"]     = new[] { "Listening", "Structure", "Reading" };
                    break;
            }
        }

        public string GetLibelle(string typeTest)
        {
            switch (typeTest)
            {
                case "Listening":       return "Listening &#8212; Comprehension Orale";
                case "Structure":       return "Structure &#8212; Grammaire";
                case "Reading":         return "Reading &#8212; Comprehension Ecrite";
                case "ImageDescription":return "Description d'images &#8212; Culture Yemba";
                default:                return "Test Complet TLC";
            }
        }
    }
}
