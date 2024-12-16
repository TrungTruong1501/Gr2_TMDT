<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="GioiThieu.aspx.cs" Inherits="Group2.GioiThieu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Banner Section Start -->
    <div class="page-banner-section section bg-gray">
        <div class="container">
            <div class="row">
                <div class="col">

                    <div class="page-banner text-center">
                        <h1>Về chúng tôi</h1>
                        <ul class="page-breadcrumb">
                            <li><a href="TrangChu.aspx">Trang chủ</a></li>
                            <li>Giới thiệu</li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- Page Banner Section End -->

    <!--About Us Area Start-->
    <div class="about-us-area section py-4">
        <div class="container">
            <div class="row">
                <!-- Section Title Start -->
                <div class="col">
                    <div class="section-title text-center mb-40 mb-xs-20">
                        <h2>WELCOME TO <span>FSHOP</span></h2>
                        <p>Chúng tôi rất hân hạnh được phục vụ quý khách. </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-12">
                    <!--About Us Image Start-->
                    <div class="about-us-img-wrapper mb-30 mb-xs-15">
                        <div class="about-us-image img-full">
                            <a href="#">
                                <img src="Image/Logo/Logo.JPG" alt=""></a>
                        </div>
                    </div>
                    <!--About Us Image End-->
                </div>
                <div class="col-lg-6 col-12">
                    <!--About Us Content Start-->
                    <div class="about-us-content">
                        <h2>Nhà sáng lập</h2>
                        <p class="mb-20">Group 12 - Phát triển ứng dụng thương mại điện tử</p>
                        <p class="mb-20">Chúng tôi rất hân hạnh được phục vụ quý khách. Sự hài lòng của quý khách làm niềm hạnh phúc đối với chúng tôi </p>
                        <p>Cung cấp các loại sản phẩm chính hãng với giá thành tốt nhất.</p>
                        <button class="template-btn">Xem thêm</button>
                    </div>
                    <!--About Us Content End-->
                </div>
            </div>
        </div>
    </div>
    <!--About Us Area End-->

    <!-- Feature Section Start -->
    <div class="feature-section section">
        <div class="container">

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
                            <h2>Đổi trong vòng 3 ngày</h2>
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
                            <p>Được hưởng các chính sách Ưu đãi khuyến mãi VIP</p>
                        </div>
                    </div>
                    <!-- Single Faeture End -->
                </div>
            </div>
        </div>
    </div>
    <!-- Feature Section End -->
</asp:Content>
