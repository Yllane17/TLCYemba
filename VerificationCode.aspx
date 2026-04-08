<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerificationCode.aspx.cs" Inherits="TLCYemba.VerificationCode" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Code de verification &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--radius:14px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;
             background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
             min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px;}
        .card{background:rgba(255,255,255,.97);border-radius:28px;
              box-shadow:0 12px 60px rgba(58,175,169,.20);width:100%;max-width:420px;overflow:hidden;}
        .card-header{background:linear-gradient(135deg,var(--teal),var(--teal-dark));
                     padding:28px 36px 36px;text-align:center;position:relative;}
        .card-header::after{content:'';position:absolute;bottom:-18px;left:0;right:0;height:36px;
                            background:rgba(255,255,255,.97);border-radius:50% 50% 0 0/100% 100% 0 0;}
        .h-icon{width:60px;height:60px;background:rgba(255,255,255,.22);
                border:2px solid rgba(255,255,255,.4);border-radius:50%;
                display:flex;align-items:center;justify-content:center;margin:0 auto 12px;}
        .h-icon i{font-size:26px;color:white}
        .h-title{font-family:'Nunito',sans-serif;font-weight:900;font-size:20px;color:white;margin-bottom:3px;}
        .h-sub{font-size:12px;color:rgba(255,255,255,.78)}
        .card-body{padding:36px 36px 30px}
        .alert{padding:10px 15px;border-radius:10px;font-size:13px;font-weight:500;
               margin-bottom:16px;display:flex;align-items:center;gap:8px;}
        .alert-success{background:#F0FFF4;border:1.5px solid #9AE6B4;color:#276749}
        .alert-error{background:#FFF5F5;border:1.5px solid #FEB2B2;color:#C53030}
        .field{margin-bottom:16px}
        .field label{display:block;font-size:12px;font-weight:700;color:var(--txt-mid);
                     margin-bottom:5px;display:flex;align-items:center;gap:5px;}
        .field label i{font-size:10px;color:var(--teal)}
        .field input{width:100%;padding:11px 15px;border-radius:var(--radius);
                     border:1.5px solid #E2E8F0;font-size:14px;font-family:'Poppins',sans-serif;
                     color:var(--txt-dark);outline:none;transition:border-color .2s,box-shadow .2s;}
        .field input:focus{border-color:var(--teal);box-shadow:0 0 0 3px rgba(58,175,169,.12)}
        .field input::placeholder{color:#A0AEC0}
        .btn-submit{width:100%;padding:13px;border-radius:50px;background:var(--teal);
                    color:white;border:none;font-size:14.5px;font-weight:700;cursor:pointer;
                    font-family:'Poppins',sans-serif;
                    box-shadow:0 6px 22px rgba(58,175,169,.38);transition:all .2s;
                    display:flex;align-items:center;justify-content:center;gap:8px;}
        .btn-submit:hover{background:var(--teal-dark);transform:translateY(-2px)}
        .bottom-link{text-align:center;margin-top:16px;font-size:12.5px;color:var(--txt-soft)}
        .bottom-link a{color:var(--teal);font-weight:600;text-decoration:none}
        .steps{display:flex;justify-content:center;gap:0;margin-bottom:24px}
        .step{display:flex;align-items:center}
        .step-dot{width:28px;height:28px;border-radius:50%;border:2px solid #E2E8F0;
                  background:white;display:flex;align-items:center;justify-content:center;
                  font-size:11px;font-weight:700;color:#A0AEC0;}
        .step-dot.active{background:var(--teal);border-color:var(--teal);color:white}
        .step-dot.done{background:var(--teal-pale);border-color:var(--teal);color:var(--teal)}
        .step-line{width:40px;height:2px;background:#E2E8F0}
        .step-line.done{background:var(--teal)}

        /* Code input speciale : 6 cases */
        .code-wrap{display:flex;gap:10px;justify-content:center;margin-bottom:24px}
        .code-input{width:50px;height:60px;border:2px solid #E2E8F0;border-radius:12px;
                    text-align:center;font-family:'Nunito',sans-serif;font-size:26px;
                    font-weight:900;color:var(--teal-dark);outline:none;
                    transition:border-color .2s,box-shadow .2s;}
        .code-input:focus{border-color:var(--teal);box-shadow:0 0 0 3px rgba(58,175,169,.15)}
        .code-input.filled{background:var(--teal-pale);border-color:var(--teal)}
        .hidden-input{display:none}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="card">
    <div class="card-header">
        <div class="h-icon"><i class="fa-solid fa-shield-halved"></i></div>
        <div class="h-title">Verification</div>
        <div class="h-sub">Etape 2 sur 3 &#8212; Code de verification</div>
    </div>
    <div class="card-body">
        <div class="steps">
            <div class="step"><div class="step-dot done"><i class="fa-solid fa-check" style="font-size:10px"></i></div></div>
            <div class="step"><div class="step-line done"></div><div class="step-dot active">2</div></div>
            <div class="step"><div class="step-line"></div><div class="step-dot">3</div></div>
        </div>

        <asp:Panel ID="pnlErreur" runat="server" Visible="false">
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i>
                <asp:Literal ID="litErreur" runat="server"/>
            </div>
        </asp:Panel>

        <p style="font-size:13.5px;color:var(--txt-soft);margin-bottom:20px;text-align:center;line-height:1.7">
            Un code a 6 chiffres a ete envoye a<br/>
            <strong style="color:var(--txt-dark)"><asp:Literal ID="litEmail" runat="server"/></strong>
        </p>

        <!-- 6 cases visuelles -->
        <div class="code-wrap" id="codeBoxes">
            <input type="text" class="code-input" maxlength="1" pattern="[0-9]" inputmode="numeric"/>
            <input type="text" class="code-input" maxlength="1" pattern="[0-9]" inputmode="numeric"/>
            <input type="text" class="code-input" maxlength="1" pattern="[0-9]" inputmode="numeric"/>
            <input type="text" class="code-input" maxlength="1" pattern="[0-9]" inputmode="numeric"/>
            <input type="text" class="code-input" maxlength="1" pattern="[0-9]" inputmode="numeric"/>
            <input type="text" class="code-input" maxlength="1" pattern="[0-9]" inputmode="numeric"/>
        </div>

        <!-- Champ caché pour postback -->
        <asp:HiddenField ID="hfCode" runat="server"/>

        <asp:Button ID="btnVerifier" runat="server" Text="Verifier le code"
            CssClass="btn-submit" OnClick="btnVerifier_Click"
            OnClientClick="collectCode(); return true;"/>

        <div style="text-align:center;margin-top:14px;font-size:12.5px;color:var(--txt-soft)">
            Code non recu ?
            <asp:LinkButton ID="lbRenvoyer" runat="server"
                style="color:var(--teal);font-weight:600;text-decoration:none"
                OnClick="lbRenvoyer_Click">Renvoyer le code</asp:LinkButton>
        </div>
        <div class="bottom-link"><a href="MotDePasseOublie.aspx"><i class="fa-solid fa-arrow-left" style="margin-right:4px"></i>Retour</a></div>
    </div>
</div>
</form>
<script>
// Navigation auto entre les cases
var boxes = document.querySelectorAll('.code-input');
boxes.forEach(function(b, i) {
    b.addEventListener('input', function() {
        b.classList.toggle('filled', b.value !== '');
        if (b.value && i < boxes.length - 1) boxes[i+1].focus();
    });
    b.addEventListener('keydown', function(e) {
        if (e.key === 'Backspace' && !b.value && i > 0) boxes[i-1].focus();
    });
    b.addEventListener('paste', function(e) {
        e.preventDefault();
        var txt = (e.clipboardData || window.clipboardData).getData('text').replace(/\D/g,'');
        boxes.forEach(function(bx, j) { bx.value = txt[j] || ''; bx.classList.toggle('filled', !!bx.value); });
    });
});
// Rassembler les 6 chiffres dans le champ caché
function collectCode() {
    var c = '';
    boxes.forEach(function(b) { c += b.value; });
    document.getElementById('<%= hfCode.ClientID %>').value = c;
}
window.addEventListener('DOMContentLoaded', function() { if(boxes.length) boxes[0].focus(); });
</script>
</body>
</html>