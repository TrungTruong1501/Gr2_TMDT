<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="Group2.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--Product section start-->
    <div class="product-section bg-gray section pt-70 pt-lg-45 pt-md-40 pt-sm-30 pt-xs-15">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="product-tab-menu mb-40 mb-xs-20">
                        <ul class="nav d-flex align-items-center">
                            <li><a class="active" data-toggle="tab" href="#products">Hot sale</a></li>
                            <li><a data-toggle="tab" href="#onsale">Sản phẩm mới</a></li>
                            <li>
                                <asp:DropDownList ID="ddlPriceFrom" runat="server" ></asp:DropDownList>
                            </li>
                            <li>-</li>
                            <li>
                                <asp:DropDownList ID="ddlPriceTo" runat="server" ></asp:DropDownList>
                            </li>
                            <li>
                                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" OnClick="btnSearch_Click" CssClass="template-btn" />
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="products">
                            <div class="row tf-element-carousel" data-slick-options='{
                                "slidesToShow": 4,
                                "slidesToScroll": 1,
                                "infinite": true,
                                "rows": 2,
                                "arrows": true,
                                "prevArrow": {"buttonClass": "slick-btn slick-prev", "iconClass": "fa fa-angle-left" },
                                "nextArrow": {"buttonClass": "slick-btn slick-next", "iconClass": "fa fa-angle-right" }
                                }'
                                data-slick-responsive='[
                                {"breakpoint":1199, "settings": {
                                "slidesToShow": 3
                                }},
                                {"breakpoint":992, "settings": {
                                "slidesToShow": 2
                                }},
                                {"breakpoint":768, "settings": {
                                "slidesToShow": 2,
                                "arrows": false,
                                "autoplay": true
                                }},
                                {"breakpoint":576, "settings": {
                                "slidesToShow": 1,
                                "arrows": false,
                                "autoplay": true
                                }}
                                ]'>

                                <asp:Repeater ID="AllProduct" runat="server">
                                    <ItemTemplate>
                                        <div class="col-12">
                                            <!-- Single Product Start -->
                                            <div class="single-product mb-30">
                                                <div class="product-img">
                                                    <a title='<%#:Eval("name") %> <%#:Eval("id") %>' href='/ChiTietSanPham.aspx?Id=<%#:Eval("id") %>'>
                                                        <img style="height: 350px" alt="" src='./Image/ProductImage/<%#:Eval("image") %>' />
                                                    </a>
                                                    <div class="product-action d-flex justify-content-between">
                                                        <a class="product-btn" href="#">Add to Cart</a>
                                                        <ul class="d-flex">
                                                            <li><a href="#quick-view-modal-container" data-toggle="modal" title="Quick View"><i class="fa fa-eye"></i></a></li>
                                                            <li><a href="#"><i class="fa fa-heart-o"></i></a></li>
                                                            <li><a href="#"><i class="fa fa-exchange"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="product-content">
                                                    <h3><a href='/ChiTietSanPham.aspx?Id=<%#:Eval("id") %>'><%#Eval("name")%></a></h3>
                                                     <h3 class="font-weight-bold text-danger pt-3"><%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Price"))) %><sup>đ</sup></h3>
                                                </div>
                                            </div>

                                            <!-- Single Product End -->
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="onsale">
                            <div class="row tf-element-carousel" data-slick-options='{
                                    "slidesToShow": 4,
                                    "slidesToScroll": 1,
                                    "infinite": true,
                                    "rows": 2,
                                    "arrows": true,
                                    "prevArrow": {"buttonClass": "slick-btn slick-prev", "iconClass": "fa fa-angle-left" },
                                    "nextArrow": {"buttonClass": "slick-btn slick-next", "iconClass": "fa fa-angle-right" }
                                    }'
                                data-slick-responsive='[
                                    {"breakpoint":1199, "settings": {
                                    "slidesToShow": 3
                                    }},
                                    {"breakpoint":992, "settings": {
                                    "slidesToShow": 2
                                    }},
                                    {"breakpoint":768, "settings": {
                                    "slidesToShow": 2,
                                    "arrows": false,
                                    "autoplay": true
                                    }},
                                    {"breakpoint":576, "settings": {
                                    "slidesToShow": 1,
                                    "arrows": false,
                                    "autoplay": true
                                    }}
                                    ]'>
                                <asp:Repeater ID="NewestProduct" runat="server">
                                    <ItemTemplate>
                                        <div class="col-12">
                                            <!-- Single Product Start -->
                                            <div class="single-product mb-30">
                                                <div class="product-img">
                                                    <a title='<%#:Eval("name") %> <%#:Eval("id") %>' href='/ChiTietSanPham.aspx?Id=<%#:Eval("id") %>'>
                                                        <img style="height: 350px" alt="" src='./Image/ProductImage/<%#:Eval("image") %>' />
                                                    </a>
                                                    <div class="product-action d-flex justify-content-between">
                                                        <a class="product-btn" href="#">Add to Cart</a>
                                                        <ul class="d-flex">
                                                            <li><a href="#quick-view-modal-container" data-toggle="modal" title="Quick View"><i class="fa fa-eye"></i></a></li>
                                                            <li><a href="#"><i class="fa fa-heart-o"></i></a></li>
                                                            <li><a href="#"><i class="fa fa-exchange"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="product-content">
                                                    <h3><a href='/ChiTietSanPham.aspx?Id=<%#:Eval("id") %>'><%#Eval("name")%></a></h3>
                                                     <h3 class="font-weight-bold text-danger pt-3"><%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Price"))) %><sup>đ</sup></h3>
                                                </div>
                                            </div>

                                            <!-- Single Product End -->
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <!-- Single Product End -->
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
    <!--Product section end-->

    <!-- Feature Section Start -->
    <div class="feature-section section pt-70 pt-lg-50 pt-md-35 pt-sm-30 pt-xs-20">
        <div class="container">
            <div class="row">
                <!-- Section Title Start -->
                <div class="col">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <!-- Single Faeture Start -->
                    <div class="single-feature feature-style-2 mb-30">
                        <div class="icon">
                            <i class="fa-truck fa"></i>
                        </div>
                        <div class="content">
                            <h2>Free shipping </h2>
                            <p>Nội thành Hà Nội với tất cả các hoá đơn</p>
                        </div>
                    </div>
                    <!-- Single Faeture End -->
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <!-- Single Faeture Start -->
                    <div class="single-feature feature-style-2 mb-30">
                        <div class="icon">
                            <i class="fa fa-undo"></i>
                        </div>
                        <div class="content">
                            <h2>Đổi trả trong vòng 3 ngày</h2>
                            <p>Quý khách có thể muốn đổi có lỗi liên hệ lại với Shop</p>
                        </div>
                    </div>
                    <!-- Single Faeture End -->
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <!-- Single Faeture Start -->
                    <div class="single-feature feature-style-2 mb-30 br-0">
                        <div class="icon">
                            <i class="fa fa-thumbs-o-up"></i>
                        </div>
                        <div class="content">
                            <h2>Member VIP</h2>
                            <p>Được hưởng các chính sách khuyến mãi VIP</p>
                        </div>
                    </div>
                    <!-- Single Feature End -->
                </div>
            </div>
        </div>
    </div>
    <!-- Feature Section End -->

    <!--Blog section start-->
    <div
        class="blog-section section bg-gray pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50 pb-75 pb-lg-55 pb-md-45 pb-sm-35 pb-xs-30">
        <div class="container">

            <div class="row">
                <!-- Section Title Start -->
                <div class="col">
                    <div class="section-title mb-30 mb-xs-20">
                        <h2>Tin Tức</h2>
                    </div>
                </div>
                <!-- Section Title End -->
            </div>
            <div class="row">
                <!-- Single Blog Start -->
                <asp:DataList ID="DataList1" runat="server" DataKeyField="id" RepeatColumns="3" RepeatDirection="Horizontal">
                    <ItemTemplate>
                        <div class="col-md-4 mb-4">
                            <div class="card" style="width: 18rem;">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/Image/Blog/" + Eval("thumb") %>' CssClass="card-img-top" />
                                <div class="card-body">
                                    <p class="font-weight-bold text-crop"><%# Eval("title") %></p>
                                    <p class="text-crop"><%# Eval("content") %></p>
                                </div>
                                <asp:Button ID="btnReadMore" CssClass="template-btn" Text="Xem thêm" runat="server" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>
    <!--Blog section end-->

</asp:Content>
