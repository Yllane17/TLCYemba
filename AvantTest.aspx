<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AvantTest.aspx.cs" Inherits="TLCYemba.AvantTest" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Avant le test &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{
            --teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
            --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--radius:18px;
        }
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html,body{height:100%}
        body{
            font-family:'Poppins',sans-serif;
            background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
            min-height:100vh;display:flex;align-items:center;
            justify-content:center;padding:24px;
        }

        /* ── Main card ── */
        .card{
            background:rgba(255,255,255,.97);
            border-radius:28px;
            box-shadow:0 12px 60px rgba(58,175,169,.20);
            width:100%;max-width:660px;
            overflow:hidden;
        }

        /* ── Header gradient ── */
        .card-header{
            background:linear-gradient(135deg,var(--teal) 0%,var(--teal-dark) 100%);
            padding:36px 44px 44px;
            text-align:center;
            position:relative;
        }
        /* Curved bottom */
        .card-header::after{
            content:'';position:absolute;
            bottom:-24px;left:0;right:0;height:48px;
            background:rgba(255,255,255,.97);
            border-radius:50% 50% 0 0 / 100% 100% 0 0;
        }
        .header-icon{
            width:76px;height:76px;
            background:rgba(255,255,255,.22);
            border:2px solid rgba(255,255,255,.4);
            border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            margin:0 auto 18px;
        }
        .header-icon i{font-size:34px;color:white}
        .header-title{
            font-family:'Nunito',sans-serif;font-weight:900;font-size:22px;
            color:white;margin-bottom:5px;
        }
        .header-sub{font-size:13px;color:rgba(255,255,255,.78)}

        /* ── Body ── */
        .card-body{padding:44px 44px 36px}

        /* Stats row */
        .stats-row{
            display:grid;grid-template-columns:repeat(3,1fr);
            gap:14px;margin-bottom:28px;
        }
        .stat-box{
            background:var(--teal-pale);
            border:1.5px solid rgba(58,175,169,.22);
            border-radius:var(--radius);
            padding:18px 12px;text-align:center;
            transition:transform .2s;
        }
        .stat-box:hover{transform:translateY(-3px)}
        .stat-box i{font-size:22px;color:var(--teal);margin-bottom:9px;display:block}
        .stat-val{
            font-family:'Nunito',sans-serif;font-weight:900;
            font-size:24px;color:var(--teal-dark);
        }
        .stat-lbl{
            font-size:10.5px;color:var(--txt-soft);font-weight:700;
            text-transform:uppercase;letter-spacing:.5px;margin-top:3px;
        }

        /* Sections chips */
        .chips-label{
            font-size:12.5px;font-weight:700;color:var(--txt-mid);
            margin-bottom:10px;display:flex;align-items:center;gap:6px;
        }
        .chips-label i{color:var(--teal);font-size:12px}
        .chips-wrap{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:26px}
        .chip{
            display:inline-flex;align-items:center;gap:7px;
            padding:8px 18px;border-radius:50px;
            border:1.5px solid rgba(58,175,169,.28);
            background:var(--teal-pale);
            font-size:13px;font-weight:600;color:var(--teal-dark);
        }
        .chip i{font-size:13px;color:var(--teal)}

        /* Instructions */
        .instructions{
            background:#FFFBF0;
            border:1.5px solid rgba(237,137,54,.28);
            border-radius:var(--radius);
            padding:18px 22px;margin-bottom:28px;
        }
        .instr-title{
            display:flex;align-items:center;gap:8px;
            font-size:13px;font-weight:700;color:#C05621;margin-bottom:12px;
        }
        .instr-item{
            display:flex;align-items:flex-start;gap:10px;
            font-size:13px;color:var(--txt-mid);line-height:1.6;margin-bottom:8px;
        }
        .instr-item:last-child{margin-bottom:0}
        .instr-item i{font-size:11px;color:#DD6B20;margin-top:3px;flex-shrink:0}

        /* Buttons row */
        .btn-row{display:flex;gap:12px;justify-content:flex-end;flex-wrap:wrap}
        .btn-back{
            display:inline-flex;align-items:center;gap:7px;
            padding:12px 22px;border-radius:50px;
            background:#F7FAFC;color:var(--txt-mid);
            border:1.5px solid #E2E8F0;font-size:14px;font-weight:600;
            cursor:pointer;font-family:'Poppins',sans-serif;
            transition:all .2s;text-decoration:none;
        }
        .btn-back:hover{background:#EDF2F7;color:var(--txt-dark)}
        .btn-launch{
            display:inline-flex;align-items:center;gap:9px;
            padding:14px 38px;border-radius:50px;
            background:var(--teal);color:white;border:none;
            font-size:15px;font-weight:700;cursor:pointer;
            font-family:'Poppins',sans-serif;
            box-shadow:0 6px 22px rgba(58,175,169,.40);
            transition:all .2s;
        }
        .btn-launch:hover{background:var(--teal-dark);transform:translateY(-2px)}
        .btn-launch i{font-size:14px;transition:transform .2s}
        .btn-launch:hover i{transform:translateX(4px)}

        /* ╔══════════════════════════════╗
           ║   COUNTDOWN OVERLAY          ║
           ╚══════════════════════════════╝ */
        .countdown-overlay{
            display:none;
            position:fixed;inset:0;
            background:rgba(0,0,0,.72);
            backdrop-filter:blur(8px);
            z-index:1000;
            align-items:center;justify-content:center;
            flex-direction:column;gap:20px;
        }
        .countdown-overlay.show{display:flex}

        .countdown-ring{
            position:relative;
            width:180px;height:180px;
        }
        .countdown-ring svg{
            width:180px;height:180px;
            transform:rotate(-90deg);
        }
        .ring-bg{fill:none;stroke:rgba(255,255,255,.15);stroke-width:10}
        .ring-fill{
            fill:none;stroke:var(--teal);stroke-width:10;
            stroke-linecap:round;
            stroke-dasharray:502;
            stroke-dashoffset:0;
            transition:stroke-dashoffset 1s linear;
        }
        .countdown-num{
            position:absolute;inset:0;
            display:flex;flex-direction:column;
            align-items:center;justify-content:center;
        }
        .countdown-digit{
            font-family:'Nunito',sans-serif;font-weight:900;
            font-size:72px;color:white;line-height:1;
            animation:popIn .35s ease;
        }
        @keyframes popIn{
            0%{transform:scale(.5);opacity:0}
            70%{transform:scale(1.15)}
            100%{transform:scale(1);opacity:1}
        }
        .countdown-label{
            font-size:14px;color:rgba(255,255,255,.75);font-weight:600;
            letter-spacing:1px;text-transform:uppercase;margin-top:4px;
        }

        .countdown-title{
            font-family:'Nunito',sans-serif;font-weight:900;
            font-size:22px;color:white;text-align:center;
        }
        .countdown-sub{
            font-size:14px;color:rgba(255,255,255,.7);text-align:center;
        }

        @media(max-width:560px){
            body{padding:12px}
            .card-header{padding:28px 24px 36px}
            .card-body{padding:36px 24px 28px}
            .stats-row{grid-template-columns:1fr 1fr}
            .btn-row{flex-direction:column-reverse}
            .btn-launch,.btn-back{justify-content:center}
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

<div class="card">
    <!-- HEADER -->
    <div class="card-header">
        <div class="header-icon">
            <i class="fa-solid fa-clipboard-list"></i>
        </div>
        <div class="header-title">
            <asp:Literal ID="litTitreTest" runat="server"/>
        </div>
        <div class="header-sub">Lisez bien les instructions avant de commencer</div>
    </div>

    <!-- BODY -->
    <div class="card-body">

        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-box">
                <i class="fa-solid fa-list-ol"></i>
                <div class="stat-val"><asp:Literal ID="litNbQ" runat="server"/></div>
                <div class="stat-lbl">Questions</div>
            </div>
            <div class="stat-box">
                <i class="fa-solid fa-stopwatch"></i>
                <div class="stat-val"><asp:Literal ID="litDuree" runat="server"/></div>
                <div class="stat-lbl">Secondes/Q</div>
            </div>
            <div class="stat-box">
                <i class="fa-solid fa-layer-group"></i>
                <div class="stat-val"><asp:Literal ID="litNbSections" runat="server"/></div>
                <div class="stat-lbl">Section(s)</div>
            </div>
        </div>

        <!-- Sections -->
        <div class="chips-label">
            <i class="fa-solid fa-tags"></i> Sections evaluees
        </div>
        <div class="chips-wrap">
            <asp:Literal ID="litChips" runat="server"/>
        </div>

        <!-- Instructions -->
        <div class="instructions">
            <div class="instr-title">
                <i class="fa-solid fa-triangle-exclamation"></i>
                Instructions importantes
            </div>
            <div class="instr-item">
                <i class="fa-solid fa-circle-dot"></i>
                Chaque question dispose de <strong>20 secondes</strong>. Le chronometre global se lance des le debut.
            </div>
            <div class="instr-item">
                <i class="fa-solid fa-circle-dot"></i>
                Selectionnez une seule reponse parmi A, B, C ou D pour chaque question.
            </div>
            <div class="instr-item">
                <i class="fa-solid fa-circle-dot"></i>
                Pour le Listening, ecoutez avant de repondre. Vous pouvez reecouter l'audio.
            </div>
            <div class="instr-item">
                <i class="fa-solid fa-circle-dot"></i>
                Naviguez librement avec Precedent / Suivant. A la fin du temps, soumission automatique.
            </div>
            <div class="instr-item">
                <i class="fa-solid fa-circle-dot"></i>
                Ne fermez pas l'onglet pendant le test — vos reponses seraient perdues.
            </div>
        </div>

        <!-- Buttons -->
        <div class="btn-row">
            <a href="ChoixTest.aspx" class="btn-back">
                <i class="fa-solid fa-arrow-left"></i> Modifier le choix
            </a>
            <button type="button" class="btn-launch" onclick="lancerCompte()">
                <i class="fa-solid fa-play"></i> Lancer le test
            </button>
            <!-- Bouton hidden pour le postback reel -->
            <asp:Button ID="btnLancer" runat="server"
                style="display:none"
                OnClick="btnLancer_Click"/>
        </div>

    </div>
</div>

<!-- COUNTDOWN OVERLAY -->
<div class="countdown-overlay" id="countdownOverlay">
    <div class="countdown-title">
        <i class="fa-solid fa-flag-checkered" style="margin-right:8px"></i>
        Le test commence dans...
    </div>
    <div class="countdown-ring">
        <svg viewBox="0 0 180 180">
            <circle class="ring-bg" cx="90" cy="90" r="80"/>
            <circle class="ring-fill" id="ringFill" cx="90" cy="90" r="80"/>
        </svg>
        <div class="countdown-num">
            <div class="countdown-digit" id="countdownDigit">3</div>
            <div class="countdown-label">secondes</div>
        </div>
    </div>
    <div class="countdown-sub">Preparez-vous !</div>
</div>

<!-- Son de depart (Web Audio API) -->
</form>

<script>
// ── Sons generes via Web Audio API (pas de fichier externe) ──
var AudioCtx = window.AudioContext || window.webkitAudioContext;

function jouerBip(freq, duree, volume) {
    try {
        var ctx = new AudioCtx();
        var osc = ctx.createOscillator();
        var gain = ctx.createGain();
        osc.connect(gain);
        gain.connect(ctx.destination);
        osc.frequency.value = freq;
        osc.type = 'sine';
        gain.gain.setValueAtTime(volume || 0.4, ctx.currentTime);
        gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + duree);
        osc.start(ctx.currentTime);
        osc.stop(ctx.currentTime + duree);
    } catch(e) {}
}

function jouerSonLancement() {
    // Fanfare rapide : do-mi-sol-do(octave)
    try {
        var ctx = new AudioCtx();
        var notes = [523, 659, 784, 1047];
        notes.forEach(function(freq, i) {
            var osc  = ctx.createOscillator();
            var gain = ctx.createGain();
            osc.connect(gain);
            gain.connect(ctx.destination);
            osc.frequency.value = freq;
            osc.type = 'triangle';
            var t = ctx.currentTime + i * 0.12;
            gain.gain.setValueAtTime(0.35, t);
            gain.gain.exponentialRampToValueAtTime(0.001, t + 0.25);
            osc.start(t);
            osc.stop(t + 0.28);
        });
    } catch(e) {}
}

// ── Countdown 3-2-1 puis lancement ──
function lancerCompte() {
    var overlay = document.getElementById('countdownOverlay');
    var digit   = document.getElementById('countdownDigit');
    var ring    = document.getElementById('ringFill');
    var circ    = 2 * Math.PI * 80; // ~502

    overlay.classList.add('show');

    var count = 3;
    ring.style.strokeDasharray  = circ;
    ring.style.strokeDashoffset = 0;

    function tick() {
        // Afficher le chiffre
        digit.textContent = count;
        // Force reflow pour relancer l'animation CSS
        digit.style.animation = 'none';
        void digit.offsetWidth;
        digit.style.animation = '';

        // Bip
        jouerBip(count === 1 ? 880 : 660, 0.18, 0.3);

        // Arc degressif
        var offset = circ * (1 - count / 3);
        ring.style.strokeDashoffset = offset;

        if (count === 0) {
            jouerSonLancement();
            setTimeout(function() {
                // Soumettre le formulaire via le bouton hidden
                document.getElementById('<%= btnLancer.ClientID %>').click();
            }, 350);
            return;
        }
        count--;
        setTimeout(tick, 1000);
    }
    tick();
}
</script>
</body>
</html>