<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="QuanlyCategory.aspx.cs" Inherits="Group2.Admin.QuanlyCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Quản lý danh mục</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Danh mục</a></li>
                    <li class="breadcrumb-item active">Quản lý</li>
                </ol>
            </nav>
        </div>
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <asp:Button ID="btThem" CssClass="btn btn-gradient-primary btn-fw mb-4" PostBackUrl="~/Admin/ThemCategory.aspx" runat="server" Text="Thêm danh mục" /><br />
                        <asp:GridView ID="CateGridView" runat="server"
                            AllowPaging="True" PageSize="10"
                            OnPageIndexChanging="GridView1_PageIndexChanging"
                            AutoGenerateColumns="False" Width="100%">
                            <Columns>
                                <asp:BoundField DataField="CategoryId" HeaderText="ID" />
                                <asp:BoundField DataField="Name" HeaderText="Tên" />
                                <asp:TemplateField HeaderText="Hình ảnh">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="anhhh" runat="server" Text='<%# Bind("image") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Image Width="130px" Height="130px" ID="Image1" runat="server" ImageUrl='<%# "~/Image/ProductImage/" + Eval("Image") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Xoá">
                                    <ItemTemplate>
                                        <asp:Button ID="btnXoa" CssClass="btn btn-gradient-primary btn-sm" CommandName="xoa" CommandArgument='<%# Bind("CategoryId") %>' Text="Xoá"
                                            OnCommand="Xoa_click" runat="server" OnClientClick="return confirm('Bạn có chắc muốn xóa danh mục này?')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sửa">
                                    <ItemTemplate>
                                        <asp:Button ID="btnSua" CssClass="btn btn-gradient-primary btn-sm" CommandName="sua" CommandArgument='<%# Bind("CategoryId") %>' Text="Sửa"
                                            OnCommand="Sua_click" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#00547E" />
                        </asp:GridView>
                        <%--<asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>--%>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="../../assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="../../assets/js/off-canvas.js"></script>
    <script src="../../assets/js/hoverable-collapse.js"></script>
    <script src="../../assets/js/misc.js"></script>
</asp:Content>
