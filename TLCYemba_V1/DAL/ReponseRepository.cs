using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TLCYemba.Models;

namespace TLCYemba.DAL
{
    /// <summary>
    /// DAL — Insertion en lot des reponses (une ligne par question).
    /// </summary>
    public class ReponseRepository
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;

        /// <summary>
        /// Insere toutes les reponses d'un test en une seule transaction.
        /// </summary>
        public void InsererReponses(List<Reponse> reponses)
        {
            if (reponses == null || reponses.Count == 0) return;

            const string sql = @"
                INSERT INTO Reponses (ResultatID, QuestionID, ReponseDonnee, EstCorrecte)
                VALUES (@RID, @QID, @Rep, @Ok)";

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (var tx = conn.BeginTransaction())
                {
                    try
                    {
                        foreach (var r in reponses)
                        {
                            using (var cmd = new SqlCommand(sql, conn, tx))
                            {
                                cmd.Parameters.Add("@RID", SqlDbType.Int).Value            = r.ResultatID;
                                cmd.Parameters.Add("@QID", SqlDbType.Int).Value            = r.QuestionID;
                                cmd.Parameters.Add("@Rep", SqlDbType.NVarChar, 2).Value    =
                                    string.IsNullOrEmpty(r.ReponseDonnee) ? (object)System.DBNull.Value : r.ReponseDonnee;
                                cmd.Parameters.Add("@Ok",  SqlDbType.Bit).Value            = r.EstCorrecte;
                                cmd.ExecuteNonQuery();
                            }
                        }
                        tx.Commit();
                    }
                    catch
                    {
                        tx.Rollback();
                        throw;
                    }
                }
            }
        }
    }
}
