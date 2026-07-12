<%@ Page Title="Ürünler" Language="C#"
    MasterPageFile="~/kullanici/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="urunler.aspx.cs"
    Inherits="WebApplication1.kullanici.urunler" %>

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
            transition: 0.3s;
        }
        .btn-gold:hover{ filter:brightness(1.1); }

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

        /* Modal dark */
        .modal-content{ background:#111; color:#fff; border:1px solid #2a2a2a; }
        .modal-header{ border-bottom-color:#2a2a2a; }
        .modal-footer{ border-top-color:#2a2a2a; }
        .form-row{ display:flex; align-items:center; gap:12px; margin-bottom:10px; }
        .form-row .form-label{ width:35%; min-width:130px; margin:0; color:#d6d6d6; }
        .form-row .form-control, .form-row .form-select{
            width:65%; background:#0f0f0f; color:#fff; border:1px solid #2a2a2a;
        }
        .form-note textarea{ min-height:130px; }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="container-fluid page-wrap">
        <div class="d-flex">
            <!-- يسار: القائمة -->
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

            <!-- يمين: البحث + الأزرار + الجدول -->
            <div class="flex-grow-1">
                <div class="search-bar">
                    <div class="d-flex align-items-center gap-2 flex-wrap">
                        <label class="fw-semibold mb-0" style="color:var(--gold)">Ürün Adı</label>
                        <div class="d-flex align-items-center gap-2">
                            <span class="input-group-text py-1 px-2" style="background:#0f0f0f;border:1px solid #2a2a2a;color:#aaa">
                                <i class="bi bi-search"></i>
                            </span>
                            <asp:TextBox ID="TxtAra" runat="server" CssClass="form-control pill-input" Width="260" placeholder="Ara..." />
                        </div>
                        <asp:Button ID="BtnAra" runat="server" Text="Ara" CssClass="btn-gold" OnClick="BtnAra_Click" />
                        <asp:Button ID="BtnUrunEkle" runat="server" Text="Ürün Ekle" CssClass="btn-gold" OnClick="BtnUrunEkle_Click" />
                    </div>
                </div>

                <div class="card gold">
                      <div class="card-header">Ürünler</div>
                    <div class="card-body p-0">
                        <!-- الجدول -->
                        <asp:GridView ID="GvUrunler" runat="server"
                            CssClass="table table-dark table-striped table-hover table-bordered mb-0 align-middle"
                            AutoGenerateColumns="False"
                            DataKeyNames="Id"
                            OnRowCommand="GvUrunler_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="UrunAdi" HeaderText="Ürün Adı" />
                                <asp:BoundField DataField="KayitTarihiText" HeaderText="Kayıt Tarihi" />
                                <asp:BoundField DataField="StokAdet" HeaderText="Stok Adet" />
                                <asp:BoundField DataField="BirimFiyatText" HeaderText="Birim Fiyat" />
                                <asp:BoundField DataField="Not" HeaderText="Not" />
                                <%-- Detaylar --%>
                                <asp:TemplateField HeaderText="Detaylar">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDetay" runat="server" Text="Detaylar"
                                            CausesValidation="false" UseSubmitBehavior="false"
                                            CommandName="detay" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Sil --%>
                                <asp:TemplateField HeaderText="Sil">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkSil" runat="server" Text="Sil"
                                            CausesValidation="false" UseSubmitBehavior="false"
                                            CommandName="sil" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <!-- hidden -->
                <asp:HiddenField ID="HfSelectedId" runat="server" />
            </div>
        </div>
    </div>

    <!-- Modal: Ürün Detayı / Güncelle / Ekle -->
    <div class="modal fade" id="detayModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header py-2">
                    <h6 class="modal-title" style="color:var(--gold)">Ürün Güncelle</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body">
                    <div class="form-row">
                        <label class="form-label">Kategori</label>
                        <asp:DropDownList ID="DdlKategori" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="form-row">
                        <label class="form-label">Ürün Adı</label>
                        <asp:TextBox ID="TxtUrunAdi" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-row">
                        <label class="form-label">Stok</label>
                        <asp:TextBox ID="TxtStok" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-row">
                        <label class="form-label">Birim Fiyat</label>
                        <asp:TextBox ID="TxtBirimFiyat" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-row form-note">
                        <label class="form-label">Not</label>
                        <asp:TextBox ID="TxtNot" runat="server" CssClass="form-control" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer py-2">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">İptal Et</button>
                    <asp:Button ID="BtnKaydet" runat="server" Text="Güncelle"
    CssClass="btn btn-gold"
    OnClick="BtnKaydet_Click" />

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
    </script>
</asp:Content>
