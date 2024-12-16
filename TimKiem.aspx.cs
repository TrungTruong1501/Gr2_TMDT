using Group2.Class;
using System;

namespace Group2
{
    public partial class TimKiem : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string keyword = Session["tukhoa"].ToString();
                searchResults.DataSource = data.searchProducts(keyword);
                searchResults.DataBind();
                allProducts.DataSource = data.getListNewestProduct();
                allProducts.DataBind();
                lblKeyword.Text = keyword;
            }
        }
    }
}