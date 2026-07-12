using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.kullanici
{
    public partial class sistemLog : System.Web.UI.Page
    {
        class LogItem
        {
            public string LogAdi { get; set; }
            public string KullaniciAdi { get; set; }
            public DateTime Tarih { get; set; }
            public string Turu { get; set; }   // örn: Login, Logout, Insert, Update, Delete
            public string IP { get; set; }
            public string TarihText => Tarih.ToString("dd.MM.yyyy HH:mm");
        }

        List<LogItem> Logs
        {
            get
            {
                if (Session["Logs"] == null)
                {
                    Session["Logs"] = new List<LogItem>
                    {
                        new LogItem{ LogAdi="Login Başarılı",  KullaniciAdi="Duha Sallat", Tarih=DateTime.Today.AddHours(9),  Turu="Login",  IP="192.168.1.10"},
                        new LogItem{ LogAdi="Ürün Ekleme",     KullaniciAdi="ersin.ersoy",Tarih=DateTime.Today.AddHours(10), Turu="Insert", IP="192.168.1.21"},
                        new LogItem{ LogAdi="Kategori Güncelle",KullaniciAdi="ayse.demir", Tarih=DateTime.Today.AddDays(-1).AddHours(14), Turu="Update", IP="192.168.1.22"},
                        new LogItem{ LogAdi="Kullanıcı Silme", KullaniciAdi="mehmet.kaya",Tarih=DateTime.Today.AddDays(-2).AddHours(16), Turu="Delete", IP="192.168.1.23"},
                        new LogItem{ LogAdi="Logout",          KullaniciAdi="Caroline Farhat",    Tarih=DateTime.Today.AddHours(18), Turu="Logout", IP="192.168.1.10"},
                    };
                }
                return (List<LogItem>)Session["Logs"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid(Logs);
        }

        void BindGrid(IEnumerable<LogItem> list)
        {
            GvLogs.DataSource = list.ToList();
            GvLogs.DataBind();
        }

        protected void BtnAra_Click(object sender, EventArgs e)
        {
            var q = (TxtAra.Text ?? "").Trim().ToLower();

            DateTime? bas = ParseDate(TxtBaslangic.Text);
            DateTime? bit = ParseDate(TxtBitis.Text);
            if (bit.HasValue) bit = bit.Value.Date.AddDays(1).AddTicks(-1); // نهاية اليوم

            var filtered = Logs.Where(l =>
                   (string.IsNullOrEmpty(q) || (l.LogAdi ?? "").ToLower().Contains(q))
                && (!bas.HasValue || l.Tarih >= bas.Value)
                && (!bit.HasValue || l.Tarih <= bit.Value)
            );

            BindGrid(filtered);
        }

        DateTime? ParseDate(string s)
        {
            if (DateTime.TryParse(s, out var d)) return d.Date;
            return null;
        }
    }
}