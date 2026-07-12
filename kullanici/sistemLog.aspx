<%@ Page Title="Sistem Logları" Language="C#"
    MasterPageFile="~/kullanici/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="sistemLog.aspx.cs"
    Inherits="WebApplication1.kullanici.sistemLog" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style>
        :root{
            --gold:#d4af37;
            --gold-2:#b58b1f;
            --bg-dark:#0a0a0a;
        }
        body{ background:var(--bg-dark)!important; color:#fff; }
        .page-wrap{ padding:18px 0; }

        /* sidebar */
        .sidebar{
            width:220px; border:1.5px solid var(--gold); border-radius:14px; padding:14px;
            background:linear-gradient(180deg,#141414,#0a0a0a); box-shadow:0 0 12px rgba(212,175,55,.2);
        }
        .side-menu .btn{
            width:100%; text-align:left; border:1px solid #2a2a2a; background:#0e0e0e; color:#eaeaea;
            padding:.6rem .75rem; margin-bottom:10px; border-radius:10px; transition:.3s;
        }
        .side-menu .btn:hover{ color:var(--gold); border-color:var(--gold-2); background:#1a1a1a; }

        /* panel */
        .panel{
            background:linear-gradient(180deg,#141414,#0c0c0c);
            border:1px solid #222; border-radius:14px; box-shadow:0 0 20px rgba(0,0,0,.6);
        }
        .panel .panel-head{
            padding:12px 16px; border-bottom:1px solid rgba(212,175,55,.25);
            background:linear-gradient(180deg,rgba(212,175,55,.25),rgba(212,175,55,.05));
            border-top-left-radius:14px; border-top-right-radius:14px; color:var(--gold); font-weight:600;
        }
        .panel .panel-body{ padding:14px; }

        /* search bar */
        .search-bar{
            background:#0f0f0f; border:1px solid #232323; border-radius:12px; padding:10px;
        }
        .pill-input{
            border-radius:999px!important; background:#121212; color:#fff; border:1px solid #323232;
        }
        .pill-input:focus{ border-color:var(--gold); box-shadow:0 0 0 .15rem rgba(212,175,55,.15); }

        /*  لون placeholder شفاف */
        .pill-input::placeholder{
            color:rgba(255,255,255,.5) !important;
            opacity:1;
        }

        .btn-gold{ background:var(--gold-2); color:#111; border:0; border-radius:10px; padding:.5rem 1rem; }
        .btn-gold:hover{ background:var(--gold); color:#111; }

        /* table dark + golden head */
        .table-dark{
            --bs-table-bg:#0b0b0b; --bs-table-striped-bg:#121212; --bs-table-hover-bg:#1a1a1a; --bs-table-border-color:#2c2c2c;
        }
        /*  إزالة الخلفية والحواف البيضاء من أيقونة البحث */
.input-group-text {
    background: transparent !important;
    border: none !important;
    color: var(--gold) !important; /* بتخلي الأيقونة نفسها ذهبية */
    padding: 0 !important;
}

        .table-dark thead th{
            color:var(--gold)!important;
            background:linear-gradient(180deg,rgba(212,175,55,.18),rgba(212,175,55,.06));
            border-bottom:1px solid rgba(212,175,55,.35)!important;
            white-space:nowrap;
        }
        .table-dark td{ color:#fff!important; border-color:rgba(255,255,255,.08)!important; }
        .gap-12{ gap:12px; }
        .search-label{ font-weight:600; white-space:nowrap; color:#ddd; }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="container-fluid page-wrap">
        <div class="d-flex">
            <!-- Sidebar -->
            <div class="sidebar me-3">
                <div class="side-menu">
                    <a class="btn" href="~/kullanici/default.aspx" runat="server">Ana Sayfa</a>
                    <a class="btn" href="~/kullanici/kullanici.aspx" runat="server">Kullanıcı Ara</a>
                    <a class="btn" href="~/kullanici/urunler.aspx" runat="server">Ürünler</a>
                    <a class="btn" href="~/kullanici/kategori.aspx" runat="server">Kategoriler</a>
                    <a class="btn" href="~/kullanici/parametre.aspx" runat="server">Parametreler</a>
                    <a class="btn" href="~/kullanici/sistemLog.aspx" runat="server">Sistem Logları</a>
                </div>
            </div>

            <!-- Right -->
            <div class="flex-grow-1">
                <div class="panel">
                    <div class="panel-head">Sistem Logları</div>
                    <div class="panel-body">
                        <!-- search -->
                        <div class="search-bar mb-3">
                            <div class="d-flex align-items-center flex-wrap gap-12">
                                <span class="search-label">Log Adı</span>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="input-group-text py-1 px-2"><i class="bi bi-search"></i></span>
                                    <asp:TextBox ID="TxtAra" runat="server"
                                        CssClass="form-control pill-input" Width="240"
                                        placeholder="Ara..." autocomplete="off" spellcheck="false" />
                                </div>

                                <span class="search-label ms-3">Başlangıç Tarihi</span>
                                <asp:TextBox ID="TxtBaslangic" runat="server"
                                    CssClass="form-control pill-input" TextMode="Date" Width="170" />
                                <i class="bi bi-calendar3 ms-1"></i>

                                <span class="search-label ms-3">Bitiş Tarihi</span>
                                <asp:TextBox ID="TxtBitis" runat="server"
                                    CssClass="form-control pill-input" TextMode="Date" Width="170" />
                                <i class="bi bi-calendar3 ms-1"></i>

                                <asp:Button ID="BtnAra" runat="server" Text="Ara"
                                    CssClass="btn-gold ms-2" OnClick="BtnAra_Click" />
                            </div>
                        </div>

                        <!-- table -->
                        <asp:GridView ID="GvLogs" runat="server"
                            CssClass="table table-dark table-striped table-hover table-bordered mb-0"
                            AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="LogAdi" HeaderText="Log Adı" />
                                <asp:BoundField DataField="KullaniciAdi" HeaderText="Kullanıcı Adı" />
                                <asp:BoundField DataField="TarihText" HeaderText="Tarihi" />
                                <asp:BoundField DataField="Turu" HeaderText="Türü" />
                                <asp:BoundField DataField="IP" HeaderText="IP" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
