<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NouveauMotDePasse.aspx.cs" Inherits="TLCYemba.NouveauMotDePasse" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Nouveau mot de passe &#8212; TLC Yemba</title>
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
        .steps{display:flex;justify-content:center;gap:0;margin-bottom:24px}
        .step{display:flex;align-items:center}
        .step-dot{width:28px;height:28px;border-radius:50%;border:2px solid #E2E8F0;
                  background:white;display:flex;align-items:center;justify-content:center;
                  font-size:11px;font-weight:700;color:#A0AEC0;}
        .step-dot.active{background:var(--teal);border-color:var(--teal);color:white}
        .step-dot.done{background:var(--teal-pale);border-color:var(--teal);color:var(--teal)}
        .step-line{width:40px;height:2px;background:#E2E8F0}
        .step-line.done{background:var(--teal)}
        /* Force meter */
        .strength-bar{height:5px;border-radius:50px;background:#E2E8F0;margin-top:6px;overflow:hidden}
        .strength-fill{height:100%;border-radius:50px;width:0%;transition:width .3s,background .3s}
        .strength-label{font-size:11px;color:var(--txt-soft);margin-top:3px}
</style>
</head>
<body>
<form id="form1" runat="server">
<div class="card">
    <div class="card-header">
        <div class="h-icon"><i class="fa-solid fa-lock-open"></i></div>
        <div class="h-title">Nouveau mot de passe</div>
        <div class="h-sub">Etape 3 sur 3 &#8212; Choisissez votre nouveau mot de passe</div>
    </div>
    <div class="card-body">
        <div class="steps">
            <div class="step"><div class="step-dot done"><i class="fa-solid fa-check" style="font-size:10px"></i></div></div>
            <div class="step"><div class="step-line done"></div><div class="step-dot done"><i class="fa-solid fa-check" style="font-size:10px"></i></div></div>
            <div class="step"><div class="step-line done"></div><div class="step-dot active">3</div></div>
        </div>

        <asp:Panel ID="pnlErreur" runat="server" Visible="false">
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i>
                <asp:Literal ID="litErreur" runat="server"/>
            </div>
        </asp:Panel>

        <div class="field">
            <label><i class="fa-solid fa-lock"></i> Nouveau mot de passe</label>
            <asp:TextBox ID="txtMdp" runat="server" TextMode="Password"
                placeholder="Min. 6 caracteres" onkeyup="evalForce(this.value)"/>
            <div class="strength-bar"><div class="strength-fill" id="sfill"></div></div>
            <div class="strength-label" id="slabel"></div>
        </div>
        <div class="field">
            <label><i class="fa-solid fa-lock"></i> Confirmer le mot de passe</label>
            <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" placeholder="Repetez le mot de passe"/>
        </div>

        <asp:Button ID="btnEnregistrer" runat="server" Text="Enregistrer le mot de passe"
            CssClass="btn-submit" OnClick="btnEnregistrer_Click"/>
    </div>
</div>
</form>
<script>
function evalForce(v) {
    var fill  = document.getElementById('sfill');
    var label = document.getElementById('slabel');
    var score = 0;
    if(v.length >= 6)  score++;
    if(v.length >= 10) score++;
    if(/[A-Z]/.test(v)) score++;
    if(/[0-9]/.test(v)) score++;
    if(/[^a-zA-Z0-9]/.test(v)) score++;
    var pct = (score/5*100)+'%';
    var colors = ['#E53E3E','#DD6B20','#D69E2E','#38A169','#3AAFA9'];
    var labels = ['Tres faible','Faible','Moyen','Fort','Tres fort'];
    fill.style.width = pct;
    fill.style.background = colors[score-1] || '#E2E8F0';
    label.textContent = score > 0 ? labels[score-1] : '';
}
</script>
</body>
</html>