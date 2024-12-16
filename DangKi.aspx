<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="DangKi.aspx.cs" Inherits="Group2.DangKi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Login Register section start-->
    <div class="login-register-section section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50  pb-70 pb-lg-50 pb-md-40 pb-sm-30 pb-xs-20">
        <div class="container">
            <div class="row">
                <!--Login Form Start-->

                <div class="col-md-6 col-sm-6">
                    <div class="customer-login-register">
                        <img style="width: 450px; height: 450px;" src="Image/Logo/Logo.JPG" />
                    </div>
                </div>

                <!--Login Form End-->
                <!--Register Form Start-->
                <%--<div class="col-md-6 col-sm-6">
                    <div class="customer-login-register register-pt-0">
                        <div class="register-form">
                            <div class="form-fild">
                                <h2 class="text-center">Đăng ký</h2>
                                <p>
                                    <label>Tên đăng nhập <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtUsername" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Email <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Địa chỉ<span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtAddress" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Số điện thoại <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtPhone" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Mật khẩu <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtPassword" class="form-control" TextMode="Password" runat="server"></asp:TextBox>
                            </div>
                            <center>
                                <div class="register-submit">
                                    <asp:Label ID="msg" runat="server"></asp:Label>
                                    <asp:Button ID="btnThem" CommandName="them" Text="Đăng ký" CssClass="template-btn" runat="server" OnClick="btnThem_Click" /><br />
                                </div>
                            </center>
                        </div>

                    </div>
                </div>--%>
                <div class="col-md-6 col-sm-6">
                    <div class="customer-login-register register-pt-0">
                        <div class="register-form">
                            <div class="form-fild">
                                <h2 class="text-center">Đăng ký</h2>
                                <p>
                                    <label>Tên đăng nhập <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtUsername" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Email <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Địa chỉ<span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtAddress" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Số điện thoại <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtPhone" class="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Mật khẩu <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtPassword" class="form-control" TextMode="Password" runat="server"></asp:TextBox>
                            </div>
                            <div class="form-fild">
                                <p>
                                    <label>Xác nhận mật khẩu <span class="required">*</span></label>
                                </p>
                                <asp:TextBox ID="txtConfirmPassword" class="form-control" TextMode="Password" runat="server"></asp:TextBox>
                            </div>
                            <center>
                                <div class="register-submit">
                                    <asp:Label ID="msg" runat="server"></asp:Label>
                                    <asp:Button ID="btnThem" CommandName="them" Text="Đăng ký" CssClass="template-btn" runat="server" OnClick="btnThem_Click" /><br />
                                </div>
                            </center>
                        </div>

                    </div>
                </div>

                <!--Register Form End-->
            </div>
        </div>
    </div>
    <!--Login Register section end-->
</asp:Content>
