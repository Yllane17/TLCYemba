using System;

namespace TLCYemba
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        private const string ADMIN_EMAIL = "yougo@gmail.com";
        private const string ADMIN_PASS  = "yougo19";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsAdmin"] != null && (bool)Session["IsAdmin"])
                Response.Redirect("AdminDashboard.aspx");
        }

        protected void btnConnecter_Click(object sender, EventArgs e)
        {
            if (txtEmail.Text.Trim() == ADMIN_EMAIL && txtMdp.Text == ADMIN_PASS)
            {
                Session["IsAdmin"] = true;
                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
                litErreur.Text    = "Identifiants administrateur incorrects.";
                pnlErreur.Visible = true;
            }
        }
    }
}
