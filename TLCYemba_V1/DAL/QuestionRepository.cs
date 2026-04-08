using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using TLCYemba.Models;

namespace TLCYemba.DAL
{
    public class QuestionRepository
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;

        private const string SELECT_COLS = @"
            QuestionID, Section, Enonce, FichierAudio,
            image_url, texte_lecture,
            ChoixA, ChoixB, ChoixC, ChoixD, BonneReponse";

        /// <summary>Retourne N questions aleatoires d'une section.</summary>
        public List<Question> GetBySection(string section, int nombre)
        {
            var list = new List<Question>();
            // SQL Server : TOP (@N) avec ORDER BY NEWID() pour l'aléatoire
            string sql = "SELECT TOP (@N) " + SELECT_COLS +
                         " FROM questions WHERE Section=@S ORDER BY NEWID()";
            using (var conn = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@S", section);
                cmd.Parameters.AddWithValue("@N", nombre);
                conn.Open();
                using (var r = cmd.ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        /// <summary>Retourne toutes les questions d'une section en ordre fixe (Reading).</summary>
        public List<Question> GetBySectionOrdered(string section)
        {
            var list = new List<Question>();
            string sql = "SELECT " + SELECT_COLS +
                         " FROM Questions WHERE Section=@S ORDER BY QuestionID";
            using (var conn = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@S", section);
                conn.Open();
                using (var r = cmd.ExecuteReader())
                    while (r.Read()) list.Add(Map(r));
            }
            return list;
        }

        private static Question Map(System.Data.IDataReader r) => new Question
        {
            QuestionID = System.Convert.ToInt32(r["QuestionID"]),
            Section = r["Section"]?.ToString() ?? "",
            Enonce = r["Enonce"]?.ToString() ?? "",
            FichierAudio = r["FichierAudio"] == System.DBNull.Value ? null : r["FichierAudio"].ToString(),
            ImageUrl = r["image_url"] == System.DBNull.Value ? null : r["image_url"].ToString(),
            TexteLecture = r["texte_lecture"] == System.DBNull.Value ? null : r["texte_lecture"].ToString(),
            ChoixA = r["ChoixA"]?.ToString() ?? "",
            ChoixB = r["ChoixB"]?.ToString() ?? "",
            ChoixC = r["ChoixC"]?.ToString() ?? "",
            ChoixD = r["ChoixD"]?.ToString() ?? "",
            BonneReponse = r["BonneReponse"]?.ToString() ?? "A",
        };
    }
}