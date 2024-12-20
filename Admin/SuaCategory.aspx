<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="SuaCategory.aspx.cs" Inherits="Group2.Admin.SuaCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Sửa danh mục</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Danh mục</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Sửa</li>
                </ol>
            </nav>
        </div>
        <div class="row">
            <div class="col-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <form class="forms-sample">
                            <div class="form-group">
                                <label for="exampleInputName1">ID danh mục</label>
                                <asp:TextBox ID="txtId" class="form-control" Enabled="false" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputName1">Tên danh mục</label>
                                <asp:TextBox ID="txtCatename" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rCateN" ControlToValidate="txtCateName"
                                    ErrorMessage="Bạn phải điền tên danh mục" ForeColor="Red" runat="server" ValidationGroup="ProductGroup"/>
                            </div>
                            <div class="form-group d-flex align-items-center">
                                <label for="exampleInputName1">Hình ảnh</label>
                                <asp:TextBox ID="txtAnh" runat="server"></asp:TextBox>
                                <label for="exampleInputName1" class="mx-4">Chọn hình ảnh mới</label>
                                <asp:FileUpload ID="fuAnh" CssClass="btn btn-gradient-primary btn-fw" runat="server" />
                            </div>
                            <asp:Label ID="the" runat="server"></asp:Label>
                            <asp:Button ID="btnSua" CssClass="btn btn-gradient-primary btn-fw mr-4" CommandName="sua" Text="Sửa" runat="server" OnClick="btnSua_Click1"  ValidationGroup="ProductGroup"/>
                            <asp:Button ID="btds" CssClass="btn btn-gradient-primary btn-fw" PostBackUrl="~/Admin/QuanlyCategory.aspx" runat="server" Text="Danh sách danh mục" />
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
