<%@ Page Title="Quản lý sản phẩm" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="Group2.Admin.QuanLySanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include additional CSS or scripts here if needed -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <!-- Page Header -->
        <div class="page-header">
            <h3 class="page-title">Quản lý sản phẩm</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Sản phẩm</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Quản lý</li>
                </ol>
            </nav>
        </div>

        <!-- Content Section -->
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <!-- Action Buttons and Search -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <asp:Button ID="btThem" CssClass="btn btn-primary btn-fw" PostBackUrl="~/Admin/ThemSanPham.aspx" runat="server" Text="Thêm sản phẩm" />
                            <div class="input-group" style="width: 300px;">
                                <asp:TextBox ID="Txttimkiem" CssClass="form-control" Placeholder="Tìm kiếm sản phẩm..." runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="Btn_Timkiem" CssClass="btn btn-primary" runat="server" Text="Tìm kiếm" OnClick="btnTim_Click" />
                                </div>
                            </div>
                        </div>

                        <!-- Product Grid -->
                        <asp:GridView ID="GridView1" runat="server"
                            AllowPaging="True" PageSize="5"
                            OnPageIndexChanging="GridView1_PageIndexChanging"
                            AutoGenerateColumns="False"
                            CssClass="table table-bordered table-striped table-hover">
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="ID" />
                                <asp:BoundField DataField="SKU" HeaderText="SKU" />
                                <asp:BoundField DataField="CategoryId" HeaderText="Danh mục" />
                                <asp:BoundField DataField="Name" HeaderText="Tên sản phẩm" />
       
                                <asp:TemplateField HeaderText="Giá">
                                    <ItemTemplate>
                                        <%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Price"))) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Stock" HeaderText="Số lượng" />
                                <asp:TemplateField HeaderText="Hình ảnh">
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" Width="96px" Height="96px" CssClass="img-thumbnail"
                                            ImageUrl='<%# "~/Image/ProductImage/" + Eval("Image") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Hành động">
                                    <ItemTemplate>
                                        <asp:Button ID="btnSua" CommandName="sua" CssClass="btn btn-warning btn-sm"
                                            CommandArgument='<%# Bind("Id") %>' Text="Sửa" OnCommand="Sua_click" runat="server" />
                                        <asp:Button ID="buXoa" CommandName="xoa" CommandArgument='<%# Bind("Id") %>' Text="Xoá"
                                            CssClass="btn btn-danger btn-sm" runat="server"
                                            OnCommand="Xoa_click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa?')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include necessary scripts -->
    <script src="../../assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="../../assets/js/off-canvas.js"></script>
    <script src="../../assets/js/hoverable-collapse.js"></script>
    <script src="../../assets/js/misc.js"></script>
</asp:Content>
