<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TLCYemba.Dashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Dashboard &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--radius:18px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;
             background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
             min-height:100vh;color:var(--txt-dark);}
        .wrap{max-width:1000px;margin:28px auto;
              background:rgba(255,255,255,.93);border-radius:28px;
              box-shadow:0 8px 48px rgba(58,175,169,.16);overflow:hidden;}
        /* NAV */
        nav{display:flex;align-items:center;justify-content:space-between;
            padding:18px 36px;background:rgba(255,255,255,.98);
            border-bottom:1.5px solid rgba(58,175,169,.10);}
        .nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none}
        .li{width:36px;height:36px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:15px;color:#fff;}
        .lt{font-family:'Nunito',sans-serif;font-weight:900;font-size:17px;color:var(--txt-dark)}
        .lt span{color:var(--teal)}
        .nav-right{display:flex;align-items:center;gap:10px}
        .nav-user{display:flex;align-items:center;gap:8px;font-size:13.5px;color:var(--txt-mid);font-weight:500}
        .user-avatar{width:34px;height:34px;background:var(--teal);border-radius:50%;
                     display:flex;align-items:center;justify-content:center;font-size:14px;color:white;font-weight:700}
        .btn-deco{display:inline-flex;align-items:center;gap:6px;
                  background:#F7FAFC;color:var(--txt-mid);border:1.5px solid #E2E8F0;
                  padding:7px 14px;border-radius:50px;font-size:12.5px;font-weight:600;
                  cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s;}
        .btn-deco:hover{background:#FFF5F5;color:#C53030;border-color:#FEB2B2}
        /* WELCOME BANNER */
        .welcome{padding:32px 36px 24px;
                 background:linear-gradient(135deg,rgba(58,175,169,.08),rgba(255,255,255,0));
                 border-bottom:1.5px solid rgba(58,175,169,.10);}
        .welcome h1{font-family:'Nunito',sans-serif;font-weight:900;
                    font-size:clamp(1.4rem,2.5vw,1.9rem);color:var(--txt-dark);margin-bottom:4px;}
        .welcome h1 span{color:var(--teal)}
        .welcome p{font-size:13.5px;color:var(--txt-soft)}
        /* STATS CARDS */
        .stats-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;padding:24px 36px}
        .stat-card{background:white;border-radius:var(--radius);padding:20px 18px;
                   box-shadow:0 2px 16px rgba(0,0,0,.05);text-align:center;
                   transition:transform .2s,box-shadow .2s;}
        .stat-card:hover{transform:translateY(-4px);box-shadow:0 8px 28px rgba(58,175,169,.12)}
        .sc-icon{width:48px;height:48px;border-radius:14px;margin:0 auto 12px;
                 display:flex;align-items:center;justify-content:center;}
        .sc-icon i{font-size:22px}
        .sc-val{font-family:'Nunito',sans-serif;font-weight:900;font-size:26px;color:var(--txt-dark)}
        .sc-lbl{font-size:11.5px;color:var(--txt-soft);font-weight:600;
                text-transform:uppercase;letter-spacing:.4px;margin-top:3px}
        /* DERNIER SCORE */
        .section-title{font-family:'Nunito',sans-serif;font-weight:800;font-size:16px;
                       color:var(--txt-dark);margin-bottom:14px;display:flex;align-items:center;gap:8px}
        .section-title i{color:var(--teal)}
        .last-score-zone{padding:0 36px 24px}
        .last-score-card{background:linear-gradient(135deg,var(--teal),var(--teal-dark));
                         border-radius:var(--radius);padding:24px 28px;
                         display:flex;align-items:center;gap:24px;color:white;}
        .ls-circle{width:80px;height:80px;border-radius:50%;background:rgba(255,255,255,.2);
                   border:3px solid rgba(255,255,255,.5);
                   display:flex;flex-direction:column;align-items:center;justify-content:center;
                   flex-shrink:0;}
        .ls-num{font-family:'Nunito',sans-serif;font-weight:900;font-size:24px;line-height:1}
        .ls-sub{font-size:9.5px;opacity:.75;letter-spacing:.3px}
        .ls-info{display:flex;flex-direction:column;gap:4px}
        .ls-niveau{font-family:'Nunito',sans-serif;font-weight:900;font-size:18px}
        .ls-meta{font-size:12.5px;opacity:.8;display:flex;align-items:center;gap:6px}
        .ls-meta i{font-size:11px}
        .ls-actions{display:flex;gap:10px;margin-left:auto;flex-wrap:wrap}
        .ls-btn{display:inline-flex;align-items:center;gap:6px;
                background:rgba(255,255,255,.2);color:white;border:1.5px solid rgba(255,255,255,.4);
                padding:8px 16px;border-radius:50px;font-size:12.5px;font-weight:600;
                cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s;text-decoration:none;}
        .ls-btn:hover{background:rgba(255,255,255,.35)}
        .no-score{background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.22);
                  border-radius:var(--radius);padding:24px;text-align:center;color:var(--txt-soft)}
        .no-score i{font-size:32px;color:rgba(58,175,169,.35);margin-bottom:8px;display:block}
        /* QUICK ACTIONS */
        .actions-zone{padding:0 36px 36px}
        .actions-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:14px}
        .action-card{background:white;border-radius:var(--radius);padding:22px 18px;
                     box-shadow:0 2px 14px rgba(0,0,0,.05);
                     display:flex;flex-direction:column;align-items:center;gap:10px;
                     text-decoration:none;transition:all .2s;border:2px solid transparent;}
        .action-card:hover{border-color:var(--teal);transform:translateY(-4px);
                           box-shadow:0 8px 28px rgba(58,175,169,.15)}
        .action-card .ac-icon{width:52px;height:52px;border-radius:16px;
                              display:flex;align-items:center;justify-content:center;}
        .action-card .ac-icon i{font-size:24px}
        .action-card .ac-title{font-family:'Nunito',sans-serif;font-weight:800;
                                font-size:14.5px;color:var(--txt-dark)}
        .action-card .ac-sub{font-size:11.5px;color:var(--txt-soft);text-align:center}
        @media(max-width:720px){
            .wrap{margin:10px;border-radius:20px}
            .stats-grid{grid-template-columns:1fr 1fr}
            .actions-grid{grid-template-columns:1fr}
            .last-score-card{flex-direction:column;align-items:flex-start}
            .ls-actions{margin-left:0}
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="wrap">
    <!-- NAV -->
    <nav>
        <a href="Default.aspx" class="nav-logo">
            <div class="li">T</div><span class="lt">TLC <span>Yemba</span></span>
        </a>
        <div class="nav-right">
            <div class="nav-user">
                <div class="user-avatar"><asp:Literal ID="litInitiale" runat="server"/></div>
                <asp:Literal ID="litNomNav" runat="server"/>
            </div>
            <asp:Button ID="btnDeconnecter" runat="server" Text="Se deconnecter"
                CssClass="btn-deco" OnClick="btnDeconnecter_Click"/>
        </div>
    </nav>

    <!-- WELCOME -->
    <div class="welcome">
        <h1>Bonjour, <span><asp:Literal ID="litPrenom" runat="server"/></span> !</h1>
        <p>Voici un apercu de votre progression sur la plateforme TLC Yemba.</p>
    </div>

    <!-- STATS -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="sc-icon" style="background:rgba(58,175,169,.12)">
                <i class="fa-solid fa-list-check" style="color:var(--teal)"></i>
            </div>
            <div class="sc-val"><asp:Literal ID="litNbTests" runat="server">0</asp:Literal></div>
            <div class="sc-lbl">Tests passes</div>
        </div>
        <div class="stat-card">
            <div class="sc-icon" style="background:rgba(72,187,120,.12)">
                <i class="fa-solid fa-star" style="color:#38A169"></i>
            </div>
            <div class="sc-val"><asp:Literal ID="litMeilleurScore" runat="server">&#8212;</asp:Literal></div>
            <div class="sc-lbl">Meilleur score</div>
        </div>
        <div class="stat-card">
            <div class="sc-icon" style="background:rgba(99,179,237,.12)">
                <i class="fa-solid fa-chart-line" style="color:#4299E1"></i>
            </div>
            <div class="sc-val"><asp:Literal ID="litScoreMoyen" runat="server">&#8212;</asp:Literal></div>
            <div class="sc-lbl">Score moyen</div>
        </div>
        <div class="stat-card">
            <div class="sc-icon" style="background:rgba(237,137,54,.12)">
                <i class="fa-solid fa-trophy" style="color:#DD6B20"></i>
            </div>
            <div class="sc-val"><asp:Literal ID="litNiveau" runat="server">&#8212;</asp:Literal></div>
            <div class="sc-lbl">Niveau actuel</div>
        </div>
    </div>

    <!-- DERNIER SCORE -->
    <div class="last-score-zone">
        <div class="section-title">
            <i class="fa-solid fa-clock-rotate-left"></i> Dernier test
        </div>
        <asp:Panel ID="pnlDernierScore" runat="server">
            <div class="last-score-card">
                <div class="ls-circle">
                    <div class="ls-num"><asp:Literal ID="litDernierScore" runat="server"/></div>
                    <div class="ls-sub">pts TLC</div>
                </div>
                <div class="ls-info">
                    <div class="ls-niveau"><asp:Literal ID="litDernierNiveau" runat="server"/></div>
                    <div class="ls-meta">
                        <i class="fa-solid fa-list-check"></i><asp:Literal ID="litDernierType" runat="server"/>
                        &nbsp;&nbsp;<i class="fa-solid fa-calendar"></i><asp:Literal ID="litDernierDate" runat="server"/>
                    </div>
                </div>
                <div class="ls-actions">
                    <a href="Historique.aspx" class="ls-btn"><i class="fa-solid fa-clock-rotate-left"></i>Historique</a>
                    <a href="Certificat.aspx" class="ls-btn"><i class="fa-solid fa-certificate"></i>Certificat</a>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlPasDeScore" runat="server" Visible="false">
            <div class="no-score">
                <i class="fa-solid fa-chart-bar"></i>
                <p>Aucun test passe. Lancez votre premier test !</p>
            </div>
        </asp:Panel>
    </div>

    <!-- QUICK ACTIONS -->
    <div class="actions-zone">
        <div class="section-title">
            <i class="fa-solid fa-rocket"></i> Actions rapides
        </div>
        <div class="actions-grid">
            <a href="ChoixTest.aspx" class="action-card">
                <div class="ac-icon" style="background:rgba(58,175,169,.12)"><i class="fa-solid fa-play" style="color:var(--teal)"></i></div>
                <div class="ac-title">Nouveau test</div>
                <div class="ac-sub">Lancer un test TLC Yemba</div>
            </a>
            <a href="Historique.aspx" class="action-card">
                <div class="ac-icon" style="background:rgba(99,179,237,.12)"><i class="fa-solid fa-chart-bar" style="color:#4299E1"></i></div>
                <div class="ac-title">Mon historique</div>
                <div class="ac-sub">Tous mes resultats passes</div>
            </a>
            <a href="Leaderboard.aspx" class="action-card">
                <div class="ac-icon" style="background:rgba(237,137,54,.12)"><i class="fa-solid fa-ranking-star" style="color:#DD6B20"></i></div>
                <div class="ac-title">Classement</div>
                <div class="ac-sub">Top 10 des candidats TLC</div>
            </a>
        </div>
    </div>
</div>
</form>
</body>
</html>