<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="ThemCategory.aspx.cs" Inherits="Group2.Admin.ThemCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Thêm danh mục</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Danh mục</a></li>
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
                                <label for="exampleInputName1">Tên danh mục</label>
                                <asp:TextBox ID="txtCatename" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rCateN" ControlToValidate="txtCateName"
                                    ErrorMessage="Bạn phải điền tên danh mục" ForeColor="Red" runat="server" />
                            </div>
                            <div class="form-group d-flex align-items-center">
                                <label for="exampleInputName1" class="mr-2">Ảnh</label>
                                <asp:FileUpload CssClass="file-upload-browse btn btn-gradient-primary" ID="txtAnh" runat="server" />
                            </div>
                            <asp:Label ID="the" runat="server"></asp:Label>
                            <asp:Button ID="btnThem" CssClass="btn btn-gradient-primary btn-fw" CommandName="them" Text="Thêm" runat="server" OnClick="btnThem_Click" />
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
