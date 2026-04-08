<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Telecharger.aspx.cs" Inherits="TLCYemba.Telecharger" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Telecharger &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;
             background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
             min-height:100vh;color:var(--txt-dark);}
        .page{max-width:780px;margin:0 auto;padding:32px 20px 60px}

        /* NAV */
        nav{display:flex;align-items:center;justify-content:space-between;
            background:rgba(255,255,255,.95);border-radius:18px;padding:14px 24px;
            margin-bottom:40px;box-shadow:0 4px 24px rgba(58,175,169,.10);}
        .nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none}
        .nl-i{width:36px;height:36px;background:var(--teal);border-radius:50%;
              display:flex;align-items:center;justify-content:center;
              font-family:'Nunito',sans-serif;font-weight:900;font-size:15px;color:white}
        .nl-t{font-family:'Nunito',sans-serif;font-weight:900;font-size:17px;color:var(--txt-dark)}
        .nl-t span{color:var(--teal)}
        .nav-back{display:inline-flex;align-items:center;gap:7px;color:var(--teal);
                  text-decoration:none;font-size:13px;font-weight:600;
                  padding:8px 16px;border-radius:50px;background:var(--teal-pale);transition:all .2s}
        .nav-back:hover{background:var(--teal);color:white}

        /* HERO */
        .hero{text-align:center;margin-bottom:44px}
        .hero-badge{display:inline-flex;align-items:center;gap:7px;
            background:rgba(255,255,255,.8);border:1.5px solid rgba(58,175,169,.25);
            color:var(--teal-dark);padding:6px 18px;border-radius:50px;
            font-size:12px;font-weight:700;margin-bottom:18px}
        .hero-badge i{color:var(--teal)}
        .hero h1{font-family:'Nunito',sans-serif;font-weight:900;
            font-size:clamp(1.7rem,3.5vw,2.3rem);color:var(--txt-dark);line-height:1.2;margin-bottom:12px}
        .hero h1 span{color:var(--teal)}
        .hero p{font-size:14px;color:var(--txt-soft);max-width:500px;margin:0 auto;line-height:1.7}

        /* ── SECTION LABEL ── */
        .sec-label{display:flex;align-items:center;gap:10px;margin:32px 0 14px}
        .sec-label .sl-line{flex:1;height:1.5px;background:rgba(58,175,169,.2)}
        .sec-label .sl-txt{font-size:11.5px;font-weight:700;color:var(--txt-soft);
            text-transform:uppercase;letter-spacing:.8px;white-space:nowrap}

        /* ── DOWNLOAD ROW (rectangle liste style Claude) ── */
        .dl-list{display:flex;flex-direction:column;gap:10px}

        .dl-row{
            display:flex;align-items:center;
            background:rgba(255,255,255,.92);
            border-radius:14px;
            padding:14px 20px;
            box-shadow:0 2px 12px rgba(0,0,0,.05);
            transition:all .2s;
            border:1.5px solid rgba(58,175,169,.08);
        }
        .dl-row:hover{
            box-shadow:0 6px 24px rgba(58,175,169,.14);
            border-color:rgba(58,175,169,.25);
            transform:translateX(3px);
        }

        /* Logo plateforme */
        .dl-logo{
            width:44px;height:44px;border-radius:12px;flex-shrink:0;
            display:flex;align-items:center;justify-content:center;
            margin-right:16px;
        }
        .dl-logo svg,.dl-logo i{width:26px;height:26px}

        /* Info */
        .dl-info{flex:1;min-width:0}
        .dl-name{font-family:'Nunito',sans-serif;font-weight:800;font-size:15.5px;color:var(--txt-dark);line-height:1}
        .dl-meta{font-size:11.5px;color:var(--txt-soft);margin-top:3px}

        /* Badges */
        .dl-badges{display:flex;gap:5px;margin-left:14px;flex-shrink:0}
        .dl-badge{font-size:10px;font-weight:700;padding:3px 9px;border-radius:50px;
            background:#F7FAFC;border:1px solid #E2E8F0;color:var(--txt-mid);white-space:nowrap}
        .badge-soon{background:#FEF9EC;border-color:#F6AD55;color:#92400E}

        /* Bouton Download */
        .dl-btn{
            display:inline-flex;align-items:center;gap:7px;
            padding:9px 20px;border-radius:50px;border:none;cursor:pointer;
            font-family:'Poppins',sans-serif;font-size:13px;font-weight:700;
            color:white;white-space:nowrap;margin-left:16px;flex-shrink:0;
            transition:all .2s;text-decoration:none;
        }
        .dl-btn:hover{opacity:.88;transform:translateY(-1px)}

        .btn-ios     {background:#007AFF}
        .btn-android {background:#34A853}
        .btn-windows {background:#0078D4}
        .btn-macos   {background:#555}
        .btn-linux   {background:#E95420}

        /* Info note */
        .info-note{
            margin-top:36px;background:rgba(255,255,255,.7);border-radius:14px;
            padding:18px 22px;font-size:13px;color:var(--txt-soft);line-height:1.7;
            border:1.5px solid rgba(58,175,169,.15);
        }
        .info-note strong{color:var(--txt-dark)}
        .info-note i{color:var(--teal);margin-right:6px}

        .copy{text-align:center;margin-top:28px;font-size:12px;color:var(--txt-soft)}
        .copy a{color:var(--teal);text-decoration:none;font-weight:600}

        @media(max-width:560px){
            .dl-badges{display:none}
            .dl-btn{padding:8px 14px;font-size:12px}
        }
    </style>
</head>
<body>
<div class="page">

<!-- NAV -->
<nav>
    <a href="Default.aspx" class="nav-logo">
        <div class="nl-i">T</div>
        <span class="nl-t">TLC <span>Yemba</span></span>
    </a>
    <a href="Default.aspx" class="nav-back">
        <i class="fa-solid fa-arrow-left"></i> Retour
    </a>
</nav>

<!-- HERO -->
<div class="hero">
    <div class="hero-badge"><i class="fa-solid fa-mobile-screen-button"></i> Applications officielles TLC Yemba</div>
    <h1>Testez votre <span>Yemba</span><br/>partout, sur tous vos appareils</h1>
    <p>5 versions disponibles — iOS, Android, Windows, macOS et Linux.
       Meme experience, meme theme, meme fonctionnalites.</p>
</div>

<!-- ── MOBILE ── -->
<div class="sec-label">
    <div class="sl-line"></div>
    <div class="sl-txt"><i class="fa-solid fa-mobile-screen-button" style="margin-right:6px;color:var(--teal)"></i>Mobile</div>
    <div class="sl-line"></div>
</div>

<div class="dl-list">

    <!-- iOS -->
    <div class="dl-row">
        <div class="dl-logo" style="background:#E8F3FF">
            <svg viewBox="0 0 24 24" fill="#007AFF"><path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.7 9.05 7.36c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.39-1.32 2.76-2.54 4.03zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"/></svg>
        </div>
        <div class="dl-info">
            <div class="dl-name">TLC Yemba pour iPhone / iPad</div>
            <div class="dl-meta">iOS 14+ &#8212; App Store</div>
        </div>
        <div class="dl-badges">
            <span class="dl-badge">iOS 14+</span>
            <span class="dl-badge badge-soon">Bientot</span>
        </div>
        <a href="#" class="dl-btn btn-ios">
            <i class="fa-brands fa-app-store-ios"></i> Download
        </a>
    </div>

    <!-- Android -->
    <div class="dl-row">
        <div class="dl-logo" style="background:#E8F8EE">
            <svg viewBox="0 0 24 24" fill="#34A853"><path d="M17.523 15.344a1.046 1.046 0 01-1.045-1.046c0-.578.468-1.045 1.045-1.045a1.046 1.046 0 010 2.091zm-11.046 0a1.046 1.046 0 110-2.091 1.046 1.046 0 010 2.091zm11.41-6.142l2.09-3.619a.436.436 0 00-.757-.436l-2.116 3.66A12.974 12.974 0 0012 8.25c-1.74 0-3.387.36-4.866.998L5.02 5.147a.436.436 0 10-.757.436l2.09 3.619C3.498 10.988 1.5 13.75 1.5 17h21c0-3.25-1.998-6.012-4.613-7.798z"/></svg>
        </div>
        <div class="dl-info">
            <div class="dl-name">TLC Yemba pour Android</div>
            <div class="dl-meta">Android 8+ &#8212; Google Play Store</div>
        </div>
        <div class="dl-badges">
            <span class="dl-badge">Android 8+</span>
            <span class="dl-badge badge-soon">Bientot</span>
        </div>
        <a href="#" class="dl-btn btn-android">
            <i class="fa-brands fa-google-play"></i> Download
        </a>
    </div>

</div>

<!-- ── DESKTOP ── -->
<div class="sec-label">
    <div class="sl-line"></div>
    <div class="sl-txt"><i class="fa-solid fa-desktop" style="margin-right:6px;color:var(--teal)"></i>Desktop</div>
    <div class="sl-line"></div>
</div>

<div class="dl-list">

    <!-- Windows -->
    <div class="dl-row">
        <div class="dl-logo" style="background:#E5F2FF">
            <svg viewBox="0 0 24 24" fill="#0078D4"><path d="M0 3.449L9.75 2.1v9.451H0m10.949-9.602L24 0v11.4H10.949M0 12.6h9.75v9.451L0 20.699M10.949 12.6H24V24l-12.9-1.801"/></svg>
        </div>
        <div class="dl-info">
            <div class="dl-name">TLC Yemba pour Windows</div>
            <div class="dl-meta">Windows 10 / 11 &#8212; Installateur .exe</div>
        </div>
        <div class="dl-badges">
            <span class="dl-badge">Win 10/11</span>
            <span class="dl-badge badge-soon">Bientot</span>
        </div>
        <a href="#" class="dl-btn btn-windows">
            <i class="fa-brands fa-windows"></i> Download
        </a>
    </div>

    <!-- macOS -->
    <div class="dl-row">
        <div class="dl-logo" style="background:#F0F0F0">
            <svg viewBox="0 0 24 24" fill="#555"><path d="M12.152 6.896c-.948 0-2.415-1.078-3.96-1.04-2.04.027-3.91 1.183-4.961 3.014-2.117 3.675-.546 9.103 1.519 12.09 1.013 1.454 2.208 3.09 3.792 3.039 1.52-.065 2.09-.987 3.935-.987 1.831 0 2.35.987 3.96.948 1.637-.026 2.676-1.48 3.676-2.948 1.156-1.688 1.636-3.325 1.662-3.415-.039-.013-3.182-1.221-3.22-4.857-.026-3.04 2.48-4.494 2.597-4.559-1.429-2.09-3.623-2.324-4.39-2.376-2-.156-3.675 1.09-4.61 1.09zM15.53 3.83c.843-1.012 1.4-2.427 1.245-3.83-1.207.052-2.662.805-3.532 1.818-.78.896-1.454 2.338-1.273 3.714 1.338.104 2.715-.688 3.559-1.701"/></svg>
        </div>
        <div class="dl-info">
            <div class="dl-name">TLC Yemba pour macOS</div>
            <div class="dl-meta">macOS 12+ &#8212; Intel &amp; Apple Silicon &#8212; Fichier .dmg</div>
        </div>
        <div class="dl-badges">
            <span class="dl-badge">macOS 12+</span>
            <span class="dl-badge">M1/M2/M3</span>
            <span class="dl-badge badge-soon">Bientot</span>
        </div>
        <a href="#" class="dl-btn btn-macos">
            <i class="fa-brands fa-apple"></i> Download
        </a>
    </div>

    <!-- Linux -->
    <div class="dl-row">
        <div class="dl-logo" style="background:#FEF0EA">
            <svg viewBox="0 0 24 24" fill="#E95420"><path d="M12.504 0C6.015 0 1.5 4.636 1.5 10.5c0 2.673.965 5.091 2.582 6.931C4.6 18.12 5 19.059 5 20v1a1 1 0 001 1h12a1 1 0 001-1v-1c0-.941.4-1.88.918-2.569C21.535 15.591 22.5 13.173 22.5 10.5 22.5 4.636 18.985 0 12.504 0zM9 9a1 1 0 110 2 1 1 0 010-2zm6 0a1 1 0 110 2 1 1 0 010-2zm-5.5 5h5a.5.5 0 010 1h-5a.5.5 0 010-1z"/></svg>
        </div>
        <div class="dl-info">
            <div class="dl-name">TLC Yemba pour Linux</div>
            <div class="dl-meta">Ubuntu / Debian &#8212; .deb + AppImage universel</div>
        </div>
        <div class="dl-badges">
            <span class="dl-badge">Ubuntu</span>
            <span class="dl-badge">AppImage</span>
            <span class="dl-badge badge-soon">Bientot</span>
        </div>
        <a href="#" class="dl-btn btn-linux">
            <i class="fa-brands fa-linux"></i> Download
        </a>
    </div>

</div>

<!-- NOTE -->
<div class="info-note">
    <p><i class="fa-solid fa-circle-info"></i><strong>Comment integrer les fichiers telechargeable ?</strong></p>
    <p style="margin-top:8px">
        Lorsque les applications Flutter seront compilees, remplacer <code>href="#"</code> par le chemin du fichier :
        <br/>&#8226; iOS : lien vers l\'App Store (publier sur store.apple.com)
        <br/>&#8226; Android : lien vers Google Play ou vers un fichier <code>.apk</code> sur votre serveur
        <br/>&#8226; Windows : lien direct vers <code>/downloads/TLCYemba_Setup.exe</code>
        <br/>&#8226; macOS : lien direct vers <code>/downloads/TLCYemba.dmg</code>
        <br/>&#8226; Linux : lien direct vers <code>/downloads/TLCYemba.AppImage</code>
    </p>
</div>

<div class="copy">
    &#169; 2025 TLC Yemba &#8212; <a href="Default.aspx">Retour au site</a>
</div>

</div>
</body>
</html>