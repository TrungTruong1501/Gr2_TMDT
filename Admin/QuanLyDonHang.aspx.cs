using Group2.Class;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace Group2.Admin
{
    public partial class QuanLyDonHang : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hienthi();
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grOrders.PageIndex = e.NewPageIndex;
            hienthi();
        }
        public void hienthi()
        {
            grOrders.DataSource = data.getListOrder();
            DataBind();
        }
        protected void Delete_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                int Id = Convert.ToInt16(e.CommandArgument);
                data.DeleteOrder(Id);
                hienthi();
            }
        }
        protected void Confirm_click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "confirm")
            {
                int Id = Convert.ToInt16(e.CommandArgument);
                data.ConfirmOrder(Id);
                data.UpdateProductQuantities(Id);
                hienthi();
            }
        }
        protected void viewDetail_Click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                int Id = Convert.ToInt32(e.CommandArgument);
                Session["OrderId"] = Id;
                Response.Redirect("CTDonHang.aspx");
            }

        }
        protected string GetOrderStatus(object orderStatusObj)
        {
            int orderStatus = Convert.ToInt32(orderStatusObj);
            switch (orderStatus)
            {
                case 1:
                    return "Chưa duyệt";
                case 2:
                    return "Đã duyệt";
                case 0:
                    return "Đã hủy";
                default:
                    return "Không xác định";
            }
        }
        protected void grOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int id = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "OrderStatus"));
                Button btnDelete = (Button)e.Row.FindControl("btnDelete");
                Button btnConfirm = (Button)e.Row.FindControl("btnConfirm");

                if (id == 0 || id == 2)
                {
                    btnDelete.Enabled = false;
                    btnConfirm.Enabled = false;
                }
            }

        }
        protected void btnExportPdf_Click(object sender, EventArgs e)
        {
            // Gọi phương thức xuất PDF ở đây
            ExportToPDF();
        }

        private void ExportToPDF()
        {
            var user = (User)Session["Admin"];
            // Lấy danh sách đơn hàng từ nguồn dữ liệu của bạn
            var orders = data.getListOrder();

            // Tạo một tài liệu PDF mới
            Document document = new Document();
            MemoryStream memoryStream = new MemoryStream();
            PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);

            // Thiết lập font cho tài liệu PDF
            BaseFont bf = BaseFont.CreateFont(Server.MapPath("~/Fonts/Arial Unicode Font.ttf"), BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font font = new Font(bf, 12);
            Font titleFont = new Font(bf, 18, Font.BOLD); // Font for the title
            Font infoFont = new Font(bf, 12, Font.NORMAL); // Font for additional info
            Font boldFont = new Font(bf, 12, Font.BOLD); // Font for bold text

            document.Open();

            DateTime now = DateTime.Now;
            string currentDate = $"Ngày {now.Day} Tháng {now.Month} Năm {now.Year}";

            PdfPTable headerTable = new PdfPTable(1); 
            headerTable.WidthPercentage = 100; // Chiều rộng của bảng là 100% của trang

            PdfPCell titleCell = new PdfPCell(new Phrase("THỐNG KÊ ĐƠN HÀNG", titleFont));
            titleCell.Border = PdfPCell.NO_BORDER;
            titleCell.HorizontalAlignment = Element.ALIGN_CENTER;
            headerTable.AddCell(titleCell);

            PdfPCell dateCell = new PdfPCell(new Phrase(currentDate, infoFont));
            dateCell.Border = PdfPCell.NO_BORDER;
            dateCell.HorizontalAlignment = Element.ALIGN_CENTER;
            headerTable.AddCell(dateCell);

            // Thêm khoảng trống
            PdfPCell spaceCell = new PdfPCell(new Phrase("\n"));
            spaceCell.Border = PdfPCell.NO_BORDER;
            headerTable.AddCell(spaceCell);

            PdfPCell infoCell = new PdfPCell();
            infoCell.Border = PdfPCell.NO_BORDER;
            infoCell.AddElement(new Paragraph("Đơn vị: FashionShop", infoFont));
            infoCell.AddElement(new Paragraph($"Người xuất: { user.FirstName } { user.LastName}", infoFont)); 
            headerTable.AddCell(infoCell);

            // Thêm bảng tiêu đề vào tài liệu
            document.Add(headerTable);

            // Thêm khoảng trống sau tiêu đề
            Paragraph space = new Paragraph("\n");
            document.Add(space);

            // Tạo bảng để hiển thị thông tin đơn hàng
            PdfPTable table = new PdfPTable(6); // Số cột là 6
            float[] columnWidths = { 10f, 10f, 20f, 20f, 15f, 25f }; // Độ rộng của các cột
            table.SetWidths(columnWidths);

            // Tiêu đề của bảng
            table.AddCell(new PdfPCell(new Phrase("Mã đơn", font)));
            table.AddCell(new PdfPCell(new Phrase("Mã KH", font)));
            table.AddCell(new PdfPCell(new Phrase("Điện thoại", font)));
            table.AddCell(new PdfPCell(new Phrase("Ngày đặt", font)));
            table.AddCell(new PdfPCell(new Phrase("Tổng tiền", font)));
            table.AddCell(new PdfPCell(new Phrase("Trạng thái", font)));

            // Thêm thông tin về từng đơn hàng vào bảng
            foreach (var order in orders)
            {
                table.AddCell(new PdfPCell(new Phrase(order.Id.ToString(), font)));
                table.AddCell(new PdfPCell(new Phrase(order.UserId.ToString(), font)));
                table.AddCell(new PdfPCell(new Phrase(order.Phone.ToString(), font)));
                table.AddCell(new PdfPCell(new Phrase(order.OrderDate.ToString("dd-MM-yyyy"), font)));
                // Định dạng giá tiền
                string formattedPrice = order.TotalPrice.ToString("#,0", CultureInfo.GetCultureInfo("vi-VN"));
                table.AddCell(new PdfPCell(new Phrase(formattedPrice, font)));
                table.AddCell(new PdfPCell(new Phrase(GetOrderStatus(order.OrderStatus), font)));
            }

            // Thêm bảng vào tài liệu
            document.Add(table);

            // Đóng tài liệu
            document.Close();

            // Xuất tài liệu PDF dưới dạng file để tải về
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=DsDonHang.pdf");
            Response.OutputStream.Write(memoryStream.GetBuffer(), 0, memoryStream.GetBuffer().Length);
            Response.OutputStream.Flush();
            Response.End();
        }
    }
}