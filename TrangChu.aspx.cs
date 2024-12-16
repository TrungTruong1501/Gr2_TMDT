using Group2.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;   
using System.Web.UI.WebControls;

namespace Group2
{
    public partial class TrangChu : System.Web.UI.Page
    {
        public DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Giá trị cho DropDownList ddlPriceFrom
                ddlPriceFrom.Items.Add(new ListItem("0", "0"));
                ddlPriceFrom.Items.Add(new ListItem("100.000", "100000"));
                ddlPriceFrom.Items.Add(new ListItem("200.000", "200000"));
                ddlPriceFrom.Items.Add(new ListItem("300.000", "300000"));
                ddlPriceFrom.Items.Add(new ListItem("400.000", "400000"));

                // Giá trị cho DropDownList ddlPriceTo
                ddlPriceTo.Items.Add(new ListItem("100.000", "100000"));
                ddlPriceTo.Items.Add(new ListItem("200.000", "200000"));
                ddlPriceTo.Items.Add(new ListItem("300.000", "300000"));
                ddlPriceTo.Items.Add(new ListItem("400.000", "400000"));
                ddlPriceTo.Items.Add(new ListItem("500.000", "500000"));

                if (Request.QueryString["CategoryId"] != null)
                {
                    int categoryId;
                    if (int.TryParse(Request.QueryString["CategoryId"], out categoryId))
                    {
                        showProductByCategory(categoryId);
                    }
                }
                else
                {
                    showProduct();
                }
                ShowBlog();
                data.DeletePendingOrders();
            }
        }
        private void ShowBlog()
        {
            DataList1.DataSource = data.getBlog();
            DataBind();
        }
        private void showProduct()
        {
            List<Tuple<Product, int>> result = data.getListHotSaleProduct();
            AllProduct.DataSource = result.Select(t => t.Item1).ToList(); ;
            AllProduct.DataBind();
            NewestProduct.DataSource = data.getListNewestProduct();
            NewestProduct.DataBind();
        }
        private void showProductByCategory(int id)
        {
            AllProduct.DataSource = data.getListProductByCategory(id);
            AllProduct.DataBind();
            NewestProduct.DataSource = data.getListNewestProductByCategory(id);
            NewestProduct.DataBind();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int priceFrom = int.Parse(ddlPriceFrom.SelectedValue);
            int priceTo = int.Parse(ddlPriceTo.SelectedValue);

            if (priceFrom > priceTo)
            {
                return;
            }
            else
            {

                AllProduct.DataSource = data.getProductByPrice(priceFrom, priceTo);
                AllProduct.DataBind();
            }
        }

    }
}