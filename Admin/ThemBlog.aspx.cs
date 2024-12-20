using Group2.Class;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group2.Admin
{
    public partial class ThemBlog : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                Group2.Class.Blog bg = new Group2.Class.Blog();
                bg.title = txtTitle.Text;
                bg.content = txtContent.Text;
                if (txtThumb.HasFile)
                {
                    bg.thumb = txtThumb.FileName;
                    string filePath = Server.MapPath("~/Image/Blog/" + txtThumb.FileName);
                    txtThumb.SaveAs(filePath);
                }
                else
                {
                    the.Text = "Vui lòng chọn một hình ảnh.";
                    return;
                }
                // Sử dụng DateTime.TryParseExact để đảm bảo định dạng ngày chính xác
                DateTime parsedDate;
                bool isDateValid = DateTime.TryParseExact(txtDate.Text, "yyyy/MM/dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out parsedDate);

                if (isDateValid)
                {
                    bg.date = parsedDate;
                }
                else
                {
                    throw new FormatException(" Định dạng ngày không hợp lệ. Vui lòng nhập ngày theo định dạng yyyy/MM/dd.");
                }
                bg.author = txtAuthor.Text;

                data.addBlog(bg);
                the.Text = "Thêm thành công";
            }
            catch (Exception ex)
            {

                the.Text = "Không thêm được" + ex.Message;
            }
        }

    }
}