<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="TLCYemba.Test" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Test — TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--radius:14px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;background:#F0F4F3;min-height:100vh}

        /* ── TOP BAR ── */
        .top-bar{background:white;border-bottom:1.5px solid rgba(58,175,169,.12);
            padding:13px 24px;display:flex;align-items:center;gap:14px;
            position:sticky;top:0;z-index:50;box-shadow:0 2px 12px rgba(0,0,0,.06)}
        .logo-pill{display:flex;align-items:center;gap:8px}
        .logo-c{width:32px;height:32px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:14px;color:white}
        .logo-t{font-family:'Nunito',sans-serif;font-weight:900;font-size:16px;color:var(--txt-dark)}
        .logo-t span{color:var(--teal)}
        .spacer{flex:1}

        /* ── TIMER 20 secondes par question ── */
        .timer-box{display:flex;align-items:center;gap:7px;padding:8px 18px;
            border-radius:50px;transition:all .3s;background:var(--teal-pale);
            border:1.5px solid rgba(58,175,169,.3)}
        .timer-box.danger{background:#FFF5F5;border-color:#FEB2B2}
        .timer-box i{font-size:14px;color:var(--teal);transition:color .3s}
        .timer-box.danger i{color:#E53E3E}
        .timer-val{font-family:'Nunito',sans-serif;font-weight:900;font-size:22px;
            color:var(--teal-dark);line-height:1;transition:color .3s;min-width:32px;text-align:center}
        .timer-box.danger .timer-val{color:#E53E3E}
        .timer-lbl{font-size:9px;color:var(--txt-soft);letter-spacing:.4px;line-height:1}

        /* ── PROGRESS ── */
        .progress-wrap{background:white;padding:12px 24px 10px;
            border-bottom:1.5px solid rgba(58,175,169,.08)}
        .prog-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:7px}
        .prog-lbl{font-size:11.5px;color:var(--txt-soft);font-weight:500}
        .prog-count{font-family:'Nunito',sans-serif;font-weight:900;font-size:13.5px;color:var(--teal)}
        .prog-bar{height:7px;background:#E2E8F0;border-radius:50px;overflow:hidden}
        .prog-fill{height:100%;background:linear-gradient(90deg,var(--teal),#44C4BE);
            border-radius:50px;transition:width .4s ease}

        /* ── DOTS ── */
        .dots-wrap{display:flex;gap:5px;flex-wrap:wrap;padding:10px 24px 6px;
            background:white;border-bottom:1.5px solid rgba(58,175,169,.08);overflow-x:auto}
        .dot{width:22px;height:22px;border-radius:6px;border:none;cursor:pointer;
            font-size:8px;font-weight:700;transition:all .18s;font-family:'Poppins',sans-serif}
        .dot-pending {background:#E2E8F0;color:#A0AEC0}
        .dot-answered{background:var(--teal);color:white}
        .dot-current {background:var(--teal-dark);color:white;transform:scale(1.12);box-shadow:0 2px 8px rgba(58,175,169,.4)}

        /* ── CONTENT ── */
        .content{max-width:860px;margin:0 auto;padding:24px 20px}

        /* ── TEXTE READING ── */
        .lecture-box{background:white;border-radius:var(--radius);padding:22px 24px;
            margin-bottom:20px;border-left:5px solid var(--teal);
            box-shadow:0 2px 12px rgba(0,0,0,.05)}
        .lecture-box h3{font-family:'Nunito',sans-serif;font-weight:800;font-size:14.5px;
            color:var(--teal);margin-bottom:10px;display:flex;align-items:center;gap:7px}
        .lecture-body{font-size:13.5px;color:var(--txt-dark);line-height:1.85;
            max-height:200px;overflow-y:auto;padding-right:4px}
        .lecture-body::-webkit-scrollbar{width:4px}
        .lecture-body::-webkit-scrollbar-thumb{background:var(--teal-pale);border-radius:50px}

        /* ── IMAGE DESCRIPTION ── */
        .image-box{background:white;border-radius:var(--radius);padding:16px;
            margin-bottom:20px;box-shadow:0 2px 12px rgba(0,0,0,.05);text-align:center}
        .image-box img{max-width:100%;max-height:280px;border-radius:10px;
            object-fit:cover;border:3px solid var(--teal-pale)}
        .image-box .img-placeholder{width:100%;height:200px;background:var(--teal-pale);
            border-radius:10px;display:flex;align-items:center;justify-content:center;
            flex-direction:column;gap:10px;color:var(--teal-dark)}
        .image-box .img-placeholder i{font-size:48px;opacity:.5}

        /* ── QUESTION CARD ── */
        .q-card{background:white;border-radius:var(--radius);padding:22px 24px;
            box-shadow:0 2px 12px rgba(0,0,0,.05);margin-bottom:18px}
        .q-top{display:flex;align-items:center;gap:10px;margin-bottom:14px}
        .q-num{width:38px;height:38px;background:var(--teal);border-radius:10px;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:15px;color:white;flex-shrink:0}
        .q-section{display:inline-flex;align-items:center;gap:5px;
            background:var(--teal-pale);border:1px solid rgba(58,175,169,.3);
            color:var(--teal-dark);padding:4px 12px;border-radius:50px;
            font-size:11.5px;font-weight:700}
        .q-enonce{font-size:15.5px;font-weight:600;color:var(--txt-dark);
            line-height:1.68;margin-bottom:20px}

        /* ── CHOIX ── */
        .choices{display:flex;flex-direction:column;gap:10px}
        .choice{display:flex;align-items:center;gap:13px;padding:13px 16px;
            border-radius:12px;border:1.8px solid #E2E8F0;background:white;
            cursor:pointer;transition:all .18s;user-select:none}
        .choice:hover{border-color:var(--teal);background:var(--teal-pale)}
        .choice.selected{border-color:var(--teal);background:var(--teal-pale);
            box-shadow:0 0 0 3px rgba(58,175,169,.12)}
        .choice-letter{width:32px;height:32px;border-radius:9px;flex-shrink:0;
            display:flex;align-items:center;justify-content:center;
            font-weight:800;font-size:13.5px;border:1.5px solid #CBD5E0;
            color:var(--txt-mid);transition:all .18s}
        .choice.selected .choice-letter{background:var(--teal);border-color:var(--teal);color:white}
        .choice-text{font-size:13.5px;color:var(--txt-dark);line-height:1.5}

        /* ── NAV BUTTONS ── */
        .nav-btns{display:flex;gap:12px;margin-top:6px}
        .btn-prev{flex:1;padding:12px;border-radius:50px;
            background:white;border:1.8px solid #E2E8F0;color:var(--txt-mid);
            font-size:14px;font-weight:600;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:all .2s;display:flex;align-items:center;justify-content:center;gap:7px}
        .btn-prev:hover{border-color:var(--teal);color:var(--teal)}
        .btn-next{flex:1;padding:12px;border-radius:50px;background:var(--teal);
            border:none;color:white;font-size:14px;font-weight:700;cursor:pointer;
            font-family:'Poppins',sans-serif;transition:all .2s;
            display:flex;align-items:center;justify-content:center;gap:7px;
            box-shadow:0 4px 16px rgba(58,175,169,.35)}
        .btn-next:hover{background:var(--teal-dark);transform:translateY(-1px)}
        .btn-finish{background:#48BB78;box-shadow:0 4px 16px rgba(72,187,120,.35)}
        .btn-finish:hover{background:#38A169}

        /* ── AUTO-ADVANCE TOAST ── */
        .auto-toast{position:fixed;bottom:80px;left:50%;transform:translateX(-50%);
            background:rgba(44,44,44,.9);color:white;padding:10px 22px;border-radius:50px;
            font-size:13px;font-weight:600;z-index:999;opacity:0;transition:opacity .3s;
            pointer-events:none;backdrop-filter:blur(8px)}
        .auto-toast.show{opacity:1}
    </style>
</head>
<body>
<form id="form1" runat="server">
<asp:HiddenField ID="hfIndex"   runat="server" Value="0"/>
<asp:HiddenField ID="hfTimerRestant" runat="server" Value="20"/>

<!-- ── TOP BAR ── -->
<div class="top-bar">
    <div class="logo-pill">
        <div class="logo-c">T</div>
        <span class="logo-t">TLC <span>Yemba</span></span>
    </div>
    <div class="spacer"></div>
    <div class="timer-box" id="timerBox">
        <i class="fa-solid fa-stopwatch"></i>
        <div>
            <div class="timer-val" id="timerVal">20</div>
            <div class="timer-lbl">sec / Q</div>
        </div>
    </div>
</div>

<!-- ── PROGRESS ── -->
<div class="progress-wrap">
    <div class="prog-row">
        <span class="prog-lbl">Progression</span>
        <span class="prog-count">
            <asp:Literal ID="litIndexDisplay" runat="server"/>
            /
            <asp:Literal ID="litTotal" runat="server"/>
        </span>
    </div>
    <div class="prog-bar">
        <div class="prog-fill" id="progFill" style="width:0%"></div>
    </div>
</div>

<!-- ── DOTS ── -->
<div class="dots-wrap" id="dotsWrap">
    <asp:Literal ID="litDots" runat="server"/>
</div>

<!-- ── CONTENU PRINCIPAL ── -->
<div class="content">

    <!-- Texte de lecture (Reading uniquement) -->
    <asp:Panel ID="pnlTexteLecture" runat="server" Visible="false">
        <div class="lecture-box">
            <h3><i class="fa-solid fa-book-open"></i> Texte de lecture</h3>
            <div class="lecture-body"><asp:Literal ID="litTexteLecture" runat="server"/></div>
        </div>
    </asp:Panel>

    <!-- Image (ImageDescription uniquement) -->
    <asp:Panel ID="pnlImage" runat="server" Visible="false">
        <div class="image-box">
            <asp:Image ID="imgQuestion" runat="server" CssClass="img-question"
                AlternateText="Image de la question"/>
            <div class="img-placeholder" id="imgPlaceholder" style="display:none">
                <i class="fa-solid fa-image"></i>
                <span>Image en cours de chargement...</span>
            </div>
        </div>
    </asp:Panel>

    <!-- Question card -->
    <div class="q-card">
        <div class="q-top">
            <div class="q-num"><asp:Literal ID="litQNum" runat="server"/></div>
            <span class="q-section">
                <i class="fa-solid fa-tag" style="font-size:10px"></i>
                <asp:Literal ID="litSection" runat="server"/>
            </span>
        </div>
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

    <!-- Boutons nav -->
    <div class="nav-btns">
        <button type="button" class="btn-prev" id="btnPrevUI"
                onclick="naviguer(-1)" style="display:none">
            <i class="fa-solid fa-arrow-left"></i> Precedent
        </button>
        <asp:Button ID="btnSuivant" runat="server" Text="Suivant"
            CssClass="btn-next" OnClick="btnSuivant_Click"
            OnClientClick="return preparerNav(false);"/>
        <asp:Button ID="btnTerminer" runat="server" Text="Terminer le test"
            CssClass="btn-next btn-finish" OnClick="btnTerminer_Click"
            Visible="false"
            OnClientClick="return preparerNav(true);"/>
    </div>
</div>

<!-- Cache pour PostBack -->
<asp:HiddenField ID="hfChoixLettre" runat="server"/>

<!-- Toast auto-avance -->
<div class="auto-toast" id="autoToast">
    <i class="fa-solid fa-forward-step"></i> Passage automatique...
</div>

</form>

<script>
    /* ================================================================
       TIMER 20s / QUESTION — auto-advance quand timer atteint 0
       ================================================================ */
    var TIMER_TOTAL = 20;
    var timerRestant = TIMER_TOTAL;
    var timerObj = null;

    function demarrerTimer() {
        if (timerObj) clearInterval(timerObj);
        timerRestant = TIMER_TOTAL;
        mettreAJourAffichage();
        timerObj = setInterval(tickTimer, 1000);
    }

    function tickTimer() {
        timerRestant--;
        mettreAJourAffichage();
        if (timerRestant <= 0) {
            clearInterval(timerObj);
            autoAvancer();
        }
    }

    function mettreAJourAffichage() {
        var el = document.getElementById('timerVal');
        var box = document.getElementById('timerBox');
        if (el) el.textContent = timerRestant > 0 ? timerRestant : 0;
        if (box) {
            if (timerRestant <= 5) box.classList.add('danger');
            else box.classList.remove('danger');
        }
        var hf = document.getElementById('<%= hfTimerRestant.ClientID %>');
    if (hf) hf.value = timerRestant;
}

function autoAvancer() {
    var toast = document.getElementById('autoToast');
    if (toast) { toast.classList.add('show'); }
    var btnNext = document.getElementById('<%= btnSuivant.ClientID %>');
    var btnFin  = document.getElementById('<%= btnTerminer.ClientID %>');
    if (btnFin && btnFin.style.display !== 'none') {
        preparerNav(true);
        if (btnFin) btnFin.click();
    } else if (btnNext) {
        preparerNav(false);
        if (btnNext) btnNext.click();
    }
}

function choisir(lettre, el) {
    document.querySelectorAll('.choice').forEach(function(c) {
        c.classList.remove('selected');
        c.querySelector('.choice-letter').style.background = '';
    });
    el.classList.add('selected');
    var hf = document.getElementById('<%= hfChoixLettre.ClientID %>');
    if (hf) hf.value = lettre;
}

function preparerNav(estFin) {
    return true;
}

function naviguer(dir) {
    // Implémentez la navigation précédente si nécessaire
    return true;
}

(function () {
    var total  = parseInt('<%= litTotal.Text %>', 10) || 1;
    var index  = parseInt('<%= hfIndex.Value %>', 10) || 0;
        var fill = document.getElementById('progFill');
        if (fill) fill.style.width = Math.round((index / total) * 100) + '%';

        var prev = document.getElementById('btnPrevUI');
        if (prev) prev.style.display = index > 0 ? 'flex' : 'none';

        demarrerTimer();
    })();
</script>
</body>
</html>