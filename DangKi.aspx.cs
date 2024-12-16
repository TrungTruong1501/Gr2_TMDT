using Group2.Class;
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
namespace Group2
{
    public partial class DangKi : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
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
            DataBind();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            // Kiểm tra xác nhận mật khẩu
            if (txtPassword.Text == txtConfirmPassword.Text)
            {
                User user = new User();
                user.Username = txtUsername.Text;
                user.Email = txtEmail.Text;
                user.Address = txtAddress.Text;
                user.Phone = txtPhone.Text;
                user.Password = txtPassword.Text;
                user.Permission = 0;

                if (!data.checkUsername(user.Username))
                {
                    try
                    {
                        data.addUser(user);
                        Response.Redirect("DangNhap.aspx");
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                        "alert('Không đăng kí được ');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                        "alert('Tên đăng nhập đã tồn tại');", true);
                }
            }
            else
            {
                // Hiển thị thông báo lỗi nếu mật khẩu và xác nhận mật khẩu không khớp nhau
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Mật khẩu và xác nhận mật khẩu không khớp.');", true);
            }
        }

    }
}