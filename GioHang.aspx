<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="Group2.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Banner Section Start -->
    <div class="page-banner-section section bg-gray">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="page-banner text-center">
                        <h1>Giỏ Hàng</h1>
                        <ul class="page-breadcrumb">
                            <li><a href="index.html">Trang Chủ</a></li>
                            <li>Cart</li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Page Banner Section End -->

    <!--Cart section start-->
    <div class="cart-section section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50  pb-70 pb-lg-50 pb-md-40 pb-sm-30 pb-xs-20">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <!-- Cart Table -->
                    <div>
                        <asp:Repeater ID="CartRepeater" runat="server">
                            <HeaderTemplate>
                                <table class="table table-striped">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Màu sắc</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Tổng tiền</th>
                                        <th>Xóa</th>
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
                                    <td>
                                        <asp:Button ID="btnRemove" CssClass="btn btn-danger" runat="server" CommandName="delete" CommandArgument='<%# Eval("CartItemId") %>' Text="Remove" 
                                            OnCommand="RemoveFromCart_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa?')"/>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
            <div class="row justify-content-end">
                <div>
                    <asp:Button ID="btnCreateOrder" CssClass="btn btn-success mr-4" Text="Mua hàng" OnClick="CreateOrder_Click" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <!--Cart section end-->


</asp:Content>
