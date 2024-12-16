 <%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="Group2.DangNhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Login Register section start-->
    <div class="login-register-section section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50  pb-70 pb-lg-50 pb-md-40 pb-sm-30 pb-xs-20">
        <div class="container">
            <%-- <div class="row">--%>
            <!--Login Form Start-->

            <%-- <div class="col-md-6 col-sm-6">--%>
            <center>
                <div class="customer-login-register">
                 
                    <div class="login-form" style="width: 500px; padding: 32px">
                        <div class="form-fild">
                            <h2 class="text-center">Đăng nhập</h2>
                            <p>
                                <label>Tên đăng nhập <span class="required">*</span></label>
                            </p>
                            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-fild">
                            <p>
                                <label>Mật khẩu <span class="required">*</span></label>
                            </p>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="login-submit">
                            <center>
                                <%-- <button type="submit" class="btn">--%>
                                <asp:Button ID="btnlogin" CssClass="template-btn" runat="server" Text="Login" OnClick="btnlogin_Click" />
                                <asp:Label ID="lbID" runat="server"></asp:Label>
                                <asp:Label ID="lbMessage" runat="server" CssClass="msg"></asp:Label>
                            </center>
                        </div>
                        <center>
                            <h5 class="mt-4"><a href="DangKi.aspx">Tạo tài khoản</a></h5>
                        </center>
                    </div>
                </div>
            </center>
        </div>
        <!--Login Form End-->
        <!--Register Form Start-->
    </div>

    <!--Login Register section end-->
</asp:Content>
