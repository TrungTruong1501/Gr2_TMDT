<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="SuaUsers.aspx.cs" Inherits="Group2.Admin.SuaUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- partial -->
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Sửa thông tin người dùng</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Người dùng</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Sửa</li>
                </ol>
            </nav>
        </div>
        <div class="row">
            <div class="col-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <form class="forms-sample">
                            <p>
                               ID: <asp:Label ID="txtId" runat="server"/>
                            </p>
                            <div class="form-group">
                                <label for="exampleInputFirst">Họ </label>
                                <asp:TextBox ID="txtFirst" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputLast">Tên</label>
                                <asp:TextBox ID="txtLast" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail">Email</label>
                                <asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rEmail" ControlToValidate="txtEmail"
                                    ErrorMessage="Bạn phải điền email" ForeColor="Red" runat="server" ValidationGroup="ProductGroup" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputUserN">Tên đăng nhập</label>
                                <asp:TextBox ID="txtUsername" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="txtUserN" ControlToValidate="txtUsername"
                                    ErrorMessage="Bạn phải điền tên đăng nhập" ForeColor="Red" runat="server" ValidationGroup="ProductGroup" />
                            </div>
                            <div class="form-group">
                                <label for="exampleTextPass">Mật khẩu</label>
                                <asp:TextBox ID="txtPassword" class="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rPass" ControlToValidate="txtPassword"
                                    ErrorMessage="Bạn phải điền mật khẩu" ForeColor="Red" runat="server" ValidationGroup="ProductGroup" />
                            </div>
                            <div class="form-group">
                                <label for="exampleInputAddress">Địa chỉ</label>
                                <asp:TextBox ID="txtAddress" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputSDT">Số điện thoại</label>
                                <asp:TextBox ID="txtPhone" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group d-flex align-items-center">
                                <label for="exampleInputCity1">Quyền quản trị</label>
                                <asp:DropDownList ID="ddlPermission" runat="server" CssClass="dropdown-toggle">
                                    <asp:ListItem Text="Admin" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="User" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <%--<button type="submit" class="btn btn-gradient-primary mr-2">Submit</button>
                      <button class="btn btn-light">Cancel</button>--%>
                            <asp:Label ID="the" runat="server"></asp:Label>
                            <asp:Button ID="btnSua" CssClass="btn btn-gradient-primary btn-fw mr-4" CommandName="sua" Text="Sửa" runat="server" OnClick="btnSua_Click1" ValidationGroup="ProductGroup" />
                            <asp:Button ID="btds" CssClass="btn btn-gradient-primary btn-fw" PostBackUrl="~/Admin/QuanLyUsers.aspx" runat="server" Text="Danh sách người dùng" />
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
