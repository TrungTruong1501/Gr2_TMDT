using Group2.Class;
using System;
using System.Web.UI.WebControls;

namespace Group2.Admin
{
    public partial class QuanLyUsers : System.Web.UI.Page
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
            UserGridView.PageIndex = e.NewPageIndex;
            hienthi();
        }
        public void hienthi()
        {
            UserGridView.DataSource = data.getListUser();
            DataBind();
        }
        protected void Xoa_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "xoa")
            {
                int b = Convert.ToInt16(e.CommandArgument);
                data.DeleteUser(b);
                hienthi();
            }
        }
        protected void Sua_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "sua")
            {
                int b = Convert.ToInt16(e.CommandArgument);
                User d = data.GetUserById(b);
                Session["us"] = d;
                Response.Redirect("SuaUsers.aspx");
            }
        }
    }
}