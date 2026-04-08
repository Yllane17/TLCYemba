using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using TLCYemba.BLL;
using TLCYemba.Models;

namespace TLCYemba
{
    public partial class Test : System.Web.UI.Page
    {
        private readonly TestService _svc = new TestService();

        private List<Question> Questions
        {
            get { return Session["Test_Questions"] as List<Question> ?? new List<Question>(); }
            set { Session["Test_Questions"] = value; }
        }

        private Dictionary<int, string> Reponses
        {
            get { return Session["Reponses"] as Dictionary<int, string> ?? new Dictionary<int, string>(); }
            set { Session["Reponses"] = value; }
        }

        private int IndexCourant
        {
            get { return hfIndex.Value != "" ? int.Parse(hfIndex.Value) : 0; }
            set { hfIndex.Value = value.ToString(); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TypeTest"] == null)
            { Response.Redirect("ChoixTest.aspx"); return; }

            if (!IsPostBack)
            {
                string typeTest = Session["TypeTest"].ToString();
                var questions = _svc.ChargerQuestions(typeTest);
                if (questions.Count == 0)
                { Response.Redirect("ChoixTest.aspx"); return; }

                Questions = questions;
                IndexCourant = 0;
                Reponses = new Dictionary<int, string>();
                Session["Test_DureeReelle"] = DateTime.Now;
            }

            AfficherQuestion(IndexCourant);
        }

        private void EnregistrerReponse()
        {
            string lettre = hfChoixLettre.Value;
            if (!string.IsNullOrEmpty(lettre))
            {
                var rep = Reponses;
                rep[IndexCourant] = lettre;
                Reponses = rep;
            }
        }

        protected void btnSuivant_Click(object sender, EventArgs e)
        {
            EnregistrerReponse();
            int next = IndexCourant + 1;
            if (next < Questions.Count)
            {
                IndexCourant = next;
                hfChoixLettre.Value = "";
                AfficherQuestion(next);
            }
        }

        protected void btnTerminer_Click(object sender, EventArgs e)
        {
            EnregistrerReponse();

            if (Session["Test_DureeReelle"] is DateTime debut)
                Session["Test_DureeMins"] = (int)(DateTime.Now - debut).TotalMinutes;

            Response.Redirect("Resultat.aspx");
        }

        private void AfficherQuestion(int idx)
        {
            var questions = Questions;
            if (idx < 0 || idx >= questions.Count) return;
            var q = questions[idx];
            int total = questions.Count;

            litQNum.Text = (idx + 1).ToString();
            litSection.Text = q.Section;
            litIndexDisplay.Text = (idx + 1).ToString();
            litTotal.Text = total.ToString();

            litEnonce.Text = System.Web.HttpUtility.HtmlEncode(q.Enonce);

            if (!string.IsNullOrEmpty(q.TexteLecture))
            {
                litTexteLecture.Text = q.TexteLecture
                    .Replace("\n", "<br/>").Replace("\r", "");
                pnlTexteLecture.Visible = true;
            }
            else pnlTexteLecture.Visible = false;

            if (!string.IsNullOrEmpty(q.ImageUrl))
            {
                imgQuestion.ImageUrl = q.ImageUrl;
                pnlImage.Visible = true;
            }
            else pnlImage.Visible = false;

            string repActuelle = "";
            Reponses.TryGetValue(idx, out repActuelle);

            var choixData = new[] {
                new { Lettre="A", Texte=q.ChoixA, IsSelected = (repActuelle == "A") },
                new { Lettre="B", Texte=q.ChoixB, IsSelected = (repActuelle == "B") },
                new { Lettre="C", Texte=q.ChoixC, IsSelected = (repActuelle == "C") },
                new { Lettre="D", Texte=q.ChoixD, IsSelected = (repActuelle == "D") },
            };
            rptChoix.DataSource = choixData;
            rptChoix.DataBind();

            hfChoixLettre.Value = repActuelle ?? "";

            bool dernier = idx == total - 1;
            btnSuivant.Visible = !dernier;
            btnTerminer.Visible = dernier;

            GenererDots(idx, total);
        }

        private void GenererDots(int courant, int total)
        {
            var rep = Reponses;
            var sb = new System.Text.StringBuilder();
            int max = total > 100 ? 100 : total;
            for (int i = 0; i < max; i++)
            {
                string cls = i == courant ? "dot dot-current"
                           : rep.ContainsKey(i) ? "dot dot-answered"
                                                : "dot dot-pending";
                sb.AppendFormat(
                    "<button type=\"button\" class=\"{0}\" " +
                    "onclick=\"allerAQuestion({1})\" title=\"Q{2}\">{2}</button>",
                    cls, i, i + 1);
            }
            litDots.Text = sb.ToString();
        }
    }
}