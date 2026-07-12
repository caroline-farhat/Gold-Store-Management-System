<%@ Page Title="Kategoriler" Language="C#"
    MasterPageFile="~/kullanici/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="kategori.aspx.cs"
    Inherits="WebApplication1.kullanici.Kategori" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style>
        :root{
            --gold:#d4af37;
            --gold-2:#b58b1f;
            --bg-dark:#0a0a0a;
            --bg-panel:#121212;
        }

        /* خلفية عامة */
        body{ background:var(--bg-dark)!important; color:#fff; }
        .page-wrap{ padding:18px 0; }

        /* الشريط الجانبي */
        .sidebar{
            width:220px;
            border:1.5px solid var(--gold);
            border-radius:14px;
            padding:14px;
            background:linear-gradient(180deg,#141414,#0a0a0a);
            box-shadow:0 0 12px rgba(212,175,55,.2);
        }
        .side-menu .btn{
            width:100%; text-align:left; border:1px solid #2a2a2a;
            background:#0e0e0e; color:#eaeaea; padding:.6rem .75rem;
            margin-bottom:10px; border-radius:10px; transition:.3s;
        }
        .side-menu .btn:hover{ color:var(--gold); border-color:var(--gold-2); background:#1a1a1a; }

        /* شريط البحث */
        .search-card{
            background:linear-gradient(180deg,#141414,#0c0c0c);
            border:1px solid #222; border-radius:14px;
            box-shadow:0 0 20px rgba(0,0,0,.6);
            padding:14px; margin-bottom:16px;
        }
        .search-card .label{ color:#e9e9e9; font-weight:600; }
        .pill-input{ border-radius:999px!important; }
        .search-input{ background:#0f0f0f; color:#fff; border:1px solid #2f2f2f; }
        .search-input:focus{ border-color:var(--gold); box-shadow:0 0 0 .15rem rgba(212,175,55,.15); }
        .btn-gold{ background:var(--gold-2); color:#fff; border:0; padding:.48rem 1rem; border-radius:10px; }
        .btn-gold:hover{ background:var(--gold); color:#111; }

        /* عنوان القسم فوق الجدول */
        .tbl-title{
            color:var(--gold);
            font-weight:600;
            margin: 0 0 12px 2px;
        }

        /* الجدول الداكن + هيدر أبيض */
        .table-dark{
            --bs-table-bg:#0b0b0b;
            --bs-table-striped-bg:#121212;
            --bs-table-hover-bg:#1a1a1a;
            --bs-table-border-color:#2c2c2c;
        }
        /* نستخدم نفس الكلاس الموجود على GridView ونبدّل لونيته للأبيض */
        .gv-gold thead th{
            color:#ffffff!important;                                  /* أبيض */
            background:linear-gradient(180deg,#1a1a1a,#0d0d0d)!important; /* خلفية داكنة */
            border-bottom:1px solid rgba(255,255,255,.28)!important;
            white-space:nowrap;
        }
        .table-dark td{ color:#fff!important; border-color:rgba(255,255,255,.08); }
        .table-dark tbody tr:hover{ background:#161616; }

        /* مودالات */
        .modal-content{ background:#0f0f0f; color:#fff; border:1px solid #2b2b2b; }
        .modal-header{ border-bottom:1px solid #232323; }
        .modal-footer{ border-top:1px solid #232323; }
        .form-row{ display:flex; align-items:center; gap:12px; margin-bottom:12px; }
        .form-row .form-label{ width:32%; min-width:140px; margin:0; color:#cfcfcf; }
        .form-row .form-control{ width:68%; background:#121212; color:#fff; border:1px solid #323232; }
        .form-row .form-control:focus{ border-color:var(--gold); box-shadow:0 0 0 .15rem rgba(212,175,55,.15); }
        .form-row textarea.form-control{ height:140px; resize:vertical; }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

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

            <!-- يمين: البحث + الجدول -->
            <div class="flex-grow-1">

                <!-- عنوان القسم فوق الجدول مباشرة -->
                <h5 class="tbl-title">Kategoriler</h5>

                <!-- شريط البحث -->
                <div class="search-card">
                    <div class="d-flex align-items-center gap-3 flex-wrap">
                        <label class="label mb-0">Kategori Adı</label>

                        <div class="d-flex align-items-center gap-2">
                            <span class="input-group-text py-1 px-2 bg-transparent border-0 text-light">
                                <i class="bi bi-search"></i>
                            </span>
                            <asp:TextBox ID="TxtAra" runat="server" CssClass="form-control pill-input search-input" Width="260" />
                        </div>

                        <asp:Button ID="BtnAra" runat="server" Text="Ara"
                            CssClass="btn-gold" OnClick="BtnAra_Click" />

                        <asp:Button ID="BtnYeni" runat="server" Text="Kategori Ekle"
                            CssClass="btn-gold"
                            OnClientClick="prepareAdd(); return false;" />
                    </div>
                </div>

                <!-- الجدول -->
                <asp:GridView ID="GvKategoriler" runat="server"
                    CssClass="table table-dark table-striped table-hover table-bordered mb-0 align-middle gv-gold"
                    AutoGenerateColumns="False"
                    DataKeyNames="Id"
                    OnRowCommand="GvKategoriler_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="KategoriAdi" HeaderText="Kategori Adı" />
                        <asp:BoundField DataField="KayitTarihiText" HeaderText="Kayıt Tarihi" />
                        <asp:BoundField DataField="Not" HeaderText="Not" />
                        <asp:TemplateField HeaderText="Detaylar">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDetay" runat="server" Text="Detaylar"
                                    CausesValidation="false"
                                    CommandName="detay"
                                    CommandArgument="<%# Container.DataItemIndex %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sil">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkSil" runat="server" Text="Sil"
                                    CausesValidation="false"
                                    CommandName="sil"
                                    CommandArgument="<%# Container.DataItemIndex %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:HiddenField ID="HfSelectedId" runat="server" />
            </div>
        </div>
    </div>

    <!-- Modal: Detay / Güncelle + إضافة -->
    <div class="modal fade" id="detayModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header py-2">
                    <h6 class="modal-title" id="modalTitle">Kategori Güncelle</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body">
                    <div class="form-row">
                        <label class="form-label">Kategori Adı</label>
                        <asp:TextBox ID="TxtDetayKategori" runat="server" CssClass="form-control" />
                    </div>
                    <div class="form-row">
                        <label class="form-label">Not</label>
                        <asp:TextBox ID="TxtDetayNot" runat="server" CssClass="form-control" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer py-2">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">İptal Et</button>
                    <asp:Button ID="BtnKaydet" runat="server" Text="Güncelle"
                        CssClass="btn btn-gold" OnClick="BtnKaydet_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal: Sil onayı -->
    <div class="modal fade" id="silModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header py-2">
                    <h6 class="modal-title">Silme Onayı</h6>
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
        function prepareAdd() {
            document.getElementById('<%= HfSelectedId.ClientID %>').value = "0"; // 0 = إضافة
            document.getElementById('modalTitle').innerText = 'Kategori Ekle';
            document.getElementById('<%= TxtDetayKategori.ClientID %>').value = '';
            document.getElementById('<%= TxtDetayNot.ClientID %>').value = '';
            bootstrap.Modal.getOrCreateInstance(document.getElementById('detayModal')).show();
        }
        function showDetay() { bootstrap.Modal.getOrCreateInstance(document.getElementById('detayModal')).show(); }
        function hideDetay() { bootstrap.Modal.getOrCreateInstance(document.getElementById('detayModal')).hide(); }
        function showSil() { bootstrap.Modal.getOrCreateInstance(document.getElementById('silModal')).show(); }
        function hideSil() { bootstrap.Modal.getOrCreateInstance(document.getElementById('silModal')).hide(); }
    </script>
</asp:Content>
