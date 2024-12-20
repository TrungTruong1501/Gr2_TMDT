using Group2.Class;
using System;
using System.Globalization;

namespace Group2.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        public DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            int orderId = (int)Session["OrderId"];
            OrderRepeater.DataSource = data.getOrderItem(orderId);
            lblTotal.Text = data.getOrder(orderId).TotalPrice.ToString("N0", new CultureInfo("vi-VN"));
            OrderRepeater.DataBind();
        }
    }
}