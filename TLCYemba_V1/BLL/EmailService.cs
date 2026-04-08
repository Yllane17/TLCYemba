using System;
using System.Net;
using System.Net.Mail;
using System.Configuration;

namespace TLCYemba.BLL
{
    /// <summary>
    /// Service BLL — Envoi d'emails (code de reset, confirmations).
    /// Config SMTP dans Web.config (AppSettings).
    /// </summary>
    public class EmailService
    {
        private string SmtpHost   => ConfigurationManager.AppSettings["Smtp_Host"]     ?? "smtp.gmail.com";
        private int    SmtpPort   => int.Parse(ConfigurationManager.AppSettings["Smtp_Port"] ?? "587");
        private string SmtpUser   => ConfigurationManager.AppSettings["Smtp_User"]     ?? "";
        private string SmtpPass   => ConfigurationManager.AppSettings["Smtp_Password"] ?? "";
        private string SmtpSender => ConfigurationManager.AppSettings["Smtp_Sender"]   ?? "noreply@tlcyemba.cm";

        // ── Envoi du code de reset ──────────────────────────────────────
        public bool EnvoyerCodeReset(string emailDestinataire, string code)
        {
            string subject = "TLC Yemba - Code de reinitialisation de mot de passe";
            string body    = BuildResetEmailBody(code);
            return Envoyer(emailDestinataire, subject, body);
        }

        // ── Envoi generique ─────────────────────────────────────────────
        public bool Envoyer(string to, string subject, string htmlBody)
        {
            try
            {
                using (var client = new SmtpClient(SmtpHost, SmtpPort))
                {
                    client.EnableSsl             = true;
                    client.DeliveryMethod        = SmtpDeliveryMethod.Network;
                    client.UseDefaultCredentials = false;
                    client.Credentials           = new NetworkCredential(SmtpUser, SmtpPass);

                    var msg = new MailMessage
                    {
                        From       = new MailAddress(SmtpSender, "TLC Yemba"),
                        Subject    = subject,
                        Body       = htmlBody,
                        IsBodyHtml = true
                    };
                    msg.To.Add(to);
                    client.Send(msg);
                    return true;
                }
            }
            catch
            {
                // En dev : logger l'erreur. En prod : monitorer.
                return false;
            }
        }

        // ── Template HTML du code reset ─────────────────────────────────
        private static string BuildResetEmailBody(string code)
        {
            return string.Format(@"
<!DOCTYPE html>
<html lang='fr'>
<head><meta charset='UTF-8'/><meta name='viewport' content='width=device-width,initial-scale=1'/></head>
<body style='margin:0;padding:0;background:#EAF8F7;font-family:Poppins,Arial,sans-serif'>
  <table width='100%' cellpadding='0' cellspacing='0'>
    <tr><td align='center' style='padding:40px 16px'>
      <table width='520' cellpadding='0' cellspacing='0'
             style='background:white;border-radius:16px;overflow:hidden;
                    box-shadow:0 4px 24px rgba(58,175,169,.15)'>
        <!-- Header -->
        <tr><td style='background:linear-gradient(135deg,#3AAFA9,#2B8F8A);
                        padding:28px 40px;text-align:center'>
          <div style='font-size:24px;font-weight:900;color:white;
                      font-family:Nunito,Arial,sans-serif'>TLC Yemba</div>
          <div style='font-size:13px;color:rgba(255,255,255,.8);margin-top:4px'>
            Test de Langue du Cameroun
          </div>
        </td></tr>
        <!-- Body -->
        <tr><td style='padding:36px 40px;text-align:center'>
          <div style='font-size:16px;font-weight:600;color:#2D3748;margin-bottom:8px'>
            Reinitialisation de mot de passe
          </div>
          <div style='font-size:14px;color:#718096;line-height:1.7;margin-bottom:28px'>
            Vous avez demande a reinitialiser votre mot de passe TLC Yemba.<br/>
            Voici votre code de verification :
          </div>
          <!-- Code -->
          <div style='display:inline-block;background:#EAF8F7;border:2px solid #3AAFA9;
                      border-radius:12px;padding:18px 40px;margin-bottom:24px'>
            <div style='font-family:Courier New,monospace;font-size:42px;font-weight:900;
                        letter-spacing:12px;color:#2B8F8A'>{0}</div>
          </div>
          <div style='font-size:13px;color:#A0AEC0;margin-bottom:28px'>
            Ce code est valable pendant <strong>15 minutes</strong>.<br/>
            Si vous n'avez pas fait cette demande, ignorez cet email.
          </div>
          <div style='background:#FFFBF0;border:1.5px solid rgba(237,137,54,.3);
                      border-radius:10px;padding:12px 20px;font-size:12.5px;color:#744210'>
            &#9888; Ne partagez jamais ce code avec quiconque.
          </div>
        </td></tr>
        <!-- Footer -->
        <tr><td style='background:#F7FAFC;padding:18px 40px;text-align:center;
                        border-top:1px solid #EDF2F7;font-size:11.5px;color:#A0AEC0'>
          TLC Yemba Online Test &mdash; Plateforme de certification en langue Yemba du Cameroun
        </td></tr>
      </table>
    </td></tr>
  </table>
</body>
</html>", code);
        }
    }
}
