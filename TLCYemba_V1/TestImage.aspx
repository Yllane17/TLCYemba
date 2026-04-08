<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestImage.aspx.cs" Inherits="TLCYemba.TestImage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Description d'images — TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--violet:#9C68C3;--violet-pale:#F5F0FA;--teal:#3AAFA9;
              --txt-dark:#2D3748;--txt-soft:#718096;--radius:14px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;background:#F4F0F8;min-height:100vh}

        .top-bar{background:white;padding:13px 24px;display:flex;align-items:center;gap:14px;
            position:sticky;top:0;z-index:50;box-shadow:0 2px 12px rgba(0,0,0,.06);
            border-bottom:1.5px solid rgba(156,104,195,.12)}
        .logo-pill{display:flex;align-items:center;gap:8px}
        .logo-c{width:32px;height:32px;background:var(--violet);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:14px;color:white}
        .badge-img{background:var(--violet-pale);color:var(--violet);border:1px solid rgba(156,104,195,.3);
            padding:5px 14px;border-radius:50px;font-size:12px;font-weight:700;
            display:flex;align-items:center;gap:6px}
        .spacer{flex:1}
        .timer-box{display:flex;align-items:center;gap:7px;padding:8px 18px;
            border-radius:50px;background:var(--violet-pale);border:1.5px solid rgba(156,104,195,.3);
            transition:all .3s}
        .timer-box.danger{background:#FFF5F5;border-color:#FEB2B2}
        .timer-val{font-family:'Nunito',sans-serif;font-weight:900;font-size:22px;
            color:var(--violet);line-height:1;min-width:32px;text-align:center;transition:color .3s}
        .timer-box.danger .timer-val{color:#E53E3E}

        .progress-wrap{background:white;padding:12px 24px 10px;border-bottom:1.5px solid rgba(156,104,195,.1)}
        .prog-row{display:flex;justify-content:space-between;margin-bottom:7px}
        .prog-lbl{font-size:11.5px;color:var(--txt-soft);font-weight:500}
        .prog-count{font-family:'Nunito',sans-serif;font-weight:900;font-size:13.5px;color:var(--violet)}
        .prog-bar{height:7px;background:#E2E8F0;border-radius:50px;overflow:hidden}
        .prog-fill{height:100%;background:linear-gradient(90deg,var(--violet),#C49DE8);
            border-radius:50px;transition:width .4s ease}

        .dots-wrap{display:flex;gap:5px;flex-wrap:wrap;padding:10px 24px 6px;
            background:white;border-bottom:1.5px solid rgba(156,104,195,.1);overflow-x:auto}
        .dot{width:22px;height:22px;border-radius:6px;border:none;cursor:pointer;
            font-size:8px;font-weight:700;transition:all .18s;font-family:'Poppins',sans-serif}
        .dot-pending {background:#E2E8F0;color:#A0AEC0}
        .dot-answered{background:var(--violet);color:white}
        .dot-current {background:#6B3FA0;color:white;transform:scale(1.12)}

        .content{max-width:700px;margin:0 auto;padding:24px 20px}

        .img-container{background:white;border-radius:var(--radius);padding:16px;
            margin-bottom:20px;box-shadow:0 2px 12px rgba(156,104,195,.12);
            border:2px solid rgba(156,104,195,.15);text-align:center}
        .img-container img{max-width:100%;max-height:320px;border-radius:10px;
            object-fit:cover;border:3px solid var(--violet-pale)}
        .img-num{font-size:11px;color:var(--txt-soft);margin-top:8px;
            display:flex;align-items:center;justify-content:center;gap:5px}

        .img-placeholder{width:100%;height:240px;background:var(--violet-pale);
            border-radius:10px;display:flex;flex-direction:column;
            align-items:center;justify-content:center;gap:12px}
        .img-placeholder i{font-size:60px;color:var(--violet);opacity:.4}
        .img-placeholder p{font-size:13px;color:var(--txt-soft)}

        .q-card{background:white;border-radius:var(--radius);padding:20px 22px;
            box-shadow:0 2px 12px rgba(0,0,0,.05);margin-bottom:16px}
        .q-label{font-size:11px;font-weight:700;color:var(--violet);
            text-transform:uppercase;letter-spacing:.5px;margin-bottom:8px;
            display:flex;align-items:center;gap:6px}
        .q-enonce{font-size:15px;font-weight:600;color:var(--txt-dark);
            line-height:1.65;margin-bottom:18px}

        .choices{display:flex;flex-direction:column;gap:9px}
        .choice{display:flex;align-items:center;gap:12px;padding:12px 15px;
            border-radius:12px;border:1.8px solid #E2E8F0;background:white;
            cursor:pointer;transition:all .18s}
        .choice:hover{border-color:var(--violet);background:var(--violet-pale)}
        .choice.selected{border-color:var(--violet);background:var(--violet-pale)}
        .choice-letter{width:32px;height:32px;border-radius:9px;flex-shrink:0;
            display:flex;align-items:center;justify-content:center;
            font-weight:800;font-size:13px;border:1.5px solid #CBD5E0;color:#666;transition:all .18s}
        .choice.selected .choice-letter{background:var(--violet);border-color:var(--violet);color:white}
        .choice-text{font-size:13.5px;color:var(--txt-dark)}

        .nav-btns{display:flex;gap:12px;margin-top:4px}
        .btn-nav{flex:1;padding:12px;border-radius:50px;font-size:14px;
            font-weight:700;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:all .2s;display:flex;align-items:center;justify-content:center;gap:7px;border:none}
        .btn-prev-n{background:white;border:1.8px solid #E2E8F0;color:var(--txt-soft)}
        .btn-prev-n:hover{border-color:var(--violet);color:var(--violet)}
        .btn-next-n{background:var(--violet);color:white;box-shadow:0 4px 16px rgba(156,104,195,.35)}
        .btn-next-n:hover{background:#6B3FA0;transform:translateY(-1px)}
        .btn-finish-n{background:#48BB78;color:white}

        .auto-toast{position:fixed;bottom:80px;left:50%;transform:translateX(-50%);
            background:rgba(44,44,44,.9);color:white;padding:10px 22px;border-radius:50px;
            font-size:13px;font-weight:600;z-index:999;opacity:0;transition:opacity .3s;pointer-events:none}
        .auto-toast.show{opacity:1}
    </style>
</head>
<body>
<form id="form1" runat="server">
<asp:HiddenField ID="hfIndex"        runat="server" Value="0"/>
<asp:HiddenField ID="hfChoixLettre"  runat="server"/>
<asp:HiddenField ID="hfTimerRestant" runat="server" Value="20"/>

<div class="top-bar">
    <div class="logo-pill">
        <div class="logo-c"><i class="fa-solid fa-image" style="font-size:13px"></i></div>
        <div class="badge-img"><i class="fa-solid fa-image"></i> Description d'images</div>
    </div>
    <div class="spacer"></div>
    <div class="timer-box" id="timerBox">
        <i class="fa-solid fa-stopwatch" style="color:var(--violet)"></i>
        <div>
            <div class="timer-val" id="timerVal">20</div>
            <div style="font-size:9px;color:var(--txt-soft);letter-spacing:.4px">sec / Q</div>
        </div>
    </div>
</div>

<div class="progress-wrap">
    <div class="prog-row">
        <span class="prog-lbl">Image <asp:Literal ID="litIdx" runat="server"/> / <asp:Literal ID="litTotal" runat="server"/></span>
        <span class="prog-count">Culture Yemba</span>
    </div>
    <div class="prog-bar"><div class="prog-fill" id="progFill"></div></div>
</div>

<div class="dots-wrap"><asp:Literal ID="litDots" runat="server"/></div>

<div class="content">

    <div class="img-container">
        <asp:Panel ID="pnlImg" runat="server" Visible="true">
            <asp:Image ID="imgQ" runat="server" AlternateText="Image Yemba"/>
        </asp:Panel>
        <asp:Panel ID="pnlPlaceholder" runat="server" Visible="false">
            <div class="img-placeholder">
                <i class="fa-solid fa-image"></i>
                <p>Image culture Yemba</p>
            </div>
        </asp:Panel>
        <div class="img-num">
            <i class="fa-solid fa-tag" style="font-size:10px"></i>
            Image <asp:Literal ID="litImgNum" runat="server"/>
        </div>
    </div>

    <div class="q-card">
        <div class="q-label"><i class="fa-solid fa-question-circle"></i> Question</div>
        <div class="q-enonce"><asp:Literal ID="litEnonce" runat="server"/></div>
        <div class="choices">
            <asp:Repeater ID="rptChoix" runat="server">
                <ItemTemplate>
                    <div class="choice <%# ((bool)Eval("IsSelected")) ? "selected" : "" %>"
                         onclick="choisir('<%# Eval("Lettre") %>', this)">
                        <div class="choice-letter"><%# Eval("Lettre") %></div>
                        <div class="choice-text"><%# Eval("Texte") %></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <div class="nav-btns">
        <asp:Button ID="btnSuivant" runat="server" Text="Image suivante"
            CssClass="btn-nav btn-next-n" OnClick="btnSuivant_Click"/>
        <asp:Button ID="btnTerminer" runat="server" Text="Terminer"
            CssClass="btn-nav btn-finish-n" Visible="false" OnClick="btnTerminer_Click"/>
    </div>

</div>

<div class="auto-toast" id="autoToast">
    <i class="fa-solid fa-forward-step"></i> Image suivante...
</div>
</form>

<script>
    var timerRestant = 20;
    var timerObj = null;

    function demarrerTimer() {
        if (timerObj) clearInterval(timerObj);
        timerRestant = 20;
        afficherTimer();
        timerObj = setInterval(tickTimer, 1000);
    }

    function tickTimer() {
        timerRestant--;
        afficherTimer();
        if (timerRestant <= 0) {
            clearInterval(timerObj);
            autoAvancer();
        }
    }

    function afficherTimer() {
        var v = document.getElementById('timerVal');
        var b = document.getElementById('timerBox');
        if (v) v.textContent = timerRestant > 0 ? timerRestant : 0;
        if (b) {
            if (timerRestant <= 5) b.classList.add('danger');
            else b.classList.remove('danger');
        }
        var hf = document.getElementById('<%= hfTimerRestant.ClientID %>');
    if (hf) hf.value = timerRestant;
}

function autoAvancer() {
    var t = document.getElementById('autoToast');
    if (t) t.classList.add('show');
    var fin  = document.getElementById('<%= btnTerminer.ClientID %>');
    var next = document.getElementById('<%= btnSuivant.ClientID %>');
    if (fin  && fin.style.display !== 'none')  { fin.click(); }
    else if (next) { next.click(); }
}

function choisir(lettre, el) {
    document.querySelectorAll('.choice').forEach(function(c) { c.classList.remove('selected'); });
    el.classList.add('selected');
    var hf = document.getElementById('<%= hfChoixLettre.ClientID %>');
    if (hf) hf.value = lettre;
}

(function () {
    var total = parseInt('<%= litTotal.Text %>', 10) || 1;
    var idx   = parseInt('<%= hfIndex.Value %>', 10) || 0;
        var fill = document.getElementById('progFill');
        if (fill) fill.style.width = Math.round(((idx) / total) * 100) + '%';
        demarrerTimer();
    })();
</script>
</body>
</html>