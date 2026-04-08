using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using TLCYemba.Models;

namespace TLCYemba.DAL
{
    public class HistoriqueRepository
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;

        public List<Resultats> GetByUtilisateur(int uid)
        {
            var list = new List<Resultats>();
            const string sql = @"
                SELECT ResultatID,UtilisateurID,TypeTest,
                       ScoreListening,ScoreStructure,ScoreReading,
                       ScoreTotal,Niveau,DateTest
                FROM   Resultats
                WHERE  UtilisateurID=@UID
                ORDER  BY DateTest DESC";
            using(var conn=new SqlConnection(ConnStr))
            using(var cmd=new SqlCommand(sql,conn)){
                cmd.Parameters.Add("@UID",SqlDbType.Int).Value=uid;
                conn.Open();
                using(var r=cmd.ExecuteReader()){
                    while(r.Read()) list.Add(Map(r));
                }
            }
            return list;
        }

        public Resultats GetById(int id)
        {
            const string sql=@"
                SELECT ResultatID,UtilisateurID,TypeTest,
                       ScoreListening,ScoreStructure,ScoreReading,
                       ScoreTotal,Niveau,DateTest
                FROM   Resultats WHERE ResultatID=@ID";
            using(var conn=new SqlConnection(ConnStr))
            using(var cmd=new SqlCommand(sql,conn)){
                cmd.Parameters.Add("@ID",SqlDbType.Int).Value=id;
                conn.Open();
                using(var r=cmd.ExecuteReader()){
                    if(r.Read()) return Map(r);
                }
            }
            return null;
        }

        public List<Resultats> GetTopScores(int top=10)
        {
            var list=new List<Resultats>();
            const string sql=@"
                SELECT TOP (@Top)
                       ResultatID,UtilisateurID,TypeTest,
                       ScoreListening,ScoreStructure,ScoreReading,
                       ScoreTotal,Niveau,DateTest
                FROM   Resultats
                ORDER  BY ScoreTotal DESC";
            using(var conn=new SqlConnection(ConnStr))
            using(var cmd=new SqlCommand(sql,conn)){
                cmd.Parameters.Add("@Top",SqlDbType.Int).Value=top;
                conn.Open();
                using(var r=cmd.ExecuteReader()){
                    while(r.Read()) list.Add(Map(r));
                }
            }
            return list;
        }

        private Resultats Map(SqlDataReader r)=>new Resultats{
            ResultatID    =(int)r["ResultatID"],
            UtilisateurID =(int)r["UtilisateurID"],
            TypeTest      =r["TypeTest"].ToString(),
            ScoreListening=(int)r["ScoreListening"],
            ScoreStructure=(int)r["ScoreStructure"],
            ScoreReading  =(int)r["ScoreReading"],
            ScoreTotal    =(int)r["ScoreTotal"],
            Niveau        =r["Niveau"].ToString(),
            DateTest      =(DateTime)r["DateTest"]
        };
    }
}
