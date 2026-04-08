<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OAuthCallback.aspx.cs" Inherits="TLCYemba.OAuthCallback" %>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"/>
<style>
body{font-family:'Poppins',sans-serif;background:linear-gradient(145deg,#C8EDEA,#EAF8F7);
     min-height:100vh;display:flex;align-items:center;justify-content:center;}
.box{text-align:center;background:white;border-radius:20px;padding:48px 40px;
     box-shadow:0 8px 40px rgba(58,175,169,.15);}
.spinner{width:52px;height:52px;border:5px solid #EAF8F7;border-top-color:#3AAFA9;
         border-radius:50%;animation:spin 1s linear infinite;margin:0 auto 20px;}
@keyframes spin{to{transform:rotate(360deg)}}
p{color:#718096;font-size:14px}
</style>
</head>
<body>
<form id="form1" runat="server">
<div class="box">
  <div class="spinner"></div>
  <asp:Literal ID="litMessage" runat="server"/>
</div>
</form>
</body></html>
