using System;

namespace Group2.Admin
{
    public partial class QuanTri : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public string FullName
        {
            get { return lbAdminFullName.Text; }
            set { lbAdminFullName.Text = value; }
        }
        public string Name
        {
            get { return lbAdminName.Text; }
            set { lbAdminName.Text = value; }
        }
    }
}