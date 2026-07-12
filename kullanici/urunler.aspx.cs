using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.kullanici
{
    public partial class urunler : System.Web.UI.Page
    {
        class Urun
        {
            public int Id { get; set; }
            public int KategoriId { get; set; }
            public string KategoriAd { get; set; }
            public string UrunAdi { get; set; }
            public int StokAdet { get; set; }
            public decimal BirimFiyat { get; set; }
            public string Not { get; set; }
            public DateTime KayitTarihi { get; set; }
            public string KayitTarihiText => KayitTarihi.ToString("dd.MM.yyyy");
            public string BirimFiyatText => BirimFiyat.ToString("N0");
        }

        List<KeyValuePair<int, string>> Kategoriler
        {
            get
            {
                // أمثلة: ذهب (بيلزيك/يوزوك/كولي)/مواد مستهلكة
                return new List<KeyValuePair<int, string>> {
                    new KeyValuePair<int,string>(1,"Bilezik"),
                    new KeyValuePair<int,string>(2,"Yüzük"),
                    new KeyValuePair<int,string>(3,"Küpe"),
                    new KeyValuePair<int,string>(4,"Kolye"),
                    new KeyValuePair<int,string>(5,"Sarf Malzeme"),
                };
            }
        }

        List<Urun> Urunler
        {
            get
            {
                if (Session["Urunler"] == null)
                {
                    Session["Urunler"] = new List<Urun>
{
    // Bilezik
    new Urun{ Id=1,  KategoriId=1, KategoriAd="Bilezik",
              UrunAdi="İtalyan Bilezik 22 Ayar", StokAdet=8,  BirimFiyat=38500, Not="-",
              KayitTarihi=new DateTime(2025,1,15) },

    new Urun{ Id=2,  KategoriId=1, KategoriAd="Bilezik",
              UrunAdi="Burma Bilezik 22 Ayar",   StokAdet=5,  BirimFiyat=41250, Not="-",
              KayitTarihi=new DateTime(2025,1,20) },

    new Urun{ Id=3,  KategoriId=1, KategoriAd="Bilezik",
              UrunAdi="Kelepçe 22 Ayar",         StokAdet=6,  BirimFiyat=52500, Not="-",
              KayitTarihi=new DateTime(2025,1,25) },

    // Yüzük
    new Urun{ Id=4,  KategoriId=2, KategoriAd="Yüzük",
              UrunAdi="Baget Yüzük 14 Ayar",     StokAdet=12, BirimFiyat=9500,  Not="-",
              KayitTarihi=new DateTime(2025,2,1) },

    new Urun{ Id=5,  KategoriId=2, KategoriAd="Yüzük",
              UrunAdi="Tektaş Yüzük 14 Ayar",    StokAdet=15, BirimFiyat=7800,  Not="-",
              KayitTarihi=new DateTime(2025,2,3) },

    // Küpe
    new Urun{ Id=6,  KategoriId=3, KategoriAd="Küpe",
              UrunAdi="Top Küpe 14 Ayar",        StokAdet=20, BirimFiyat=5200,  Not="-",
              KayitTarihi=new DateTime(2025,2,5) },

    new Urun{ Id=7,  KategoriId=3, KategoriAd="Küpe",
              UrunAdi="Halka Küpe 14 Ayar",      StokAdet=18, BirimFiyat=6400,  Not="-",
              KayitTarihi=new DateTime(2025,2,6) },

    // Kolye
    new Urun{ Id=8,  KategoriId=4, KategoriAd="Kolye",
              UrunAdi="Tuğralı Kolye 14 Ayar",   StokAdet=7,  BirimFiyat=16800, Not="-",
              KayitTarihi=new DateTime(2025,2,8) },

    new Urun{ Id=9,  KategoriId=4, KategoriAd="Kolye",
              UrunAdi="Minimal Kolye 8 Ayar",    StokAdet=10, BirimFiyat=7200,  Not="-",
              KayitTarihi=new DateTime(2025,2,10) },

    new Urun{ Id=10, KategoriId=4, KategoriAd="Kolye",
              UrunAdi="Zincir 14 Ayar",          StokAdet=9,  BirimFiyat=13200, Not="-",
              KayitTarihi=new DateTime(2025,2,12) },
};

                }
                return (List<Urun>)Session["Urunler"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindKategori();
                BindGrid(Urunler);
            }
        }

        void BindKategori()
        {
            DdlKategori.DataSource = Kategoriler;
            DdlKategori.DataTextField = "Value";
            DdlKategori.DataValueField = "Key";
            DdlKategori.DataBind();
            DdlKategori.Items.Insert(0, new ListItem("Kategori Seç", "0"));
        }

        void BindGrid(IEnumerable<Urun> list)
        {
            GvUrunler.DataSource = list.ToList();
            GvUrunler.DataBind();
        }

        protected void BtnAra_Click(object sender, EventArgs e)
        {
            var q = (TxtAra.Text ?? "").Trim().ToLower();
            var filtered = string.IsNullOrEmpty(q)
                ? Urunler
                : Urunler.Where(u => (u.UrunAdi ?? "").ToLower().Contains(q)).ToList();
            BindGrid(filtered);
        }

        protected void BtnUrunEkle_Click(object sender, EventArgs e)
        {
            // وضع إضافة: تفريغ الحقول
            HfSelectedId.Value = "";
            BindKategori();
            TxtUrunAdi.Text = "";
            TxtStok.Text = "";
            TxtBirimFiyat.Text = "";
            TxtNot.Text = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "showDetay", "showDetay();", true);
        }

        protected void GvUrunler_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "detay" && e.CommandName != "sil") return;

            int rowIndex = Convert.ToInt32(e.CommandArgument);
            int id = Convert.ToInt32(GvUrunler.DataKeys[rowIndex].Value);
            HfSelectedId.Value = id.ToString();

            if (e.CommandName == "detay")
            {
                var urun = Urunler.FirstOrDefault(x => x.Id == id);
                if (urun != null)
                {
                    BindKategori();
                    DdlKategori.SelectedValue = urun.KategoriId.ToString();
                    TxtUrunAdi.Text = urun.UrunAdi;
                    TxtStok.Text = urun.StokAdet.ToString();
                    TxtBirimFiyat.Text = urun.BirimFiyat.ToString();
                    TxtNot.Text = urun.Not;
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "showDetay", "showDetay();", true);
            }
            else if (e.CommandName == "sil")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showSil", "showSil();", true);
            }
        }

        protected void BtnKaydet_Click(object sender, EventArgs e)
        {
            int.TryParse(DdlKategori.SelectedValue, out var katId);
            string katAd = Kategoriler.FirstOrDefault(k => k.Key == katId).Value ?? "";

            int.TryParse(TxtStok.Text.Trim(), out var stok);
            decimal.TryParse(TxtBirimFiyat.Text.Trim(), out var fiyat);

            if (int.TryParse(HfSelectedId.Value, out var id) && id > 0)
            {
                // تحديث
                var u = Urunler.FirstOrDefault(x => x.Id == id);
                if (u != null)
                {
                    u.KategoriId = katId;
                    u.KategoriAd = katAd;
                    u.UrunAdi = TxtUrunAdi.Text.Trim();
                    u.StokAdet = stok;
                    u.BirimFiyat = fiyat;
                    u.Not = TxtNot.Text.Trim();
                }
            }
            else
            {
                // إضافة
                int newId = (Urunler.Count == 0) ? 1 : Urunler.Max(x => x.Id) + 1;
                Urunler.Add(new Urun
                {
                    Id = newId,
                    KategoriId = katId,
                    KategoriAd = katAd,
                    UrunAdi = TxtUrunAdi.Text.Trim(),
                    StokAdet = stok,
                    BirimFiyat = fiyat,
                    Not = TxtNot.Text.Trim(),
                    KayitTarihi = DateTime.Today
                });
            }

            BindGrid(Urunler);
            ScriptManager.RegisterStartupScript(this, GetType(), "hideDetay", "hideDetay();", true);
        }

        protected void BtnSilOnay_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(HfSelectedId.Value, out var id)) return;
            var u = Urunler.FirstOrDefault(x => x.Id == id);
            if (u != null) Urunler.Remove(u);
            BindGrid(Urunler);
            ScriptManager.RegisterStartupScript(this, GetType(), "hideSil", "hideSil();", true);
        }
    }
}