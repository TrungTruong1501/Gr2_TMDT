using Group2.Class;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Group2
{
    public partial class My_Account : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var user = (User)Session["Customer"];
                labName.Text = $"{user.FirstName} {user.LastName}";
                labAddress.Text = user.Address;
                labEmail.Text = user.Email;
                labPhone.Text = user.Phone;
                BindOrderData(user.Id);
                txtFirst.Text = user.FirstName ?? string.Empty;
                txtLast.Text = user.LastName ?? string.Empty;
                txtEmail.Text = user.Email;
                txtCurrentPassword.Text = user.Password;
                txtPhone.Text = user.Phone ?? string.Empty;
                txtAddress.Text = user.Address ?? string.Empty;
                DataBind();
            }
        }
        private void BindOrderData(int id)
        {
            List<Order> orders = data.getOrderByUserId(id);

            Repeater1.DataSource = orders;
            Repeater1.DataBind();
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater Repeater2 = (Repeater)e.Item.FindControl("Repeater2");
                Order order = (Order)e.Item.DataItem;
                Repeater2.DataSource = data.getOrderItem(order.Id);
                Repeater2.DataBind();
                int orderStatus = (int)DataBinder.Eval(e.Item.DataItem, "OrderStatus");
                HtmlGenericControl p = (HtmlGenericControl)e.Item.FindControl("pOrderStatus");
                if (p != null)
                {
                    // Gọi phương thức để chuyển đổi giá trị OrderStatus thành chuỗi trạng thái
                    string statusText = GetOrderStatusText(orderStatus);
                    p.InnerText = statusText;
                }
            }
           
        }

        protected void btnSua_Click1(object sender, EventArgs e)
        {
            try
            {
                var user = (User)Session["Customer"];
                if (!string.IsNullOrEmpty(txtNewPassword.Text))
                {
                    // Băm mật khẩu hiện tại mà người dùng nhập vào
                    string hashedCurrentPassword = ComputeMd5Hash(txtCurrentPassword.Text.Trim());
                    Console.WriteLine("Hashed Input: " + hashedCurrentPassword); 
                    Console.WriteLine("Expected Hash: " + user.Password);
                    if (hashedCurrentPassword != user.Password)
                    {
                        the.Text = "Mật khẩu hiện tại không đúng: " + hashedCurrentPassword + " - " + user.Password;
                        return;
                    }
                    user.Password = txtNewPassword.Text;
                }
                User x = new User();
                x.Id = user.Id;
                x.FirstName = !string.IsNullOrEmpty(txtFirst.Text) ? txtFirst.Text : null;
                x.LastName = !string.IsNullOrEmpty(txtLast.Text) ? txtLast.Text : null;
                x.Email = txtEmail.Text;
                x.Password = user.Password;
                x.Username = user.Username;
                x.Phone = !string.IsNullOrEmpty(txtPhone.Text) ? txtPhone.Text : null;
                x.Address = !string.IsNullOrEmpty(txtAddress.Text) ? txtAddress.Text : null;
                data.UpdateUser(x);
                the.Text = "Sửa thành công !";
            }
            catch (Exception e1)
            {

                the.Text = "Có lỗi xảy ra: " + e1.Message.ToString();
            }
        }
        private string ComputeMd5Hash(string input)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] inputBytes = Encoding.UTF8.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                StringBuilder sb = new StringBuilder();
                foreach (byte b in hashBytes)
                {
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }
        private void exportpdf()
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=OrderInvoice.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            //Panel2.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }
        public override void VerifyRenderingInServerForm(Control control)
        {

        }
        protected void btnpdf_Click(object sender, EventArgs e)
        {
            exportpdf();
        }
        protected string GetOrderStatusText(object orderStatusObj)
        {
            int orderStatus = Convert.ToInt32(orderStatusObj);
            switch (orderStatus)
            {
                case 1:
                    return "Chưa duyệt";
                case 2:
                    return "Hoàn thành";
                case 0:
                    return "Đã hủy";
                default:
                    return "Không xác định";
            }
        }
        
    }
}
