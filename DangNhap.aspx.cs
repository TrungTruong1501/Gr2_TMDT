using Group2.Class;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace Group2
{
    public partial class DangNhap : System.Web.UI.Page
    {
        public DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            var masterPageAccount = (HtmlControl)Master.FindControl("MasterPageAccount");
            if (masterPageAccount != null)
            {
                masterPageAccount.Attributes["class"] = "hidden"; 
            }
            var masterPageLogin = (HtmlControl)Master.FindControl("MasterPageLogin");
            if (masterPageLogin != null)
            {
                masterPageLogin.Attributes["class"] = "";
            }
            lbID.Visible = true;
            txtUsername.Attributes.Add("placeholder", "Tên tài khoản");
            txtPassword.Attributes.Add("placeholder", "Mật khẩu");
            lbMessage.Visible = false;
        }
        

        protected void btnlogin_Click(object sender, EventArgs e)
        {
            User user = data.checkUser(txtUsername.Text, txtPassword.Text);
            if (user != null)
            {
                if (user.Permission == 1)
                {
                    Session["Admin"] = user;
                    Response.Redirect("~/Admin/HomeAdmin.aspx");
                }
                else if (user.Permission == 0)
                {
                    Session["Customer"] = user;
                    HttpCookie returnCookie = Request.Cookies["returnUrl"];
                    if ((returnCookie == null) || string.IsNullOrEmpty(returnCookie.Value))
                    {
                        Response.Redirect("TrangChu.aspx");
                    }
                    else
                    {
                        HttpCookie deleteCookie = new HttpCookie("returnUrl");
                        deleteCookie.Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies.Add(deleteCookie);
                        Response.Redirect(returnCookie.Value);
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Sai tên tài khoản hoặc mật khẩu');", true);
            }
        }
    }
}