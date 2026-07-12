using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.kullanici
{
    public partial class parametre : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // نحفظ/نقرأ نصّ السوزليشمي من Session لسهولة التجربة
                if (Session["SozlesmeText"] == null)
                {
                    Session["SozlesmeText"] =
@"💎 Kullanıcı Sözleşmesi

Bu site, FARHAT GOLD markasına ait olup, kullanıcılarına güvenli ve kaliteli altın ürünleri sunmayı amaçlar.
Siteye giren herkes aşağıdaki koşulları kabul eder:
Tüm içerik ve görseller FARHAT GOLD’a aittir. İzinsiz kopyalanamaz veya kullanılamaz.
Ürün fiyatları piyasa koşullarına göre değişebilir.
Sipariş bilgilerinin doğruluğundan kullanıcı sorumludur.
Altın ürünlerinde iade yalnızca üretim hatasında mümkündür.
Kullanıcı bilgileri gizli tutulur, üçüncü kişilerle paylaşılmaz.
Her türlü anlaşmazlık Türk Hukuku kapsamında çözülür.

📧 info@farhatgold.com";
                }
                TxtSozlesme.Text = Session["SozlesmeText"].ToString();
            }
        }

        protected void BtnGuncelle_Click(object sender, EventArgs e)
        {
            // حفظ النصّ المُحدَّث
            Session["SozlesmeText"] = TxtSozlesme.Text;
            // إخفاء المودال بعد الحفظ (تماماً كالموكاب)
            ScriptManager.RegisterStartupScript(this, GetType(), "hideSoz",
                "hideSozlesme();", true);
        }
    }
}