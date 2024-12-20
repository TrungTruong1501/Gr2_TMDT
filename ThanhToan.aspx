<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="Group2.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Banner Section Start -->
    <div class="page-banner-section section bg-gray">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="page-banner text-center">
                        <h1>Thanh toán</h1>
                        <ul class="page-breadcrumb">
                            <li><a href="index.html">Tranh chủ</a></li>
                            <li>Thanh toán</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page Banner Section End -->
    <div class="content-wraper">
        <div class="container-fluid">
            <div class="row">
                <div class="d-flex p-4">
                    <p class="font-weight-bold">
                        <asp:Label ID="lblName" Text="" runat="server" />
                    </p>
                    <p class="font-weight-bold ml-2">
                        <asp:Label ID="lblPhone" Text="" runat="server" />
                    </p>
                    <p class="ml-4">
                        <asp:Label ID="lblAddress" Text="" runat="server" />
                    </p>
                </div>
            </div>
            <div>
                <div>
                    <asp:Repeater ID="OrderRepeater" runat="server">
                        <HeaderTemplate>
                            <table class="table table-striped">
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Màu sắc</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Tổng tiền</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="d-flex" style="max-width: 480px">
                                    <img class="list-image-item" src='./Image/ProductImage/<%# Eval("ImageUrl") %>' alt="Image" />
                                    <p class="font-weight-bold ml-1"><%# Eval("ProductName") %></p>
                                </td>
                                <td><%# Eval("ColorName") %></td>
                                <td><%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Price"))) %></td>
                                <td>
                                    <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' CssClass="quantity-input" />
                                </td>
                                <td><%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Total"))) %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="text-right">
                <p class="font-weight-bold" style="font-size: 18px">Total: <asp:Label ID="lblTotal" runat="server" /></p>
            </div>
            <div class="mt-3 d-flex align-items-center">
                <p class="font-weight-bold mr-2">Phương thức thanh toán:</p>
                <p>
                    <asp:DropDownList ID="DDLPayment" runat="server"></asp:DropDownList>
                </p>
            </div>
            <div class="mt-2">
                <div class="py-4 d-flex justify-content-between align-items-center">
                    <p class="font-weight-bold font-italic text-danger">Nhấn đặt hàng để hoàn tất quá trình thanh toán</p>
                    <asp:Button ID="btnPay" CssClass="btn btn-success" Text="Đặt hàng" runat="server" OnClick="btnPay_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
