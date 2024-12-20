using Group2.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group2.Admin
{
    public partial class HomeAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                QuanTri master = (QuanTri)this.Master;
                if (master != null && Session["Admin"] != null)
                {
                    User user = (User)Session["Admin"];
                    master.Name = user.LastName;
                    master.FullName = user.FirstName + " " + user.LastName;
                }
            }
        }
    }
}