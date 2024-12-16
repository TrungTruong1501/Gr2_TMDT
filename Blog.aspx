<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Blog.aspx.cs" Inherits="Group2.Blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Banner Section Start -->
    <div class="page-banner-section section bg-gray">
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    <div class="page-banner text-center">
                        <h1>Tin tức mỗi ngày</h1>
                        <ul class="page-breadcrumb">
                            <li><a href="index.html">Trang chủ</a></li>
                            <li>Blog</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page Banner Section End -->

    <!-- Blog Section Start -->
    <div class="blog-section section pt-100 pt-lg-80 pt-md-70 pt-sm-60 pt-xs-50 pb-100 pb-lg-80 pb-md-70 pb-sm-60 pb-xs-50">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 order-lg-1 order-2">
                    <!-- Single Sidebar Start  -->
                    <div class="common-sidebar-widget">
                        <h3 class="sidebar-title">Bài viết theo tháng</h3>
                        <ul class="sidebar-list">
                            <li><a href="#"><i class="fa fa-angle-right"></i>June 2024 <span class="count">(2)</span></a></li>
                            <li><a href="#"><i class="fa fa-angle-right"></i>May 2024 <span class="count">(0)</span></a></li>
                            <li><a href="#"><i class="fa fa-angle-right"></i>April 2024 <span class="count">(0)</span></a></li>
                        </ul>
                    </div>
                    <!-- Single Sidebar End  -->
                    <!-- Single Sidebar Start  -->
                    <div class="common-sidebar-widget">
                        <div class="single-banner">
                            <a href="#">
                                <img src="Image/Logo/Anh dọc 1.jpg" alt="">
                            </a>
                        </div>
                    </div>
                    <!-- Single Sidebar End  -->
                </div>
                <div class="col-lg-9 order-lg-2 order-1">
                    <div>
                        <!-- Single Blog Start -->

                        <asp:DataList ID="DataList1" runat="server" DataKeyField="id">
                            <ItemTemplate>
                                <div class="blog">
                                    <div class="blog-inner mb-20 border">
                                        <div class="media">
                                            <a href="blog-details.html" class="image">
                                                <%--<asp:Label ID="ImageLabel" runat="server" Text='<%# Eval("Image") %>' />--%>
                                                <asp:Image ID="Image1" Height="320px" runat="server" ImageUrl='<%# "~/Image/Blog/" + Eval("thumb") %>' />
                                            </a>
                                        </div>
                                        <div class="content">
                                            <h3 class="title">
                                                <a href="blog-details.html">
                                                    <asp:Label ID="tieuDeLabel" runat="server" Text='<%# Eval("title") %>' />
                                                </a>
                                            </h3>

                                            <ul class="meta">
                                                <li><i class="fa fa-calendar"></i><span class="date-time">
                                                    <asp:Label ID="ngayDangTinLabel" runat="server" Text='<%# Eval("date") %>' />
                                                </span></li>
                                            </ul>
                                            <p>
                                                <asp:Label ID="noiDungLabel" runat="server" Text='<%# Eval("content") %>' />
                                            </p>
                                            <asp:Label ID="tacGiaLabel" runat="server" Text='<%# Eval("author") %>' />
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                        <!-- Single Blog End -->

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Blog Section End -->
</asp:Content>
