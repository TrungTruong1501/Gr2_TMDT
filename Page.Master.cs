using Group2.Class;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
namespace Group2
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetVisibility();
                CategoryRepeater.DataSource = data.getListCategory();
                CategoryRepeater.DataBind();

            }
        }
        private void SetVisibility()
        {
            var masterPageLogin = (HtmlControl)FindControl("MasterPageLogin");
            var masterPageAccount = (HtmlControl)FindControl("MasterPageAccount");
            var masterPageCart = (HtmlControl)FindControl("MasterPageCart");
            bool isUserLoggedIn = Group2.Class.Extension.ShowAccountOptions();

            if (masterPageLogin != null)
            {
                masterPageLogin.Visible = !isUserLoggedIn;
            }

            if (masterPageAccount != null)
            {
                masterPageAccount.Visible = isUserLoggedIn;
            }
            if (masterPageCart != null)
            {
                masterPageCart.Visible = isUserLoggedIn;
            }
        }

        protected void btnTim_Click(object sender, EventArgs e)
        {
            Session["tukhoa"] = Txttimkiem.Text;
            Response.Redirect("TimKiem.aspx");
        }

        protected void btn_Wishlist_Click(object sender, EventArgs e)
        {
            var customer = (User)Session["Customer"];
            if (customer != null)
            {
                Response.Redirect("YeuThich.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Bạn chưa đăng nhập');", true);
            }
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                HttpCookie cookie = new HttpCookie(".ASPXAUTH");
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }

            Response.Redirect("DangNhap.aspx");
        }
    }
}