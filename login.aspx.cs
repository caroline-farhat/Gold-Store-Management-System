using System;
using System.Web.UI;

namespace WebApplication1
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            var user = TxtUser.Text.Trim();
            var pass = TxtPass.Text.Trim();

            if (user == "caroline" && pass == "12345")
            {
                Session["UserName"] = user;
                Response.Redirect("~/kullanici/default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                LblError.Text = "Kullanıcı adı veya şifre hatalı";
            }

        }
        // زر التسجيل (Üye Ol)
        protected void btnUyeOl_Click(object sender, EventArgs e)
        {
            // هون تقدر لاحقاً تضيفي كود التسجيل الحقيقي (تخزين البيانات بقاعدة بيانات)
            // حالياً خلينا فقط نجلب البيانات من الـ Modal لتجربة الزر
            string ad = Request.Form["txtAdi"];
            string soyad = Request.Form["txtSoyadi"];
            string user = Request.Form["txtYeniUser"];
            string pass = Request.Form["txtYeniPass"];

            // بعد ما يخلص التسجيل، نسكر الـ modal
            ScriptManager.RegisterStartupScript(this, GetType(), "hideUyeOl",
                "bootstrap.Modal.getOrCreateInstance(document.getElementById('uyeOlModal')).hide();",
                true);
        }
    }
}
    
