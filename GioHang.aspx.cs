using Group2.Class;
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace Group2
{
    public partial class GioHang : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                View();
            }
        }
        protected void View()
        {
            var customer = (User)Session["Customer"];
            CartRepeater.DataSource = data.getCart(customer.Id);
            CartRepeater.DataBind();
        }
        protected void RemoveFromCart_Click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                int id = Convert.ToInt16(e.CommandArgument);
                data.removeCartItem(id);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                "alert('Xóa sản phẩm khỏi giỏ hàng thành công');", true);
                View();
            }
        }
        protected void CreateOrder_Click(object sender, EventArgs e)
        {
            var customer = (User)Session["Customer"];
            int orderId = data.CreateOrder(customer.Id);
            Session["OrderId"] = orderId;
            Response.Redirect("ThanhToan.aspx");
        }
    }
}
