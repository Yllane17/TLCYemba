<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="TLCYemba.AdminDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>Admin &#8212; TLC Yemba</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
    <style>
        :root{
            --sidebar:#1A3A35;--sidebar-hover:#243E38;--sidebar-active:#3AAFA9;
            --teal:#3AAFA9;--teal-dark:#2B8F8A;--teal-pale:#EAF8F7;
            --txt-dark:#1A2B2A;--txt-mid:#4A5568;--txt-soft:#718096;
            --bg:#F4F7F6;--white:#FFFFFF;--radius:14px;
            --gold:#F59E0B;--red:#EF4444;--green:#10B981;
        }
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html,body{height:100%;overflow:hidden}
        body{font-family:'Poppins',sans-serif;background:var(--bg);display:flex;}

        /* ══ SIDEBAR ══ */
        .sidebar{
            width:230px;min-height:100vh;background:var(--sidebar);
            display:flex;flex-direction:column;flex-shrink:0;
            box-shadow:4px 0 20px rgba(0,0,0,.18);position:relative;z-index:10;
        }
        .sb-logo{padding:24px 20px 20px;display:flex;align-items:center;gap:10px;
                 border-bottom:1px solid rgba(255,255,255,.08);}
        .sb-logo-icon{width:38px;height:38px;background:var(--teal);border-radius:50%;
                      display:flex;align-items:center;justify-content:center;
                      font-family:'Nunito',sans-serif;font-weight:900;font-size:16px;color:white;}
        .sb-logo-text{font-family:'Nunito',sans-serif;font-weight:900;font-size:16px;color:white}
        .sb-logo-text span{color:#FCD116}

        .sb-section{padding:16px 14px 8px;font-size:10px;font-weight:700;
                    color:rgba(255,255,255,.38);text-transform:uppercase;letter-spacing:.8px}
        .sb-item{display:flex;align-items:center;gap:11px;padding:11px 16px;
                 border-radius:10px;margin:2px 10px;cursor:pointer;
                 text-decoration:none;font-size:13.5px;font-weight:500;
                 color:rgba(255,255,255,.65);transition:all .2s;}
        .sb-item i{font-size:15px;width:20px;text-align:center;flex-shrink:0}
        .sb-item:hover{background:var(--sidebar-hover);color:white}
        .sb-item.active{background:var(--teal);color:white;
                        box-shadow:0 4px 12px rgba(58,175,169,.35);}
        .sb-badge{margin-left:auto;background:var(--gold);color:white;
                  font-size:10px;font-weight:700;padding:2px 7px;border-radius:50px}

        .sb-profile{margin-top:auto;padding:16px;border-top:1px solid rgba(255,255,255,.08);
                    display:flex;align-items:center;gap:10px;}
        .sb-avatar{width:40px;height:40px;border-radius:50%;background:var(--teal);
                   display:flex;align-items:center;justify-content:center;
                   font-family:'Nunito',sans-serif;font-weight:900;font-size:15px;color:white;flex-shrink:0}
        .sb-profile-info{display:flex;flex-direction:column;gap:1px;min-width:0}
        .sb-profile-name{font-size:12.5px;font-weight:700;color:white;
                         white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
        .sb-profile-role{font-size:10.5px;color:rgba(255,255,255,.45)}
        .sb-logout{margin-left:auto;background:none;border:none;cursor:pointer;
                   color:rgba(255,255,255,.4);font-size:14px;transition:color .2s;}
        .sb-logout:hover{color:#EF4444}

        /* ══ MAIN CONTENT ══ */
        .main{flex:1;display:flex;flex-direction:column;overflow:hidden}

        /* Top bar */
        .topbar{background:white;padding:14px 28px;
                display:flex;align-items:center;gap:16px;
                box-shadow:0 2px 12px rgba(0,0,0,.06);z-index:5}
        .topbar-breadcrumb{display:flex;align-items:center;gap:8px;font-size:13px}
        .topbar-breadcrumb .bc-sep{color:var(--txt-soft)}
        .topbar-breadcrumb .bc-current{font-weight:700;color:var(--txt-dark)}
        .topbar-breadcrumb .bc-prev{color:var(--txt-soft);cursor:pointer}
        .topbar-breadcrumb .bc-prev:hover{color:var(--teal)}
        .tb-spacer{flex:1}
        /* Filter tabs */
        .filter-tabs{display:flex;gap:4px;background:#F4F7F6;border-radius:8px;padding:3px}
        .ft-btn{padding:5px 14px;border-radius:6px;border:none;background:transparent;
                font-size:12px;font-weight:600;color:var(--txt-soft);cursor:pointer;
                font-family:'Poppins',sans-serif;transition:all .2s;}
        .ft-btn.active{background:white;color:var(--teal);
                       box-shadow:0 1px 6px rgba(0,0,0,.08);}
        /* Search */
        .search-wrap{position:relative}
        .search-wrap i{position:absolute;left:10px;top:50%;transform:translateY(-50%);
                       font-size:12px;color:var(--txt-soft)}
        .search-wrap input{padding:7px 12px 7px 32px;border:1.5px solid #E2E8F0;
                           border-radius:8px;font-size:13px;font-family:'Poppins',sans-serif;
                           outline:none;width:200px;transition:border-color .2s;}
        .search-wrap input:focus{border-color:var(--teal)}

        /* Scrollable content */
        .content{flex:1;overflow-y:auto;padding:24px 28px;display:flex;flex-direction:column;gap:20px}

        /* ══ STAT CARDS ROW ══ */
        .stat-cards{display:grid;grid-template-columns:repeat(4,1fr);gap:14px}
        .sc{background:white;border-radius:var(--radius);padding:20px;
            box-shadow:0 2px 12px rgba(0,0,0,.05);display:flex;flex-direction:column;gap:10px;
            transition:transform .2s,box-shadow .2s;}
        .sc:hover{transform:translateY(-3px);box-shadow:0 6px 24px rgba(0,0,0,.09)}
        .sc-header{display:flex;align-items:center;justify-content:space-between}
        .sc-title{font-size:12px;font-weight:600;color:var(--txt-soft);
                  text-transform:uppercase;letter-spacing:.5px}
        .sc-icon{width:36px;height:36px;border-radius:10px;
                 display:flex;align-items:center;justify-content:center;}
        .sc-icon i{font-size:16px}
        .sc-val{font-family:'Nunito',sans-serif;font-weight:900;font-size:28px;color:var(--txt-dark)}
        .sc-trend{display:flex;align-items:center;gap:5px;font-size:11.5px;font-weight:600}
        .sc-trend.up{color:var(--green)} .sc-trend.down{color:var(--red)}
        .sc-trend i{font-size:10px}

        /* ══ CHARTS ROW ══ */
        .charts-row{display:grid;grid-template-columns:2fr 1fr 1fr;gap:14px}
        .chart-card{background:white;border-radius:var(--radius);padding:20px;
                    box-shadow:0 2px 12px rgba(0,0,0,.05);}
        .chart-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px}
        .chart-title{font-family:'Nunito',sans-serif;font-weight:800;font-size:15px;color:var(--txt-dark)}
        .chart-sub{font-size:11px;color:var(--txt-soft);margin-top:1px}
        .chart-filter{display:flex;gap:4px}
        .cf-btn{padding:3px 10px;border-radius:5px;border:1.5px solid #E2E8F0;
                background:transparent;font-size:11px;font-weight:600;color:var(--txt-soft);
                cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s;}
        .cf-btn.active{background:var(--teal);color:white;border-color:var(--teal)}
        canvas{max-width:100%}
        /* Donut legend */
        .donut-legend{display:flex;flex-direction:column;gap:8px;margin-top:12px}
        .dl-item{display:flex;align-items:center;gap:8px;font-size:12px}
        .dl-dot{width:10px;height:10px;border-radius:50%;flex-shrink:0}

        /* ══ TABLES ROW ══ */
        .tables-row{display:grid;grid-template-columns:1fr 1fr;gap:14px}
        .tbl-card{background:white;border-radius:var(--radius);padding:20px;
                  box-shadow:0 2px 12px rgba(0,0,0,.05);}
        .tbl-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:14px}
        .tbl-title{font-family:'Nunito',sans-serif;font-weight:800;font-size:15px;color:var(--txt-dark)}
        .tbl-filter{display:flex;align-items:center;gap:8px}
        .tbl-filter select{padding:5px 10px;border:1.5px solid #E2E8F0;border-radius:7px;
                            font-size:12px;font-family:'Poppins',sans-serif;outline:none;
                            cursor:pointer;color:var(--txt-mid)}
        table{width:100%;border-collapse:collapse}
        thead th{padding:9px 12px;text-align:left;font-size:11px;font-weight:700;
                 color:var(--txt-soft);text-transform:uppercase;letter-spacing:.4px;
                 border-bottom:1.5px solid #F0F0EC}
        tbody tr{border-bottom:1px solid #F8F8F5;transition:background .15s}
        tbody tr:hover{background:#FAFAF8}
        tbody td{padding:11px 12px;font-size:13px;color:var(--txt-mid)}
        .u-avatar{width:30px;height:30px;border-radius:50%;background:var(--teal);
                  display:inline-flex;align-items:center;justify-content:center;
                  font-size:11px;font-weight:700;color:white;margin-right:8px;vertical-align:middle}
        .badge{display:inline-flex;align-items:center;gap:4px;padding:3px 10px;
               border-radius:50px;font-size:11px;font-weight:700}
        .badge-green{background:#D1FAE5;color:#065F46}
        .badge-orange{background:#FEF3C7;color:#92400E}
        .badge-red{background:#FEE2E2;color:#991B1B}
        .badge-blue{background:#DBEAFE;color:#1E40AF}
        /* Score bar */
        .score-bar{display:inline-block;width:80px;height:5px;background:#E2E8F0;
                   border-radius:50px;vertical-align:middle;position:relative}
        .score-fill{position:absolute;inset:0;border-radius:50px;background:var(--teal)}

        /* ══ ADMIN SETTINGS MODAL ══ */
        .modal-backdrop{display:none;position:fixed;inset:0;background:rgba(0,0,0,.45);
                        z-index:100;align-items:center;justify-content:center}
        .modal-backdrop.show{display:flex}
        .modal-box{background:white;border-radius:20px;padding:32px;width:400px;
                   box-shadow:0 20px 60px rgba(0,0,0,.18);animation:mi .3s ease}
        @keyframes mi{from{transform:scale(.9);opacity:0}to{transform:scale(1);opacity:1}}
        .modal-title{font-family:'Nunito',sans-serif;font-weight:900;font-size:19px;
                     color:var(--txt-dark);margin-bottom:4px;}
        .modal-sub{font-size:12.5px;color:var(--txt-soft);margin-bottom:20px}
        .mfield{margin-bottom:14px}
        .mfield label{display:block;font-size:11.5px;font-weight:700;color:var(--txt-mid);
                      margin-bottom:4px;text-transform:uppercase;letter-spacing:.3px}
        .mfield input{width:100%;padding:10px 13px;border:1.5px solid #E2E8F0;border-radius:10px;
                      font-size:13.5px;font-family:'Poppins',sans-serif;outline:none;transition:border-color .2s}
        .mfield input:focus{border-color:var(--teal)}
        .modal-alert{padding:9px 14px;border-radius:8px;font-size:12.5px;margin-bottom:14px;
                     display:none;align-items:center;gap:7px}
        .modal-alert.show{display:flex}
        .modal-alert.ok{background:#D1FAE5;color:#065F46}
        .modal-alert.err{background:#FEE2E2;color:#991B1B}
        .modal-btns{display:flex;gap:10px;justify-content:flex-end;margin-top:20px}
        .btn-cancel{padding:9px 20px;border-radius:50px;border:1.5px solid #E2E8F0;
                    background:white;color:var(--txt-mid);font-size:13px;font-weight:600;
                    cursor:pointer;font-family:'Poppins',sans-serif;transition:all .2s}
        .btn-save{padding:9px 24px;border-radius:50px;background:var(--teal);color:white;
                  border:none;font-size:13px;font-weight:700;cursor:pointer;
                  font-family:'Poppins',sans-serif;transition:all .2s;
                  box-shadow:0 4px 14px rgba(58,175,169,.35)}
        .btn-save:hover{background:var(--teal-dark)}
    </style>
</head>
<body>
<form id="form1" runat="server">

<!-- ══ SIDEBAR ══ -->
<div class="sidebar">
    <div class="sb-logo">
        <div class="sb-logo-icon">T</div>
        <span class="sb-logo-text">TLC <span>Yemba</span></span>
    </div>

    <div class="sb-section">Menu principal</div>
    <a href="AdminDashboard.aspx" class="sb-item active">
        <i class="fa-solid fa-gauge-high"></i> Dashboard
    </a>
    <a href="#" class="sb-item" onclick="showTab('utilisateurs',event);return false">
        <i class="fa-solid fa-users"></i> Utilisateurs
        <span class="sb-badge"><asp:Literal ID="litNbUsers" runat="server">0</asp:Literal></span>
    </a>
    <a href="#" class="sb-item" onclick="showTab('certifies',event);return false">
        <i class="fa-solid fa-certificate"></i> Certifies
    </a>
    <a href="#" class="sb-item" onclick="showTab('nonCertifies',event);return false">
        <i class="fa-solid fa-hourglass-half"></i> Non certifies
    </a>
    <a href="#" class="sb-item" onclick="showTab('stats',event);return false">
        <i class="fa-solid fa-chart-line"></i> Statistiques
    </a>

    <div class="sb-section">Autres</div>
    <a href="#" class="sb-item" onclick="ouvrirSettings();return false">
        <i class="fa-solid fa-gear"></i> Parametres admin
    </a>
    <a href="Default.aspx" class="sb-item">
        <i class="fa-solid fa-house"></i> Retour au site
    </a>

    <div class="sb-profile">
        <div class="sb-avatar">A</div>
        <div class="sb-profile-info">
            <span class="sb-profile-name">Administrateur</span>
            <span class="sb-profile-role">yougo@gmail.com</span>
        </div>
        <asp:Button ID="btnLogout" runat="server" CssClass="sb-logout"
            Text="" OnClick="btnLogout_Click" ToolTip="Deconnexion"/>
        <i class="fa-solid fa-right-from-bracket" style="color:rgba(255,255,255,.4);font-size:14px;pointer-events:none;margin-left:-28px"></i>
    </div>
</div>

<!-- ══ MAIN ══ -->
<div class="main">

    <!-- Top Bar -->
    <div class="topbar">
        <div class="topbar-breadcrumb">
            <span class="bc-prev">Dashboard</span>
            <span class="bc-sep"><i class="fa-solid fa-chevron-right" style="font-size:10px"></i></span>
            <span class="bc-current" id="breadcrumbCurrent">Vue generale</span>
        </div>
        <div class="tb-spacer"></div>
        <!-- Filter tabs -->
        <div class="filter-tabs">
            <button class="ft-btn" onclick="filterPeriod('yesterday',event)">Hier</button>
            <button class="ft-btn active" onclick="filterPeriod('today',event)">Aujourd'hui</button>
            <button class="ft-btn" onclick="filterPeriod('week',event)">Semaine</button>
            <button class="ft-btn" onclick="filterPeriod('month',event)">Mois</button>
            <button class="ft-btn" onclick="filterPeriod('year',event)">Annee</button>
        </div>
        <!-- Search -->
        <div class="search-wrap">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Rechercher..." id="globalSearch"
                   onkeyup="globalSearchFn(this.value)"/>
        </div>
    </div>

    <!-- Content -->
    <div class="content">

        <!-- ══ STAT CARDS ══ -->
        <div class="stat-cards">
            <div class="sc">
                <div class="sc-header">
                    <span class="sc-title">Utilisateurs</span>
                    <div class="sc-icon" style="background:#EAF8F7">
                        <i class="fa-solid fa-users" style="color:var(--teal)"></i>
                    </div>
                </div>
                <div class="sc-val"><asp:Literal ID="litStatUsers" runat="server">0</asp:Literal></div>
                <div class="sc-trend up">
                    <i class="fa-solid fa-arrow-trend-up"></i>
                    <span>+<asp:Literal ID="litStatUsersNew" runat="server">0</asp:Literal> ce mois</span>
                </div>
            </div>
            <div class="sc">
                <div class="sc-header">
                    <span class="sc-title">Tests passes</span>
                    <div class="sc-icon" style="background:#FEF9EC">
                        <i class="fa-solid fa-list-check" style="color:var(--gold)"></i>
                    </div>
                </div>
                <div class="sc-val"><asp:Literal ID="litStatTests" runat="server">0</asp:Literal></div>
                <div class="sc-trend up">
                    <i class="fa-solid fa-arrow-trend-up"></i>
                    <span>Depuis le debut</span>
                </div>
            </div>
            <div class="sc">
                <div class="sc-header">
                    <span class="sc-title">Certifies</span>
                    <div class="sc-icon" style="background:#D1FAE5">
                        <i class="fa-solid fa-certificate" style="color:var(--green)"></i>
                    </div>
                </div>
                <div class="sc-val"><asp:Literal ID="litStatCertifies" runat="server">0</asp:Literal></div>
                <div class="sc-trend up">
                    <i class="fa-solid fa-arrow-trend-up"></i>
                    <span>Score >= 468</span>
                </div>
            </div>
            <div class="sc">
                <div class="sc-header">
                    <span class="sc-title">Score moyen</span>
                    <div class="sc-icon" style="background:#FEE2E2">
                        <i class="fa-solid fa-star" style="color:var(--red)"></i>
                    </div>
                </div>
                <div class="sc-val"><asp:Literal ID="litStatMoyenne" runat="server">&#8212;</asp:Literal></div>
                <div class="sc-trend">
                    <span>Sur 677 points</span>
                </div>
            </div>
        </div>

        <!-- ══ CHARTS ══ -->
        <div class="charts-row">
            <!-- Line chart : scores quotidiens -->
            <div class="chart-card">
                <div class="chart-header">
                    <div>
                        <div class="chart-title">Evolution des scores</div>
                        <div class="chart-sub">30 derniers jours</div>
                    </div>
                    <div class="chart-filter">
                        <button class="cf-btn active">Scores</button>
                        <button class="cf-btn">Tests</button>
                    </div>
                </div>
                <canvas id="lineChart" height="130"></canvas>
            </div>
            <!-- Donut : taux reussite -->
            <div class="chart-card">
                <div class="chart-header">
                    <div>
                        <div class="chart-title">Taux de reussite</div>
                        <div class="chart-sub">Tous les tests</div>
                    </div>
                </div>
                <canvas id="donutChart" height="160"></canvas>
                <div class="donut-legend">
                    <div class="dl-item"><div class="dl-dot" style="background:#3AAFA9"></div><span>Reussite (>= 468)</span></div>
                    <div class="dl-item"><div class="dl-dot" style="background:#F59E0B"></div><span>Intermediaire</span></div>
                    <div class="dl-item"><div class="dl-dot" style="background:#EF4444"></div><span>Echec (< 398)</span></div>
                </div>
            </div>
            <!-- Bar : creations de compte -->
            <div class="chart-card">
                <div class="chart-header">
                    <div>
                        <div class="chart-title">Inscriptions</div>
                        <div class="chart-sub">Par semaine</div>
                    </div>
                </div>
                <canvas id="barChart" height="160"></canvas>
            </div>
        </div>

        <!-- ══ TABLES ══ -->
        <div class="tables-row">

            <!-- Table utilisateurs / certifies -->
            <div class="tbl-card">
                <div class="tbl-header">
                    <div class="tbl-title" id="tableTitle1">Tous les utilisateurs</div>
                    <div class="tbl-filter">
                        <select id="filterNiveau" onchange="filtrerCertificats()">
                            <option value="">Tous les niveaux</option>
                            <option value="Courant">Courant</option>
                            <option value="Avance">Avance</option>
                            <option value="Intermediaire">Intermediaire</option>
                            <option value="Elementaire">Elementaire</option>
                            <option value="Debutant">Debutant</option>
                        </select>
                        <select id="filterScore" onchange="filtrerCertificats()">
                            <option value="">Tous les scores</option>
                            <option value="588">Score >= 588 (Courant)</option>
                            <option value="468">Score >= 468 (Certifie)</option>
                            <option value="310">Score >= 310</option>
                        </select>
                    </div>
                </div>
                <div style="overflow-x:auto">
                    <table id="tableUsers">
                        <thead>
                            <tr>
                                <th>Candidat</th>
                                <th>Email</th>
                                <th>Score</th>
                                <th>Niveau</th>
                                <th>Statut</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyUsers">
                            <asp:Literal ID="litTableUsers" runat="server"/>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Table meilleurs scores -->
            <div class="tbl-card">
                <div class="tbl-header">
                    <div class="tbl-title">Meilleurs scores</div>
                    <div class="tbl-filter">
                        <select id="filterType" onchange="filtrerTypes()">
                            <option value="">Tous les types</option>
                            <option value="FullTest">Test Complet</option>
                            <option value="Listening">Listening</option>
                            <option value="Structure">Structure</option>
                            <option value="Reading">Reading</option>
                        </select>
                    </div>
                </div>
                <div style="overflow-x:auto">
                    <table id="tableTop">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Candidat</th>
                                <th>Type</th>
                                <th>Score</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyTop">
                            <asp:Literal ID="litTableTop" runat="server"/>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

    </div><!-- end .content -->
</div><!-- end .main -->

<!-- ══ MODAL PARAMETRES ADMIN ══ -->
<div class="modal-backdrop" id="settingsModal">
    <div class="modal-box">
        <div class="modal-title">Parametres administrateur</div>
        <div class="modal-sub">Modifier vos informations de connexion</div>

        <div class="modal-alert" id="modalAlert"></div>

        <div class="mfield">
            <label>Nouvel email</label>
            <asp:TextBox ID="txtAdminEmail" runat="server" placeholder="yougo@gmail.com"/>
        </div>
        <div class="mfield">
            <label>Mot de passe actuel</label>
            <asp:TextBox ID="txtAdminMdpActuel" runat="server" TextMode="Password" placeholder="Mot de passe actuel"/>
        </div>
        <div class="mfield">
            <label>Nouveau mot de passe</label>
            <asp:TextBox ID="txtAdminMdpNew" runat="server" TextMode="Password" placeholder="Nouveau mot de passe (laisser vide = inchange)"/>
        </div>

        <div class="modal-btns">
            <button type="button" class="btn-cancel" onclick="fermerSettings()">Annuler</button>
            <asp:Button ID="btnSaveAdmin" runat="server" Text="Enregistrer"
                CssClass="btn-save" OnClick="btnSaveAdmin_Click"/>
        </div>
    </div>
</div>

</form>

<script>
/* ── Charts ── */
var lineData  = JSON.parse('<%= LineChartJSON %>');
var donutData = JSON.parse('<%= DonutChartJSON %>');
var barData   = JSON.parse('<%= BarChartJSON %>');

new Chart(document.getElementById('lineChart'), {
    type: 'line',
    data: {
        labels: lineData.labels,
        datasets: [
            { label: 'Score moyen', data: lineData.scores,
              borderColor: '#3AAFA9', backgroundColor: 'rgba(58,175,169,.10)',
              borderWidth: 2.5, pointRadius: 3, fill: true, tension: 0.4 },
            { label: 'Nb tests', data: lineData.tests,
              borderColor: '#F59E0B', backgroundColor: 'rgba(245,158,11,.06)',
              borderWidth: 2, pointRadius: 3, fill: false, tension: 0.4 }
        ]
    },
    options: { responsive: true, interaction: { mode: 'index' },
        plugins: { legend: { display: true, position: 'top',
            labels: { font: { size: 11, family: 'Poppins' }, usePointStyle: true } } },
        scales: { y: { grid: { color: '#F4F7F6' }, ticks: { font: { size: 10 } } },
                  x: { grid: { display: false }, ticks: { font: { size: 10 } } } } }
});
new Chart(document.getElementById('donutChart'), {
    type: 'doughnut',
    data: { labels: ['Reussite', 'Intermediaire', 'Echec'],
        datasets: [{ data: donutData, backgroundColor: ['#3AAFA9','#F59E0B','#EF4444'],
                     borderWidth: 0, hoverOffset: 6 }] },
    options: { responsive: true, cutout: '68%',
        plugins: { legend: { display: false },
            tooltip: { callbacks: { label: function(c){ return c.label+': '+c.parsed+'%'; } } } } }
});
new Chart(document.getElementById('barChart'), {
    type: 'bar',
    data: { labels: barData.labels,
        datasets: [{ label: 'Inscriptions', data: barData.values,
            backgroundColor: 'rgba(58,175,169,.7)', borderRadius: 6, borderSkipped: false }] },
    options: { responsive: true,
        plugins: { legend: { display: false } },
        scales: { y: { grid: { color: '#F4F7F6' }, ticks: { font: { size: 10 } } },
                  x: { grid: { display: false }, ticks: { font: { size: 10 } } } } }
});

function globalSearchFn(val) {
    val = val.toLowerCase();
    document.querySelectorAll('#tbodyUsers tr, #tbodyTop tr').forEach(function(tr) {
        tr.style.display = tr.textContent.toLowerCase().indexOf(val) !== -1 ? '' : 'none';
    });
}

function filterPeriod(p, ev) {
    document.querySelectorAll('.ft-btn').forEach(function(b) { b.classList.remove('active'); });
    if (ev && ev.target) ev.target.classList.add('active');
}

function filtrerCertificats() {
    var niv   = document.getElementById('filterNiveau').value;
    var scMin = parseInt(document.getElementById('filterScore').value, 10) || 0;
    document.querySelectorAll('#tbodyUsers tr').forEach(function(tr) {
        var tds = tr.querySelectorAll('td');
        if (!tds.length) return;
        var niveau = tds[3] ? tds[3].textContent.trim() : '';
        var score  = parseInt(tds[2] ? tds[2].textContent.trim() : '0', 10) || 0;
        var ok = true;
        if (niv && niveau !== niv)  ok = false;
        if (scMin && score < scMin) ok = false;
        tr.style.display = ok ? '' : 'none';
    });
}

function filtrerTypes() {
    var typ = document.getElementById('filterType').value;
    document.querySelectorAll('#tbodyTop tr').forEach(function(tr) {
        var tds = tr.querySelectorAll('td');
        if (!tds.length) return;
        var type = tds[2] ? tds[2].textContent.trim() : '';
        tr.style.display = (!typ || type.indexOf(typ) !== -1) ? '' : 'none';
    });
}

function showTab(tab, ev) {
    var titles = { utilisateurs:'Tous les utilisateurs', certifies:'Candidats certifies',
                   nonCertifies:'Candidats non certifies', stats:'Statistiques' };
    var el = document.getElementById('breadcrumbCurrent');
    if (el) el.textContent = titles[tab] || tab;
    if (tab === 'certifies') {
        document.getElementById('filterScore').value = '468'; filtrerCertificats();
    } else if (tab === 'nonCertifies') {
        document.getElementById('filterScore').value = '';
        document.querySelectorAll('#tbodyUsers tr').forEach(function(tr) {
            var tds = tr.querySelectorAll('td');
            if (!tds.length) return;
            var score = parseInt(tds[2] ? tds[2].textContent.trim() : '0', 10) || 0;
            tr.style.display = score < 468 ? '' : 'none';
        });
    } else { document.getElementById('filterScore').value=''; document.getElementById('filterNiveau').value=''; filtrerCertificats(); }
    document.querySelectorAll('.sb-item').forEach(function(i) { i.classList.remove('active'); });
    if (ev && ev.currentTarget) ev.currentTarget.classList.add('active');
}

function ouvrirSettings() { document.getElementById('settingsModal').classList.add('show'); }
function fermerSettings()  { document.getElementById('settingsModal').classList.remove('show'); }
document.getElementById('settingsModal').addEventListener('click', function(ev) {
    if (ev.target === this) fermerSettings();
});
</script>
</body>
</html>