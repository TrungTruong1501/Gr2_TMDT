<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="ChiTietSanPham.aspx.cs" Inherits="Group2.ChiTietSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.sm-image img').click(function (event) {
                event.preventDefault();
                var imageUrl = $(this).attr('src');
                $('.large-image').attr('src', imageUrl);
            });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Single Product Section Start -->
    <div class="single-product-section section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50 pb-100 pb-lg-80 pb-md-70 pb-sm-30 pb-xs-20">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <!-- Product Details Left -->
                    <div class="product-details-left">
                        <div class="product-details-images-2 slider-lg-image-1 tf-element-carousel">
                            <div class="lg-image">
                                <asp:Image ID="anhsp" runat="server" CssClass="large-image" />
                            </div>
                        </div>
                        <div class="product-details-thumbs-2 mt-0 mt-xs-20 slider-thumbs-1 tf-element-carousel" data-slick-options='{
            "slidesToShow": 4,
            "slidesToScroll": 1,
            "infinite": true,
            "focusOnSelect": true,
            "asNavFor": ".slider-lg-image-1",
            "arrows": false,
            "vertical": true,
            "prevArrow": {"buttonClass": "slick-btn slick-prev", "iconClass": "fa fa-angle-left" },
            "nextArrow": {"buttonClass": "slick-btn slick-next", "iconClass": "fa fa-angle-right" }
            }'
                            data-slick-responsive='[
            {"breakpoint":991, "settings": {
                "slidesToShow": 3
            }},
            {"breakpoint":767, "settings": {
                "slidesToShow": 4
            }},
            {"breakpoint":479, "settings": {
                "slidesToShow": 2
            }}
        ]'>
                            <asp:Repeater ID="ImageRepeater" runat="server">
                                <ItemTemplate>
                                    <div class="sm-image">
                                        <asp:LinkButton ID="ImageLinkButton" runat="server">
                        <img src='./Image/ProductImage/<%# Container.DataItem %>' alt="Image" class="small-image" />
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <!--Product Details Left -->
                </div>
                <div class="col-md-6">
                    <!--Product Details Content Start-->
                    <div class="product-details-content">
                        <h2>
                            <asp:Label ID="LbName" runat="server" Text='<%# Eval("Name") %>' /></h2>
                        <div class="single-product-reviews">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                        </div>
                        <div class="single-product-price">
                            <span class="price new-price">
                                <asp:Label ID="lbPrice" runat="server" />
                                đ</span>
                        </div>
                        <div>
                            <asp:Repeater ID="ColorRepeater" runat="server">
                                <ItemTemplate>
                                    <asp:LinkButton ID="ColorLinkButton" runat="server" CommandArgument='<%# Eval("Id") %>' OnClick="ColorLinkButton_Click">
                                        <div class="d-flex mr-2 border rounded selectedColor" style="min-width: 84px; padding: 0 6px">
                                            <div class="rounded" style="background-color:<%# Eval("HexCode") %>; width: 16px; height: 16px; margin: 6px 0"></div>
                                            <p class="imageUrl d-none"><%# Eval("ImageUrl") %></p>
                                            <p class="ml-1"><%# Eval("Name") %></p>
                                        </div>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                            <p>
                                Danh mục:
                                <asp:Label ID="LbdanhMuc" runat="server" />
                            </p>
                        </div>
                        <div class="single-product-quantity">
                            <form class="add-quantity" action="#">
                                <label>Số lượng</label>
                                <div>
                                    <asp:TextBox TextMode="Number" ID="txtOrderQuantity" CssClass="text-center" Width="60px" runat="server" Text="1"></asp:TextBox>
                                </div>
                                <div class="my-2">
                                    <p>
                                        <i class="fa fa-check text-success"></i>
                                        <asp:Label ID="lbQuantityStatus" CssClass="add-to-cart" runat="server"></asp:Label>
                                        sản phẩm
                                    </p>
                                </div>
                                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="add-to-link">
                                            <asp:Button ID="btnAddToCart" CssClass="product-add-btn" Text="Add to cart" runat="server"
                                                OnClick="btnAddToCart_Click" />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </form>
                        </div>
                        
                        <div>
                            <asp:Button ID="btn_wishlist" CssClass="btn text-light" Text="Yêu thích" runat="server" OnClick="btn_wishlist_Click"/>
                        </div>
                    </div>
                    <!--Product Details Content End-->
                </div>
            </div>
        </div>
    </div>

    <!-- Single Product Section End -->
    <!--Product Description Review Section Start-->
    <div class="product-description-review-section section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="product-review-tab">
                        <!--Review And Description Tab Menu Start-->
                        <ul class="nav dec-and-review-menu">
                            <li>
                                <a class="active" data-toggle="tab" href="#description">Mô tả</a>
                            </li>
                            <li>
                                <a data-toggle="tab" href="#reviews">Đánh giá (1)</a>
                            </li>
                        </ul>
                        <!--Review And Description Tab Menu End-->
                        <!--Review And Description Tab Content Start-->
                        <div class="tab-content product-review-content-tab" id="myTabContent-4">
                            <div class="tab-pane fade active show" id="description">
                                <div class="single-product-description">
                                    <p>
                                        Thông tin:
                                        <asp:Label ID="LbDescription" runat="server" Text='<%# Eval("Description") %>' />
                                    </p>

                                </div>
                            </div>
                            <div class="tab-pane fade" id="reviews">
                                <div class="review-page-comment">
                                    <h2>Đánh giá của khách hàng</h2>
                                    <ul>
                                        <li>
                                            <div class="product-comment">
                                                <img src="assets/images/icons/author.png" alt="">
                                                <div class="product-comment-content">
                                                    <div class="product-reviews">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <p class="meta">
                                                        <strong>admin</strong> - <span>June 10, 2024</span>
                                                        <div class="description">
                                                            <p>Good product!</p>
                                                        </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!--Review And Description Tab Content End-->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Product Description Review Section Start-->

    <!--Product section start-->
    <div
        class="product-section section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50 pb-65 pb-lg-45 pb-md-35 pb-sm-25 pb-xs-15">
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

                <asp:Repeater ID="Repeater2" runat="server">
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
                                    <h3 class="font-weight-bold text-danger pt-3"><%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Price"))) %><sup>đ</sup></h3>
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
