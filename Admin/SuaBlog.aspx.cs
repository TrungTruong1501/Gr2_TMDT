using Group2.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group2.Admin
{
    public partial class SuaBlog : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Group2.Class.Blog bg = (Group2.Class.Blog)Session["us"];
                txtId.Text = bg.id.ToString();
                txtTitle.Text = bg.title;
                txtContent.Text = bg.content;
                txtThumb.Text = bg.thumb;
                txtDate.Text = bg.date.ToString();
                txtAuthor.Text = bg.author;
                DataBind();
            }

        }
        protected void btnSua_Click1(object sender, EventArgs e)
        {
            try
            {
                Group2.Class.Blog bg = new Group2.Class.Blog();
                bg.id = int.Parse(txtId.Text);
                bg.title = txtTitle.Text;
                bg.content = txtContent.Text;
                if (fuAnh.HasFile)
                {
                    string fileName = fuAnh.FileName;
                    fuAnh.SaveAs(Server.MapPath("~/Image/ProductImage/") + fileName);
                    bg.thumb = fileName;
                    
                }
                else
                {
                    bg.thumb = txtThumb.Text;
                }
                bg.date = Convert.ToDateTime(txtDate.Text);
                bg.author = txtAuthor.Text;
                data.updateBlog(bg);
                the.Text = "Sửa thành công !";
                Response.Redirect(url: "QuanLyBlog.aspx");
            }
            catch (Exception ex)
            {

                the.Text = "Something wrong: " + ex.Message.ToString();
            }
        }
    }
}