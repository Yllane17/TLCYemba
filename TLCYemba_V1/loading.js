
/**
 * loading.js — Splash screen TLC Yemba (version améliorée)
 * Injecter dans Default.aspx via <script src="loading.js"></script>
 * dans le <head> AVANT tout autre script.
 */
(function () {
    'use strict';

    /* ── Injection immédiate du splash avant rendu DOM ── */
    var style = document.createElement('style');
    style.textContent = `
        #tlc-splash{
            position:fixed;inset:0;z-index:99999;
            background:linear-gradient(145deg,#1A6F6A 0%,#2B8F8A 35%,#3AAFA9 65%,#44C4BE 100%);
            display:flex;align-items:center;justify-content:center;
            flex-direction:column;
            transition:opacity .7s ease, visibility .7s ease;
        }
        #tlc-splash.fade{opacity:0;visibility:hidden;}

        /* Particules flottantes */
        .sp-particle{
            position:absolute;border-radius:50%;
            background:rgba(255,255,255,.12);
            animation:sp-float linear infinite;
        }
        @keyframes sp-float{
            0%  {transform:translateY(100vh) scale(0)}
            10% {opacity:1}
            90% {opacity:.3}
            100%{transform:translateY(-20px) scale(1);opacity:0}
        }

        /* Boîte centrale */
        .sp-center{
            display:flex;flex-direction:column;align-items:center;gap:18px;
            position:relative;z-index:2;
        }

        /* Logo pill */
        .sp-logo-pill{
            display:flex;align-items:center;gap:12px;
            background:rgba(255,255,255,.15);
            backdrop-filter:blur(10px);
            border:1.5px solid rgba(255,255,255,.3);
            border-radius:50px;padding:10px 24px;
            animation:sp-appear .5s ease both;
        }
        .sp-logo-circle{
            width:40px;height:40px;border-radius:50%;
            background:white;
            display:flex;align-items:center;justify-content:center;
        }
        .sp-logo-circle svg{width:24px;height:24px}
        .sp-logo-name{
            font-family:Nunito,sans-serif;font-weight:900;font-size:20px;color:white;
            letter-spacing:-.5px;
        }
        .sp-logo-name span{color:#FCD116}

        /* Titre */
        .sp-title{
            font-family:Nunito,sans-serif;font-weight:900;
            font-size:clamp(1.1rem,4vw,1.5rem);
            color:rgba(255,255,255,.85);text-align:center;
            animation:sp-appear .5s .15s ease both;
            letter-spacing:.2px;
        }

        /* Anneau SVG + pourcentage */
        .sp-ring-wrap{
            position:relative;width:100px;height:100px;
            animation:sp-appear .5s .25s ease both;
        }
        .sp-ring-wrap svg{position:absolute;inset:0;width:100%;height:100%}
        .sp-ring-bg{fill:none;stroke:rgba(255,255,255,.15);stroke-width:7}
        .sp-ring-fill{
            fill:none;stroke:white;stroke-width:7;stroke-linecap:round;
            stroke-dasharray:283;stroke-dashoffset:283;
            transform:rotate(-90deg);transform-origin:50% 50%;
            transition:stroke-dashoffset .08s linear;
        }
        .sp-pct{
            position:absolute;inset:0;
            display:flex;flex-direction:column;
            align-items:center;justify-content:center;
        }
        .sp-pct-num{
            font-family:Nunito,sans-serif;font-weight:900;font-size:20px;color:white;
            line-height:1;
        }
        .sp-pct-lbl{font-size:9px;color:rgba(255,255,255,.6);letter-spacing:.5px}

        /* Barre fine */
        .sp-bar-wrap{
            width:min(280px,70vw);height:3px;
            background:rgba(255,255,255,.2);border-radius:50px;overflow:hidden;
            animation:sp-appear .5s .3s ease both;
        }
        .sp-bar{height:100%;width:0%;background:white;border-radius:50px;
                transition:width .05s linear;}

        /* Slogan */
        .sp-slogan{
            font-size:12px;color:rgba(255,255,255,.6);
            letter-spacing:1.5px;text-transform:uppercase;
            animation:sp-appear .5s .35s ease both;
        }

        /* Cameroun flags dots */
        .sp-flag{
            display:flex;gap:6px;align-items:center;
            animation:sp-appear .5s .4s ease both;
        }
        .sp-flag-dot{
            width:10px;height:10px;border-radius:50%;
        }

        @keyframes sp-appear{
            from{opacity:0;transform:translateY(16px)}
            to{opacity:1;transform:translateY(0)}
        }

        /* Empêche le scroll pendant le splash */
        body.sp-active{overflow:hidden}
    `;
    document.head.appendChild(style);
    document.body.classList.add('sp-active');

    /* ── Particules de fond ── */
    var overlay = document.createElement('div');
    overlay.id  = 'tlc-splash';

    var sizes = [60,40,80,50,35,70,45,55,30,65];
    var positions = [[5,10],[15,80],[85,15],[90,75],[50,5],[25,90],[70,50],[40,30],[60,85],[10,55]];
    var durations = [8,11,9,13,10,12,7,14,9,11];
    var particles = '';
    sizes.forEach(function(s,i){
        var pos = positions[i];
        particles += '<div class="sp-particle" style="' +
            'width:'+s+'px;height:'+s+'px;' +
            'left:'+pos[0]+'%;top:'+pos[1]+'%;' +
            'animation-duration:'+durations[i]+'s;' +
            'animation-delay:'+(i*0.6)+'s' +
        '"></div>';
    });

    /* ── Drapeau Cameroun SVG miniature ── */
    var flagDots = [
        '<div class="sp-flag-dot" style="background:#007A5E"></div>',
        '<div class="sp-flag-dot" style="background:#CE1126"></div>',
        '<div class="sp-flag-dot" style="background:#FCD116"></div>',
    ].join('');

    /* ── Logo TLC Yemba SVG ── */
    var logoSvg = '<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">' +
        '<circle cx="12" cy="12" r="11" fill="#3AAFA9"/>' +
        '<text x="12" y="16" text-anchor="middle" font-family="Nunito,sans-serif" font-weight="900" font-size="10" fill="white">T</text>' +
        '</svg>';

    overlay.innerHTML = particles +
        '<div class="sp-center">' +
            '<div class="sp-logo-pill">' +
                '<div class="sp-logo-circle">' + logoSvg + '</div>' +
                '<div class="sp-logo-name">TLC <span>Yemba</span></div>' +
            '</div>' +
            '<div class="sp-title">Test de Langue du Cameroun</div>' +
            '<div class="sp-ring-wrap">' +
                '<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">' +
                    '<circle class="sp-ring-bg" cx="50" cy="50" r="45"/>' +
                    '<circle class="sp-ring-fill" id="sp-ring" cx="50" cy="50" r="45"/>' +
                '</svg>' +
                '<div class="sp-pct">' +
                    '<div class="sp-pct-num" id="sp-pct">0</div>' +
                    '<div class="sp-pct-lbl">%</div>' +
                '</div>' +
            '</div>' +
            '<div class="sp-bar-wrap"><div class="sp-bar" id="sp-bar"></div></div>' +
            '<div class="sp-slogan">Certifiez votre niveau Yemba</div>' +
            '<div class="sp-flag">' + flagDots + '</div>' +
        '</div>';

    document.body.insertBefore(overlay, document.body.firstChild);

    /* ── Animation de progression ── */
    var pct    = 0;
    var circ   = 2 * Math.PI * 45; // ~283
    var ring   = null;
    var pctEl  = null;
    var barEl  = null;

    function init() {
        ring  = document.getElementById('sp-ring');
        pctEl = document.getElementById('sp-pct');
        barEl = document.getElementById('sp-bar');
    }

    function step() {
        if (!ring) init();

        /* Progression non-linéaire : rapide au début, ralentit à la fin */
        var jump = pct < 60 ? (Math.random() * 10 + 4) :
                   pct < 85 ? (Math.random() * 5  + 2) :
                               (Math.random() * 2  + 1);
        pct = Math.min(pct + jump, 100);

        var offset = circ * (1 - pct / 100);
        if (ring)   { ring.style.strokeDashoffset = offset; }
        if (pctEl)  { pctEl.textContent = Math.round(pct); }
        if (barEl)  { barEl.style.width = pct + '%'; }

        if (pct < 100) {
            setTimeout(step, pct < 70 ? 60 : 100);
        } else {
            setTimeout(hideSplash, 350);
        }
    }

    function hideSplash() {
        overlay.classList.add('fade');
        document.body.classList.remove('sp-active');
        setTimeout(function () {
            if (overlay.parentNode) overlay.parentNode.removeChild(overlay);
        }, 750);
    }

    /* Démarrer après micro-délai */
    setTimeout(step, 80);

})();
