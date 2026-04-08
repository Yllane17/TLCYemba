
/**
 * timer.js — Chronometre 20 secondes par question — TLC Yemba
 *
 * Usage depuis Test.aspx.cs (inject via RegisterStartupScript) :
 *   startQuestionTimer(20, 'timerDisplay', 'timerBox', onExpireCallback);
 *
 * Le timer se reinitialie a chaque changement de question (postback).
 * A l'expiration, passe automatiquement a la question suivante.
 */

var _qTimer = null;  // Reference au setInterval courant

/**
 * Demarre (ou redemarre) le chrono de 20s pour la question courante.
 * @param {number}   secondes     Duree en secondes (20 par question)
 * @param {string}   displayId    ID du <span> qui affiche MM:SS
 * @param {string}   boxId        ID du conteneur (pour la classe .danger)
 * @param {Function} onExpire     Callback appele quand le temps expire
 */
function startQuestionTimer(secondes, displayId, boxId, onExpire) {
    // Annuler tout timer precedent
    if (_qTimer) {
        clearInterval(_qTimer);
        _qTimer = null;
    }

    var remaining = parseInt(secondes, 10);
    var display   = document.getElementById(displayId);
    var box       = document.getElementById(boxId);

    if (!display || !box) {
        console.warn('[timer.js] Elements introuvables :', displayId, boxId);
        return;
    }

    /* Affichage immediat */
    updateTimerDisplay(remaining, display, box);

    /* Tick chaque seconde */
    _qTimer = setInterval(function () {
        remaining--;

        if (remaining < 0) {
            clearInterval(_qTimer);
            _qTimer = null;
            /* Sonnette d'alarme via Web Audio API */
            jouerSonExpire();
            if (typeof onExpire === 'function') onExpire();
            return;
        }

        updateTimerDisplay(remaining, display, box);
    }, 1000);
}

/** Met a jour l'affichage et bascule en mode danger si <= 5s */
function updateTimerDisplay(remaining, display, box) {
    var m = Math.floor(remaining / 60);
    var s = remaining % 60;
    display.textContent =
        (m < 10 ? '0' : '') + m + ':' +
        (s < 10 ? '0' : '') + s;

    if (remaining <= 5) {
        box.classList.add('danger');
        /* Bip d'urgence a chaque seconde sous 5s */
        jouerBip(880, 0.12);
    } else {
        box.classList.remove('danger');
    }
}

/* ── Sons Web Audio API ─────────────────────────────────────── */
function jouerBip(freq, duree) {
    try {
        var ctx  = new (window.AudioContext || window.webkitAudioContext)();
        var osc  = ctx.createOscillator();
        var gain = ctx.createGain();
        osc.connect(gain);
        gain.connect(ctx.destination);
        osc.frequency.value = freq;
        osc.type = 'sine';
        gain.gain.setValueAtTime(0.25, ctx.currentTime);
        gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + duree);
        osc.start(ctx.currentTime);
        osc.stop(ctx.currentTime + duree);
    } catch (e) {}
}

function jouerSonExpire() {
    /* Trois bips descendants : do-si-la */
    try {
        var ctx   = new (window.AudioContext || window.webkitAudioContext)();
        var notes = [523, 466, 392];
        notes.forEach(function (freq, i) {
            var osc  = ctx.createOscillator();
            var gain = ctx.createGain();
            osc.connect(gain);
            gain.connect(ctx.destination);
            osc.frequency.value = freq;
            osc.type = 'triangle';
            var t = ctx.currentTime + i * 0.18;
            gain.gain.setValueAtTime(0.3, t);
            gain.gain.exponentialRampToValueAtTime(0.001, t + 0.22);
            osc.start(t);
            osc.stop(t + 0.25);
        });
    } catch (e) {}
}
