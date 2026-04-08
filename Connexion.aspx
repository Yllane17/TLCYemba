<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Connexion.aspx.cs" Inherits="TLCYemba.Connexion" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Connexion &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --cream:#F5F4EF;--txt-dark:#2D3748;--txt-mid:#4A5568;
              --txt-soft:#718096;--radius:12px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html,body{height:100%}
        body{font-family:'Poppins',sans-serif;background:#F0F0EC;
             display:flex;align-items:center;justify-content:center;padding:16px;min-height:100vh;}
        .outer{width:100%;max-width:900px;background:white;border-radius:24px;
               box-shadow:0 16px 64px rgba(0,0,0,.12);overflow:hidden;
               display:grid;grid-template-columns:1fr 1fr;min-height:580px;}
        /* LEFT PANEL */
        .left-panel{background:linear-gradient(145deg,#2B8F8A 0%,#3AAFA9 60%,#44C4BE 100%);
            padding:48px 40px;display:flex;flex-direction:column;
            align-items:center;justify-content:space-between;position:relative;overflow:hidden;}
        .left-panel::before{content:'';position:absolute;bottom:-80px;left:-80px;
            width:280px;height:280px;border-radius:50%;background:rgba(255,255,255,.07);}
        .left-panel::after{content:'';position:absolute;top:-60px;right:-60px;
            width:200px;height:200px;border-radius:50%;background:rgba(255,255,255,.05);}
        .lp-logo{display:flex;align-items:center;gap:10px;align-self:flex-start;z-index:1}
        .lp-logo-icon{width:40px;height:40px;border-radius:50%;background:rgba(255,255,255,.25);
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:16px;color:white;}
        .lp-logo-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:17px;color:white}
        .lp-logo-text span{color:#FCD116}
        .lp-illo{z-index:1;width:100%;max-width:280px}
        .lp-text{z-index:1;text-align:center}
        .lp-text h2{font-family:'Nunito',sans-serif;font-weight:900;
            font-size:clamp(1.1rem,2vw,1.4rem);color:white;line-height:1.35;margin-bottom:6px;}
        .lp-text p{font-size:12.5px;color:rgba(255,255,255,.72);line-height:1.6}
        .lp-dots{display:flex;gap:7px;justify-content:center;margin-top:14px}
        .lp-dot{width:8px;height:8px;border-radius:50%;background:rgba(255,255,255,.35)}
        .lp-dot.active{background:#FCD116;width:22px;border-radius:4px}
        /* RIGHT PANEL */
        .right-panel{background:var(--cream);padding:48px 44px;
            display:flex;flex-direction:column;justify-content:center;overflow-y:auto;}
        .rp-title{font-family:'Nunito',sans-serif;font-weight:900;
            font-size:24px;color:var(--txt-dark);margin-bottom:4px;}
        .rp-sub{font-size:13px;color:var(--txt-soft);margin-bottom:24px}
        /* Alerts */
        .alert-box{padding:9px 14px;border-radius:9px;font-size:12.5px;font-weight:500;
            margin-bottom:14px;display:flex;align-items:center;gap:7px;}
        .alert-ok {background:#F0FFF4;border:1.5px solid #9AE6B4;color:#276749}
        .alert-err{background:#FFF5F5;border:1.5px solid #FEB2B2;color:#C53030}
        /* Fields */
        .field{margin-bottom:14px;position:relative}
        .field label{display:block;font-size:11.5px;font-weight:700;color:var(--txt-mid);
            margin-bottom:5px;text-transform:uppercase;letter-spacing:.4px}
        .field input{width:100%;padding:11px 14px 11px 40px;border-radius:var(--radius);
            border:1.5px solid #DDD8CE;background:white;font-size:13.5px;
            font-family:'Poppins',sans-serif;color:var(--txt-dark);outline:none;
            transition:border-color .2s,box-shadow .2s;}
        .field input:focus{border-color:var(--teal);box-shadow:0 0 0 3px rgba(58,175,169,.12)}
        .field input::placeholder{color:#B0A898;font-size:13px}
        .fi{position:absolute;left:13px;top:35px;font-size:14px;color:#B0A898;pointer-events:none}
        .eye-btn{position:absolute;right:12px;top:34px;cursor:pointer;
            background:none;border:none;padding:0;font-size:13px;color:#B0A898;transition:color .2s}
        .eye-btn:hover{color:var(--teal)}
        /* Forgot */
        .forgot-row{text-align:right;margin-top:-8px;margin-bottom:16px}
        .forgot-row a{font-size:12px;color:var(--teal);text-decoration:none;font-weight:500}
        .forgot-row a:hover{text-decoration:underline}
        /* Main button */
        .btn-main{width:100%;padding:12.5px;border-radius:50px;background:var(--teal);color:white;
            border:none;font-size:14.5px;font-weight:700;cursor:pointer;
            font-family:'Poppins',sans-serif;box-shadow:0 6px 22px rgba(58,175,169,.38);
            transition:all .2s;display:flex;align-items:center;justify-content:center;gap:8px;}
        .btn-main:hover{background:var(--teal-dark);transform:translateY(-2px)}
        /* Separator */
        .sep-or{display:flex;align-items:center;gap:10px;margin:16px 0;color:#B0A898;font-size:12px}
        .sep-or::before,.sep-or::after{content:'';flex:1;height:1px;background:#DDD8CE}
        /* OAuth */
        .oauth-row{display:flex;gap:8px;margin-bottom:14px}
        .btn-oa{flex:1;display:flex;align-items:center;justify-content:center;gap:6px;
            padding:9px 6px;border-radius:50px;background:white;border:1.5px solid #DDD8CE;
            font-size:11.5px;font-weight:600;color:var(--txt-dark);cursor:pointer;
            font-family:'Poppins',sans-serif;transition:all .2s;text-decoration:none;white-space:nowrap;}
        .btn-oa:hover{border-color:var(--teal);background:var(--teal-pale);color:var(--teal)}
        .oa-ico{width:16px;height:16px;flex-shrink:0}
        /* Guest */
        .btn-guest{width:100%;padding:10px;border-radius:50px;background:transparent;
            color:var(--txt-mid);border:1.5px solid #DDD8CE;font-size:12.5px;font-weight:600;
            cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s;
            display:flex;align-items:center;justify-content:center;gap:7px;}
        .btn-guest:hover{background:white;border-color:var(--txt-mid)}
        /* Bottom */
        .btm-link{text-align:center;margin-top:14px;font-size:12px;color:var(--txt-soft)}
        .btm-link a{color:var(--teal);font-weight:600;text-decoration:none}
        .btm-link a:hover{text-decoration:underline}
        .copy{text-align:center;margin-top:20px;font-size:11px;color:#C0BAB0}
        @media(max-width:720px){
            .outer{grid-template-columns:1fr}.left-panel{display:none}
            .right-panel{padding:32px 24px}}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="outer">

    <!-- ══ LEFT ══ -->
    <div class="left-panel">
        <div class="lp-logo">
            <div class="lp-logo-icon">T</div>
            <span class="lp-logo-text">TLC <span>Yemba</span></span>
        </div>
        <div class="lp-illo">
<svg viewBox="0 0 280 240" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="20" width="180" height="140" rx="10" fill="rgba(255,255,255,.15)" stroke="rgba(255,255,255,.3)" stroke-width="1.5"/>
  <rect x="36" y="80" width="18" height="60" rx="3" fill="rgba(255,255,255,.5)"/>
  <rect x="62" y="60" width="18" height="80" rx="3" fill="#FCD116" opacity=".8"/>
  <rect x="88" y="70" width="18" height="70" rx="3" fill="rgba(255,255,255,.5)"/>
  <rect x="114" y="50" width="18" height="90" rx="3" fill="#FCD116" opacity=".9"/>
  <rect x="140" y="75" width="18" height="65" rx="3" fill="rgba(255,255,255,.5)"/>
  <circle cx="218" cy="78" r="38" fill="none" stroke="rgba(255,255,255,.2)" stroke-width="14"/>
  <circle cx="218" cy="78" r="38" fill="none" stroke="#FCD116" stroke-width="14" stroke-dasharray="96 143" stroke-dashoffset="0" transform="rotate(-90 218 78)"/>
  <circle cx="218" cy="78" r="38" fill="none" stroke="rgba(255,255,255,.6)" stroke-width="14" stroke-dasharray="50 143" stroke-dashoffset="-96" transform="rotate(-90 218 78)"/>
  <text x="218" y="83" text-anchor="middle" fill="white" font-size="12" font-weight="700" font-family="Nunito,sans-serif">43%</text>
  <path d="M138 180 C138 148 152 138 168 136 C184 138 198 148 198 180 Z" fill="#F0C070"/>
  <path d="M158 136 L168 150 L178 136 L175 168 C170 176 166 176 161 168 Z" fill="white"/>
  <rect x="162" y="122" width="12" height="16" rx="6" fill="#F5C090"/>
  <ellipse cx="168" cy="114" rx="20" ry="22" fill="#F5C090"/>
  <path d="M148 108 C148 90 158 80 168 80 C178 80 188 90 188 108 C186 100 178 96 168 96 C158 96 150 100 148 108 Z" fill="#1A2818"/>
  <path d="M148 108 C142 116 140 128 142 140 C146 130 148 120 150 112 Z" fill="#1A2818"/>
  <ellipse cx="162" cy="112" rx="3" ry="3.5" fill="white"/>
  <ellipse cx="174" cy="112" rx="3" ry="3.5" fill="white"/>
  <circle cx="162" cy="112" r="2" fill="#1A0C04"/>
  <circle cx="174" cy="112" r="2" fill="#1A0C04"/>
  <circle cx="163" cy="111" r="1" fill="white"/>
  <circle cx="175" cy="111" r="1" fill="white"/>
  <path d="M163 120 Q168 125 173 120" stroke="#C87858" stroke-width="1.5" fill="none" stroke-linecap="round"/>
  <path d="M198 148 C212 136 222 120 228 108" stroke="#F0C070" stroke-width="10" fill="none" stroke-linecap="round"/>
  <circle cx="230" cy="106" r="5" fill="#F5C090"/>
  <path d="M138 148 C130 156 126 168 124 178" stroke="#F0C070" stroke-width="10" fill="none" stroke-linecap="round"/>
  <rect x="154" y="178" width="12" height="50" rx="4" fill="#2B5C4A"/>
  <rect x="170" y="178" width="12" height="50" rx="4" fill="#2B5C4A"/>
  <ellipse cx="160" cy="228" rx="10" ry="5" fill="#1A2818"/>
  <ellipse cx="176" cy="228" rx="10" ry="5" fill="#1A2818"/>
  <rect x="236" y="196" width="20" height="14" rx="3" fill="#2B7A5A" opacity=".7"/>
  <path d="M246 196 C244 184 238 172 234 160" stroke="#3A9A6A" stroke-width="3" fill="none" stroke-linecap="round"/>
  <path d="M246 196 C246 182 246 168 244 154" stroke="#3A9A6A" stroke-width="3" fill="none" stroke-linecap="round"/>
  <ellipse cx="232" cy="158" rx="10" ry="7" fill="#3A9A6A" transform="rotate(-30 232 158)" opacity=".8"/>
  <ellipse cx="244" cy="150" rx="11" ry="7" fill="#4CAA7A" opacity=".8"/>
</svg>
        </div>
        <div class="lp-text">
            <h2>Testez et Certifiez<br/>votre niveau en Yemba</h2>
            <p>Plateforme officielle TLC &#8212; Langues maternelles du Cameroun</p>
            <div class="lp-dots">
                <div class="lp-dot active"></div>
                <div class="lp-dot"></div>
                <div class="lp-dot"></div>
            </div>
        </div>
    </div>

    <!-- ══ RIGHT ══ -->
    <div class="right-panel">
        <div class="rp-title">Bienvenue !</div>
        <div class="rp-sub">Connectez-vous pour continuer</div>

        <!-- Succes inscription -->
        <asp:Panel ID="pnlSucces" runat="server" Visible="false">
            <div class="alert-box alert-ok">
                <i class="fa-solid fa-circle-check"></i>
                Inscription reussie ! Connectez-vous.
            </div>
        </asp:Panel>

        <!-- Succes reset -->
        <asp:Panel ID="pnlReset" runat="server" Visible="false">
            <div class="alert-box alert-ok">
                <i class="fa-solid fa-lock"></i>
                Mot de passe modifie avec succes !
            </div>
        </asp:Panel>

        <!-- Erreur -->
        <asp:Panel ID="pnlErreur" runat="server" Visible="false">
            <div class="alert-box alert-err">
                <i class="fa-solid fa-circle-exclamation"></i>
                <asp:Literal ID="litErreur" runat="server"/>
            </div>
        </asp:Panel>

        <!-- Email -->
        <div class="field">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="exemple@email.com"/>
            <i class="fa-solid fa-envelope fi"></i>
        </div>

        <!-- Mot de passe — SANS id HTML -->
        <div class="field">
            <label>Mot de passe</label>
            <asp:TextBox ID="txtMdp" runat="server" TextMode="Password" placeholder="Votre mot de passe"/>
            <i class="fa-solid fa-lock fi"></i>
            <button type="button" class="eye-btn" onclick="togglePw(this)">
                <i class="fa-solid fa-eye"></i>
            </button>
        </div>

        <div class="forgot-row">
            <a href="MotDePasseOublie.aspx">Mot de passe oublie ?</a>
        </div>

        <asp:Button ID="btnConnecter" runat="server" Text="Se connecter"
            CssClass="btn-main" OnClick="btnConnecter_Click"/>

        <div class="sep-or">ou</div>

        <!-- OAuth -->
        <div class="oauth-row">
            <asp:HyperLink ID="lnkGoogle" runat="server" CssClass="btn-oa">
                <svg class="oa-ico" viewBox="0 0 24 24">
                    <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                    <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                    <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                    <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                </svg>
                Google
            </asp:HyperLink>
            <asp:HyperLink ID="lnkGitHub" runat="server" CssClass="btn-oa">
                <svg class="oa-ico" viewBox="0 0 24 24" fill="#333">
                    <path d="M12 0C5.37 0 0 5.37 0 12c0 5.3 3.44 9.8 8.21 11.39.6.11.82-.26.82-.58v-2.03c-3.34.73-4.04-1.61-4.04-1.61-.55-1.39-1.34-1.76-1.34-1.76-1.09-.75.08-.73.08-.73 1.21.08 1.85 1.24 1.85 1.24 1.07 1.83 2.81 1.3 3.5 1 .1-.78.42-1.3.76-1.6-2.67-.3-5.47-1.33-5.47-5.93 0-1.31.47-2.38 1.24-3.22-.14-.3-.54-1.52.1-3.18 0 0 1.01-.32 3.3 1.23a11.5 11.5 0 013-.4c1.02 0 2.04.13 3 .4 2.28-1.55 3.29-1.23 3.29-1.23.64 1.66.24 2.88.12 3.18.77.84 1.24 1.91 1.24 3.22 0 4.61-2.81 5.63-5.48 5.92.43.37.81 1.1.81 2.22v3.29c0 .32.22.7.83.58C20.57 21.8 24 17.3 24 12c0-6.63-5.37-12-12-12z"/>
                </svg>
                GitHub
            </asp:HyperLink>
            <asp:HyperLink ID="lnkApple" runat="server" CssClass="btn-oa">
                <svg class="oa-ico" viewBox="0 0 24 24" fill="#000">
                    <path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.7 9.05 7.36c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.39-1.32 2.76-2.54 4.03zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z"/>
                </svg>
                Apple
            </asp:HyperLink>
        </div>

        <div class="sep-or">ou</div>

        <asp:Button ID="btnInvite" runat="server"
            Text="Continuer en tant qu&#39;invite"
            CssClass="btn-guest" OnClick="btnInvite_Click"/>

        <!-- LIEN sans apostrophe dans attribut -->
        <div class="btm-link">
            Pas de compte ?
            <a href="Inscription.aspx">S&#39;inscrire gratuitement</a>
        </div>

        <div class="copy">&#169; 2025 TLC Yemba Online Test</div>
    </div>

</div>
</form>
<script>
function togglePw(btn) {
    var fieldEl = btn.previousElementSibling;
    while (fieldEl && fieldEl.tagName !== 'INPUT') {
        fieldEl = fieldEl.previousElementSibling;
    }
    if (!fieldEl) return;
    fieldEl.type = (fieldEl.type === 'password') ? 'text' : 'password';
    var ico = btn.querySelector('i');
    if (ico) ico.className = (fieldEl.type === 'text') ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye';
}
</script>
</body>
</html>