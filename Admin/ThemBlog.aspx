<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="ThemBlog.aspx.cs" Inherits="Group2.Admin.ThemBlog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- partial -->
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Thêm bài viết</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Bài viết</a></li>
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
                                <label for="exampleInputTitle">Tiêu đề</label>
                                <asp:TextBox ID="txtTitle" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rtieude" ControlToValidate="txtTitle"
                                    ErrorMessage="Bạn phải điền tiêu đề" ForeColor="Red" runat="server" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputContent">Nội dung</label>
                                <asp:TextBox ID="txtContent" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rContent" ControlToValidate="txtContent"
                                    ErrorMessage="Bạn phải điền nội dung" ForeColor="Red" runat="server" />
                            </div>
                            <div class="form-group d-flex align-items-center">
                                <label for="exampleInputThumb" class="mr-2">Hình ảnh</label>
                                <asp:FileUpload CssClass="file-upload-browse btn btn-gradient-primary" ID="txtThumb" runat="server" />
                                <asp:RequiredFieldValidator ID="rThumb" ControlToValidate="txtThumb"
                                    ErrorMessage="Bạn phải chọn ảnh" ForeColor="Red" runat="server" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputDate">Ngày đăng</label>
                                <asp:TextBox ID="txtDate" class="form-control" runat="server" placeholder="yyyy/MM/dd"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="exampleAuthor">Tác giả</label>
                                <asp:TextBox ID="txtAuthor" class="form-control" runat="server"></asp:TextBox>
                            </div>


                            <%--<button type="submit" class="btn btn-gradient-primary mr-2">Submit</button>
                  <button class="btn btn-light">Cancel</button>--%>
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
