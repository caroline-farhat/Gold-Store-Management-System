<%@ Page Title="Kullanıcı Ara" Language="C#" MasterPageFile="~/kullanici/Site1.Master"
    AutoEventWireup="true" CodeBehind="kullanici.aspx.cs" Inherits="WebApplication1.kullanici.Kullanici" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style>
        :root{
            --gold:#d4af37;
            --gold-2:#b58b1f;
            --bg-dark:#0a0a0a;
            --bg-panel:#121212;
        }

        body{ background:var(--bg-dark)!important; color:#fff; }

        .page-wrap{ padding:18px 0; }

        /* Sidebar */
        .sidebar{
            width:220px;
            border:1.5px solid var(--gold);
            border-radius:14px;
            padding:14px;
            background:linear-gradient(180deg,#141414,#0a0a0a);
            box-shadow:0 0 12px rgba(212,175,55,.2);
        }
        .side-menu .btn{
            width:100%;
            text-align:left;
            border:1px solid #2a2a2a;
            background:#0e0e0e;
            color:#eaeaea;
            padding:.6rem .75rem;
            margin-bottom:10px;
            border-radius:10px;
            transition:.3s;
        }
        .side-menu .btn:hover{
            color:var(--gold);
            border-color:var(--gold-2);
            background:#1a1a1a;
        }

        /* Search bar */
        .search-bar{
            border:1.5px solid rgba(212,175,55,.35);
            border-radius:14px;
            padding:14px;
            margin-bottom:14px;
            background:linear-gradient(180deg,#121212,#0d0d0d);
            box-shadow:0 0 10px rgba(0,0,0,.35);
        }
        .pill-input{ border-radius:999px!important; background:#0f0f0f; color:#fff; border:1px solid #2a2a2a; }
        .pill-input::placeholder{ color:#9a9a9a; }

        .btn-gold{
            background:var(--gold-2); color:#fff; border:0;
            padding:.45rem .95rem; border-radius:10px;
            box-shadow:0 0 10px rgba(212,175,55,.25);
        }
        .btn-gold:hover{ filter:brightness(1.07); }

        /* Card (table wrapper) */
        .card.gold{
            background:linear-gradient(180deg,#141414,#0c0c0c);
            border:1px solid #222;
            border-radius:14px;
            box-shadow:0 0 20px rgba(0,0,0,.6);
        }
        .card.gold .card-header{
            background:linear-gradient(180deg,rgba(212,175,55,.25),rgba(212,175,55,.05));
            color:var(--gold);
            border-bottom:1px solid rgba(212,175,55,.25);
            border-top-left-radius:14px;
            border-top-right-radius:14px;
            font-weight:600;
        }
        /* 🔍 إزالة الخلفية والحواف البيضاء من أيقونة البحث */
.input-group-text {
    background: transparent !important;
    border: none !important;
    color: var(--gold) !important; /* بتخلي الأيقونة نفسها ذهبية */
    padding: 0 !important;
}


        /* GridView table */
        .table-dark{
            --bs-table-bg:#0b0b0b;
            --bs-table-striped-bg:#121212;
            --bs-table-hover-bg:#1a1a1a;
            --bs-table-border-color:#2c2c2c;
        }
        .table-dark thead th{
            color:var(--gold)!important;
            border-bottom:1px solid rgba(212,175,55,.4);
            white-space:nowrap;
        }
        .table-dark td{
            color:#fff!important;
            border-color:rgba(255,255,255,.1);
        }
        .table-dark tbody tr:hover{ background:#161616; }

        /* Modals dark */
        .modal-content{ background:#111; color:#fff; border:1px solid #2a2a2a; }
        .modal-header{ border-bottom-color:#2a2a2a; }
        .modal-footer{ border-top-color:#2a2a2a; }
        .form-row{ display:flex; align-items:center; gap:12px; margin-bottom:10px; }
        .form-row .form-label{ width:35%; min-width:130px; margin:0; color:#d6d6d6; }
        .form-row .form-control{ width:65%; background:#0f0f0f; color:#fff; border:1px solid #2a2a2a; }

        /* small helper for password field with toggle */
        .pw-wrap{ position:relative; display:flex; align-items:center; }
        .pw-toggle-btn{
            position:absolute; right:8px; top:50%; transform:translateY(-50%);
            background:transparent; border:0; color:#cfcfcf; cursor:pointer; font-size:1rem;
            padding:.25rem .4rem; border-radius:.35rem;
        }
        .pw-toggle-btn:hover{ color:var(--gold); }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="container-fluid page-wrap">
        <div class="d-flex">
            <!-- Left: Sidebar -->
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

            <!-- Right: search + grid -->
            <div class="flex-grow-1">
                <div class="search-bar">
                    <div class="d-flex align-items-center gap-3 flex-wrap">
                        <label class="fw-semibold mb-0" style="color:var(--gold)">Adı Soyadı</label>
                        <div class="d-flex align-items-center gap-2">
                            <span class="input-group-text py-1 px-2" style="background:#0f0f0f;border:1px solid #2a2a2a;color:#aaa">
                                <i class="bi bi-search"></i>
                            </span>
                            <asp:TextBox ID="TxtAra" runat="server" CssClass="form-control pill-input" Width="260"
                                placeholder="Ara..." autocomplete="off" spellcheck="false" />
                        </div>
                        <asp:Button ID="BtnAra" runat="server" Text="Ara" CssClass="btn-gold" OnClick="BtnAra_Click" />
                    </div>
                </div>

                <div class="card gold">
                    <div class="card-header">Kullanıcılar</div>
                    <div class="card-body p-0">
                        <asp:GridView ID="GvUsers" runat="server"
                            CssClass="table table-dark table-striped table-hover table-bordered mb-0 align-middle"
                            AutoGenerateColumns="False"
                            DataKeyNames="Id"
                            OnRowCommand="GvUsers_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="AdSoyad" HeaderText="Adı Soyadı" />
                                <asp:BoundField DataField="KayitTarihiText" HeaderText="Kayıt Tarihi" />
                                <asp:BoundField DataField="KullaniciAdi" HeaderText="Kullanıcı Adı" />
                                <asp:TemplateField HeaderText="Detaylar">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDetay" runat="server"
                                            Text="Detaylar" CausesValidation="false"
                                            CommandName="detay" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sil">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkSil" runat="server"
                                            Text="Sil" CausesValidation="false"
                                            CommandName="sil" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- hidden for selected id -->
                <asp:HiddenField ID="HfSelectedId" runat="server" />
            </div>
        </div>
    </div>

    <!-- Modal: Detaylar / Güncelle -->
    <div class="modal fade" id="detayModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header py-2">
                    <h6 class="modal-title" style="color:var(--gold)">Kullanıcı Detayları</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body">
                    <div class="form-row">
                        <label class="form-label">Adı</label>
                        <asp:TextBox ID="TxtDetayAd" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-row">
                        <label class="form-label">Soyadı</label>
                        <asp:TextBox ID="TxtDetaySoyad" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-row">
                        <label class="form-label">Kullanıcı Adı</label>
                        <asp:TextBox ID="TxtDetayKullanici" runat="server" CssClass="form-control" />
                    </div>

                    <!-- Password row with toggle -->
                    <div class="form-row">
                        <label class="form-label">Şifre</label>
                        <div class="pw-wrap" style="width:65%;">
                            <!-- keep TextMode=Password for default secure behavior -->
                            <asp:TextBox ID="TxtDetaySifre" runat="server" CssClass="form-control" TextMode="Password" />
                            <button type="button" class="pw-toggle-btn" id="btnTogglePw" aria-label="Show password"
                                    onclick="togglePassword()">
                                <i id="pwIcon" class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="modal-footer py-2">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">İptal Et</button>
                    <asp:Button ID="BtnGuncelle" runat="server" Text="Güncelle"
                        CssClass="btn-gold" OnClick="BtnGuncelle_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal: Sil onayı -->
    <div class="modal fade" id="silModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header py-2">
                    <h6 class="modal-title" style="color:var(--gold)">Silme Onayı</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body text-center fs-4">
                    Silmek istediğine emin misin?
                </div>
                <div class="modal-footer py-2">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">İptal Et</button>
                    <asp:Button ID="BtnSilOnay" runat="server" Text="Sil"
                        CssClass="btn btn-outline-danger" OnClick="BtnSilOnay_Click" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function showDetay() { bootstrap.Modal.getOrCreateInstance(document.getElementById('detayModal')).show(); }
        function hideDetay() { bootstrap.Modal.getOrCreateInstance(document.getElementById('detayModal')).hide(); }
        function showSil() { bootstrap.Modal.getOrCreateInstance(document.getElementById('silModal')).show(); }
        function hideSil() { bootstrap.Modal.getOrCreateInstance(document.getElementById('silModal')).hide(); }

        // toggle password visibility
        function togglePassword() {
            const input = document.getElementById('<%= TxtDetaySifre.ClientID %>');
            const icon = document.getElementById('pwIcon');
            if (!input) return;
            if (input.type === 'password') {
                input.type = 'text';
                icon.className = 'bi bi-eye-slash';
            } else {
                input.type = 'password';
                icon.className = 'bi bi-eye';
            }
        }
    </script>
</asp:Content>
