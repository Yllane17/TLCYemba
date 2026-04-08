using System;
using System.Text;
using TLCYemba.BLL;

namespace TLCYemba
{
    public partial class AvantTest : System.Web.UI.Page
    {
        private readonly ChoixTestService _svc = new ChoixTestService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TypeTest"] == null)
            { Response.Redirect("ChoixTest.aspx"); return; }
            if (!IsPostBack) AfficherRecap();
        }

        protected void btnLancer_Click(object sender, EventArgs e)
        {
            Session["Reponses"]         = new System.Collections.Generic.Dictionary<int, string>();
            Session["QuestionActuelle"] = 0;

            string typeTest = Session["TypeTest"]?.ToString() ?? "FullTest";

            // ImageDescription → page speciale avec affichage image
            if (typeTest == "ImageDescription")
                Response.Redirect("TestImage.aspx");
            else
                Response.Redirect("Test.aspx");
        }

        private void AfficherRecap()
        {
            string   typeTest = Session["TypeTest"].ToString();
            int      nbQ      = Session["NbQuestions"] != null ? (int)Session["NbQuestions"] : 0;
            string[] sections = Session["Sections"] as string[] ?? new[] { typeTest };

            litTitreTest.Text  = _svc.GetLibelle(typeTest);
            litNbQ.Text        = nbQ.ToString();
            litDuree.Text      = "20"; // 20 secondes par question
            litNbSections.Text = sections.Length.ToString();

            var sb = new StringBuilder();
            foreach (var s in sections)
            {
                string icon = s == "Listening"        ? "fa-headphones"
                            : s == "Structure"         ? "fa-pen-nib"
                            : s == "ImageDescription"  ? "fa-image"
                                                       : "fa-book-open";
                sb.AppendFormat(
                    "<span class=\"chip\"><i class=\"fa-solid {0}\"></i>{1}</span>",
                    icon, s);
            }
            litChips.Text = sb.ToString();
        }
    }
}
