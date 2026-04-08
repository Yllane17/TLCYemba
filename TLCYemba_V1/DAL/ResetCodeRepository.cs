using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TLCYemba.Models;

namespace TLCYemba.DAL
{
    /// <summary>DAL — Codes de reinitialisation de mot de passe.</summary>
    public class ResetCodeRepository
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;

        /// <summary>Insere un nouveau code (invalide les anciens).</summary>
        public void InsererCode(string email, string code)
        {
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                // Invalider les anciens codes de cet email
                using (var cmd = new SqlCommand(
                    "UPDATE ResetCodes SET Utilise=1 WHERE Email=@E AND Utilise=0", conn))
                {
                    cmd.Parameters.Add("@E", SqlDbType.NVarChar, 200).Value = email;
                    cmd.ExecuteNonQuery();
                }
                // Inserer le nouveau code (expire dans 15 min)
                using (var cmd = new SqlCommand(
                    "INSERT INTO ResetCodes (Email,Code,DateExpire,Utilise) VALUES (@E,@C,@D,0)", conn))
                {
                    cmd.Parameters.Add("@E", SqlDbType.NVarChar, 200).Value = email;
                    cmd.Parameters.Add("@C", SqlDbType.Char,     6  ).Value = code;
                    cmd.Parameters.Add("@D", SqlDbType.DateTime      ).Value = DateTime.Now.AddMinutes(15);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        /// <summary>Verifie si le code est valide et non utilise.</summary>
        public bool VerifierCode(string email, string code)
        {
            const string sql = @"
                SELECT COUNT(1) FROM ResetCodes
                WHERE Email=@E AND Code=@C AND Utilise=0 AND DateExpire > GETDATE()";
            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@E", SqlDbType.NVarChar, 200).Value = email;
                cmd.Parameters.Add("@C", SqlDbType.Char,     6  ).Value = code;
                conn.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        /// <summary>Marque le code comme utilise.</summary>
        public void MarquerUtilise(string email, string code)
        {
            const string sql = "UPDATE ResetCodes SET Utilise=1 WHERE Email=@E AND Code=@C";
            using (var conn = new SqlConnection(ConnStr))
            using (var cmd  = new SqlCommand(sql, conn))
            {
                cmd.Parameters.Add("@E", SqlDbType.NVarChar, 200).Value = email;
                cmd.Parameters.Add("@C", SqlDbType.Char,     6  ).Value = code;
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
