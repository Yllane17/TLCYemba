<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TLCYemba.Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>TLC Yemba &#8212; Test de Langue du Cameroun</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <!-- Splash screen (first page only) -->
    
    <style>
        /* === Base variables === */
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;--teal-mid:#DEF2F1;
              --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--white:#fff;--radius:18px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        body{font-family:'Poppins',sans-serif;
             background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
             min-height:100vh;color:var(--txt-dark);}
        .bg-wave{position:fixed;inset:0;z-index:0;pointer-events:none}
        .bg-wave svg{width:100%;height:100%}
        .page-wrapper{position:relative;z-index:1;max-width:1280px;margin:32px auto;
            background:rgba(255,255,255,.85);backdrop-filter:blur(20px);
            border-radius:32px;box-shadow:0 8px 64px rgba(58,175,169,.18);overflow:hidden;}

        /* ══ NAVBAR ══ */
        nav{display:flex;align-items:center;justify-content:space-between;
            padding:20px 52px;background:rgba(255,255,255,.97);
            border-bottom:1.5px solid rgba(58,175,169,.10);}
        .nav-logo{display:flex;align-items:center;gap:13px;text-decoration:none}
        .logo-icon{width:44px;height:44px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:19px;color:#fff;
            box-shadow:0 4px 14px rgba(58,175,169,.4);}
        .logo-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:19px;color:var(--txt-dark)}
        .logo-text span{color:var(--teal)}
        .nav-links{display:flex;gap:4px;list-style:none}
        .nav-links a{display:flex;align-items:center;gap:7px;text-decoration:none;
            color:var(--txt-mid);font-size:14px;font-weight:500;
            padding:8px 16px;border-radius:50px;transition:all .2s;}
        .nav-links a i{font-size:13px;color:var(--txt-soft);transition:color .2s}
        .nav-links a:hover{color:var(--teal);background:var(--teal-pale)}
        .nav-links a:hover i{color:var(--teal)}
        /* Bouton droit dynamique */
        .nav-user-btn{display:inline-flex;align-items:center;gap:9px;
            background:var(--teal);color:#fff;border:none;
            padding:10px 22px;border-radius:50px;font-size:14px;font-weight:600;
            cursor:pointer;font-family:'Poppins',sans-serif;
            transition:background .2s,transform .15s,box-shadow .2s;
            box-shadow:0 4px 16px rgba(58,175,169,.38);text-decoration:none;}
        .nav-user-btn:hover{background:var(--teal-dark);transform:translateY(-2px)}
        .nav-user-btn .user-avatar-sm{width:28px;height:28px;background:rgba(255,255,255,.3);
            border-radius:50%;display:flex;align-items:center;justify-content:center;
            font-weight:900;font-size:12px;}

        /* ══ HERO ══ */
        .hero{display:grid;grid-template-columns:1fr 1fr;align-items:center;
            padding:60px 52px 44px;gap:16px;}
        .hero-left{display:flex;flex-direction:column;gap:24px}
        .hero-badge{display:inline-flex;align-items:center;gap:8px;background:var(--teal-pale);
            border:1.5px solid rgba(58,175,169,.25);color:var(--teal-dark);
            padding:7px 18px;border-radius:50px;font-size:12.5px;font-weight:600;
            width:fit-content;animation:fadeUp .5s ease both;}
        .hero-badge i{font-size:11px;color:var(--teal)}
        .hero-title{font-family:'Nunito',sans-serif;font-size:clamp(2rem,3.4vw,2.85rem);
            font-weight:900;line-height:1.17;color:var(--txt-dark);
            animation:fadeUp .5s .1s ease both;}
        .hero-title span{color:var(--teal)}
        .hero-desc{font-size:14.5px;color:var(--txt-soft);line-height:1.78;max-width:420px;
            animation:fadeUp .5s .2s ease both;}
        .hero-buttons{display:flex;gap:14px;flex-wrap:wrap;animation:fadeUp .5s .3s ease both}
        .btn-primary{display:inline-flex;align-items:center;gap:9px;background:var(--teal);
            color:#fff;border:none;padding:15px 34px;border-radius:50px;
            font-size:15px;font-weight:700;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:background .2s,transform .15s,box-shadow .2s;
            box-shadow:0 6px 22px rgba(58,175,169,.38);text-decoration:none;}
        .btn-primary:hover{background:var(--teal-dark);transform:translateY(-3px)}
        .btn-secondary{display:inline-flex;align-items:center;gap:9px;background:transparent;
            color:var(--teal);border:2px solid var(--teal);padding:13px 28px;border-radius:50px;
            font-size:15px;font-weight:600;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:all .2s;text-decoration:none;}
        .btn-secondary:hover{background:var(--teal);color:#fff;transform:translateY(-3px)}
        .hero-stats{display:flex;gap:32px;animation:fadeUp .5s .4s ease both}
        .stat-item{display:flex;flex-direction:column;gap:2px}
        .stat-num{font-family:'Nunito',sans-serif;font-weight:900;font-size:24px;color:var(--teal)}
        .stat-label{font-size:11.5px;color:var(--txt-soft);font-weight:500}
        /* Hero right */
        .hero-right{position:relative;display:flex;align-items:flex-end;justify-content:center;
            min-height:390px;animation:fadeUp .5s .15s ease both;}
        .hero-right svg.illo{width:100%;max-width:580px;height:auto;
            filter:drop-shadow(0 8px 24px rgba(58,175,169,.08));}
        .ia{animation:ifA 3.8s ease-in-out infinite}
        .ib{animation:ifB 4.5s .7s ease-in-out infinite}
        .ic{animation:ifC 3.2s 1.1s ease-in-out infinite}
        @keyframes ifA{0%,100%{transform:translateY(0)}50%{transform:translateY(-10px)}}
        @keyframes ifB{0%,100%{transform:translateY(0)}50%{transform:translateY(-8px)}}
        @keyframes ifC{0%,100%{transform:translateY(0)}50%{transform:translateY(-13px)}}
        /* Sections pills */
        .sections-strip{display:flex;justify-content:center;gap:10px;padding:0 52px 42px;
            flex-wrap:wrap;animation:fadeUp .5s .5s ease both;}
        .section-pill{display:flex;align-items:center;gap:9px;padding:10px 22px;
            border-radius:50px;border:1.5px solid rgba(58,175,169,.25);background:var(--teal-pale);
            font-size:13.5px;font-weight:600;color:var(--teal-dark);cursor:pointer;
            transition:all .2s;text-decoration:none;}
        .section-pill i{font-size:14px;color:var(--teal);transition:color .2s}
        .section-pill:hover{background:var(--teal);color:#fff;border-color:var(--teal);
            transform:translateY(-2px);box-shadow:0 4px 16px rgba(58,175,169,.3)}
        .section-pill:hover i{color:#fff}
        /* Cards */
        .cards-section{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;padding:0 52px 52px}
        .card{background:var(--white);border-radius:var(--radius);padding:28px 24px;
            box-shadow:0 2px 20px rgba(0,0,0,.06);display:flex;flex-direction:row;
            align-items:flex-start;gap:18px;transition:transform .22s,box-shadow .22s;
            animation:fadeUp .5s .6s ease both;}
        .card:hover{transform:translateY(-7px);box-shadow:0 14px 40px rgba(58,175,169,.17)}
        .card-icon-wrap{flex-shrink:0;width:58px;height:58px;background:var(--teal);
            border-radius:16px;display:flex;align-items:center;justify-content:center;
            box-shadow:0 4px 16px rgba(58,175,169,.32);transition:transform .2s;}
        .card:hover .card-icon-wrap{transform:scale(1.1) rotate(-5deg)}
        .card-icon-wrap i{font-size:24px;color:#fff}
        .card-body{display:flex;flex-direction:column;gap:6px}
        .card-title{font-family:'Nunito',sans-serif;font-weight:800;font-size:16px;color:var(--txt-dark)}
        .card-desc{font-size:12.5px;color:var(--txt-soft);line-height:1.65}
        .card-link{font-size:12px;font-weight:600;color:var(--teal);text-decoration:none;
            margin-top:4px;display:inline-flex;align-items:center;gap:5px;transition:gap .2s;}
        .card-link:hover{gap:9px}
        /* Footer */
        footer{background:rgba(255,255,255,.7);border-top:1.5px solid rgba(58,175,169,.12);
            padding:22px 52px;display:flex;align-items:center;justify-content:space-between;
            font-size:12.5px;color:var(--txt-soft);}
        .footer-brand{font-family:'Nunito',sans-serif;font-weight:800;color:var(--teal);font-size:14px}
        .footer-links{display:flex;gap:20px}
        .footer-links a{display:flex;align-items:center;gap:6px;color:var(--txt-soft);
            text-decoration:none;font-size:12px;transition:color .2s;}
        .footer-links a:hover{color:var(--teal)}
        .cam-colors{display:flex;gap:5px;align-items:center}
        .cam-dot{width:11px;height:11px;border-radius:50%}
        @keyframes fadeUp{from{opacity:0;transform:translateY(24px)}to{opacity:1;transform:translateY(0)}}
        @media(max-width:920px){
            .page-wrapper{margin:12px;border-radius:22px}
            nav{padding:18px 24px}
            .nav-links a span{display:none}
            .hero{grid-template-columns:1fr;padding:40px 24px 24px}
            .hero-right{display:none}
            .cards-section{grid-template-columns:1fr;padding:0 24px 36px}
            .sections-strip{padding:0 24px 30px}
            footer{flex-direction:column;gap:10px;text-align:center;padding:20px 24px}
        }
    </style>
</head>
<body>
<div class="bg-wave" aria-hidden="true">
    <svg viewBox="0 0 1440 900" preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
        <ellipse cx="180" cy="720" rx="540" ry="360" fill="rgba(58,175,169,.12)"/>
        <ellipse cx="1300" cy="180" rx="380" ry="260" fill="rgba(58,175,169,.09)"/>
        <path d="M0 640 Q380 510 740 640 T1440 550 V900 H0Z" fill="rgba(58,175,169,.07)"/>
    </svg>
</div>
<form id="form1" runat="server">
<div class="page-wrapper">

<!-- ══ NAVBAR ══ -->
<nav>
  <a href="Default.aspx" class="nav-logo">
    <div class="logo-icon">T</div>
    <span class="logo-text">TLC <span>Yemba</span></span>
  </a>
  <ul class="nav-links">
    <li><a href="Default.aspx"><i class="fa-solid fa-house"></i><span>Accueil</span></a></li>
    <li><a href="#sections"><i class="fa-solid fa-layer-group"></i><span>Sections</span></a></li>
    <li><a href="Historique.aspx"><i class="fa-solid fa-chart-bar"></i><span>Resultats</span></a></li>
    <li><a href="Leaderboard.aspx"><i class="fa-solid fa-ranking-star"></i><span>Classement</span></a></li>
  </ul>
  <!-- Bouton dynamique : nom si connecte, sinon S'inscrire -->
  <asp:Panel ID="pnlConnecte" runat="server" Visible="false">
    <a href="Telecharger.aspx" id="dlBtn" style="display:inline-flex;align-items:center;gap:7px;background:var(--teal-pale);color:var(--teal-dark);border:1.5px solid rgba(58,175,169,.25);padding:8px 16px;border-radius:50px;font-size:13px;font-weight:600;text-decoration:none;margin-right:8px"><i class="fa-solid fa-download"></i> Download</a><a href="Dashboard.aspx" class="nav-user-btn">
      <div class="user-avatar-sm"><asp:Literal ID="litNavInitiale" runat="server"/></div>
      <asp:Literal ID="litNavNom" runat="server"/>
    </a>
  </asp:Panel>
  <asp:Panel ID="pnlDeconnecte" runat="server" Visible="true">
    <a href="Inscription.aspx" class="nav-user-btn">
      <i class="fa-solid fa-user-plus"></i> S'inscrire
    </a>
  </asp:Panel>
</nav>

<!-- ══ HERO ══ -->
<section class="hero">
  <div class="hero-left">
    <div class="hero-badge">
      <i class="fa-solid fa-circle-check"></i>
      Plateforme officielle TLC &#8212; Yemba
    </div>
    <h1 class="hero-title">Apprenez &amp; Maitrisez<br/><span>Le Yemba</span> en Ligne</h1>
    <p class="hero-desc">Testez et certifiez votre niveau en langue Yemba grace a notre plateforme de tests certifiants inspiree du TOEFL/TOEIC, concue pour valoriser les langues maternelles du Cameroun.</p>
    <div class="hero-buttons">
      <a href="ChoixTest.aspx" class="btn-primary"><i class="fa-solid fa-play"></i> Commencer un Test</a>
      <a href="Historique.aspx" class="btn-secondary"><i class="fa-solid fa-clock-rotate-left"></i> Mes Resultats</a>
    </div>
    <div class="hero-stats">
      <div class="stat-item"><span class="stat-num">4</span><span class="stat-label">Sections TLC</span></div>
      <div class="stat-item"><span class="stat-num">5</span><span class="stat-label">Niveaux</span></div>
      <div class="stat-item"><span class="stat-num">100%</span><span class="stat-label">Gratuit</span></div>
    </div>
  </div>

  <div class="hero-right">
<svg class="illo" viewBox="0 0 580 480" fill="none" xmlns="http://www.w3.org/2000/svg">
<defs>
  <filter id="sd1"><feDropShadow dx="0" dy="3" stdDeviation="5" flood-color="rgba(0,0,0,0.10)"/></filter>
  <filter id="sd2"><feDropShadow dx="0" dy="2" stdDeviation="3" flood-color="rgba(0,0,0,0.07)"/></filter>
  <clipPath id="flg"><circle cx="155" cy="110" r="36"/></clipPath>
  <linearGradient id="blobG" x1="0" y1="0" x2="0" y2="1">
    <stop offset="0%" stop-color="#D8F0EE"/><stop offset="100%" stop-color="#E8F8F6"/>
  </linearGradient>
</defs>
<ellipse cx="330" cy="268" rx="218" ry="196" fill="url(#blobG)" opacity="0.95"/>
<rect x="100" y="398" width="430" height="15" rx="7" fill="#B0D5D2"/>
<rect x="192" y="385" width="216" height="15" rx="6" fill="#B4D8D4"/>
<rect x="196" y="256" width="208" height="132" rx="12" fill="#C8E6E2" stroke="#A4CECA" stroke-width="2"/>
<rect x="206" y="266" width="188" height="112" rx="7" fill="#E0F2F0"/>
<rect x="222" y="282" width="86" height="8" rx="4" fill="rgba(58,175,169,.55)"/>
<rect x="222" y="296" width="148" height="5" rx="2.5" fill="rgba(58,175,169,.32)"/>
<rect x="222" y="308" width="124" height="5" rx="2.5" fill="rgba(58,175,169,.24)"/>
<rect x="222" y="320" width="96" height="5" rx="2.5" fill="rgba(58,175,169,.16)"/>
<text x="300" y="356" text-anchor="middle" font-family="Nunito,sans-serif" font-size="11" font-weight="900" fill="#2B9990">TLC Yemba</text>
<g class="ic"><rect x="436" y="360" width="30" height="28" rx="4" fill="#9AC4C0"/>
<rect x="434" y="354" width="34" height="9" rx="4.5" fill="#B0D6D2"/>
<path d="M466 365 C476 365 480 370 480 374 C480 378 476 381 466 381" stroke="#9AC4C0" stroke-width="3.5" fill="none" stroke-linecap="round"/></g>
<path d="M524 404 L518 374 L538 374 Z" fill="#8ABAB6"/>
<rect x="514" y="400" width="36" height="10" rx="4" fill="#78AAA6"/>
<path d="M527 374 C524 358 516 336 509 310" stroke="#58A896" stroke-width="4" fill="none" stroke-linecap="round"/>
<path d="M527 374 C527 352 525 325 523 296" stroke="#58A896" stroke-width="4" fill="none" stroke-linecap="round"/>
<path d="M527 374 C532 356 540 332 547 306" stroke="#58A896" stroke-width="4" fill="none" stroke-linecap="round"/>
<ellipse cx="507" cy="307" rx="20" ry="11" fill="#46A090" transform="rotate(-40 507 307)"/>
<ellipse cx="523" cy="292" rx="20" ry="11" fill="#52B0A0"/>
<ellipse cx="548" cy="303" rx="20" ry="11" fill="#46A090" transform="rotate(36 548 303)"/>
<path d="M246 312 C228 342 218 370 216 393" stroke="#3AAFA9" stroke-width="32" fill="none" stroke-linecap="round"/>
<ellipse cx="217" cy="393" rx="16" ry="10" fill="#F5C4A2"/>
<path d="M358 312 C374 342 382 370 384 393" stroke="#3AAFA9" stroke-width="32" fill="none" stroke-linecap="round"/>
<ellipse cx="383" cy="393" rx="16" ry="10" fill="#F5C4A2"/>
<path d="M202 410 C202 306 226 280 240 270 C260 256 280 248 302 246 C324 248 344 256 364 270 C378 280 402 306 402 410 Z" fill="#3AAFA9"/>
<path d="M264 268 L302 316 L340 268 L334 332 C318 356 286 356 270 332 Z" fill="white"/>
<path d="M226 276 C242 262 260 260 266 268 L258 320 C240 308 222 316 218 320 Z" fill="#2E9A94"/>
<path d="M378 276 C362 262 344 260 338 268 L346 320 C364 308 382 316 386 320 Z" fill="#2E9A94"/>
<rect x="280" y="240" width="44" height="38" rx="20" fill="#F5C4A2"/>
<path d="M222 182 C218 110 248 82 302 78 C356 78 382 110 380 182 C384 238 382 294 380 308 C358 272 302 264 246 272 C244 260 222 238 222 182 Z" fill="#1C2E20"/>
<path d="M220 186 C202 204 192 236 190 276 C188 316 200 358 214 390" stroke="#1C2E20" stroke-width="12" fill="none" stroke-linecap="round"/>
<path d="M234 98 C252 80 276 74 302 74 C328 74 352 80 370 98 C382 112 384 134 380 154" fill="#243426"/>
<path d="M222 182 C218 110 248 82 302 78 C356 78 382 110 380 182" fill="#243426"/>
<path d="M244 162 C244 124 270 100 302 100 C334 100 360 124 360 162 C360 204 348 232 334 244 C322 256 308 262 302 262 C296 262 282 256 270 244 C256 232 244 204 244 162 Z" fill="#F5C4A2"/>
<ellipse cx="243" cy="186" rx="10" ry="13" fill="#F0B890"/>
<ellipse cx="361" cy="186" rx="10" ry="13" fill="#F0B890"/>
<path d="M264 158 C272 151 284 149 296 153" stroke="#2A1810" stroke-width="4" fill="none" stroke-linecap="round"/>
<path d="M308 153 C320 149 332 151 340 158" stroke="#2A1810" stroke-width="4" fill="none" stroke-linecap="round"/>
<path d="M262 180 C265 170 278 167 288 170 C296 173 300 179 298 188 C296 196 288 200 278 198 C268 196 260 190 262 180 Z" fill="white"/>
<ellipse cx="280" cy="184" rx="10" ry="12" fill="#2A3E78"/>
<circle cx="280" cy="185" r="6" fill="#0A0A1A"/>
<ellipse cx="275" cy="178" rx="4" ry="3" fill="white"/>
<path d="M306 180 C304 170 316 167 326 170 C336 173 342 179 340 188 C338 196 330 200 320 198 C310 196 304 190 306 180 Z" fill="white"/>
<ellipse cx="324" cy="184" rx="10" ry="12" fill="#2A3E78"/>
<circle cx="324" cy="185" r="6" fill="#0A0A1A"/>
<ellipse cx="319" cy="178" rx="4" ry="3" fill="white"/>
<ellipse cx="258" cy="208" rx="18" ry="8" fill="rgba(238,128,100,.22)"/>
<ellipse cx="346" cy="208" rx="18" ry="8" fill="rgba(238,128,100,.22)"/>
<path d="M295 216 C298 222 305 221 308 216" stroke="#D48862" stroke-width="2" fill="none" stroke-linecap="round" opacity=".6"/>
<path d="M278 234 C286 246 302 252 326 246 C314 256 290 256 278 234 Z" fill="#D88868"/>
<path d="M282 236 C288 244 316 244 322 238" fill="white" opacity=".9"/>
<path d="M240 178 C242 108 268 92 302 90 C336 92 362 108 364 178" stroke="#F0F0F0" stroke-width="14" fill="none" stroke-linecap="round"/>
<ellipse cx="238" cy="186" rx="23" ry="27" fill="#F4F4F4"/>
<ellipse cx="238" cy="186" rx="13" ry="15" fill="#ECA890"/>
<circle cx="238" cy="186" r="5.5" fill="#E09078"/>
<ellipse cx="366" cy="186" rx="23" ry="27" fill="#F4F4F4"/>
<ellipse cx="366" cy="186" rx="13" ry="15" fill="#ECA890"/>
<circle cx="366" cy="186" r="5.5" fill="#E09078"/>
<g class="ia" filter="url(#sd1)">
  <circle cx="155" cy="110" r="46" fill="white"/>
  <rect x="115" y="72" width="27" height="76" fill="#007A5E" clip-path="url(#flg)"/>
  <rect x="142" y="72" width="27" height="76" fill="#CE1126" clip-path="url(#flg)"/>
  <rect x="169" y="72" width="27" height="76" fill="#FCD116" clip-path="url(#flg)"/>
  <text x="155" y="116" text-anchor="middle" font-size="18" fill="#FCD116" font-family="Arial">&#9733;</text>
  <circle cx="155" cy="110" r="46" fill="none" stroke="white" stroke-width="5"/>
  <circle cx="155" cy="110" r="46" fill="none" stroke="rgba(58,175,169,.22)" stroke-width="2"/>
</g>
<g class="ib" filter="url(#sd2)">
  <rect x="388" y="98" width="116" height="76" rx="18" fill="#3AAFA9"/>
  <path d="M400 174 L382 196 L424 174 Z" fill="#3AAFA9"/>
  <rect x="404" y="118" width="84" height="8" rx="4" fill="rgba(255,255,255,.92)"/>
  <rect x="404" y="133" width="70" height="6" rx="3" fill="rgba(255,255,255,.72)"/>
  <rect x="404" y="146" width="56" height="6" rx="3" fill="rgba(255,255,255,.55)"/>
</g>
<g class="ia" style="animation-delay:.95s" filter="url(#sd2)">
  <rect x="380" y="210" width="100" height="58" rx="16" fill="#3AAFA9"/>
  <path d="M392 268 L374 290 L420 268 Z" fill="#3AAFA9"/>
  <circle cx="406" cy="239" r="7.5" fill="rgba(255,255,255,.92)"/>
  <circle cx="430" cy="239" r="7.5" fill="rgba(255,255,255,.92)"/>
  <circle cx="454" cy="239" r="7.5" fill="rgba(255,255,255,.92)"/>
</g>
<g class="ic" filter="url(#sd1)">
  <circle cx="492" cy="138" r="30" fill="white"/>
  <path d="M480 138 L490 149 L506 122" stroke="#3AAFA9" stroke-width="5" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
</g>
<circle cx="168" cy="62" r="7" fill="rgba(58,175,169,.28)" class="ib"/>
<circle cx="478" cy="76" r="5.5" fill="rgba(58,175,169,.22)" class="ia"/>
<circle cx="138" cy="218" r="4.5" fill="rgba(58,175,169,.18)" class="ic"/>
</svg>
  </div>
</section>

<!-- ══ SECTION PILLS ══ -->
<div class="sections-strip" id="sections">
  <a href="ChoixTest.aspx?section=Listening" class="section-pill"><i class="fa-solid fa-headphones"></i> Listening</a>
  <a href="ChoixTest.aspx?section=Structure" class="section-pill"><i class="fa-solid fa-pen-nib"></i> Structure</a>
  <a href="ChoixTest.aspx?section=Reading"   class="section-pill"><i class="fa-solid fa-book-open"></i> Reading</a>
  <a href="ChoixTest.aspx?section=FullTest"  class="section-pill"><i class="fa-solid fa-trophy"></i> Test Complet</a>
</div>

<!-- ══ CARDS ══ -->
<div class="cards-section">
  <div class="card">
    <div class="card-icon-wrap"><i class="fa-solid fa-headphones-simple"></i></div>
    <div class="card-body">
      <div class="card-title">Comprehension Orale</div>
      <p class="card-desc">Entrainez-vous a comprendre le Yemba parle a travers des exercices audio cibles.</p>
      <a href="ChoixTest.aspx?section=Listening" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
    </div>
  </div>
  <div class="card">
    <div class="card-icon-wrap"><i class="fa-solid fa-book"></i></div>
    <div class="card-body">
      <div class="card-title">Grammaire &amp; Structure</div>
      <p class="card-desc">Maitrisez la syntaxe et les regles grammaticales de la langue Yemba.</p>
      <a href="ChoixTest.aspx?section=Structure" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
    </div>
  </div>
  <div class="card">
    <div class="card-icon-wrap"><i class="fa-solid fa-file-lines"></i></div>
    <div class="card-body">
      <div class="card-title">Lecture &amp; Vocabulaire</div>
      <p class="card-desc">Developpez votre comprehension ecrite et enrichissez votre vocabulaire Yemba.</p>
      <a href="ChoixTest.aspx?section=Reading" class="card-link">Commencer <i class="fa-solid fa-arrow-right"></i></a>
    </div>
  </div>
</div>

<!-- ══ FOOTER ══ -->
<footer>
  <span class="footer-brand">TLC Yemba Online Test</span>
  <div class="footer-links">
    <a href="#"><i class="fa-solid fa-shield-halved"></i> Confidentialite</a>
    <a href="#"><i class="fa-solid fa-envelope"></i> Contact</a> </div>
  <div class="cam-colors">
    <div class="cam-dot" style="background:#007A5E"></div>
    <div class="cam-dot" style="background:#CE1126"></div>
    <div class="cam-dot" style="background:#FCD116"></div>
    <span style="margin-left:7px;font-size:11.5px;font-weight:600;color:#718096">Cameroun</span>
  </div>
</footer>

</div>
</form>
    <script src="loading.js"></script>
<script>
document.querySelectorAll('.nav-links a').forEach(function(l){
  if(l.href===window.location.href){l.style.color='var(--teal)';l.style.background='var(--teal-pale)'}
});
</script>
</body>
</html>
