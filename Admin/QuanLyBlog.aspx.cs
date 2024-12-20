using Group2.Class;
using System;
using System.Web.UI.WebControls;

namespace Group2.Admin
{
    public partial class QuanLyBlog : System.Web.UI.Page
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
            BlogGridView.PageIndex = e.NewPageIndex;
            hienthi();
        }
        private void hienthi()
        {
            BlogGridView.DataSource = data.getBlog();
            DataBind();
        }
        protected void Xoa_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "xoa")
            {
                int b = Convert.ToInt16(e.CommandArgument);
                data.delBlog(b);
                hienthi();
            }
        }
        protected void Sua_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "sua")
            {
                int b = Convert.ToInt16(e.CommandArgument);
                Group2.Class.Blog d = data.getBlogById(b);
                Session["us"] = d;
                Response.Redirect("SuaBlog.aspx");
            }
        }
    }
}