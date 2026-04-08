<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inscription.aspx.cs" Inherits="TLCYemba.Inscription" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Inscription &#8212; TLC Yemba</title>
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
               display:grid;grid-template-columns:1fr 1fr;min-height:640px;}
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
        .lp-illo{z-index:1;width:100%;max-width:260px}
        .lp-text{z-index:1;text-align:center}
        .lp-text h2{font-family:'Nunito',sans-serif;font-weight:900;
            font-size:clamp(1.1rem,2vw,1.35rem);color:white;line-height:1.35;margin-bottom:6px;}
        .lp-text p{font-size:12px;color:rgba(255,255,255,.72);line-height:1.6}
        .right-panel{background:var(--cream);padding:40px 44px;
            display:flex;flex-direction:column;justify-content:center;overflow-y:auto;}
        .rp-title{font-family:'Nunito',sans-serif;font-weight:900;
            font-size:22px;color:var(--txt-dark);margin-bottom:3px;}
        .rp-sub{font-size:12.5px;color:var(--txt-soft);margin-bottom:20px}
        .alert-err{padding:9px 14px;border-radius:9px;font-size:12.5px;font-weight:500;
            margin-bottom:12px;background:#FFF5F5;border:1.5px solid #FEB2B2;color:#C53030;
            display:flex;align-items:center;gap:7px;}
        .field-row{display:grid;grid-template-columns:1fr 1fr;gap:12px}
        .field{margin-bottom:12px;position:relative}
        .field label{display:block;font-size:11px;font-weight:700;color:var(--txt-mid);
            margin-bottom:4px;text-transform:uppercase;letter-spacing:.4px}
        .field input[type=text],.field input[type=email],.field input[type=password]{
            width:100%;padding:10px 36px 10px 38px;border-radius:var(--radius);
            border:1.5px solid #DDD8CE;background:white;font-size:13px;
            font-family:'Poppins',sans-serif;color:var(--txt-dark);outline:none;
            transition:border-color .2s,box-shadow .2s;}
        .field input:focus{border-color:var(--teal);box-shadow:0 0 0 3px rgba(58,175,169,.12)}
        .field input::placeholder{color:#B0A898;font-size:12.5px}
        .fi{position:absolute;left:12px;top:33px;font-size:12.5px;color:#B0A898;pointer-events:none}
        .eye-btn{position:absolute;right:11px;top:32px;cursor:pointer;
            background:none;border:none;padding:0;font-size:13px;color:#B0A898;transition:color .2s;}
        .eye-btn:hover{color:var(--teal)}
        .strength-bar{height:4px;border-radius:50px;background:#E8E4DC;margin-top:4px;overflow:hidden}
        .strength-fill{height:100%;border-radius:50px;width:0%;transition:width .3s,background .3s}
        .strength-lbl{font-size:10px;color:var(--txt-soft);margin-top:2px}
        .btn-main{width:100%;padding:12px;border-radius:50px;background:var(--teal);
            color:white;border:none;font-size:14px;font-weight:700;cursor:pointer;
            font-family:'Poppins',sans-serif;box-shadow:0 6px 22px rgba(58,175,169,.38);
            transition:all .2s;display:flex;align-items:center;justify-content:center;gap:8px;margin-top:4px;}
        .btn-main:hover{background:var(--teal-dark);transform:translateY(-2px)}
        .btm-link{text-align:center;margin-top:14px;font-size:12px;color:var(--txt-soft)}
        .btm-link a{color:var(--teal);font-weight:600;text-decoration:none}
        .copy{text-align:center;margin-top:18px;font-size:11px;color:#C0BAB0}
        @media(max-width:720px){.outer{grid-template-columns:1fr}.left-panel{display:none}
            .right-panel{padding:28px 20px}.field-row{grid-template-columns:1fr}}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="outer">

    <!-- LEFT PANEL -->
    <div class="left-panel">
        <div class="lp-logo">
            <div class="lp-logo-icon">T</div>
            <span class="lp-logo-text">TLC <span>Yemba</span></span>
        </div>
        <div class="lp-illo">
<svg viewBox="0 0 260 220" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="30" y="30" width="160" height="120" rx="12" fill="rgba(255,255,255,.18)" stroke="rgba(255,255,255,.4)" stroke-width="2"/>
  <rect x="46" y="52" width="80" height="7" rx="3" fill="rgba(255,255,255,.8)"/>
  <rect x="46" y="66" width="128" height="5" rx="2" fill="rgba(255,255,255,.5)"/>
  <rect x="46" y="78" width="100" height="5" rx="2" fill="rgba(255,255,255,.45)"/>
  <rect x="46" y="90" width="115" height="5" rx="2" fill="rgba(255,255,255,.4)"/>
  <circle cx="148" cy="118" r="22" fill="#FCD116" opacity=".9"/>
  <text x="148" y="124" text-anchor="middle" font-size="22" fill="#1A6F6A">&#9733;</text>
  <ellipse cx="220" cy="96" rx="22" ry="24" fill="#F5C090"/>
  <path d="M198 90 C198 72 208 62 220 62 C232 62 242 72 242 90 C240 82 232 78 220 78 C208 78 200 82 198 90 Z" fill="#1A2818"/>
  <path d="M198 90 C192 98 190 110 192 122" stroke="#1A2818" stroke-width="8" stroke-linecap="round"/>
  <circle cx="214" cy="95" r="2.5" fill="#1A0C04"/><circle cx="226" cy="95" r="2.5" fill="#1A0C04"/>
  <circle cx="215" cy="94" r="1" fill="white"/><circle cx="227" cy="94" r="1" fill="white"/>
  <path d="M213 105 Q220 111 227 105" stroke="#C87858" stroke-width="1.8" fill="none" stroke-linecap="round"/>
  <path d="M194 185 C194 158 204 148 212 144 C220 146 228 146 236 144 C244 148 254 158 254 185 Z" fill="#2B8F8A"/>
  <path d="M212 144 L220 158 L228 144 L226 174 C222 180 218 180 214 174 Z" fill="white"/>
  <path d="M194 154 C184 142 175 132 170 120" stroke="#2B8F8A" stroke-width="10" stroke-linecap="round"/>
  <rect x="155" y="108" width="28" height="20" rx="4" fill="rgba(255,255,255,.9)" stroke="#FCD116" stroke-width="2"/>
  <text x="169" y="122" text-anchor="middle" font-size="10" fill="#2B8F8A" font-weight="700">TLC</text>
  <rect x="60" y="170" width="8" height="8" rx="2" fill="#FCD116" transform="rotate(25 64 174)"/>
  <circle cx="100" cy="175" r="4" fill="rgba(255,255,255,.5)"/>
  <circle cx="145" cy="185" r="3" fill="#FCD116" opacity=".7"/>
</svg>
        </div>
        <div class="lp-text">
            <h2>Rejoignez la communaute<br/>TLC Yemba</h2>
            <p>Creez votre compte et obtenez votre certificat officiel</p>
        </div>
    </div>

    <!-- RIGHT PANEL -->
    <div class="right-panel">
        <div class="rp-title">Creer un compte</div>
        <div class="rp-sub">C'est rapide et gratuit</div>

        <asp:Panel ID="pnlErreur" runat="server" Visible="false">
            <div class="alert-err">
                <i class="fa-solid fa-circle-exclamation"></i>
                <asp:Literal ID="litErreur" runat="server"/>
            </div>
        </asp:Panel>

        <div class="field-row">
            <div class="field">
                <label>Nom</label>
                <asp:TextBox ID="txtNom" runat="server" placeholder="Nom de famille"/>
                <i class="fa-solid fa-user fi"></i>
            </div>
            <div class="field">
                <label>Prenom</label>
                <asp:TextBox ID="txtPrenom" runat="server" placeholder="Prenom"/>
                <i class="fa-solid fa-user fi"></i>
            </div>
        </div>

        <div class="field">
            <label>Adresse email</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="exemple@email.com"/>
            <i class="fa-solid fa-envelope fi"></i>
        </div>

        <!-- PAS de id HTML ici — uniquement ID ASP.NET -->
        <div class="field">
            <label>Mot de passe</label>
            <asp:TextBox ID="txtMdp" runat="server" TextMode="Password" placeholder="Min. 6 caracteres"/>
            <i class="fa-solid fa-lock fi"></i>
            <button type="button" class="eye-btn" onclick="togglePw('<%= txtMdp.ClientID %>', this)">
                <i class="fa-solid fa-eye"></i>
            </button>
            <div class="strength-bar"><div class="strength-fill" id="sfill"></div></div>
            <div class="strength-lbl" id="slbl"></div>
        </div>

        <!-- PAS de id HTML ici — uniquement ID ASP.NET -->
        <div class="field">
            <label>Confirmer le mot de passe</label>
            <asp:TextBox ID="txtMdpConfirm" runat="server" TextMode="Password" placeholder="Repetez le mot de passe"/>
            <i class="fa-solid fa-lock fi"></i>
            <button type="button" class="eye-btn" onclick="togglePw('<%= txtMdpConfirm.ClientID %>', this)">
                <i class="fa-solid fa-eye"></i>
            </button>
        </div>

        <asp:Button ID="btnInscrire" runat="server" Text="Creer mon compte"
            CssClass="btn-main" OnClick="btnInscrire_Click"/>

        <div class="btm-link">Deja un compte ? <a href="Connexion.aspx">Se connecter</a></div>
        <div class="copy">&#169; 2025 TLC Yemba Online Test</div>
    </div>

</div>
</form>
<script>
/* toggle afficher/masquer MDP — utilise ClientID injecte par serveur */
function togglePw(clientId, btn) {
    var f = document.getElementById(clientId);
    var i = btn.querySelector('i');
    if (!f) return;
    f.type = (f.type === 'password') ? 'text' : 'password';
    i.className = (f.type === 'text') ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye';
}

/* Jauge de force — attachee apres rendu via ClientID */
(function(){
    var mdpField = document.getElementById('<%= txtMdp.ClientID %>');
    if (!mdpField) return;
    mdpField.addEventListener('input', function(){ evalForce(this.value); });
})();

function evalForce(v) {
    var fill = document.getElementById('sfill');
    var lbl  = document.getElementById('slbl');
    if (!fill || !lbl) return;
    var s = 0;
    if (v.length >= 6)         s++;
    if (v.length >= 10)        s++;
    if (/[A-Z]/.test(v))       s++;
    if (/[0-9]/.test(v))       s++;
    if (/[^a-zA-Z0-9]/.test(v))s++;
    var cols = ['#E53E3E','#DD6B20','#D69E2E','#38A169','#3AAFA9'];
    var lbls = ['Tres faible','Faible','Moyen','Fort','Tres fort'];
    fill.style.width      = (s/5*100) + '%';
    fill.style.background = cols[s-1] || '#E2E8F0';
    lbl.textContent       = s > 0 ? lbls[s-1] : '';
}
</script>
</body>
</html>