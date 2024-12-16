using Group2.Class;
using System;
using System.Drawing;
using System.Web.UI;

namespace Group2
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var customer = (User)Session["Customer"];
                lblAddress.Text = customer.Address;
                lblPhone.Text = customer.Phone;
                lblName.Text = customer.FirstName + " " + customer.LastName;
                lblAddress.Text = customer.Address;
                int orderId = (int)Session["OrderId"];
                Order order = data.getOrder(orderId);
                OrderRepeater.DataSource = data.getOrderItem(orderId);
                OrderRepeater.DataBind();
                lblTotal.Text = order.TotalPrice.ToString("N0");
                DDLPayment.DataSource = data.getListPayment();
                DDLPayment.DataTextField = "Name";
                DDLPayment.DataValueField = "Id";
                DDLPayment.DataBind();
            }
        }
        protected void btnPay_Click(object sender, EventArgs e)
        {
            var customer = (User)Session["Customer"];
            int orderId = (int)Session["OrderId"];
            int payment_id = Convert.ToInt32(DDLPayment.SelectedValue.ToString());
            data.CompleteOrder( orderId, customer.Id, payment_id, lblAddress.Text,lblPhone.Text);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Thanh toán thành công');", true);
            Response.Redirect("TrangChu.aspx");
        }

    }
}