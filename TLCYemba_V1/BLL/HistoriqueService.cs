using System.Collections.Generic;
using System.Web.SessionState;
using TLCYemba.DAL;
using TLCYemba.Models;

namespace TLCYemba.BLL
{
    public class HistoriqueService
    {
        private readonly HistoriqueRepository _repo = new HistoriqueRepository();

        public List<Resultats> GetHistorique(HttpSessionState session)
        {
            int uid = session["UtilisateurID"] != null ? (int)session["UtilisateurID"] : 0;
            return _repo.GetByUtilisateur(uid);
        }

        public List<Resultats> GetLeaderboard(int top=10)
            => _repo.GetTopScores(top);

        public Resultats GetDernierResultat(HttpSessionState session)
        {
            if(session["DernierResultatID"]==null) return null;
            return _repo.GetById((int)session["DernierResultatID"]);
        }
    }
}
