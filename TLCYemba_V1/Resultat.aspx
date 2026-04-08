<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Resultat.aspx.cs" Inherits="TLCYemba.Resultat" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Resultats &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
            --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;
            --white:#fff;--radius:18px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;
            background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
            min-height:100vh;color:var(--txt-dark);}
        .page-wrapper{max-width:860px;margin:32px auto;
            background:rgba(255,255,255,.93);backdrop-filter:blur(20px);
            border-radius:28px;box-shadow:0 8px 48px rgba(58,175,169,.16);
            overflow:hidden;}

        /* TOP BAR */
        .top-bar{display:flex;align-items:center;justify-content:space-between;
            padding:18px 36px;background:rgba(255,255,255,.98);
            border-bottom:1.5px solid rgba(58,175,169,.12);}
        .top-logo{display:flex;align-items:center;gap:10px;text-decoration:none}
        .logo-icon{width:38px;height:38px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:16px;color:#fff;}
        .logo-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:17px;color:var(--txt-dark)}
        .logo-text span{color:var(--teal)}
        .top-date{font-size:12.5px;color:var(--txt-soft);display:flex;align-items:center;gap:6px}
        .top-date i{color:var(--teal)}

        /* HERO SCORE */
        .score-hero{padding:40px 36px 32px;text-align:center;
            background:linear-gradient(135deg,rgba(58,175,169,.06) 0%,rgba(255,255,255,0) 100%);}
        .confetti-row{font-size:28px;margin-bottom:16px;animation:bounce .6s ease}
        @keyframes bounce{0%,100%{transform:translateY(0)}40%{transform:translateY(-12px)}}

        .score-circle-wrap{position:relative;width:180px;height:180px;margin:0 auto 24px}
        .score-circle-bg{fill:none;stroke:#E2E8F0;stroke-width:12}
        .score-circle-fill{fill:none;stroke-width:12;stroke-linecap:round;
            transform:rotate(-90deg);transform-origin:50% 50%;
            transition:stroke-dashoffset 1.4s cubic-bezier(.4,0,.2,1);}
        .score-circle-text{position:absolute;inset:0;display:flex;flex-direction:column;
            align-items:center;justify-content:center;}
        .score-num{font-family:'Nunito',sans-serif;font-weight:900;font-size:42px;color:var(--teal-dark)}
        .score-label{font-size:11px;color:var(--txt-soft);font-weight:600;text-transform:uppercase;letter-spacing:.5px}
        .score-max{font-size:12px;color:var(--txt-soft)}

        .niveau-badge{display:inline-flex;align-items:center;gap:8px;
            padding:8px 22px;border-radius:50px;
            border:2px solid;font-size:14px;font-weight:700;
            margin-bottom:14px;letter-spacing:.3px;}
        .niveau-badge i{font-size:13px}

        .score-message{font-size:14.5px;color:var(--txt-mid);max-width:480px;
            margin:0 auto;line-height:1.7;}

        .type-test-tag{display:inline-flex;align-items:center;gap:7px;
            background:var(--teal-pale);border:1.5px solid rgba(58,175,169,.25);
            color:var(--teal-dark);padding:6px 16px;border-radius:50px;
            font-size:12px;font-weight:600;margin-top:14px;}
        .type-test-tag i{font-size:11px;color:var(--teal)}

        /* PROGRESS GLOBAL */
        .global-progress{padding:0 36px 28px}
        .gp-header{display:flex;justify-content:space-between;
            align-items:center;margin-bottom:10px}
        .gp-label{font-size:13px;font-weight:600;color:var(--txt-mid);
            display:flex;align-items:center;gap:6px}
        .gp-label i{color:var(--teal)}
        .gp-pct{font-family:'Nunito',sans-serif;font-weight:900;font-size:16px;color:var(--teal)}
        .gp-bar{height:12px;background:#E2E8F0;border-radius:50px;overflow:hidden}
        .gp-fill{height:100%;border-radius:50px;transition:width 1.2s ease;}

        /* SECTION CARDS */
        .sections-grid{display:grid;grid-template-columns:repeat(3,1fr);
            gap:16px;padding:0 36px 28px;}
        .sec-card{background:var(--white);border-radius:var(--radius);
            padding:22px 20px;box-shadow:0 2px 16px rgba(0,0,0,.06);
            display:flex;flex-direction:column;gap:12px;
            animation:fadeUp .5s ease both;}
        .sec-card:nth-child(1){animation-delay:.1s}
        .sec-card:nth-child(2){animation-delay:.2s}
        .sec-card:nth-child(3){animation-delay:.3s}
        .sec-header{display:flex;align-items:center;gap:10px}
        .sec-icon{width:40px;height:40px;border-radius:12px;
            display:flex;align-items:center;justify-content:center;flex-shrink:0}
        .sec-icon i{font-size:18px}
        .icon-L{background:rgba(58,175,169,.12)} .icon-L i{color:var(--teal)}
        .icon-S{background:rgba(99,179,237,.12)} .icon-S i{color:#4299E1}
        .icon-R{background:rgba(72,187,120,.12)} .icon-R i{color:#38A169}
        .sec-name{font-family:'Nunito',sans-serif;font-weight:800;font-size:14px;color:var(--txt-dark)}
        .sec-subscore{font-size:11px;color:var(--txt-soft)}
        .sec-score-num{font-family:'Nunito',sans-serif;font-weight:900;font-size:28px;color:var(--teal-dark)}
        .sec-score-brut{font-size:11.5px;color:var(--txt-soft)}
        .sec-bar{height:6px;background:#E2E8F0;border-radius:50px;overflow:hidden}
        .sec-bar-fill{height:100%;border-radius:50px;transition:width 1.2s .3s ease}
        .fill-L{background:linear-gradient(90deg,#3AAFA9,#44C4BE)}
        .fill-S{background:linear-gradient(90deg,#4299E1,#63B3ED)}
        .fill-R{background:linear-gradient(90deg,#38A169,#68D391)}

        /* GRILLE NIVEAUX */
        .levels-section{padding:0 36px 28px}
        .levels-title{font-family:'Nunito',sans-serif;font-weight:800;font-size:16px;
            color:var(--txt-dark);margin-bottom:14px;display:flex;align-items:center;gap:8px}
        .levels-title i{color:var(--teal)}
        .levels-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:8px}
        .level-item{padding:10px 8px;border-radius:12px;text-align:center;
            border:2px solid transparent;transition:all .2s;}
        .level-item.active{border-color:currentColor;transform:scale(1.05)}
        .level-dot{width:12px;height:12px;border-radius:50%;margin:0 auto 6px}
        .level-name{font-size:10.5px;font-weight:700}
        .level-range{font-size:9.5px;opacity:.7}

        /* ACTION BUTTONS */
        .action-zone{padding:20px 36px 36px;display:flex;gap:14px;
            justify-content:center;flex-wrap:wrap;}
        .btn-action{display:inline-flex;align-items:center;gap:9px;
            padding:13px 28px;border-radius:50px;font-size:14.5px;font-weight:700;
            cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s;border:none;}
        .btn-primary{background:var(--teal);color:#fff;
            box-shadow:0 4px 16px rgba(58,175,169,.38);}
        .btn-primary:hover{background:var(--teal-dark);transform:translateY(-2px)}
        .btn-secondary{background:#fff;color:var(--teal);border:2px solid var(--teal);}
        .btn-secondary:hover{background:var(--teal);color:#fff;transform:translateY(-2px)}
        .btn-history{background:#F7FAFC;color:var(--txt-mid);border:2px solid #E2E8F0;}
        .btn-history:hover{background:#EDF2F7;transform:translateY(-2px)}

        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        @media(max-width:680px){
            .page-wrapper{margin:12px;border-radius:22px}
            .top-bar,.score-hero,.sections-grid,.global-progress,
            .levels-section,.action-zone{padding-left:20px;padding-right:20px}
            .sections-grid{grid-template-columns:1fr}
            .levels-grid{grid-template-columns:repeat(3,1fr)}
            .action-zone{flex-direction:column;align-items:stretch}
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="page-wrapper">

  <!-- TOP BAR -->
  <div class="top-bar">
    <a href="Default.aspx" class="top-logo">
      <div class="logo-icon">T</div>
      <span class="logo-text">TLC <span>Yemba</span></span>
    </a>
    <div class="top-date">
      <i class="fa-solid fa-calendar-check"></i>
      <asp:Literal ID="litDate" runat="server"/>
    </div>
  </div>

  <!-- HERO SCORE -->
  <div class="score-hero">
    <div class="confetti-row">&#127881;</div>

    <!-- Cercle score animé -->
    <div class="score-circle-wrap">
      <svg viewBox="0 0 180 180" width="180" height="180">
        <circle class="score-circle-bg" cx="90" cy="90" r="74"/>
        <circle id="scoreArc" class="score-circle-fill" cx="90" cy="90" r="74"
                stroke="var(--teal)"
                stroke-dasharray="465"
                stroke-dashoffset="465"/>
      </svg>
      <div class="score-circle-text">
        <div class="score-num"><asp:Literal ID="litScoreTotal" runat="server"/></div>
        <div class="score-label">Score TLC</div>
        <div class="score-max">/ 677</div>
      </div>
    </div>

    <!-- Badge niveau -->
    <asp:Panel ID="pnlNiveauBadge" runat="server" CssClass="niveau-badge" style="display:inline-flex">
      <i class="fa-solid fa-star"></i>
      Niveau : <asp:Literal ID="litNiveau" runat="server"/>
    </asp:Panel>

    <p class="score-message">
      <asp:Literal ID="litMessage" runat="server"/>
    </p>

    <div class="type-test-tag">
      <i class="fa-solid fa-list-check"></i>
      <asp:Literal ID="litTypeTest" runat="server"/>
    </div>
  </div>

  <!-- PROGRESS GLOBAL -->
  <div class="global-progress">
    <div class="gp-header">
      <span class="gp-label"><i class="fa-solid fa-percent"></i> Score global</span>
      <span class="gp-pct"><asp:Literal ID="litPourcentage" runat="server"/>%</span>
    </div>
    <div class="gp-bar">
      <asp:Panel ID="progressGlobal" runat="server" CssClass="gp-fill" style="width:0%"/>
    </div>
  </div>

  <!-- SCORES PAR SECTION -->
  <div class="sections-grid">

    <!-- Listening -->
    <div class="sec-card">
      <div class="sec-header">
        <div class="sec-icon icon-L"><i class="fa-solid fa-headphones"></i></div>
        <div>
          <div class="sec-name">Listening</div>
          <div class="sec-subscore">31 &#8211; 68 pts</div>
        </div>
      </div>
      <div class="sec-score-num"><asp:Literal ID="litScoreL" runat="server"/></div>
      <div class="sec-score-brut">
        <i class="fa-solid fa-check-circle" style="color:var(--teal)"></i>
        <asp:Literal ID="litBrutL" runat="server"/> bonnes reponses
      </div>
      <div class="sec-bar">
        <asp:Panel ID="progressL" runat="server" CssClass="sec-bar-fill fill-L" style="width:0%"/>
      </div>
    </div>

    <!-- Structure -->
    <div class="sec-card">
      <div class="sec-header">
        <div class="sec-icon icon-S"><i class="fa-solid fa-pen-nib"></i></div>
        <div>
          <div class="sec-name">Structure</div>
          <div class="sec-subscore">31 &#8211; 68 pts</div>
        </div>
      </div>
      <div class="sec-score-num"><asp:Literal ID="litScoreS" runat="server"/></div>
      <div class="sec-score-brut">
        <i class="fa-solid fa-check-circle" style="color:#4299E1"></i>
        <asp:Literal ID="litBrutS" runat="server"/> bonnes reponses
      </div>
      <div class="sec-bar">
        <asp:Panel ID="progressS" runat="server" CssClass="sec-bar-fill fill-S" style="width:0%"/>
      </div>
    </div>

    <!-- Reading -->
    <div class="sec-card">
      <div class="sec-header">
        <div class="sec-icon icon-R"><i class="fa-solid fa-book-open"></i></div>
        <div>
          <div class="sec-name">Reading</div>
          <div class="sec-subscore">31 &#8211; 67 pts</div>
        </div>
      </div>
      <div class="sec-score-num"><asp:Literal ID="litScoreR" runat="server"/></div>
      <div class="sec-score-brut">
        <i class="fa-solid fa-check-circle" style="color:#38A169"></i>
        <asp:Literal ID="litBrutR" runat="server"/> bonnes reponses
      </div>
      <div class="sec-bar">
        <asp:Panel ID="progressR" runat="server" CssClass="sec-bar-fill fill-R" style="width:0%"/>
      </div>
    </div>

  </div>

  <!-- GRILLE DES NIVEAUX -->
  <div class="levels-section">
    <div class="levels-title">
      <i class="fa-solid fa-layer-group"></i> Echelle des niveaux TLC
    </div>
    <div class="levels-grid">
      <div class="level-item" style="color:#E53E3E">
        <div class="level-dot" style="background:#E53E3E"></div>
        <div class="level-name">Debutant</div>
        <div class="level-range">310&#8211;397</div>
      </div>
      <div class="level-item" style="color:#DD6B20">
        <div class="level-dot" style="background:#DD6B20"></div>
        <div class="level-name">Elementaire</div>
        <div class="level-range">398&#8211;467</div>
      </div>
      <div class="level-item" style="color:#D69E2E">
        <div class="level-dot" style="background:#D69E2E"></div>
        <div class="level-name">Intermediaire</div>
        <div class="level-range">468&#8211;527</div>
      </div>
      <div class="level-item" style="color:#38A169">
        <div class="level-dot" style="background:#38A169"></div>
        <div class="level-name">Avance</div>
        <div class="level-range">528&#8211;587</div>
      </div>
      <div class="level-item" style="color:var(--teal)">
        <div class="level-dot" style="background:var(--teal)"></div>
        <div class="level-name">Courant</div>
        <div class="level-range">588&#8211;677</div>
      </div>
    </div>
  </div>

  <!-- ACTION BUTTONS -->
  <div class="action-zone">
    <asp:Button ID="btnNouveauTest" runat="server"
      Text="Nouveau Test"
      CssClass="btn-action btn-primary"
      OnClick="btnNouveauTest_Click"/>

    <a href="Certificat.aspx" class="btn-action btn-secondary">
      <i class="fa-solid fa-certificate"></i> Mon Certificat
    </a>

    <asp:Button ID="btnVoirHistorique" runat="server"
      Text="Voir l'Historique"
      CssClass="btn-action btn-history"
      OnClick="btnVoirHistorique_Click"/>
  </div>

</div>
</form>

<script>
window.addEventListener('DOMContentLoaded', function(){
    // Animer le cercle de score
    var scoreEl = document.querySelector('.score-num');
    var arc     = document.getElementById('scoreArc');
    if(scoreEl && arc){
        var score   = parseInt(scoreEl.textContent) || 310;
        var pct     = Math.max(0, Math.min(1, (score - 310) / (677 - 310)));
        var circ    = 2 * Math.PI * 74;
        var offset  = circ * (1 - pct);
        setTimeout(function(){
            arc.style.strokeDasharray  = circ;
            arc.style.strokeDashoffset = offset;
        }, 200);
    }

    // Surligner le niveau actif
    var niveauEl = document.querySelector('.niveau-badge');
    if(niveauEl){
        var niveauText = niveauEl.textContent.replace('Niveau :','').trim();
        document.querySelectorAll('.level-item').forEach(function(el){
            if(el.querySelector('.level-name').textContent.trim() === niveauText){
                el.classList.add('active');
                el.style.background = el.style.color + '18';
            }
        });
    }
});
</script>
</body>
</html>
