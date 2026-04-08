using System;

namespace TLCYemba
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool connecte = Session["UtilisateurID"] != null
                            && Session["NomCandidat"]?.ToString() != "Invite";

            if (connecte)
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
