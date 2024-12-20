using Group2.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group2.Admin
{
    public partial class ThemCategory : System.Web.UI.Page
    {

        DataUtil da = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            //cbbCategoryId.DataSource = da.au();
            //cbbCategoryId.DataTextField = "Name";
            //cbbCategoryId.DataValueField = "CategoryId";
           

            DataBind();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                Category bo = new Category();
                //bo.maDT = int.Parse(txtmaDT.Text);

                bo.Name = txtCatename.Text;
                bo.Image = txtAnh.FileName;
                da.AddCategory(bo);
                the.Text = "thêm thành công";
            }
            catch (Exception ex)
            {

                the.Text = "không thêm được" + ex.Message;
            }

        }
    }
}