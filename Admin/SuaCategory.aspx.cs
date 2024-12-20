using Group2.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group2.Admin
{
    public partial class SuaCategory : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Category d = (Category)Session["ct"];
                txtId.Text = d.CategoryId.ToString();
                txtCatename.Text = d.Name;
                txtAnh.Text = d.Image;
                DataBind();
            }
        }
        protected void btnSua_Click1(object sender, EventArgs e)
        {
            try
            {
                Category x = new Category();
                x.Name = txtCatename.Text;
                x.CategoryId = int.Parse(txtId.Text);
                x.Image = txtAnh.Text;

                if (fuAnh.HasFile)
                {
                    string fileName = fuAnh.FileName;
                    fuAnh.SaveAs(Server.MapPath("~/Image/ProductImage/") + fileName);
                    x.Image = fileName;
                }
                else
                {
                    x.Image = txtAnh.Text;
                }

                data.SuaCategory(x);
                the.Text = "Sửa thành công !";
                
            }
            catch (Exception e1)
            {
                the.Text = "Có lỗi xảy ra: " + e1.Message.ToString();
            }
        }

    }
}