<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Leaderboard.aspx.cs" Inherits="TLCYemba.Leaderboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Classement &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--radius:16px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;
             background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
             min-height:100vh;}
        .wrap{max-width:780px;margin:32px auto;
              background:rgba(255,255,255,.93);border-radius:28px;
              box-shadow:0 8px 48px rgba(58,175,169,.16);overflow:hidden;}
        nav{display:flex;align-items:center;justify-content:space-between;
            padding:18px 36px;background:rgba(255,255,255,.98);
            border-bottom:1.5px solid rgba(58,175,169,.10);}
        .nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none}
        .li{width:36px;height:36px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:15px;color:#fff;}
        .lt{font-family:'Nunito',sans-serif;font-weight:900;font-size:17px;color:var(--txt-dark)}
        .lt span{color:var(--teal)}
        .nav-links{display:flex;gap:4px;list-style:none}
        .nav-links a{display:flex;align-items:center;gap:6px;text-decoration:none;
            color:var(--txt-mid);font-size:13.5px;font-weight:500;
            padding:7px 14px;border-radius:50px;transition:all .2s;}
        .nav-links a:hover,.nav-links a.active{color:var(--teal);background:var(--teal-pale)}
        .nav-links a i{font-size:12px;color:var(--txt-soft)}
        .nav-links a:hover i,.nav-links a.active i{color:var(--teal)}
        /* PODIUM */
        .podium-hdr{padding:32px 36px 8px;text-align:center}
        .podium-hdr h1{font-family:'Nunito',sans-serif;font-weight:900;
            font-size:clamp(1.4rem,2.2vw,1.9rem);color:var(--txt-dark);margin-bottom:4px}
        .podium-hdr h1 span{color:var(--teal)}
        .podium-hdr p{font-size:13px;color:var(--txt-soft)}
        .podium-row{display:flex;align-items:flex-end;justify-content:center;
            gap:12px;padding:24px 36px 12px}
        .podium-item{display:flex;flex-direction:column;align-items:center;gap:8px;flex:1;max-width:180px}
        .podium-avatar{border-radius:50%;display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;color:white;flex-shrink:0}
        .podium-block{width:100%;border-radius:12px 12px 0 0;display:flex;
            align-items:center;justify-content:center;flex-direction:column;gap:4px;padding:12px 8px}
        .podium-rank{font-size:22px}
        .podium-score{font-family:'Nunito',sans-serif;font-weight:900;font-size:20px;color:white}
        .podium-niveau{font-size:10.5px;color:rgba(255,255,255,.78);font-weight:600}
        .p1 .podium-block{background:linear-gradient(135deg,#F6AD55,#ED8936);height:100px}
        .p2 .podium-block{background:linear-gradient(135deg,#A0AEC0,#718096);height:80px}
        .p3 .podium-block{background:linear-gradient(135deg,#68D391,#38A169);height:65px}
        .p1 .podium-avatar{width:60px;height:60px;background:#ED8936;font-size:20px}
        .p2 .podium-avatar{width:50px;height:50px;background:#718096;font-size:16px}
        .p3 .podium-avatar{width:50px;height:50px;background:#38A169;font-size:16px}
        /* RANKING LIST */
        .ranking-list{padding:0 36px 36px}
        .rank-row{display:flex;align-items:center;gap:14px;
            padding:14px 18px;border-radius:var(--radius);margin-bottom:8px;
            background:white;box-shadow:0 1px 8px rgba(0,0,0,.05);transition:all .2s;}
        .rank-row:hover{box-shadow:0 4px 16px rgba(58,175,169,.12);transform:translateX(4px)}
        .rank-row.me{border:2px solid var(--teal);background:var(--teal-pale)}
        .rank-num{width:32px;height:32px;border-radius:9px;background:#F7FAFC;
            border:1.5px solid #E2E8F0;display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:14px;color:var(--txt-mid);flex-shrink:0}
        .rank-num.top3{background:var(--teal);border-color:var(--teal);color:white}
        .rank-info{display:flex;flex-direction:column;gap:2px;flex:1}
        .rank-name{font-size:14px;font-weight:600;color:var(--txt-dark)}
        .rank-meta{font-size:11.5px;color:var(--txt-soft);display:flex;align-items:center;gap:8px}
        .rank-meta i{font-size:10px;color:var(--teal)}
        .rank-score{font-family:'Nunito',sans-serif;font-weight:900;font-size:20px;color:var(--teal-dark)}
        .rank-niveau{display:inline-flex;align-items:center;padding:3px 10px;border-radius:50px;
            font-size:10.5px;font-weight:700;border:1.5px solid;}
        @media(max-width:600px){.wrap{margin:10px;border-radius:20px}
            .podium-row,.ranking-list,.podium-hdr{padding-left:18px;padding-right:18px}
            nav{padding:14px 18px}}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="wrap">
  <nav>
    <a href="Default.aspx" class="nav-logo">
      <div class="li">T</div><span class="lt">TLC <span>Yemba</span></span>
    </a>
    <ul class="nav-links">
      <li><a href="Default.aspx"><i class="fa-solid fa-house"></i>Accueil</a></li>
      <li><a href="Historique.aspx"><i class="fa-solid fa-chart-bar"></i>Historique</a></li>
      <li><a href="Leaderboard.aspx" class="active"><i class="fa-solid fa-ranking-star"></i>Classement</a></li>
    </ul>
  </nav>

  <div class="podium-hdr">
    <h1><i class="fa-solid fa-trophy" style="font-size:.85em;margin-right:8px;color:#ED8936"></i>Meilleurs <span>Scores</span></h1>
    <p>Top 10 des candidats TLC Yemba</p>
  </div>

  <!-- Podium top 3 -->
  <asp:Panel ID="pnlPodium" runat="server" CssClass="podium-row">
    <asp:Literal ID="litPodium" runat="server"/>
  </asp:Panel>

  <!-- Liste complete -->
  <div class="ranking-list">
    <asp:Repeater ID="rptLeaderboard" runat="server">
      <ItemTemplate>
        <div class="rank-row <%# IsMe(Eval("UtilisateurID")) ? "me" : "" %>">
          <div class="rank-num <%# (int)Eval("Rang") <= 3 ? "top3" : "" %>">
            <%# Eval("Rang") %>
          </div>
          <div class="rank-info">
            <div class="rank-name">
              <%# IsMe(Eval("UtilisateurID")) ? "&#11088; Vous" : "Candidat #" + Eval("UtilisateurID") %>
            </div>
            <div class="rank-meta">
              <i class="fa-solid fa-list-check"></i><%# Eval("TypeTest") %>&nbsp;&nbsp;
              <i class="fa-solid fa-calendar"></i><%# Eval("DateTest","{0:dd/MM/yyyy}") %>
            </div>
          </div>
          <span class="rank-niveau" style="color:<%# GetCouleur(Eval("Niveau").ToString()) %>;border-color:<%# GetCouleur(Eval("Niveau").ToString()) %>44">
            <%# Eval("Niveau") %>
          </span>
          <div class="rank-score"><%# Eval("ScoreTotal") %></div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>

</div>
</form>
</body>
</html>
