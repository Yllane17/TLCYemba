using System;
using TLCYemba.BLL;

namespace TLCYemba
{
    public partial class ChoixTest : System.Web.UI.Page
    {
        private readonly ChoixTestService _svc = new ChoixTestService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) AfficherNavbar();
        }

        protected void btnCommencer_Click(object sender, EventArgs e)
        {
            string type = hfTypeTest.Value;
            string erreur = _svc.ValiderChoix(type);
            if (!string.IsNullOrEmpty(erreur))
            {
                litErreur.Text    = erreur;
                pnlErreur.Visible = true;
                AfficherNavbar();
                return;
            }
            _svc.EnregistrerChoixEnSession(type, Session);
            Response.Redirect("AvantTest.aspx");
        }

        private void AfficherNavbar()
        {
            if (Session["NomCandidat"] != null && Session["UtilisateurID"] != null
                && Session["NomCandidat"].ToString() != "Invite")
            {
                string nom     = Session["NomCandidat"].ToString();
                string prenom  = nom.Split(' ')[0];
                string initiale= prenom.Length > 0 ? prenom[0].ToString().ToUpper() : "?";
                litNavInitiale.Text   = initiale;
                litNavNom.Text        = prenom;
                pnlConnecte.Visible   = true;
                pnlDeconnecte.Visible = false;
            }
            else
            {
                pnlConnecte.Visible   = false;
                pnlDeconnecte.Visible = true;
            }
        }
    }
}
