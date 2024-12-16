<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="YeuThich.aspx.cs" Inherits="Group2.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-banner-section section bg-gray">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="page-banner text-center">
                        <h1>Sản phẩm yêu thích</h1>
                        <ul class="page-breadcrumb">
                            <li><a href="TrangChu.aspx">Trang chủ</a></li>
                            <li>Yêu thích</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Search results start-->
    <div class="product-section bg-gray section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50 pb-65 pb-lg-45 pb-md-35 pb-sm-25 pb-xs-15">
    <div class="container">
        <div class="row tf-element-carousel" data-slick-options='{
        "slidesToShow": 4,
        "slidesToScroll": 1,
        "infinite": true,
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

            <asp:Repeater ID="wishlistProduct" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3">
                        <!-- Single Product Start -->
                        <div class="single-product mb-30">
                            <div class="product-img">
                                <a title='<%#:Eval("Name") %> <%#:Eval("ProductId") %>' href='/ChiTietSanPham.aspx?Id=<%#:Eval("ProductId") %>'>
                                    <img style="height: 350px" alt="" src='./Image/ProductImage/<%#:Eval("Image") %>' />
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
                                <h3><a href='/ChiTietSanPham.aspx?Id=<%#:Eval("ProductId") %>'><%#Eval("Name")%></a></h3>
                                <div class="ratting">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Single Product End -->
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</div>
    <!--Product section end-->

    <!--Product section start-->
    <div class="product-section bg-gray section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50 pb-65 pb-lg-45 pb-md-35 pb-sm-25 pb-xs-15">
        <div class="container">

            <div class="row">
                <!-- Section Title Start -->
                <div class="col">
                    <div class="section-title mb-40 mb-xs-20">
                        <h2>Sản phẩm liên quan</h2>
                    </div>
                </div>
                <!-- Section Title End -->
            </div>
            <div class="row tf-element-carousel" data-slick-options='{
            "slidesToShow": 4,
            "slidesToScroll": 1,
            "infinite": true,
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

                <asp:Repeater ID="allProducts" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3">
                            <!-- Single Product Start -->
                            <div class="single-product mb-30">
                                <div class="product-img">
                                    <a title='<%#:Eval("Name") %> <%#:Eval("Id") %>' href='/ChiTietSanPham.aspx?Id=<%#:Eval("Id") %>'>
                                        <img style="height: 350px" alt="" src='./Image/ProductImage/<%#:Eval("Image") %>' />
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
                                    <h3><a href='/ChiTietSanPham.aspx?Id=<%#:Eval("Id") %>'><%#Eval("Name")%></a></h3>
                                    <div class="ratting">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                    </div>
                                </div>
                            </div>

                            <!-- Single Product End -->
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    <!--Product section end-->
</asp:Content>
