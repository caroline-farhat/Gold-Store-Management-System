<%@ Page Title="Parametreler" Language="C#"
    MasterPageFile="~/kullanici/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="parametre.aspx.cs"
    Inherits="WebApplication1.kullanici.parametre" %>

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
            width:100%; text-align:left;
            border:1px solid #2a2a2a; background:#0e0e0e; color:#eaeaea;
            padding:.6rem .75rem; margin-bottom:10px; border-radius:10px; transition:.3s;
        }
        .side-menu .btn:hover{ color:var(--gold); border-color:var(--gold-2); background:#1a1a1a; }

        /* الإطار الداخلي */
        .content-frame{
            background:linear-gradient(180deg,#141414,#0c0c0c);
            border:1px solid #222; border-radius:14px;
            box-shadow:0 0 20px rgba(0,0,0,.6);
            min-height:420px;
        }

        /* أزرار ذهبية */
        .btn-gold{
            background:var(--gold-2); color:#fff; border:0; padding:.52rem 1rem; border-radius:10px;
        }
        .btn-gold:hover{ background:var(--gold); color:#111; }

        /* المودال والحقول */
        .modal-content{ background:#0f0f0f; color:#fff; border:1px solid #2b2b2b; }
        .modal-header{ border-bottom:1px solid #232323; }
        .modal-footer{ border-top:1px solid #232323; }
        .sozlez-box{
            width:100%; height:420px; resize:none;
            background:#121212; color:#fff; border:1px solid #323232;
        }
        .sozlez-box:focus{ border-color:var(--gold); box-shadow:0 0 0 .15rem rgba(212,175,55,.15); }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="container-fluid page-wrap">
        <div class="d-flex">
            <!-- يسار: القائمة -->
            <div class="sidebar me-3">
                <div class="side-menu">
                    <a class="btn" href="~/kullanici/default.aspx"   runat="server">Ana Sayfa</a>
                    <a class="btn" href="~/kullanici/kullanici.aspx" runat="server">Kullanıcı Ara</a>
                    <a class="btn" href="~/kullanici/urunler.aspx"   runat="server">Ürünler</a>
                    <a class="btn" href="~/kullanici/kategori.aspx"  runat="server">Kategoriler</a>
                    <a class="btn" href="~/kullanici/parametre.aspx" runat="server">Parametreler</a>
                    <a class="btn" href="~/kullanici/sistemLog.aspx" runat="server">Sistem Logları</a>
                </div>
            </div>

            <!-- يمين: الإطار + زر تحديث العقد -->
            <div class="flex-grow-1">
                <div class="content-frame p-3 d-flex align-items-start">
                    <asp:Button ID="BtnOpenSozlesme" runat="server"
                        Text="Kullanıcı Sözleşmesi Güncelle"
                        CssClass="btn-gold"
                        OnClientClick="showSozlesme(); return false;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Modal: Sözleşme -->
    <div class="modal fade" id="sozlesmeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header py-2">
                    <h6 class="modal-title">Sözleşme</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="TxtSozlesme" runat="server" TextMode="MultiLine" CssClass="form-control sozlez-box" />
                </div>
                <div class="modal-footer py-2">
                    <asp:Button ID="BtnGuncelle" runat="server" Text="Güncelle"
                        CssClass="btn-gold" OnClick="BtnGuncelle_Click" />
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">İptal</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showSozlesme() {
            bootstrap.Modal.getOrCreateInstance(document.getElementById('sozlesmeModal')).show();
        }
        function hideSozlesme() {
            bootstrap.Modal.getOrCreateInstance(document.getElementById('sozlesmeModal')).hide();
        }
    </script>
</asp:Content>
