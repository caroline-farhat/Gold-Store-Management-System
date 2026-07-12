using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.kullanici
{
    public partial class Kategori : System.Web.UI.Page
    {
        // موديل بسيط
        class Kat
        {
            public int Id { get; set; }
            public string KategoriAdi { get; set; }
            public string Not { get; set; }
            public DateTime KayitTarihi { get; set; }
            public string KayitTarihiText { get { return KayitTarihi.ToString("dd.MM.yyyy"); } }
        }

        // التخزين بالـ Session
        List<Kat> Kategoriler
        {
            get
            {
                if (Session["Kategoriler"] == null)
                {
                    Session["Kategoriler"] = new List<Kat>
                    {
                        new Kat{ Id=1, KategoriAdi="Sarf Malzemesi", Not="Son kullanma tarihi olmayan ürün",
                                 KayitTarihi=new DateTime(2025,1,2) }
                    };
                }
                return (List<Kat>)Session["Kategoriler"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid(Kategoriler);
        }

        void BindGrid(IEnumerable<Kat> list)
        {
            GvKategoriler.DataSource = list.ToList();
            GvKategoriler.DataBind();
        }

        protected void BtnAra_Click(object sender, EventArgs e)
        {
            var q = (TxtAra.Text ?? "").Trim().ToLower();
            var list = Kategoriler;
            var filtered = string.IsNullOrEmpty(q) ? list : list.Where(k => (k.KategoriAdi ?? "").ToLower().Contains(q)).ToList();
            GvKategoriler.DataSource = filtered;
            GvKategoriler.DataBind();
        }

        protected void GvKategoriler_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "detay" && e.CommandName != "sil") return;

            int rowIndex = Convert.ToInt32(e.CommandArgument);
            int id = Convert.ToInt32(GvKategoriler.DataKeys[rowIndex].Value);
            HfSelectedId.Value = id.ToString();

            if (e.CommandName == "detay")
            {
                var k = Kategoriler.FirstOrDefault(x => x.Id == id);
                if (k != null)
                {
                    TxtDetayKategori.Text = k.KategoriAdi;
                    TxtDetayNot.Text = k.Not;
                    // عنوان المودال للتحديث
                    ScriptManager.RegisterStartupScript(this, GetType(), "setTitle",
                        "document.getElementById('modalTitle').innerText='Kategori Güncelle';", true);
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "showDetay", "showDetay();", true);
            }
            else if (e.CommandName == "sil")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showSil", "showSil();", true);
            }
        }

        // إضافة/تحديث
        protected void BtnKaydet_Click(object sender, EventArgs e)
        {
            int id = 0;
            int.TryParse(HfSelectedId.Value, out id);

            if (id == 0)
            {
                // إضافة
                var nextId = (Kategoriler.Count == 0) ? 1 : Kategoriler.Max(x => x.Id) + 1;
                Kategoriler.Add(new Kat
                {
                    Id = nextId,
                    KategoriAdi = TxtDetayKategori.Text.Trim(),
                    Not = TxtDetayNot.Text.Trim(),
                    KayitTarihi = DateTime.Today
                });
            }
            else
            {
                // تحديث
                var k = Kategoriler.FirstOrDefault(x => x.Id == id);
                if (k != null)
                {
                    k.KategoriAdi = TxtDetayKategori.Text.Trim();
                    k.Not = TxtDetayNot.Text.Trim();
                }
            }

            BindGrid(Kategoriler);
            ScriptManager.RegisterStartupScript(this, GetType(), "hideDetay", "hideDetay();", true);
        }

        protected void BtnSilOnay_Click(object sender, EventArgs e)
        {
            int id;
            if (!int.TryParse(HfSelectedId.Value, out id)) return;

            var k = Kategoriler.FirstOrDefault(x => x.Id == id);
            if (k != null) Kategoriler.Remove(k);

            BindGrid(Kategoriler);
            ScriptManager.RegisterStartupScript(this, GetType(), "hideSil", "hideSil();", true);
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (GvKategoriler.HeaderRow != null)
                GvKategoriler.HeaderRow.TableSection = System.Web.UI.WebControls.TableRowSection.TableHeader;
        }

    }
}

