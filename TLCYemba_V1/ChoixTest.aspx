<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChoixTest.aspx.cs" Inherits="TLCYemba.ChoixTest" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Choix du Test &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --violet:#9C68C3;--violet-pale:#F5F0FA;
              --txt-dark:#2D3748;--txt-mid:#4A5568;--txt-soft:#718096;--radius:18px;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;
             background:linear-gradient(145deg,#C8EDEA 0%,#EAF8F7 40%,#DEF5F3 70%,#B8E8E4 100%);
             min-height:100vh;color:var(--txt-dark);}
        .page-wrap{max-width:1000px;margin:28px auto;background:rgba(255,255,255,.93);
            border-radius:28px;box-shadow:0 8px 48px rgba(58,175,169,.16);overflow:hidden;}
        /* NAVBAR */
        nav{display:flex;align-items:center;justify-content:space-between;
            padding:18px 36px;background:rgba(255,255,255,.98);
            border-bottom:1.5px solid rgba(58,175,169,.10);}
        .nav-left{display:flex;align-items:center;gap:12px}
        .btn-back{display:inline-flex;align-items:center;gap:7px;background:var(--teal-pale);
            color:var(--teal-dark);border:none;padding:9px 18px;border-radius:50px;
            font-size:13px;font-weight:600;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:all .2s;text-decoration:none;}
        .btn-back:hover{background:var(--teal);color:white}
        .nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none}
        .nl-icon{width:36px;height:36px;background:var(--teal);border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:15px;color:#fff}
        .nl-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:17px;color:var(--txt-dark)}
        .nl-text span{color:var(--teal)}
        .nav-user-btn{display:inline-flex;align-items:center;gap:8px;background:var(--teal);
            color:#fff;border:none;padding:9px 20px;border-radius:50px;font-size:13.5px;
            font-weight:600;cursor:pointer;font-family:'Poppins',sans-serif;
            transition:all .2s;box-shadow:0 4px 14px rgba(58,175,169,.35);text-decoration:none}
        .nav-user-btn:hover{background:var(--teal-dark)}
        .user-avatar-sm{width:26px;height:26px;background:rgba(255,255,255,.3);border-radius:50%;
            display:flex;align-items:center;justify-content:center;font-weight:900;font-size:11px}

        /* HEADER */
        .page-header{padding:32px 36px 16px;text-align:center}
        .page-header h1{font-family:'Nunito',sans-serif;font-weight:900;font-size:26px;color:var(--txt-dark);margin-bottom:6px}
        .page-header p{font-size:14px;color:var(--txt-soft)}

        /* GRILLE 5 cartes */
        .cards-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:16px;padding:0 36px 36px}

        .test-card{background:white;border-radius:var(--radius);padding:22px 18px;
            border:2.5px solid transparent;cursor:pointer;transition:all .22s;
            box-shadow:0 2px 16px rgba(0,0,0,.06);position:relative;overflow:hidden;}
        .test-card::before{content:'';position:absolute;top:0;left:0;right:0;height:4px}
        .test-card:hover{transform:translateY(-4px);box-shadow:0 10px 32px rgba(58,175,169,.12)}
        .test-card.selected{border-color:var(--sel-color,var(--teal));box-shadow:0 8px 28px rgba(58,175,169,.18)}
        .card-listening::before{background:linear-gradient(90deg,#3AAFA9,#44C4BE)}
        .card-structure::before{background:linear-gradient(90deg,#48BB78,#68D391)}
        .card-reading::before{background:linear-gradient(90deg,#4299E1,#63B3ED)}
        .card-full::before{background:linear-gradient(90deg,#FCD116,#F6AD55)}
        .card-image::before{background:linear-gradient(90deg,#9C68C3,#C49DE8)}
        .card-icon{width:52px;height:52px;border-radius:14px;
            display:flex;align-items:center;justify-content:center;margin-bottom:12px}
        .card-icon i{font-size:24px}
        .card-listening .card-icon{background:rgba(58,175,169,.12)} .card-listening .card-icon i{color:var(--teal)}
        .card-structure .card-icon{background:rgba(72,187,120,.12)} .card-structure .card-icon i{color:#38A169}
        .card-reading   .card-icon{background:rgba(66,153,225,.12)} .card-reading   .card-icon i{color:#3182CE}
        .card-full      .card-icon{background:rgba(252,209,22,.15)} .card-full      .card-icon i{color:#B7791F}
        .card-image     .card-icon{background:rgba(156,104,195,.12)} .card-image .card-icon i{color:var(--violet)}
        .card-title{font-family:'Nunito',sans-serif;font-weight:900;font-size:15.5px;
            color:var(--txt-dark);margin-bottom:5px}
        .card-desc{font-size:11.5px;color:var(--txt-soft);line-height:1.6;margin-bottom:10px}
        .card-tags{display:flex;gap:5px;flex-wrap:wrap}
        .tag{font-size:10px;font-weight:700;padding:2px 8px;border-radius:50px;
            background:#F7FAFC;border:1px solid #E2E8F0;color:var(--txt-mid)}
        .check-badge{position:absolute;top:14px;right:14px;width:24px;height:24px;
            background:var(--teal);border-radius:50%;display:none;
            align-items:center;justify-content:center;color:white;font-size:11px}
        .card-image .check-badge{background:var(--violet)}
        .test-card.selected .check-badge{display:flex}

        /* ALERTE */
        .alert-wrap{padding:0 36px 8px}
        .alert-err{background:#FFF5F5;border:1.5px solid #FEB2B2;color:#C53030;
            border-radius:10px;padding:10px 16px;font-size:13px;font-weight:500;
            display:flex;align-items:center;gap:8px}

        /* BOUTON */
        .launch-wrap{padding:0 36px 36px}
        .btn-launch{width:100%;padding:14px;border-radius:50px;background:var(--teal);
            color:white;border:none;font-size:15px;font-weight:700;cursor:pointer;
            font-family:'Poppins',sans-serif;box-shadow:0 6px 22px rgba(58,175,169,.38);
            transition:all .2s;display:flex;align-items:center;justify-content:center;gap:9px}
        .btn-launch:hover{background:var(--teal-dark);transform:translateY(-2px)}
        .btn-launch:disabled{opacity:.38;cursor:not-allowed;transform:none}

        @media(max-width:640px){
            .cards-grid{grid-template-columns:1fr 1fr;padding:0 18px 28px}
            .page-wrap{margin:10px;border-radius:20px}
            nav{padding:14px 18px}
            .page-header{padding:22px 18px 12px}
            .launch-wrap,.alert-wrap{padding-left:18px;padding-right:18px}
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="page-wrap">

    <!-- NAVBAR -->
    <nav>
        <div class="nav-left">
            <a href="Default.aspx" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Accueil</a>
            <a href="Default.aspx" class="nav-logo">
                <div class="nl-icon">T</div>
                <span class="nl-text">TLC <span>Yemba</span></span>
            </a>
        </div>
        <asp:Panel ID="pnlConnecte" runat="server" Visible="false">
            <a href="Dashboard.aspx" class="nav-user-btn">
                <div class="user-avatar-sm"><asp:Literal ID="litNavInitiale" runat="server"/></div>
                <asp:Literal ID="litNavNom" runat="server"/>
            </a>
        </asp:Panel>
        <asp:Panel ID="pnlDeconnecte" runat="server" Visible="true">
            <a href="Inscription.aspx" class="nav-user-btn">
                <i class="fa-solid fa-user-plus"></i> S&#39;inscrire
            </a>
        </asp:Panel>
    </nav>

    <!-- HEADER -->
    <div class="page-header">
        <h1>Choisissez votre test</h1>
        <p>5 types d\'evaluation disponibles &#8212; choisissez selon votre objectif</p>
    </div>

    <!-- ERREUR -->
    <asp:Panel ID="pnlErreur" runat="server" Visible="false">
        <div class="alert-wrap">
            <div class="alert-err">
                <i class="fa-solid fa-circle-exclamation"></i>
                <asp:Literal ID="litErreur" runat="server"/>
            </div>
        </div>
    </asp:Panel>

    <!-- CARTES -->
    <div class="cards-grid">

        <!-- LISTENING -->
        <label class="test-card card-listening" id="cardListening">
            <input type="radio" name="typeTest" value="Listening" style="display:none" onchange="selectCard(this)"/>
            <div class="check-badge"><i class="fa-solid fa-check"></i></div>
            <div class="card-icon"><i class="fa-solid fa-headphones"></i></div>
            <div class="card-title">Listening</div>
            <div class="card-desc">Comprehension orale en langue Yemba</div>
            <div class="card-tags">
                <span class="tag">50 Q</span><span class="tag">30 min</span>
            </div>
        </label>

        <!-- STRUCTURE -->
        <label class="test-card card-structure" id="cardStructure">
            <input type="radio" name="typeTest" value="Structure" style="display:none" onchange="selectCard(this)"/>
            <div class="check-badge"><i class="fa-solid fa-check"></i></div>
            <div class="card-icon"><i class="fa-solid fa-pen-nib"></i></div>
            <div class="card-title">Structure</div>
            <div class="card-desc">Grammaire et syntaxe Yemba</div>
            <div class="card-tags">
                <span class="tag">40 Q</span><span class="tag">25 min</span>
            </div>
        </label>

        <!-- READING -->
        <label class="test-card card-reading" id="cardReading">
            <input type="radio" name="typeTest" value="Reading" style="display:none" onchange="selectCard(this)"/>
            <div class="check-badge"><i class="fa-solid fa-check"></i></div>
            <div class="card-icon"><i class="fa-solid fa-book-open"></i></div>
            <div class="card-title">Reading</div>
            <div class="card-desc">Comprehension ecrite avec textes</div>
            <div class="card-tags">
                <span class="tag">50 Q</span><span class="tag">55 min</span><span class="tag">Texte</span>
            </div>
        </label>

        <!-- IMAGE DESCRIPTION -->
        <label class="test-card card-image" id="cardImageDescription">
            <input type="radio" name="typeTest" value="ImageDescription" style="display:none" onchange="selectCard(this)"/>
            <div class="check-badge"><i class="fa-solid fa-check"></i></div>
            <div class="card-icon"><i class="fa-solid fa-image"></i></div>
            <div class="card-title">Description d'images</div>
            <div class="card-desc">Vocabulaire via images de culture Yemba</div>
            <div class="card-tags">
                <span class="tag">20 Q</span><span class="tag">40 min</span><span class="tag" style="background:#F5F0FA;border-color:#D4B8EA;color:var(--violet)">Images</span>
            </div>
        </label>

        <!-- FULL TEST -->
        <label class="test-card card-full" id="cardFull">
            <input type="radio" name="typeTest" value="FullTest" style="display:none" onchange="selectCard(this)"/>
            <div class="check-badge"><i class="fa-solid fa-check"></i></div>
            <div class="card-icon"><i class="fa-solid fa-trophy"></i></div>
            <div class="card-title">Test Complet TLC</div>
            <div class="card-desc">Listening + Structure + Reading</div>
            <div class="card-tags">
                <span class="tag">140 Q</span><span class="tag">115 min</span><span class="tag">Certif.</span>
            </div>
        </label>

    </div>

    <asp:HiddenField ID="hfTypeTest" runat="server"/>

    <!-- BOUTON -->
    <div class="launch-wrap">
        <asp:Button ID="btnCommencer" runat="server" Text="Commencer le test"
            CssClass="btn-launch" OnClick="btnCommencer_Click"
            OnClientClick="return preparer();"/>
    </div>

</div>
</form>
<script>
function selectCard(radio) {
    document.querySelectorAll('.test-card').forEach(function(c) { c.classList.remove('selected'); });
    var card = radio.closest('.test-card');
    if (card) card.classList.add('selected');
}

function preparer() {
    var sel = document.querySelector('input[name=typeTest]:checked');
    if (!sel) { alert('Veuillez selectionner un type de test.'); return false; }
    document.getElementById('<%= hfTypeTest.ClientID %>').value = sel.value;
    return true;
}

/* Pre-selection depuis ?section=X */
(function(){
    var qs  = new URLSearchParams(window.location.search);
    var sec = qs.get('section');
    var map = {
        'Listening':'Listening','Structure':'Structure','Reading':'Reading',
        'FullTest':'FullTest','Full':'FullTest','ImageDescription':'ImageDescription','Image':'ImageDescription'
    };
    if (!sec) return;
    var val = map[sec] || sec;
    var radio = document.querySelector('input[name=typeTest][value="' + val + '"]');
    if (!radio) return;
    radio.checked = true;
    selectCard(radio);
    setTimeout(function() {
        var card = radio.closest('.test-card');
        if (card) card.scrollIntoView({ behavior:'smooth', block:'center' });
    }, 120);
})();
</script>
</body>
</html>