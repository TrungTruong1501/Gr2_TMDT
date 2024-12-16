using Group2.Class;
using System;

namespace Group2
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        public DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var customer = (User)Session["Customer"];
                int Id = customer.Id;
                wishlistProduct.DataSource = data.GetListWishlist(Id);
                wishlistProduct.DataBind();
                allProducts.DataSource = data.getListNewestProduct();
                allProducts.DataBind();
            }
        }
    }
}