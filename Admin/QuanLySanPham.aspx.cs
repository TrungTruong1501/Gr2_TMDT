using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Group2.Class;

namespace Group2.Admin
{
    public partial class QuanLySanPham : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hienthi();
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            hienthi();
        }

        public void hienthi()
        {
            GridView1.DataSource = data.getListProduct();
            DataBind();
        }
        protected void Xoa_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "xoa")
            {
                int b = Convert.ToInt16(e.CommandArgument);
                data.deleteProduct(b);
                hienthi();
            }
        }
        protected void Sua_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "sua")
            {
                int b = Convert.ToInt16(e.CommandArgument);
                Product d = data.getProductById(b);
                Session["sp"] = d;
                Response.Redirect("SuaSanPham.aspx");
            }
        }
        protected void btnTim_Click(object sender, EventArgs e)
        {
           
            string keyword = Txttimkiem.Text.Trim();
            GridView1.DataSource = data.searchProducts(keyword);
            GridView1.DataBind();
        }
    }
}