using Group2.Class;
using System;
using System.Web.UI.WebControls;

namespace Group2.Admin
{
    public partial class QuanlyCategory : System.Web.UI.Page
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
            CateGridView.PageIndex = e.NewPageIndex;
            hienthi();
        }
        public void hienthi()
        {
            CateGridView.DataSource = data.getListCategory();
            DataBind();
        }
        protected void Xoa_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "xoa")
            {
                int categoryId = Convert.ToInt16(e.CommandArgument);
                string message;
                bool result = data.DeleteCategoryById(categoryId, out message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);
                //lblMessage.Text = message;
                if (result)
                {
                    hienthi();
                }
            }
        }
        protected void Sua_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "sua")
            {
                int b = Convert.ToInt16(e.CommandArgument);
                Category d = data.GetCategoryById(b);
                Session["ct"] = d;
                Response.Redirect("SuaCategory.aspx");
            }
        }
    }
}