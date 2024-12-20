using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Group2.Class;
namespace Group2.Admin
{
    public partial class ThemSanPham : System.Web.UI.Page
    {
        DataUtil data = new DataUtil();


        protected int ProductId
        {
            get { return ViewState["ProductId"] != null ? (int)ViewState["ProductId"] : 0; }
            set { ViewState["ProductId"] = value; }
        }

        protected List<string> GalleryPaths
        {
            get { return ViewState["GalleryPaths"] != null ? (List<string>)ViewState["GalleryPaths"] : new List<string>(); }
            set { ViewState["GalleryPaths"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cbbCategoryId.DataSource = data.getListCategory();
                cbbCategoryId.DataTextField = "Name";
                cbbCategoryId.DataValueField = "CategoryId";
                cbbCategoryId.DataBind();

                cblColor.DataSource = data.getListColorD();
                cblColor.DataTextField = "Name";
                cblColor.DataValueField = "HexCode";
                cblColor.DataBind();

                ViewState["TempColors"] = new List<Color>();
                ViewState["GalleryFileNames"] = new List<String>();
                ViewState["ProductImage"] = null;
                ViewState["ProductImageContent"] = null;

            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                Product bo = new Product();

                bo.CategoryId = int.Parse(cbbCategoryId.SelectedValue);
                bo.SKU = txtSKU.Text;
                bo.Name = txtName.Text;
                bo.Price = int.Parse(txtPrice.Text);
                bo.Description = txtgioithieu.Text;
                bo.Stock = int.Parse(txtStock.Text);

                // Lấy lại thông tin tệp đã chọn trong txtAnhd từ ViewState nếu có
                if (ViewState["ProductImage"] != null && ViewState["ProductImageContent"] != null)
                {
                    string fileName = ViewState["ProductImage"].ToString();
                    byte[] fileBytes = (byte[])ViewState["ProductImageContent"];
                    string filePath = Server.MapPath("~/Image/productImage/" + fileName);
                    File.WriteAllBytes(filePath, fileBytes);
                    bo.Image = fileName;
                }
                else if (txtAnhd.HasFile)
                {
                    bo.Image = SaveFile(txtAnhd);
                }
                else
                {
                    bo.Image = null; 
                }

                
                List<string> GalleryPaths = ViewState["GalleryFileNames"] as List<string> ?? new List<string>();

                bo.Gallery = GalleryPaths.ToArray();

                int ProductId = data.addProduct(bo);


                if (ProductId > 0)
                {

                    // Lấy thông tin màu tạm thời
                    List<Color> tempColors = ViewState["TempColors"] as List<Color>;
                    foreach (var color in tempColors)
                    {
                        // Lưu mỗi màu vào cơ sở dữ liệu với ProductId hợp lệ
                        data.addColor(ProductId, color.Name, color.HexCode, color.ImageUrl);
                    }

                    // Update gallery 
                    data.updateProductGallery(ProductId, GalleryPaths.ToArray());
                    Response.Redirect("QuanLySanPham.aspx");
                }
                else
                {
                    the.Text = "Không thêm được sản phẩm";
                }

            }
            catch (Exception ex)
            {
                the.Text = "Không thêm được " + ex.Message;
            }
        }
        protected void btnThemColor_Click(object sender, EventArgs e)
        {
            List<string> GalleryFileNames = ViewState["GalleryFileNames"] as List<string> ?? new List<string>();
            List<string> ColorName = new List<string>();
            List<Color> tempColors = ViewState["TempColors"] as List<Color> ?? new List<Color>();

            // Lưu thông tin file đã chọn trong txtAnhd vào ViewState nếu chưa có
            if (ViewState["ProductImage"] == null && txtAnhd.HasFile)
            {
                ViewState["ProductImage"] = txtAnhd.FileName;
                ViewState["ProductImageContent"] = txtAnhd.FileBytes;
            }

            if (txtAnhColor.HasFiles)
            {
                int colorIndex = 0;
                foreach (ListItem item in cblColor.Items)
                {
                    if (item.Selected && colorIndex < txtAnhColor.PostedFiles.Count)
                    {
                        string colorHex = item.Value;
                        string colorName = item.Text;
                        HttpPostedFile postedFile = txtAnhColor.PostedFiles[colorIndex];
                        string colorImagePath = SaveColorImage(postedFile);

                        // Tạo một đối tượng mới để lưu trữ thông tin màu tạm thời
                        tempColors.Add(new Color
                        {
                            Name = colorName,
                            HexCode = colorHex,
                            ImageUrl = colorImagePath
                        });
                        // Thêm giá trị fileName vào 
                        GalleryFileNames.Add(Path.GetFileName(postedFile.FileName));
                        ColorName.Add(colorName);

                        colorIndex++;
                    }
                }
                string colorN = string.Join(", ", ColorName);

                if (!string.IsNullOrEmpty(msg.Text))
                {
                    // Display success message
                    msg.Text += ", " + colorN;
                }
                else
                {
                    msg.Text = colorN;
                }
            }
            else
            {
                msg.Text = "Vui lòng tải lên ít nhất một ảnh.";
            }
            // Lưu trữ thông tin màu sắc tạm thời
            ViewState["TempColors"] = tempColors;
            ViewState["GalleryFileNames"] = GalleryFileNames;
            // Reset input fields
            cblColor.ClearSelection();
            txtAnhColor.Attributes.Clear();
            foreach (var file in txtAnhColor.PostedFiles)
            {
                file.InputStream.Dispose();
            }

        }
        private string SaveFile(FileUpload fileUpload)
        {
            if (fileUpload.HasFile)
            {
                string folderPath = Server.MapPath("~/Image/productImage/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fileUpload.FileName);
                string filePath = Path.Combine(folderPath, fileName);
                fileUpload.SaveAs(filePath);
                return fileName;
            }
            return null;
        }

        private string SaveColorImage(HttpPostedFile postedFile)
        {
            string folderPath = Server.MapPath("~/Image/productImage/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fileName = Path.GetFileName(postedFile.FileName);
            string filePath = Path.Combine(folderPath, fileName);
            postedFile.SaveAs(filePath);
            return fileName;
        }
    }
}
