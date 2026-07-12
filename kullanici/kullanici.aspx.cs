using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace WebApplication1.kullanici
{
    public partial class Kullanici : System.Web.UI.Page
    {
        class Uye
        {
            public int Id { get; set; }
            public string Ad { get; set; }
            public string Soyad { get; set; }
            public string KullaniciAdi { get; set; }
            public string Sifre { get; set; }
            public DateTime KayitTarihi { get; set; }
            public string AdSoyad => $"{Ad} {Soyad}".Trim();
            public string KayitTarihiText => KayitTarihi.ToString("dd.MM.yyyy");
        }

        List<Uye> Users
        {
            get
            {
                if (Session["Users"] == null)
                {
                    Session["Users"] = new List<Uye>
                    {
                        new Uye{ Id=1, Ad="Ersin",  Soyad="ERSOY", KullaniciAdi="ersin.ersoy", Sifre="124567", KayitTarihi=new DateTime(2025,1,1)},
                        new Uye{ Id=2, Ad="Ayşe",   Soyad="DEMİR", KullaniciAdi="ayse.demir",  Sifre="sldna", KayitTarihi=DateTime.Today.AddDays(-15)},
                        new Uye{ Id=3, Ad="Mehmet", Soyad="KAYA",  KullaniciAdi="mehmet.kaya", Sifre="jsjnj123", KayitTarihi=DateTime.Today.AddDays(-30)},
                    };
                }
                return (List<Uye>)Session["Users"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid(Users);
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            TxtAra.Attributes["autocomplete"] = "off";          
            TxtAra.Attributes["autocapitalize"] = "off";
            TxtAra.Attributes["autocorrect"] = "off";
            TxtAra.Attributes["spellcheck"] = "false";
            TxtAra.Attributes["type"] = "search";
            TxtAra.Attributes["name"] = "q";
        }
        void BindGrid(IEnumerable<Uye> list)
        {
            GvUsers.DataSource = list.ToList();
            GvUsers.DataBind();
        }

        protected void BtnAra_Click(object sender, EventArgs e)
        {
            var q = (TxtAra.Text ?? "").Trim().ToLower();
            var filtered = string.IsNullOrEmpty(q)
                ? Users
                : Users.Where(u => (u.AdSoyad ?? "").ToLower().Contains(q)).ToList();
            BindGrid(filtered);
        }

        protected void GvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName != "detay" && e.CommandName != "sil") return;

            int rowIndex = Convert.ToInt32(e.CommandArgument);
            int id = Convert.ToInt32(GvUsers.DataKeys[rowIndex].Value);
            HfSelectedId.Value = id.ToString();

            if (e.CommandName == "detay")
            {
                var u = Users.FirstOrDefault(x => x.Id == id);
                if (u != null)
                {
                    TxtDetayAd.Text = u.Ad;
                    TxtDetaySoyad.Text = u.Soyad;
                    TxtDetayKullanici.Text = u.KullaniciAdi;

                    // مهم: WebForms ما بيحقن قيمة الـ Password تلقائياً
                    TxtDetaySifre.Text = u.Sifre;                  // اختياري
                    TxtDetaySifre.Attributes["value"] = u.Sifre;   // الضرورية
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "showDetay", "showDetay();", true);
            }
            else if (e.CommandName == "sil")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showSil", "showSil();", true);
            }
        }

        protected void BtnGuncelle_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(HfSelectedId.Value, out var id)) return;
            var u = Users.FirstOrDefault(x => x.Id == id);
            if (u != null)
            {
                u.Ad = TxtDetayAd.Text.Trim();
                u.Soyad = TxtDetaySoyad.Text.Trim();
                u.KullaniciAdi = TxtDetayKullanici.Text.Trim();
                var sifre = Request.Form[TxtDetaySifre.UniqueID];
                u.Sifre = (sifre ?? "").Trim();
            }
            BindGrid(Users);
            ScriptManager.RegisterStartupScript(this, GetType(), "hideDetay", "hideDetay();", true);
        }

        protected void BtnSilOnay_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(HfSelectedId.Value, out var id)) return;
            var u = Users.FirstOrDefault(x => x.Id == id);
            if (u != null) Users.Remove(u);
            BindGrid(Users);
            ScriptManager.RegisterStartupScript(this, GetType(), "hideSil", "hideSil();", true);
        }
    }
}
