<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="LienHe.aspx.cs" Inherits="Group2.LienHe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Banner Section Start -->
    <div class="page-banner-section section bg-gray">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="page-banner text-center">
                        <h1>Liên hệ</h1>
                        <ul class="page-breadcrumb">
                            <li><a href="index.html">Trang chủ</a></li>
                            <li>Liên hệ</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Page Banner Section End -->

    <!--Contact Map section start-->
    <div class="contact-map-section section">
        <div id="contact-map" class="contact-map mt-4">
            <center>
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3725.4796767870907!2d105.77622851488248!3d20.97340068602842!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3134532b891f24db%3A0xfe97bb9176d92787!2zQsawdSDEkWnhu4duIEjDoCDEkMO0bmc!5e0!3m2!1svi!2s!4v1612695715288!5m2!1svi!2s" width="600" height="450" frameborder="0" style="border: 0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
            </center>
        </div>
    </div>
    <!--Contact Map section End-->

    <!--Contact section start-->
    <div class="conact-section section pt-95 pt-lg-75 pt-md-65 pt-sm-55 pt-xs-45  pb-100 pb-lg-80 pb-md-70 pb-sm-60 pb-xs-50">
        <div class="container">
            <div class="row mt-4 py-4">
                <div class="col-lg-3 col-12">
                    <div class="contact-information">
                        <h3>Thông tin liên hệ</h3>
                        <ul>
                            <li>
                                <span class="icon"><i class="pe-7s-map"></i></span>
                                <span class="text"><span>Hanoi, Vietnam</span></span>
                            </li>
                            <li>
                                <span class="icon"><i class="pe-7s-call"></i></span>
                                <span class="text"><a href="#">(+84) 366 666 666)</a></span>
                            </li>
                            <li>
                                <span class="icon"><i class="pe-7s-mail-open"></i></span>
                                <span class="text"><a href="#">fshop@gmail.com</a></span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-9 col-12">
                    <div class="contact-form-wrap">
                        <h3 class="contact-title">Gửi câu hỏi cho chúng tôi</h3>
                        <form id="contact-form" action="http://hasthemes.com/file/mail.php" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="contact-form-style mb-20">
                                        <input name="lastname" placeholder="Họ*" type="text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="contact-form-style mb-20">
                                        <input name="firstname" placeholder="Tên*" type="text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="contact-form-style mb-20">
                                        <input name="email" placeholder="Email*" type="Email">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="contact-form-style mb-20">
                                        <input name="phone" placeholder="Điện thoại*" type="text">
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="contact-form-style">
                                        <textarea name="message" placeholder="Nội dung..."></textarea>
                                        <button class="template-btn" type="submit"><span>Gửi</span></button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <p class="form-messege"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Contact section end-->
</asp:Content>
