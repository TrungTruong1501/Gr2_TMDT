using Group2.Class;
using System;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace Group2
{
    public partial class ChiTietSanPham : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        public int productId;
        public int colorId;
        public string anh;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            productId = int.Parse(Request.QueryString[0].ToString());
            Product product = data.getProductById(productId);
            ImageRepeater.DataSource = product.Gallery;
            ImageRepeater.DataBind();
            anhsp.ImageUrl = "~/Image/ProductImage/" + product.Image;
            LbName.Text = product.Name;
            lbPrice.Text = product.Price.ToString("N0", new CultureInfo("vi-VN"));
            LbdanhMuc.Text = data.getCategoryName(productId);
            lbQuantityStatus.Text = product.Stock.ToString();
            LbDescription.Text = product.Description;
            Repeater2.DataSource = data.GetListRelatedProduct(productId);
            Repeater2.DataBind();
            ColorRepeater.DataSource = data.getListColor(productId);
            ColorRepeater.DataBind();
            colorId = ViewState["ColorId"] != null ? (int)ViewState["ColorId"] : 0;
            if (!IsPostBack)
            {
                var customer = (User)Session["Customer"];
                if (customer != null)
                {
                    int customer_id = customer.Id;
                    if (!data.CheckWishlist(productId, customer_id))
                    {
                        btn_wishlist.BackColor = System.Drawing.Color.Gray;
                    }
                    else
                    {
                        btn_wishlist.BackColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    btn_wishlist.BackColor = System.Drawing.Color.Gray;
                }
            }
        }
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            var customer = (User)Session["Customer"];
            if (customer != null)
            {
            int customer_id = customer.Id;
            int quantity = Convert.ToInt32(txtOrderQuantity.Text.ToString());
            if (quantity < 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Số lượng không hợp lệ');", true);
            }
            else if (colorId == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Chưa chọn màu');", true);
            }
            else
            {
                data.addToCart(customer_id, productId, quantity, colorId);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Thêm thành công!');", true);
            }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Bạn chưa đăng nhập!');", true);
            }
        }
        protected void ColorLinkButton_Click(object sender, EventArgs e)
        {
            var button = sender as LinkButton;
            if (button != null)
            {
                int id = Convert.ToInt32(button.CommandArgument);
                colorId = id;
                string imageUrl = data.getImageUrlByColorId(id);
                anhsp.ImageUrl = $"./Image/ProductImage/{imageUrl}";
                ViewState["ColorId"] = colorId;
            }
        }

        protected void btn_wishlist_Click(object sender, EventArgs e)
        {
            var customer = (User)Session["Customer"];
            if (customer != null)
            {
                int customer_id = customer.Id;
                if (!data.CheckWishlist(productId, customer_id))
                {
                    data.AddWishlist(productId, customer_id);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Thêm sản phẩm yêu thích thành công');", true);
                }
                else
                {
                    data.RemoveWishlist(productId, customer_id);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Xóa sản phẩm khỏi mục yêu thích');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "message",
                    "alert('Bạn chưa đăng nhập');", true);
            }
        }
    }
}
