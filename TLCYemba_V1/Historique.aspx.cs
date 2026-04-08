using System;
using System.Web.UI.WebControls;
using TLCYemba.BLL;
using TLCYemba.Models;

namespace TLCYemba
{
    public partial class Historique : System.Web.UI.Page
    {
        private readonly HistoriqueService _svc = new HistoriqueService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                ChargerHistorique();
        }

        private void ChargerHistorique()
        {
            var liste = _svc.GetHistorique(Session);
            if (liste.Count == 0)
            {
                pnlEmpty.Visible = true;
                pnlTable.Visible = false;
            }
            else
            {
                pnlEmpty.Visible = false;
                pnlTable.Visible = true;
                rptHistorique.DataSource = liste;
                rptHistorique.DataBind();
            }
        }

        // Helper appelé dans le Repeater
        protected string GetCouleurNiveau(string niveau)
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
