using System.Collections.Generic;
using TLCYemba.DAL;
using TLCYemba.Models;

namespace TLCYemba.BLL
{
    public class TestService
    {
        private readonly QuestionRepository _repo = new QuestionRepository();

        private const int NB_LISTENING  = 50;
        private const int NB_STRUCTURE  = 40;
        private const int NB_READING    = 50;
        private const int NB_IMAGEDESC  = 20;

        public List<Question> ChargerQuestions(string typeTest)
        {
            var all = new List<Question>();
            switch (typeTest)
            {
                case "Listening":
                    all.AddRange(_repo.GetBySection("Listening", NB_LISTENING));
                    break;
                case "Structure":
                    all.AddRange(_repo.GetBySection("Structure", NB_STRUCTURE));
                    break;
                case "Reading":
                    // Reading : ordre FIXE pour que le texte corresponde aux questions
                    all.AddRange(_repo.GetBySectionOrdered("Reading"));
                    if (all.Count > NB_READING) all = all.GetRange(0, NB_READING);
                    break;
                case "ImageDescription":
                    all.AddRange(_repo.GetBySection("ImageDescription", NB_IMAGEDESC));
                    break;
                default: // FullTest
                    all.AddRange(_repo.GetBySection("Listening", NB_LISTENING));
                    all.AddRange(_repo.GetBySection("Structure",  NB_STRUCTURE));
                    // Reading en ordre fixe dans le FullTest aussi
                    var reading = _repo.GetBySectionOrdered("Reading");
                    if (reading.Count > NB_READING) reading = reading.GetRange(0, NB_READING);
                    all.AddRange(reading);
                    break;
            }
            return all;
        }

        public int GetNbQuestions(string typeTest)
        {
            switch (typeTest)
            {
                case "Listening":       return NB_LISTENING;
                case "Structure":       return NB_STRUCTURE;
                case "Reading":         return NB_READING;
                case "ImageDescription":return NB_IMAGEDESC;
                default:                return NB_LISTENING + NB_STRUCTURE + NB_READING;
            }
        }
    }
}
