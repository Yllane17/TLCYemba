<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="TLCYemba.AdminLogin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Admin Login &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        body{font-family:'Poppins',sans-serif;background:#1A3A35;
             min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px}
        .card{background:white;border-radius:22px;padding:40px;width:100%;max-width:380px;
              box-shadow:0 20px 60px rgba(0,0,0,.4)}
        .logo{display:flex;align-items:center;gap:10px;margin-bottom:28px;justify-content:center}
        .logo-icon{width:48px;height:48px;background:#3AAFA9;border-radius:50%;
                   display:flex;align-items:center;justify-content:center;
                   font-family:'Nunito',sans-serif;font-weight:900;font-size:20px;color:white}
        .logo-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:20px;color:#2D3748}
        .logo-text span{color:#3AAFA9}
        .title{font-family:'Nunito',sans-serif;font-weight:900;font-size:18px;
               color:#2D3748;margin-bottom:4px;text-align:center}
        .sub{font-size:12px;color:#718096;text-align:center;margin-bottom:22px}
        .badge-admin{display:inline-flex;align-items:center;gap:6px;
                     background:#1A3A35;color:white;padding:5px 14px;border-radius:50px;
                     font-size:11px;font-weight:700;margin:0 auto 22px;display:flex;width:fit-content}
        .alert{padding:9px 14px;border-radius:9px;font-size:12.5px;background:#FFF5F5;
               border:1.5px solid #FEB2B2;color:#C53030;margin-bottom:14px;
               display:flex;align-items:center;gap:7px}
        .field{margin-bottom:14px;position:relative}
        .field label{display:block;font-size:11px;font-weight:700;color:#4A5568;
                     margin-bottom:4px;text-transform:uppercase;letter-spacing:.4px}
        .field input{width:100%;padding:11px 14px 11px 38px;border-radius:10px;
                     border:1.5px solid #E2E8F0;font-size:13.5px;font-family:'Poppins',sans-serif;
                     outline:none;transition:border-color .2s,box-shadow .2s}
        .field input:focus{border-color:#3AAFA9;box-shadow:0 0 0 3px rgba(58,175,169,.12)}
        .field-icon{position:absolute;left:12px;top:34px;font-size:13px;color:#A0AEC0}
        .btn-submit{width:100%;padding:13px;border-radius:50px;background:#1A3A35;
                    color:white;border:none;font-size:14.5px;font-weight:700;cursor:pointer;
                    font-family:'Poppins',sans-serif;transition:all .2s;margin-top:4px}
        .btn-submit:hover{background:#3AAFA9;transform:translateY(-1px)}
        .back-link{text-align:center;margin-top:16px;font-size:12px;color:#718096}
        .back-link a{color:#3AAFA9;font-weight:600;text-decoration:none}
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="card">
    <div class="logo">
        <div class="logo-icon">T</div>
        <span class="logo-text">TLC <span>Yemba</span></span>
    </div>
    <div class="badge-admin"><i class="fa-solid fa-lock"></i> Acces Administrateur</div>
    <div class="title">Connexion Admin</div>
    <div class="sub">Acces reserve a l'administrateur TLC Yemba</div>

    <asp:Panel ID="pnlErreur" runat="server" Visible="false">
        <div class="alert">
            <i class="fa-solid fa-circle-exclamation"></i>
            <asp:Literal ID="litErreur" runat="server"/>
        </div>
    </asp:Panel>

    <div class="field">
        <label>Email administrateur</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="yougo@gmail.com"/>
        <i class="fa-solid fa-envelope field-icon"></i>
    </div>
    <div class="field">
        <label>Mot de passe</label>
        <asp:TextBox ID="txtMdp" runat="server" TextMode="Password" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;"/>
        <i class="fa-solid fa-lock field-icon"></i>
    </div>

    <asp:Button ID="btnConnecter" runat="server" Text="Acceder au tableau de bord"
        CssClass="btn-submit" OnClick="btnConnecter_Click"/>

    <div class="back-link"><a href="Default.aspx"><i class="fa-solid fa-arrow-left" style="margin-right:4px"></i>Retour au site</a></div>
</div>
</form>
</body>
</html>
