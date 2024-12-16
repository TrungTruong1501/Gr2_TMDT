<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="MyAccount.aspx.cs" Inherits="Group2.My_Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Banner Section Start -->
    <div class="page-banner-section section bg-gray">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="page-banner text-center">
                        <h1>Tài khoản</h1>
                        <ul class="page-breadcrumb">
                            <li><a href="index.html">Trang chủ</a></li>
                            <li>Tài khoản của tôi</li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Page Banner Section End -->

    <!--My Account section start-->
    <div class="section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50  pb-100 pb-lg-80 pb-md-70 pb-sm-60 pb-xs-50">
        <div class="container">
            <div class="row">

                <div class="col-12">
                    <div class="row">
                        <!-- My Account Tab Menu Start -->
                        <div class="col-lg-3 col-12">
                            <div class="myaccount-tab-menu nav" role="tablist">
                                <a href="#dashboad" class="active" data-toggle="tab"><i class="fa fa-dashboard"></i>
                                    Giới thiệu</a>

                                <a href="#orders" data-toggle="tab"><i class="fa fa-cart-arrow-down"></i>Đơn hàng</a>

                                <%--<a href="#payment-method" data-toggle="tab"><i class="fa fa-credit-card"></i> Paymen Method</a>--%>

                                <a href="#account-info" data-toggle="tab"><i class="fa fa-user"></i>Cập nhật thông tin </a>

                                <%--<a href="#" data-toggle="tab">--%><%--<i class="fa fa-sign-out"></i>--%>

                                <%--</a>--%>
                            </div>
                        </div>
                        <!-- My Account Tab Menu End -->

                        <!-- My Account Tab Content Start -->
                        <div class="col-lg-9 col-12">
                            <div class="tab-content" id="myaccountContent">
                                <!-- Single Tab Content Start -->
                                <div class="tab-pane fade show active" id="dashboad" role="tabpanel">
                                    <div class="myaccount-content">
                                        <h3>Thông tin người dùng</h3>

                                        <div class="welcome mb-20">
                                            <p>Họ tên:
                                                <asp:Label ID="labName" runat="server"></asp:Label></p>
                                            <p>Địa chỉ:
                                                <asp:Label ID="labAddress" runat="server"></asp:Label></p>
                                            <p>Email:
                                                <asp:Label ID="labEmail" runat="server"></asp:Label></p>
                                            <p>Số điện thoại:
                                                <asp:Label ID="labPhone" runat="server"></asp:Label></p>
                                        </div>
                                    </div>
                                </div>
                                <!-- Single Tab Content End -->

                                <!-- Single Tab Content Start -->
                                <div class="tab-pane fade" id="orders" role="tabpanel">
                                    <div class="myaccount-content">
                                        <h3>Đơn hàng</h3>
                                        <div class="myaccount-table table-responsive">
                                            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="container-fluid border mb-4 rounded">
                                                        <div class="row">
                                                            <p class="col-8">Ngày đặt: <%# Group2.Class.Extension.FormatDate(Convert.ToDateTime(Eval("OrderDate"))) %></p>
                                                            <p class="col-4">Trạng thái: <span id="pOrderStatus" runat="server"></span></p>
                                                        </div>
                                                        <asp:Repeater ID="Repeater2" runat="server">
                                                            <ItemTemplate>
                                                                <div>
                                                                    <div class="bg-gray mb-2 d-flex align-items-center rounded p-3">
                                                                        <asp:Image CssClass="d-inline-block mr-3 list-image-item rounded" ID="Image1" runat="server" ImageUrl='<%# "~/Image/ProductImage/" + Eval("ImageUrl") %>' />
                                                                        <div>
                                                                            <p class="font-weight-bold text-crop" style="width: 600px;"><%# Eval("ProductName") %></p>
                                                                            <div class="d-flex">
                                                                                <div class="col-8">
                                                                                    <p>x<%# Eval("Quantity") %></p>
                                                                                    <p>Phân loại: <%# Eval("ColorName") %></p>
                                                                                </div>
                                                                                <p class="col-4">Giá: <%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Price"))) %> VND</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        <div class="row">
                                                            <p class="col-8">Địa chỉ: <%# Eval("Address") %></p>
                                                            <p class="font-weight-bold col-4">Tổng tiền: <%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("TotalPrice"))) %> VND</p>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </div>
                                    </div>
                                </div>
                                <!-- Single Tab Content End -->

                                <!-- Single Tab Content Start -->
                                <div class="tab-pane fade" id="account-info" role="tabpanel">
                                    <div class="page-header">
                                        <h3 class="page-title">Sửa thông tin</h3>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 grid-margin stretch-card">
                                            <div class="card">
                                                <div class="card-body">
                                                    <form class="forms-sample">
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
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputAddress">Địa chỉ</label>
                                                            <asp:TextBox ID="txtAddress" class="form-control" runat="server"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleInputSDT">Số điện thoại</label>
                                                            <asp:TextBox ID="txtPhone" class="form-control" runat="server"></asp:TextBox>
                                                        </div>
                                                        <h3>Đổi mật khẩu</h3>
                                                        <div class="form-group">
                                                            <label for="exampleTextPass">Mật khẩu hiện tại</label>
                                                            <asp:TextBox ID="txtCurrentPassword" class="form-control" TextMode="Password" runat="server"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="exampleTextPass">Mật khẩu mới</label>
                                                            <asp:TextBox ID="txtNewPassword" class="form-control" TextMode="Password" runat="server"></asp:TextBox>
                                                        </div>
                                                        <asp:Label ID="the" runat="server"></asp:Label><br />
                                                        <asp:Button ID="btnSua" CssClass="btn btn-success" CommandName="sua" Text="Cập nhật" runat="server" OnClick="btnSua_Click1" />
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Single Tab Content End -->
                            </div>
                        </div>
                        <!-- My Account Tab Content End -->
                    </div>

                </div>

            </div>
        </div>
    </div>
</asp:Content>
