using Group2.Class;
using System;

namespace Group2
{
    public partial class Blog : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                View();
            }
        }
        private void View()
        {
            DataList1.DataSource = data.getBlog();
            DataBind();
        }
    }
}