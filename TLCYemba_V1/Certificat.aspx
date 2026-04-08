<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Certificat.aspx.cs" Inherits="TLCYemba.Certificat" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Certificat &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,700;1,700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        :root{--teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
              --gold:#C9A84C;--gold-light:#F4E4A6;--txt-dark:#2D3748;}
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;
             background:linear-gradient(145deg,#C8EDEA,#EAF8F7,#DEF5F3);
             min-height:100vh;padding:28px 16px;}
        /* ACTION BAR */
        .action-bar{max-width:820px;margin:0 auto 20px;
            display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px}
        .btn-back{display:inline-flex;align-items:center;gap:7px;text-decoration:none;
            background:rgba(255,255,255,.8);color:var(--txt-dark);
            padding:9px 18px;border-radius:50px;font-size:13.5px;font-weight:600;
            border:1.5px solid rgba(58,175,169,.25);transition:all .2s;}
        .btn-back:hover{background:var(--teal-pale)}
        .btn-print{display:inline-flex;align-items:center;gap:7px;
            background:var(--teal);color:#fff;border:none;padding:10px 22px;
            border-radius:50px;font-size:13.5px;font-weight:600;cursor:pointer;
            font-family:'Poppins',sans-serif;transition:all .2s;
            box-shadow:0 4px 14px rgba(58,175,169,.35);}
        .btn-print:hover{background:var(--teal-dark);transform:translateY(-2px)}
        /* CERTIFICATE */
        .cert{max-width:820px;margin:0 auto;background:white;border-radius:4px;
              box-shadow:0 12px 48px rgba(0,0,0,.18);position:relative;overflow:hidden;}
        /* Decorative border frame */
        .cert::before{content:'';position:absolute;inset:12px;
            border:3px solid var(--gold);border-radius:2px;pointer-events:none;z-index:1}
        .cert::after{content:'';position:absolute;inset:18px;
            border:1px solid rgba(201,168,76,.4);border-radius:1px;pointer-events:none;z-index:1}
        /* Corner ornaments */
        .corner{position:absolute;width:52px;height:52px;z-index:2}
        .corner svg{width:100%;height:100%}
        .c-tl{top:8px;left:8px}
        .c-tr{top:8px;right:8px;transform:scaleX(-1)}
        .c-bl{bottom:8px;left:8px;transform:scaleY(-1)}
        .c-br{bottom:8px;right:8px;transform:scale(-1)}
        /* Header banner */
        .cert-header{background:linear-gradient(135deg,var(--teal) 0%,var(--teal-dark) 100%);
            padding:28px 60px 24px;text-align:center;position:relative;}
        .cert-flag-row{display:flex;align-items:center;justify-content:center;gap:20px;margin-bottom:14px}
        .cert-flag{width:44px;height:44px;border-radius:50%;overflow:hidden;
            display:flex;border:3px solid rgba(255,255,255,.6);box-shadow:0 2px 8px rgba(0,0,0,.2)}
        .cert-flag .s1{flex:1;background:#007A5E}
        .cert-flag .s2{flex:1;background:#CE1126;position:relative;
            display:flex;align-items:center;justify-content:center}
        .cert-flag .star{color:#FCD116;font-size:14px;position:absolute}
        .cert-flag .s3{flex:1;background:#FCD116}
        .cert-org{font-family:'Nunito',sans-serif;font-weight:900;font-size:15px;
            color:rgba(255,255,255,.9);letter-spacing:1.5px;text-transform:uppercase}
        .cert-title{font-family:'Playfair Display',serif;font-style:italic;
            font-size:clamp(1.6rem,3.5vw,2.4rem);color:white;
            text-shadow:0 2px 8px rgba(0,0,0,.2);margin-bottom:4px}
        .cert-subtitle{font-size:13px;color:rgba(255,255,255,.78);letter-spacing:.8px}
        /* BODY */
        .cert-body{padding:32px 64px 28px;text-align:center}
        .cert-present{font-size:13.5px;color:#718096;letter-spacing:.5px;
            text-transform:uppercase;margin-bottom:10px}
        .cert-name{font-family:'Playfair Display',serif;font-size:clamp(1.8rem,3.5vw,2.6rem);
            color:var(--teal-dark);border-bottom:2px solid var(--gold);
            padding-bottom:6px;display:inline-block;margin-bottom:18px;min-width:320px}
        .cert-text{font-size:14px;color:var(--txt-dark);line-height:1.8;max-width:540px;margin:0 auto 24px}
        /* Score zone */
        .score-zone{display:flex;justify-content:center;gap:20px;margin-bottom:28px;flex-wrap:wrap}
        .score-box{background:linear-gradient(135deg,var(--teal-pale),white);
            border:2px solid rgba(58,175,169,.25);border-radius:16px;
            padding:16px 24px;min-width:130px;text-align:center;}
        .score-box.main{background:linear-gradient(135deg,var(--teal),var(--teal-dark));
            border-color:var(--teal);}
        .score-box .sb-label{font-size:10.5px;font-weight:700;color:var(--txt-soft);
            text-transform:uppercase;letter-spacing:.5px;margin-bottom:4px}
        .score-box.main .sb-label{color:rgba(255,255,255,.8)}
        .score-box .sb-val{font-family:'Nunito',sans-serif;font-weight:900;
            font-size:26px;color:var(--teal-dark)}
        .score-box.main .sb-val{color:white;font-size:32px}
        .score-box .sb-sub{font-size:11px;color:var(--txt-soft)}
        .score-box.main .sb-sub{color:rgba(255,255,255,.7)}
        /* Niveau badge */
        .niveau-zone{margin-bottom:24px}
        .niveau-cert{display:inline-flex;align-items:center;gap:10px;
            padding:10px 28px;border-radius:50px;border:2px solid;
            font-family:'Nunito',sans-serif;font-weight:900;font-size:16px;}
        /* FOOTER */
        .cert-footer{display:flex;justify-content:space-between;align-items:center;
            padding:16px 64px 28px;border-top:1px solid rgba(201,168,76,.3);flex-wrap:wrap;gap:14px}
        .sig-block{display:flex;flex-direction:column;align-items:center;gap:4px}
        .sig-line{width:140px;height:1.5px;background:var(--txt-dark);margin-bottom:4px}
        .sig-title{font-size:11px;color:var(--txt-soft);font-weight:600;text-transform:uppercase;letter-spacing:.5px}
        .cert-id{font-size:10.5px;color:var(--txt-soft);
            display:flex;flex-direction:column;align-items:center;gap:3px}
        .cert-id .id-num{font-family:'Nunito',sans-serif;font-weight:700;
            color:var(--txt-dark);font-size:12px;letter-spacing:.8px}
        .cert-seal{width:70px;height:70px;border-radius:50%;
            background:linear-gradient(135deg,var(--teal),var(--teal-dark));
            display:flex;align-items:center;justify-content:center;
            border:3px solid white;box-shadow:0 4px 14px rgba(58,175,169,.35);}
        .cert-seal i{font-size:28px;color:white}
        @media print{
            body{background:white;padding:0}
            .action-bar{display:none}
            .cert{box-shadow:none;max-width:100%}
        }
        @media(max-width:600px){
            .cert-body{padding:24px 28px 20px}
            .cert-header{padding:22px 28px 18px}
            .cert-footer{padding:14px 28px 22px}
            .score-zone{gap:12px}
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

  <div class="action-bar">
    <a href="Historique.aspx" class="btn-back">
      <i class="fa-solid fa-arrow-left"></i> Retour a l'historique
    </a>
    <button type="button" class="btn-print" onclick="window.print()">
      <i class="fa-solid fa-print"></i> Imprimer / Exporter PDF
    </button>
  </div>

  <!-- CERTIFICAT -->
  <div class="cert" id="certificat">

    <!-- Corner ornaments SVG -->
    <div class="corner c-tl"><svg viewBox="0 0 52 52"><path d="M4 4 L4 24 L8 24 L8 8 L24 8 L24 4 Z" fill="#C9A84C"/><path d="M4 4 L14 4 L14 6 L6 6 L6 14 L4 14 Z" fill="#C9A84C" opacity=".5"/></svg></div>
    <div class="corner c-tr"><svg viewBox="0 0 52 52"><path d="M4 4 L4 24 L8 24 L8 8 L24 8 L24 4 Z" fill="#C9A84C"/><path d="M4 4 L14 4 L14 6 L6 6 L6 14 L4 14 Z" fill="#C9A84C" opacity=".5"/></svg></div>
    <div class="corner c-bl"><svg viewBox="0 0 52 52"><path d="M4 4 L4 24 L8 24 L8 8 L24 8 L24 4 Z" fill="#C9A84C"/><path d="M4 4 L14 4 L14 6 L6 6 L6 14 L4 14 Z" fill="#C9A84C" opacity=".5"/></svg></div>
    <div class="corner c-br"><svg viewBox="0 0 52 52"><path d="M4 4 L4 24 L8 24 L8 8 L24 8 L24 4 Z" fill="#C9A84C"/><path d="M4 4 L14 4 L14 6 L6 6 L6 14 L4 14 Z" fill="#C9A84C" opacity=".5"/></svg></div>

    <!-- HEADER -->
    <div class="cert-header">
      <div class="cert-flag-row">
        <div class="cert-flag">
          <div class="s1"></div>
          <div class="s2"><span class="star">&#9733;</span></div>
          <div class="s3"></div>
        </div>
        <div class="cert-org">TLC &#8212; Test de Langue du Cameroun</div>
        <div class="cert-flag">
          <div class="s1"></div>
          <div class="s2"><span class="star">&#9733;</span></div>
          <div class="s3"></div>
        </div>
      </div>
      <div class="cert-title">Certificat de Competence</div>
      <div class="cert-subtitle">en Langue Yemba</div>
    </div>

    <!-- BODY -->
    <div class="cert-body">
      <div class="cert-present">Ce certificat est decerne a</div>
      <div class="cert-name"><asp:Literal ID="litNomCandidat" runat="server"/></div>

      <p class="cert-text">
        Pour avoir satisfait aux exigences du
        <strong><asp:Literal ID="litTypeTestCert" runat="server"/></strong>
        de la plateforme TLC Yemba Online Test, en date du
        <strong><asp:Literal ID="litDateCert" runat="server"/></strong>.
      </p>

      <!-- Scores -->
      <div class="score-zone">
        <div class="score-box main">
          <div class="sb-label">Score TLC</div>
          <div class="sb-val"><asp:Literal ID="litScoreCert" runat="server"/></div>
          <div class="sb-sub">sur 677 points</div>
        </div>
        <asp:Panel ID="pnlScoreL" runat="server" CssClass="score-box">
          <div class="sb-label">Listening</div>
          <div class="sb-val"><asp:Literal ID="litScoreLCert" runat="server"/></div>
          <div class="sb-sub">31&#8211;68</div>
        </asp:Panel>
        <asp:Panel ID="pnlScoreS" runat="server" CssClass="score-box">
          <div class="sb-label">Structure</div>
          <div class="sb-val"><asp:Literal ID="litScoreSCert" runat="server"/></div>
          <div class="sb-sub">31&#8211;68</div>
        </asp:Panel>
        <asp:Panel ID="pnlScoreR" runat="server" CssClass="score-box">
          <div class="sb-label">Reading</div>
          <div class="sb-val"><asp:Literal ID="litScoreRCert" runat="server"/></div>
          <div class="sb-sub">31&#8211;67</div>
        </asp:Panel>
      </div>

      <!-- Niveau -->
      <div class="niveau-zone">
        <asp:Panel ID="pnlNiveauCert" runat="server" CssClass="niveau-cert" style="display:inline-flex">
          <i class="fa-solid fa-award"></i>
          Niveau : <asp:Literal ID="litNiveauCert" runat="server"/>
        </asp:Panel>
      </div>
    </div>

    <!-- FOOTER -->
    <div class="cert-footer">
      <div class="sig-block">
        <div class="sig-line"></div>
        <div class="sig-title">Directeur TLC Yemba</div>
      </div>
      <div class="cert-seal"><i class="fa-solid fa-certificate"></i></div>
      <div class="cert-id">
        <div>Identifiant du certificat</div>
        <div class="id-num">TLC-YEM-<asp:Literal ID="litIdCert" runat="server"/></div>
        <div><asp:Literal ID="litDateFooter" runat="server"/></div>
      </div>
    </div>

  </div>

</form>
</body>
</html>
