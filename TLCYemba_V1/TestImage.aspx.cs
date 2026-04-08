using System;
using System.Collections.Generic;
using TLCYemba.BLL;
using TLCYemba.Models;

namespace TLCYemba
{
    public partial class TestImage : System.Web.UI.Page
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
                var questions = _svc.ChargerQuestions("ImageDescription");
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
            string l = hfChoixLettre.Value;
            if (!string.IsNullOrEmpty(l))
            {
                var rep = Reponses;
                rep[IndexCourant] = l;
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

            litIdx.Text = (idx + 1).ToString();
            litImgNum.Text = (idx + 1).ToString();
            litTotal.Text = total.ToString();
            litEnonce.Text = System.Web.HttpUtility.HtmlEncode(q.Enonce);

            if (!string.IsNullOrEmpty(q.ImageUrl))
            {
                imgQ.ImageUrl = q.ImageUrl;
                pnlImg.Visible = true;
                pnlPlaceholder.Visible = false;
            }
            else
            {
                imgQ.ImageUrl = "images/default.jpg";
                pnlImg.Visible = true;
                pnlPlaceholder.Visible = false;
            }

            string repActuelle = "";
            Reponses.TryGetValue(idx, out repActuelle);
            hfChoixLettre.Value = repActuelle ?? "";

            var choixData = new[] {
                new { Lettre="A", Texte=q.ChoixA, IsSelected = (repActuelle == "A") },
                new { Lettre="B", Texte=q.ChoixB, IsSelected = (repActuelle == "B") },
                new { Lettre="C", Texte=q.ChoixC, IsSelected = (repActuelle == "C") },
                new { Lettre="D", Texte=q.ChoixD, IsSelected = (repActuelle == "D") },
            };
            rptChoix.DataSource = choixData;
            rptChoix.DataBind();

            btnSuivant.Visible = idx < total - 1;
            btnTerminer.Visible = idx == total - 1;

            var rep = Reponses;
            var sb = new System.Text.StringBuilder();
            for (int i = 0; i < total; i++)
            {
                string cls = i == idx ? "dot dot-current"
                           : rep.ContainsKey(i) ? "dot dot-answered"
                                                : "dot dot-pending";
                sb.AppendFormat(
                    "<button type=\"button\" class=\"{0}\" title=\"Image {1}\">{1}</button>",
                    cls, i + 1);
            }
            litDots.Text = sb.ToString();
        }
    }
}