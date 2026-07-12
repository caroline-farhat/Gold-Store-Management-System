<%@ Page Title="Ana Sayfa" Language="C#"
    MasterPageFile="~/kullanici/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="default.aspx.cs"
    Inherits="WebApplication1.kullanici.Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --gold: #d4af37;
            --gold-2: #b58b1f;
            --bg-dark: #0a0a0a;
            --bg-panel: #121212;
        }

        /* خلفية الموقع بالكامل */
        body {
            background: var(--bg-dark) !important;
            color: #fff;
        }

        .page-wrap {
            padding: 18px 0;
        }

        /* الشريط الجانبي */
        .sidebar {
            width: 220px;
            border: 1.5px solid var(--gold);
            border-radius: 14px;
            padding: 14px;
            background: linear-gradient(180deg, #141414, #0a0a0a);
            box-shadow: 0 0 12px rgba(212, 175, 55, 0.2);
        }

        .side-menu .btn {
            width: 100%;
            text-align: left;
            border: 1px solid #2a2a2a;
            background: #0e0e0e;
            color: #eaeaea;
            padding: 0.6rem 0.75rem;
            margin-bottom: 10px;
            border-radius: 10px;
            transition: 0.3s;
        }

        .side-menu .btn:hover {
            color: var(--gold);
            border-color: var(--gold-2);
            background: #1a1a1a;
        }

        /* البطاقة (صندوق الجدول) */
        .card.gold {
            background: linear-gradient(180deg, #141414, #0c0c0c);
            border: 1px solid #222;
            border-radius: 14px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.6);
        }

        .card.gold .card-header {
            background: linear-gradient(180deg, rgba(212, 175, 55, 0.25), rgba(212, 175, 55, 0.05));
            color: var(--gold);
            border-bottom: 1px solid rgba(212, 175, 55, 0.25);
            border-top-left-radius: 14px;
            border-top-right-radius: 14px;
            font-weight: 600;
        }

        /* الجدول */
        .table-dark {
            --bs-table-bg: #0b0b0b;
            --bs-table-striped-bg: #121212;
            --bs-table-hover-bg: #1a1a1a;
            --bs-table-border-color: #2c2c2c;
        }

        .table-dark thead th {
        color: #ffffff !important; /* أبيض */
        border-bottom: 1px solid rgba(255, 255, 255, 0.2); /* خط فاتح خفيف */
        }

        }

        .table-dark td {
            color: #fff !important;
            border-color: rgba(255, 255, 255, 0.1);
        }

        .table-dark tbody tr:hover {
            background: #161616;
        }

        .page-title {
            font-size: 46px;
            font-weight: 700;
            color: var(--gold);
        }

        .work-row {
            gap: 18px;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid page-wrap">
        <div class="d-flex align-items-center mb-3">
            <div class="ms-auto">
            </div>
        </div>

        <div class="d-flex work-row">
            <!-- الشريط الجانبي -->
            <div class="sidebar">
                <div class="side-menu">
                    <a class="btn" href="~/kullanici/default.aspx" runat="server">Ana Sayfa</a>
                    <a class="btn" href="~/kullanici/kullanici.aspx" runat="server">Kullanıcı Ara</a>
                    <a class="btn" href="~/kullanici/urunler.aspx" runat="server">Ürünler</a>
                    <a class="btn" href="~/kullanici/kategori.aspx" runat="server">Kategoriler</a>
                    <a class="btn" href="~/kullanici/parametre.aspx" runat="server">Parametreler</a>
                    <a class="btn" href="~/kullanici/sistemLog.aspx" runat="server">Sistem Logları</a>
                </div>
            </div>

            <!-- الجدول -->
            <div class="flex-grow-1">
                <div class="card gold">
                    <div class="card-header">Stok Bilgileri</div>
                    <div class="card-body p-0">
                        <table class="table table-dark table-striped table-hover table-bordered mb-0 align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Ürün Adı</th>
                                    <th>Kategori</th>
                                    <th class="text-end">Adet</th>
                                    <th class="text-end">Fiyat (TL)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td>1</td><td>İtalyan Bilezik 22 Ayar</td><td>Bilezik</td><td class="text-end">8</td><td class="text-end">38.500</td></tr>
                                <tr><td>2</td><td>Burma Bilezik 22 Ayar</td><td>Bilezik</td><td class="text-end">5</td><td class="text-end">41.250</td></tr>
                                <tr><td>3</td><td>Kelepçe 22 Ayar</td><td>Bilezik</td><td class="text-end">6</td><td class="text-end">52.500</td></tr>
                                <tr><td>4</td><td>Baget Yüzük 14 Ayar</td><td>Yüzük</td><td class="text-end">12</td><td class="text-end">9.500</td></tr>
                                <tr><td>5</td><td>Tektaş Yüzük 14 Ayar</td><td>Yüzük</td><td class="text-end">15</td><td class="text-end">7.800</td></tr>
                                <tr><td>6</td><td>Top Küpe 14 Ayar</td><td>Küpe</td><td class="text-end">20</td><td class="text-end">5.200</td></tr>
                                <tr><td>7</td><td>Halka Küpe 14 Ayar</td><td>Küpe</td><td class="text-end">18</td><td class="text-end">6.400</td></tr>
                                <tr><td>8</td><td>Tuğralı Kolye 14 Ayar</td><td>Kolye</td><td class="text-end">7</td><td class="text-end">16.800</td></tr>
                                <tr><td>9</td><td>Minimal Kolye 8 Ayar</td><td>Kolye</td><td class="text-end">10</td><td class="text-end">7.200</td></tr>
                                <tr><td>10</td><td>Zincir 14 Ayar</td><td>Kolye</td><td class="text-end">9</td><td class="text-end">13.200</td></tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="3" class="text-end" style="color: var(--gold)">Toplam Adet</th>
                                    <th class="text-end" style="color: var(--gold)">110</th>
                                    <th></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
