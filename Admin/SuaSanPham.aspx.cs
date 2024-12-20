using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Group2.Class;

namespace Group2.Admin
{
    public partial class SuaSanPham : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Product d = (Product)Session["sp"];
                txtId.Text = d.Id.ToString();

                cbbCategoryId.DataSource = data.getListCategory();
                cbbCategoryId.DataTextField = "Name";
                cbbCategoryId.DataValueField = "CategoryId";
                DataBind();
                cbbCategoryId.SelectedValue = d.CategoryId.ToString();

                txtName.Text = d.Name;
                txtPrice.Text = d.Price.ToString();
                txtgioithieu.Text = d.Description;
                TxtSKU.Text = d.SKU.ToString();
                TxtSoLuong.Text = d.Stock.ToString();
                TxtImage.Text = d.Image;
            }
        }

        protected void btnSua_Click1(object sender, EventArgs e)
        {
            try
            {
                Product bo = new Product();
                bo.Id = int.Parse(txtId.Text);
                bo.CategoryId = int.Parse(cbbCategoryId.SelectedValue);
                bo.SKU = TxtSKU.Text;
                bo.Name = txtName.Text;
                bo.Price = int.Parse(txtPrice.Text);
                bo.Description = txtgioithieu.Text;
                bo.Stock = int.Parse(TxtSoLuong.Text);
                if (fuAnh.HasFile)
                {
                    string fileName = fuAnh.FileName;
                    fuAnh.SaveAs(Server.MapPath("~/Image/ProductImage/") + fileName);
                    bo.Image = fileName;
                }
                else
                {
                    bo.Image = TxtImage.Text;
                }

                data.updateProduct(bo);
                the.Text = "Cập nhật thành công! ";
                Response.Redirect("QuanLySanPham.aspx");
            }
            catch (Exception ex)
            {

                the.Text = "Không sửa được" + ex.Message;

            }
        }
    }
}