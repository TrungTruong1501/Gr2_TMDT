<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="ThemSanPham.aspx.cs" Inherits="Group2.Admin.ThemSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- partial -->
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Thêm sản phẩm</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Sản phẩm</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Thêm</li>
                </ol>
            </nav>
        </div>
        <div class="row">
            <div class="col-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <form class="forms-sample">
                            <div class="form-group">
                                <label for="exampleInputName1">Tên sản phẩm</label>
                                <asp:TextBox ID="txtName" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rtensp" ControlToValidate="txtName"
                                    ErrorMessage="Bạn phải điền tên sản phẩm" ForeColor="Red" runat="server" ValidationGroup="ProductGroup" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputName1">SKU</label>
                                <asp:TextBox ID="txtSKU" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rSKU" ControlToValidate="txtSKU"
                                    ErrorMessage="Bạn phải điền SKU" ForeColor="Red" runat="server" ValidationGroup="ProductGroup" />
                            </div>
                            <div class="form-group d-flex align-items-center">
                                <label for="exampleInputName1" class="mr-2">Danh mục</label>
                                <asp:DropDownList ID="cbbCategoryId" runat="server" Height="28px" Width="161px"></asp:DropDownList>
                            </div>
                            <div class="form-group d-flex align-items-center">
                                <label for="exampleInputCity1" class="mr-2">Hình ảnh</label>
                                <asp:FileUpload CssClass="file-upload-browse btn btn-gradient-primary" ID="txtAnhd" runat="server" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputColor">Màu sắc</label>
                                <asp:DropDownList ID="cblColor" runat="server" Height="28px" Width="160px" AutoPostBack="false"></asp:DropDownList>
                            </div>
                            <div class="form-group d-flex align-items-center">
                                <label for="exampleInputImageColor" class="mr-2">Ảnh màu</label>
                                <asp:FileUpload CssClass="file-upload-browse btn btn-gradient-primary mr-4" ID="txtAnhColor" runat="server" AllowMultiple="true" />
                                <asp:Button ID="btnThemColor" CssClass="btn btn-gradient-primary btn-fw" CommandName="themColor" Text="Thêm màu" runat="server" OnClick="btnThemColor_Click" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="txt" runat="server" Text="Danh sách màu đã thêm: "></asp:Label>
                                <asp:Label ID="msg" runat="server" Text="" ForeColor="Red"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail3">Đơn giá</label>
                                <asp:TextBox ID="txtPrice" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rPrice" ControlToValidate="txtPrice"
                                    ErrorMessage="Bạn phải điền đơn giá" ForeColor="Red" runat="server" ValidationGroup="ProductGroup" />
                            </div>
                            <div class="form-group">
                                <label for="exampleTextStock">Số lượng</label>
                                <asp:TextBox ID="txtStock" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rStock" ControlToValidate="txtStock"
                                    ErrorMessage="Bạn phải điền số lượng sản phẩm" ForeColor="Red" runat="server" ValidationGroup="ProductGroup" />
                            </div>
                            <div class="form-group">
                                <label for="exampleTextarea1">Mô tả</label>
                                <asp:TextBox ID="txtgioithieu" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <p class="text-danger"><asp:Label ID="the" runat="server"></asp:Label></p>
                            <asp:Button ID="btnThem" CssClass="btn btn-gradient-primary btn-fw" CommandName="them" Text="Thêm" runat="server" OnClick="btnThem_Click" ValidationGroup="ProductGroup" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../../assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="../../assets/js/off-canvas.js"></script>
    <script src="../../assets/js/hoverable-collapse.js"></script>
    <script src="../../assets/js/misc.js"></script>
    <script src="../../assets/js/file-upload.js"></script>
</asp:Content>
