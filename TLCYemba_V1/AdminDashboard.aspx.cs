using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace TLCYemba
{
    /// <summary>
    /// Dashboard admin — accessible uniquement via Session["IsAdmin"] = true.
    /// L’admin se connecte via Connexion.aspx normale (identifiants reconnus cote serveur).
    /// </summary>
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private string ConnStr => ConfigurationManager.ConnectionStrings["TLCYembaDB"].ConnectionString;

        public string LineChartJSON { get; private set; }
        public string DonutChartJSON { get; private set; }
        public string BarChartJSON { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Securite : verifier session admin
            if (Session["IsAdmin"] == null || !(bool)Session["IsAdmin"])
            {
                Response.Redirect("Connexion.aspx");
                return;
            }
            if (!IsPostBack)
            {
                ChargerStats();
                ChargerTableUsers();
                ChargerTableTop();
                ChargerCharts();
            }
        }

        // ── Deconnexion ─────────────────────────────────────────────────
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Connexion.aspx");
        }

        // ── Sauvegarder parametres admin ────────────────────────────────
        protected void btnSaveAdmin_Click(object sender, EventArgs e)
        {
            string mdpActuel = txtAdminMdpActuel.Text;

            // Verification du mot de passe actuel
            if (mdpActuel != "yougo19")
            {
                ClientScript.RegisterStartupScript(GetType(), "adminAlert",
                    "var al=document.getElementById('modalAlert');" +
                    "al.className='modal-alert show err';" +
                    "al.innerHTML='<i class=\"fa-solid fa-xmark\"></i> " +
                    "Mot de passe actuel incorrect.';",
                    true);
                return;
            }

            // Succes — dans une vraie app, mettre a jour la BDD ici
            ClientScript.RegisterStartupScript(GetType(), "adminAlert",
                "var al=document.getElementById('modalAlert');" +
                "al.className='modal-alert show ok';" +
                "al.innerHTML='<i class=\"fa-solid fa-check\"></i> " +
                "Informations mises a jour avec succes.';",
                true);
        }

        // ── Stats ───────────────────────────────────────────────────────
        private void ChargerStats()
        {
            try
            {
                using (var conn = new SqlConnection(ConnStr))
                {
                    conn.Open();
                    int nbU = Scalar(conn, "SELECT COUNT(*) FROM utilisateurs");
                    int nbT = Scalar(conn, "SELECT COUNT(*) FROM resultats");
                    int nbC = Scalar(conn, "SELECT COUNT(*) FROM resultats WHERE score_total >= 468");
                    int newU = Scalar(conn,
                        "SELECT COUNT(*) FROM utilisateurs " +
                        "WHERE DATEPART(MONTH, date_inscription) = DATEPART(MONTH, GETDATE()) " +
                        "AND DATEPART(YEAR, date_inscription) = DATEPART(YEAR, GETDATE())");
                    double moy = 0;
                    using (var cmd = new SqlCommand("SELECT COALESCE(AVG(score_total),0) FROM resultats", conn))
                        moy = Convert.ToDouble(cmd.ExecuteScalar());

                    litStatUsers.Text = nbU.ToString();
                    litNbUsers.Text = nbU.ToString();
                    litStatTests.Text = nbT.ToString();
                    litStatCertifies.Text = nbC.ToString();
                    litStatMoyenne.Text = moy > 0 ? ((int)Math.Round(moy, 0)).ToString() : "&#8212;";
                    litStatUsersNew.Text = newU.ToString();
                }
            }
            catch { /* Silencieux en prod */ }
        }

        // ── Table utilisateurs ──────────────────────────────────────────
        private void ChargerTableUsers()
        {
            var sb = new StringBuilder();
            try
            {
                const string sql = @"
                    SELECT TOP 50
                        u.utilisateur_id, u.nom, u.prenom, u.email,
                        COALESCE(r.max_score, 0) AS best_score,
                        COALESCE(r.nb_tests,  0) AS nb_tests,
                        r.last_niveau
                    FROM utilisateurs u
                    LEFT JOIN (
                        SELECT utilisateur_id,
                               MAX(score_total) AS max_score,
                               COUNT(*)         AS nb_tests,
                               (SELECT TOP 1 niveau
                                FROM resultats r2
                                WHERE r2.utilisateur_id = r1.utilisateur_id
                                ORDER BY date_test DESC) AS last_niveau
                        FROM resultats r1
                        GROUP BY utilisateur_id
                    ) r ON r.utilisateur_id = u.utilisateur_id
                    ORDER BY u.utilisateur_id DESC";

                using (var conn = new SqlConnection(ConnStr))
                using (var cmd = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    using (var r = cmd.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            int score = Convert.ToInt32(r["best_score"]);
                            string nom = r["prenom"].ToString() + " " + r["nom"].ToString();
                            string email = r["email"].ToString();
                            string niveau = r["last_niveau"] == DBNull.Value ? "&#8212;" : r["last_niveau"].ToString();
                            bool certif = score >= 468;
                            string initiale = nom.Length > 0 ? nom[0].ToString().ToUpper() : "?";
                            string bClass = certif ? "badge-green" : (score > 0 ? "badge-orange" : "badge-blue");
                            string bText = certif ? "Certifie" : (score > 0 ? "En cours" : "Pas teste");

                            sb.AppendFormat(
                                "<tr data-score=\"{0}\" data-niveau=\"{1}\">" +
                                "<td><span class=\"u-avatar\">{2}</span>{3}</td>" +
                                "<td style=\"font-size:12px;color:var(--txt-soft)\">{4}</td>" +
                                "<td><strong>{5}</strong></td>" +
                                "<td>{6}</td>" +
                                "<td><span class=\"badge {7}\">{8}</span></td>" +
                                "</tr>",
                                score, niveau, initiale, nom, email,
                                score > 0 ? score.ToString() : "&#8212;",
                                niveau, bClass, bText);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sb.Append("<tr><td colspan=\"5\" style=\"text-align:center;color:#A0AEC0\">Erreur: " +
                          System.Web.HttpUtility.HtmlEncode(ex.Message) + "</td></tr>");
            }
            litTableUsers.Text = sb.ToString();
        }

        // ── Table top scores ────────────────────────────────────────────
        private void ChargerTableTop()
        {
            var sb = new StringBuilder();
            try
            {
                const string sql = @"
                    SELECT TOP 20
                        ROW_NUMBER() OVER (ORDER BY r.score_total DESC) AS rang,
                        u.nom, u.prenom, r.type_test, r.score_total, r.niveau, r.date_test
                    FROM resultats r
                    JOIN utilisateurs u ON u.utilisateur_id = r.utilisateur_id
                    ORDER BY r.score_total DESC";

                using (var conn = new SqlConnection(ConnStr))
                using (var cmd = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    using (var r = cmd.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            int rang = Convert.ToInt32(r["rang"]);
                            string nom = r["prenom"].ToString() + " " + r["nom"].ToString();
                            string type = r["type_test"].ToString();
                            int score = Convert.ToInt32(r["score_total"]);
                            string date = Convert.ToDateTime(r["date_test"]).ToString("dd/MM/yy");
                            string init = nom.Length > 0 ? nom[0].ToString().ToUpper() : "?";
                            int bar = Math.Max(0, Math.Min(100, (int)((score - 310.0) / (677 - 310) * 100)));

                            sb.AppendFormat(
                                "<tr data-type=\"{0}\">" +
                                "<td><strong style=\"color:var(--teal)\">{1}</strong></td>" +
                                "<td><span class=\"u-avatar\">{2}</span>{3}</td>" +
                                "<td><span class=\"badge badge-blue\" style=\"font-size:10px\">{4}</span></td>" +
                                "<td><strong>{5}</strong>" +
                                "<div class=\"score-bar\"><div class=\"score-fill\" style=\"width:{6}%\"></div></div>" +
                                "</td>" +
                                "<td style=\"font-size:11.5px;color:var(--txt-soft)\">{7}</td>" +
                                "</tr>",
                                type, rang, init, nom, type, score, bar, date);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sb.Append("<tr><td colspan=\"5\" style=\"text-align:center;color:#A0AEC0\">Erreur: " +
                          System.Web.HttpUtility.HtmlEncode(ex.Message) + "</td></tr>");
            }
            litTableTop.Text = sb.ToString();
        }

        // ── Charts JSON ─────────────────────────────────────────────────
        private void ChargerCharts()
        {
            ChargerLineChart();
            ChargerDonutChart();
            ChargerBarChart();
        }

        private void ChargerLineChart()
        {
            var labels = new List<string>();
            var scores = new List<int>();
            var tests = new List<int>();
            try
            {
                using (var conn = new SqlConnection(ConnStr))
                using (var cmd = new SqlCommand(
                    "SELECT CAST(date_test AS DATE) AS jour, " +
                    "COALESCE(AVG(score_total),0) AS moy, COUNT(*) AS nb " +
                    "FROM resultats " +
                    "WHERE date_test >= DATEADD(day, -10, GETDATE()) " +
                    "GROUP BY CAST(date_test AS DATE) ORDER BY jour", conn))
                {
                    conn.Open();
                    using (var r = cmd.ExecuteReader())
                        while (r.Read())
                        {
                            labels.Add(Convert.ToDateTime(r["jour"]).ToString("dd/MM"));
                            scores.Add(Convert.ToInt32(r["moy"]));
                            tests.Add(Convert.ToInt32(r["nb"]));
                        }
                }
            }
            catch { }
            if (labels.Count == 0)
            {
                for (int i = 9; i >= 0; i--)
                { labels.Add(DateTime.Now.AddDays(-i).ToString("dd/MM")); scores.Add(0); tests.Add(0); }
            }
            var sb = new StringBuilder("{\"labels\":[");
            sb.Append(string.Join(",", labels.ConvertAll(l => "\"" + l + "\"")));
            sb.Append("],\"scores\":[").Append(string.Join(",", scores));
            sb.Append("],\"tests\":[").Append(string.Join(",", tests)).Append("]}");
            LineChartJSON = sb.ToString();
        }

        private void ChargerDonutChart()
        {
            int total = 0, r1 = 0, r2 = 0;
            try
            {
                using (var conn = new SqlConnection(ConnStr))
                {
                    conn.Open();
                    total = Scalar(conn, "SELECT COUNT(*) FROM resultats");
                    if (total > 0)
                    {
                        r1 = Scalar(conn, "SELECT COUNT(*) FROM resultats WHERE score_total >= 528");
                        r2 = Scalar(conn, "SELECT COUNT(*) FROM resultats WHERE score_total >= 398 AND score_total < 528");
                    }
                }
            }
            catch { }
            if (total == 0) { r1 = 60; r2 = 25; }
            else
            {
                r1 = (int)(r1 * 100.0 / total);
                r2 = (int)(r2 * 100.0 / total);
            }
            DonutChartJSON = "[" + r1 + "," + r2 + "," + (100 - r1 - r2) + "]";
        }

        private void ChargerBarChart()
        {
            var labels = new List<string>();
            var vals = new List<int>();
            try
            {
                using (var conn = new SqlConnection(ConnStr))
                using (var cmd = new SqlCommand(
                    "SELECT DATEPART(WEEK, date_inscription) AS sem, COUNT(*) AS nb " +
                    "FROM utilisateurs " +
                    "WHERE date_inscription >= DATEADD(week, -6, GETDATE()) " +
                    "GROUP BY DATEPART(WEEK, date_inscription) ORDER BY sem", conn))
                {
                    conn.Open();
                    using (var r = cmd.ExecuteReader())
                        while (r.Read())
                        { labels.Add("Sem " + r["sem"].ToString()); vals.Add(Convert.ToInt32(r["nb"])); }
                }
            }
            catch { }
            if (labels.Count == 0)
            { for (int i = 6; i >= 1; i--) { labels.Add("Sem " + i); vals.Add(0); } }
            var sb = new StringBuilder("{\"labels\":[");
            sb.Append(string.Join(",", labels.ConvertAll(l => "\"" + l + "\"")));
            sb.Append("],\"values\":[").Append(string.Join(",", vals)).Append("]}");
            BarChartJSON = sb.ToString();
        }

        private static int Scalar(SqlConnection conn, string sql)
        {
            using (var cmd = new SqlCommand(sql, conn))
                return Convert.ToInt32(cmd.ExecuteScalar());
        }
    }
}