<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Historique.aspx.cs" Inherits="TLCYemba.Historique" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Historique &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--radius:16px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;
             background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
             min-height:100vh;color:var(--txt-dark);}
        .wrap{max-width:1000px;margin:32px auto;
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
        .nav-links{display:flex;gap:4px;list-style:none}
        .nav-links a{display:flex;align-items:center;gap:6px;text-decoration:none;
            color:var(--txt-mid);font-size:13.5px;font-weight:500;
            padding:7px 14px;border-radius:50px;transition:all .2s;}
        .nav-links a:hover,.nav-links a.active{color:var(--teal);background:var(--teal-pale)}
        .nav-links a i{font-size:12px;color:var(--txt-soft)}
        .nav-links a:hover i,.nav-links a.active i{color:var(--teal)}
        /* PAGE HEADER */
        .page-hdr{padding:32px 36px 24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:16px}
        .hdr-left h1{font-family:'Nunito',sans-serif;font-weight:900;font-size:clamp(1.5rem,2.5vw,2rem);color:var(--txt-dark)}
        .hdr-left p{font-size:13.5px;color:var(--txt-soft);margin-top:4px}
        .hdr-left h1 span{color:var(--teal)}
        .btn-new{display:inline-flex;align-items:center;gap:7px;background:var(--teal);
            color:#fff;border:none;padding:11px 22px;border-radius:50px;font-size:13.5px;
            font-weight:600;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:all .2s;text-decoration:none;
            box-shadow:0 4px 14px rgba(58,175,169,.35);}
        .btn-new:hover{background:var(--teal-dark);transform:translateY(-2px)}
        /* EMPTY STATE */
        .empty{text-align:center;padding:60px 36px;color:var(--txt-soft)}
        .empty i{font-size:52px;color:rgba(58,175,169,.25);margin-bottom:16px;display:block}
        .empty p{font-size:15px}
        /* TABLE */
        .tbl-wrap{padding:0 36px 36px;overflow-x:auto}
        table{width:100%;border-collapse:collapse}
        thead th{padding:12px 16px;text-align:left;font-size:11.5px;font-weight:700;
            color:var(--txt-soft);text-transform:uppercase;letter-spacing:.5px;
            border-bottom:2px solid rgba(58,175,169,.12);}
        thead th i{color:var(--teal);margin-right:5px}
        tbody tr{border-bottom:1px solid rgba(0,0,0,.05);transition:background .15s}
        tbody tr:hover{background:var(--teal-pale)}
        tbody td{padding:14px 16px;font-size:13.5px;color:var(--txt-mid)}
        .score-cell{font-family:'Nunito',sans-serif;font-weight:900;font-size:17px;color:var(--teal-dark)}
        .niveau-pill{display:inline-flex;align-items:center;gap:5px;
            padding:4px 12px;border-radius:50px;font-size:11.5px;font-weight:700;border:1.5px solid;}
        .type-pill{display:inline-flex;align-items:center;gap:5px;
            background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.22);
            color:var(--teal-dark);padding:4px 12px;border-radius:50px;font-size:11.5px;font-weight:600;}
        .type-pill i{font-size:10px;color:var(--teal)}
        .btn-cert{display:inline-flex;align-items:center;gap:5px;
            background:#fff;color:var(--teal);border:1.5px solid rgba(58,175,169,.4);
            padding:5px 12px;border-radius:50px;font-size:11.5px;font-weight:600;
            cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s;text-decoration:none;}
        .btn-cert:hover{background:var(--teal);color:#fff}
        @media(max-width:700px){.wrap{margin:10px;border-radius:22px}
            .page-hdr,.tbl-wrap{padding-left:20px;padding-right:20px}
            nav{padding:16px 20px}}
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
      <li><a href="ChoixTest.aspx"><i class="fa-solid fa-list-check"></i>Test</a></li>
      <li><a href="Historique.aspx" class="active"><i class="fa-solid fa-chart-bar"></i>Historique</a></li>
      <li><a href="Leaderboard.aspx"><i class="fa-solid fa-ranking-star"></i>Classement</a></li>
    </ul>
  </nav>

  <div class="page-hdr">
    <div class="hdr-left">
      <h1><i class="fa-solid fa-clock-rotate-left" style="font-size:.85em;margin-right:8px"></i>Mes <span>Resultats</span></h1>
      <p>Retrouvez l'ensemble de vos tests passes et leur score TLC.</p>
    </div>
    <a href="ChoixTest.aspx" class="btn-new">
      <i class="fa-solid fa-plus"></i> Nouveau test
    </a>
  </div>

  <asp:Panel ID="pnlEmpty" runat="server" CssClass="empty" Visible="false">
    <i class="fa-solid fa-folder-open"></i>
    <p>Aucun test passe pour le moment.<br/>
       <a href="ChoixTest.aspx" style="color:var(--teal);font-weight:600">Commencez votre premier test !</a>
    </p>
  </asp:Panel>

  <asp:Panel ID="pnlTable" runat="server" CssClass="tbl-wrap">
    <table>
      <thead>
        <tr>
          <th><i class="fa-solid fa-calendar"></i>Date</th>
          <th><i class="fa-solid fa-list-check"></i>Type</th>
          <th><i class="fa-solid fa-star"></i>Score Total</th>
          <th><i class="fa-solid fa-headphones"></i>Listen.</th>
          <th><i class="fa-solid fa-pen-nib"></i>Struct.</th>
          <th><i class="fa-solid fa-book-open"></i>Reading</th>
          <th><i class="fa-solid fa-layer-group"></i>Niveau</th>
          <th><i class="fa-solid fa-certificate"></i>Certificat</th>
        </tr>
      </thead>
      <tbody>
        <asp:Repeater ID="rptHistorique" runat="server">
          <ItemTemplate>
            <tr>
              <td><%# Eval("DateTest", "{0:dd/MM/yyyy HH:mm}") %></td>
              <td>
                <span class="type-pill">
                  <i class="fa-solid fa-list-check"></i>
                  <%# Eval("TypeTest") %>
                </span>
              </td>
              <td><span class="score-cell"><%# Eval("ScoreTotal") %></span></td>
              <td><%# (int)Eval("ScoreListening") > 0 ? Eval("ScoreListening").ToString() : "&#8212;" %></td>
              <td><%# (int)Eval("ScoreStructure") > 0 ? Eval("ScoreStructure").ToString() : "&#8212;" %></td>
              <td><%# (int)Eval("ScoreReading") > 0 ? Eval("ScoreReading").ToString() : "&#8212;" %></td>
              <td>
                <span class="niveau-pill" style="color:<%# GetCouleurNiveau(Eval("Niveau").ToString()) %>;border-color:<%# GetCouleurNiveau(Eval("Niveau").ToString()) %>44;background:<%# GetCouleurNiveau(Eval("Niveau").ToString()) %>12">
                  <%# Eval("Niveau") %>
                </span>
              </td>
              <td>
                <a href='<%# "Certificat.aspx?id=" + Eval("ResultatID") %>' class="btn-cert">
                  <i class="fa-solid fa-certificate"></i> Voir
                </a>
              </td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
      </tbody>
    </table>
  </asp:Panel>
</div>
</form>
</body>
</html>
