<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="login.aspx.cs"
    Inherits="WebApplication1.login" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Giriş</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        :root{
            --gold:#d4af37;
            --gold-2:#b58b1f;
            --bg-dark:#0a0a0a;
        }

        /* خلفية متدرجة أسود -> ذهبي غامق */
        body{
            min-height:100vh;
            margin:0;
            display:flex; align-items:center; justify-content:center;
            background:linear-gradient(180deg,#000 0%, #141414 55%, #2b210c 100%);
            color:#fff;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            padding:24px;
        }

        /* بطاقة الدخول */
        .login-card{
            width:100%; max-width:520px;
            background:rgba(15,15,15,.96);
            border:1.6px solid var(--gold);
            border-radius:16px;
            box-shadow:0 0 24px rgba(212,175,55,.22);
        }
        .login-card .card-body{ padding:28px; }

        /* اللوغو */
        .login-logo{
            width:96px; height:auto;
            margin:6px auto 12px auto; display:block;
            border-radius:12px;
            border:2px solid var(--gold);
            padding:4px;
            box-shadow:0 0 14px rgba(212,175,55,.45);
            background:#0b0b0b;
            object-fit:contain;
        }

        /* العنوان */
        .login-title{
            text-align:center; margin-bottom:18px;
            color:var(--gold); font-weight:700;
            letter-spacing:.3px;
        }

        /* صف الحقول */
        .form-row{ display:flex; align-items:center; gap:14px; margin-bottom:12px; }
        .form-row .form-label{ width:40%; min-width:140px; margin:0; color:#e8e8e8; font-weight:500; }
        .form-row .form-control{
            width:60%;
            background:#0e0e0e; color:#fff;
            border:1px solid #3a3a3a; border-radius:10px;
        }
        .form-row .form-control:focus{
            border-color:var(--gold);
            box-shadow:0 0 0 .2rem rgba(212,175,55,.18);
        }

        /* أزرار ذهبية */
        .btn-gold{
            background:var(--gold); color:#111;
            border:0; border-radius:10px; font-weight:600;
            padding:.47rem 1rem; transition:.3s;
            box-shadow:0 0 10px rgba(212,175,55,.25);
        }
        .btn-gold:hover{ background:var(--gold-2); color:#fff; box-shadow:0 0 16px rgba(212,175,55,.45); }

        /* أزرار إطار ذهبي */
        .btn-outline-gold{
            border:1px solid var(--gold); color:var(--gold);
            border-radius:10px; padding:.47rem 1rem; font-weight:600;
        }
        .btn-outline-gold:hover{ background:var(--gold); color:#111; }

        /* صف الأزرار */
        .btn-row{ display:flex; gap:10px; justify-content:space-between; margin-top:16px; }

        /* موودال داكن */
        .modal-content{
            background:#111; color:#fff; border:1.5px solid #2b2b2b;
        }
        .modal-header,.modal-footer{ border-color:#2b2b2b; }
        .modal-title{ color:var(--gold); }
        .modal .form-control{
            background:#0f0f0f; color:#fff; border:1px solid #323232;
        }
        .modal .form-control:focus{
            border-color:var(--gold);
            box-shadow:0 0 0 .2rem rgba(212,175,55,.18);
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="card login-card">
        <div class="card-body">

            <!-- اللوغو -->
            <!-- ضعي الصورة داخل: /kullanici/images/logopro.jpg -->
            <img src="kullanici/images/logopro.jpg" alt="Logo" class="login-logo" />

            <h4 class="login-title">FARHAT GOLD</h4>

            <!-- Kullanıcı Adı -->
            <div class="form-row">
                <label for="TxtUser" class="form-label">Kullanıcı Adı</label>
                <asp:TextBox ID="TxtUser" runat="server" CssClass="form-control" />
            </div>

            <!-- Şifre -->
            <div class="form-row">
                <label for="TxtPass" class="form-label">Şifre</label>
                <asp:TextBox ID="TxtPass" runat="server" TextMode="Password" CssClass="form-control" />
            </div>

            <!-- رسالة خطأ إن وجدت -->
            <asp:Label ID="LblError" runat="server" CssClass="text-danger d-block mb-1"></asp:Label>

            <!-- الأزرار -->
            <div class="btn-row">
                <button type="button" class="btn btn-outline-gold" data-bs-toggle="modal" data-bs-target="#sozlesmeModal">
                    Sözleşme Oku
                </button>

                <button type="button" class="btn btn-outline-gold" data-bs-toggle="modal" data-bs-target="#uyeOlModal">
                    Üye ol
                </button>

                <asp:Button ID="btnLogin" runat="server"
                    Text="Login"
                    CssClass="btn btn-gold"
                    OnClick="btnLogin_Click" />
            </div>
        </div>
    </div>

    <!-- MODAL: ÜYE OL -->
    <div class="modal fade" id="uyeOlModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header py-2">
                    <h6 class="modal-title">Üye Ol</h6>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-2 align-items-center mb-2">
                        <div class="col-5"><label class="col-form-label">Adı</label></div>
                        <div class="col-7"><input type="text" class="form-control" id="txtAdi" /></div>
                    </div>
                    <div class="row g-2 align-items-center mb-2">
                        <div class="col-5"><label class="col-form-label">Soyadı</label></div>
                        <div class="col-7"><input type="text" class="form-control" id="txtSoyadi" /></div>
                    </div>
                    <div class="row g-2 align-items-center mb-2">
                        <div class="col-5"><label class="col-form-label">Kullanıcı Adı</label></div>
                        <div class="col-7"><input type="text" class="form-control" id="txtYeniUser" /></div>
                    </div>
                    <div class="row g-2 align-items-center">
                        <div class="col-5"><label class="col-form-label">Şifre</label></div>
                        <div class="col-7"><input type="password" class="form-control" id="txtYeniPass" /></div>
                    </div>
                </div>
                <div class="modal-footer py-2">
                    <button type="button" class="btn btn-outline-gold" data-bs-dismiss="modal">İptal Et</button>

                    <asp:Button ID="btnUyeOl" runat="server"
                        Text="Üye ol"
                        CssClass="btn btn-gold"
                        UseSubmitBehavior="false"
                        OnClick="btnUyeOl_Click"
                        OnClientClick="closeUyeOl();" />
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL: SÖZLEŞME OKU -->
    <div class="modal fade" id="sozlesmeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header py-2">
                    <h6 class="modal-title">Sözleşme</h6>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Kapat"></button>
                </div>
                <div class="modal-body">
                    <p class="mb-0">
                        <strong>💎 Kullanıcı Sözleşmesi</strong><br /><br />
                        Bu site, FARHAT GOLD markasına ait olup, kullanıcılarına güvenli ve kaliteli altın ürünleri sunmayı amaçlar.
                        Siteye giren herkes aşağıdaki koşulları kabul eder:<br />
                        • Tüm içerik ve görseller FARHAT GOLD’a aittir. İzinsiz kopyalanamaz veya kullanılamaz.<br />
                        • Ürün fiyatları piyasa koşullarına göre değişebilir.<br />
                        • Sipariş bilgilerinin doğruluğundan kullanıcı sorumludur.<br />
                        • Altın ürünlerinde iade yalnızca üretim hatasında mümkündür.<br />
                        • Kullanıcı bilgileri gizli tutulur, üçüncü kişilerle paylaşılmaz.<br />
                        • Her türlü anlaşmazlık Türk Hukuku kapsamında çözülür.<br /><br />
                        📧 info@farhatgold.com
                    </p>
                </div>
                <div class="modal-footer py-2">
                    <button type="button" class="btn btn-gold" data-bs-dismiss="modal">Okudum</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // إغلاق مودال "Üye Ol" بعد الضغط على زر التسجيل
        function closeUyeOl() {
            const el = document.getElementById('uyeOlModal');
            const modal = bootstrap.Modal.getOrCreateInstance(el);
            modal.hide();
        }
    </script>

</form>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
