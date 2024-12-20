using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Group2.Class;
namespace Group2.Admin
{
    public partial class ThemUsers : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtUsername.Text) || string.IsNullOrEmpty(txtPassword.Text))
                {
                    the.Text = "Email, Username và Password không được để trống.";
                    return;
                }

                User user = new User();
                user.FirstName = !string.IsNullOrEmpty(txtFirst.Text) ? txtFirst.Text : null;
                user.LastName = !string.IsNullOrEmpty(txtLast.Text) ? txtLast.Text : null;
                user.Email = txtEmail.Text;
                user.Username = txtUsername.Text;
                user.Password = txtPassword.Text;
                user.Address = !string.IsNullOrEmpty(txtAddress.Text) ? txtAddress.Text : null;
                user.Phone = !string.IsNullOrEmpty(txtPhone.Text) ? txtPhone.Text : null;
                string Permission = ddlPermission.SelectedValue;
                if (Permission == "1")
                {
                    user.Permission = Convert.ToByte(1);
                }
                else if (Permission == "0")
                {
                    user.Permission = Convert.ToByte(0);
                };

                data.addUser(user);
                the.Text = "Thêm thành công";

                // Clear input
                txtFirst.Text = "";
                txtLast.Text = "";
                txtEmail.Text = "";
                txtUsername.Text = "";
                txtPassword.Text = "";
                txtAddress.Text = "";
                txtPhone.Text = "";
                ddlPermission.SelectedIndex = 0;

            }
            catch (Exception ex)
            {

                the.Text = "Không thêm được " + ex.Message;
            }

        }
    }
}