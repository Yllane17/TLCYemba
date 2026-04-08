using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TLCYemba.Models;

namespace TLCYemba.DAL
{
    /// <summary>
    /// DAL — Insertion des resultats et des reponses en base.
    /// Seule couche autorisee a ecrire du SQL.
    /// </summary>
    public class ResultatRepository
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;

        /// <summary>
        /// Insere un resultat et retourne son ID genere.
        /// </summary>
        public int InsererResultat(Resultats r)
        {
            const string sql = @"
                INSERT INTO Resultats
                    (UtilisateurID, TypeTest, ScoreListening, ScoreStructure,
                     ScoreReading, ScoreTotal, Niveau, DateTest)
                OUTPUT INSERTED.ResultatID
                VALUES
                    (@UID, @TypeTest, @ScL, @ScS, @ScR, @ScT, @Niveau, @Date)";

            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@UID",     SqlDbType.Int).Value           = r.UtilisateurID;
                cmd.Parameters.Add("@TypeTest",SqlDbType.NVarChar,20).Value   = r.TypeTest;
                cmd.Parameters.Add("@ScL",     SqlDbType.Int).Value           = r.ScoreListening;
                cmd.Parameters.Add("@ScS",     SqlDbType.Int).Value           = r.ScoreStructure;
                cmd.Parameters.Add("@ScR",     SqlDbType.Int).Value           = r.ScoreReading;
                cmd.Parameters.Add("@ScT",     SqlDbType.Int).Value           = r.ScoreTotal;
                cmd.Parameters.Add("@Niveau",  SqlDbType.NVarChar,50).Value   = r.Niveau;
                cmd.Parameters.Add("@Date",    SqlDbType.DateTime).Value      = r.DateTest;
                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }
    }
}
