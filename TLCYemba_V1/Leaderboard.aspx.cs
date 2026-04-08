using System;
using System.Collections.Generic;
using TLCYemba.BLL;
using TLCYemba.Models;

namespace TLCYemba
{
    public partial class Leaderboard : System.Web.UI.Page
    {
        private readonly HistoriqueService _svc = new HistoriqueService();
        private int _myUid = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            _myUid = Session["UtilisateurID"] != null ? (int)Session["UtilisateurID"] : 0;
            if (!IsPostBack) ChargerLeaderboard();
        }

        private void ChargerLeaderboard()
        {
            var top = _svc.GetLeaderboard(10);

            // Podium top 3
            BuildPodium(top);

            // Ajouter rang
            var withRang = new List<dynamic>();
            // On utilise DataTable pour le Repeater
            var dt = new System.Data.DataTable();
            dt.Columns.Add("Rang",typeof(int));
            dt.Columns.Add("UtilisateurID",typeof(int));
            dt.Columns.Add("TypeTest",typeof(string));
            dt.Columns.Add("ScoreTotal",typeof(int));
            dt.Columns.Add("Niveau",typeof(string));
            dt.Columns.Add("DateTest",typeof(DateTime));

            for (int i = 0; i < top.Count; i++)
            {
                var r = top[i];
                dt.Rows.Add(i+1, r.UtilisateurID, r.TypeTest, r.ScoreTotal, r.Niveau, r.DateTest);
            }
            rptLeaderboard.DataSource = dt;
            rptLeaderboard.DataBind();
        }

        private void BuildPodium(List<Resultats> top)
        {
            if (top.Count < 1) { pnlPodium.Visible = false; return; }
            var sb = new System.Text.StringBuilder();

            // Ordre visuel : 2e, 1er, 3e
            int[] order = top.Count >= 3 ? new[]{1,0,2} :
                          top.Count == 2 ? new[]{1,0}   : new[]{0};
            string[] classes = {"p2","p1","p3"};
            string[] medals  = {"&#129352;","&#129351;","&#129353;"};

            for (int vi = 0; vi < order.Length; vi++)
            {
                int i = order[vi];
                if (i >= top.Count) continue;
                var r = top[i];
                string cls = classes[vi];
                string med = medals[vi];
                sb.AppendFormat(
                    "<div class=\"podium-item {0}\">" +
                    "  <div class=\"podium-avatar\">{1}</div>" +
                    "  <div class=\"podium-block\">" +
                    "    <div class=\"podium-rank\">{1}</div>" +
                    "    <div class=\"podium-score\">{2}</div>" +
                    "    <div class=\"podium-niveau\">{3}</div>" +
                    "  </div>" +
                    "</div>",
                    cls, med, r.ScoreTotal, r.Niveau);
            }
            litPodium.Text = sb.ToString();
        }

        protected bool IsMe(object uid) =>
            _myUid > 0 && uid != null && _myUid == Convert.ToInt32(uid);

        protected string GetCouleur(string niveau)
        {
            switch (niveau)
            {
                case "Courant":       return "#3AAFA9";
                case "Avance":        return "#38A169";
                case "Intermediaire": return "#D69E2E";
                case "Elementaire":   return "#DD6B20";
                default:              return "#E53E3E";
            }
        }
    }
}
