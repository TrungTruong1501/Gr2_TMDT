<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyBlog.aspx.cs" Inherits="Group2.Admin.QuanLyBlog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Bài viết</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Bài viết</a></li>
                    <li class="breadcrumb-item active">Quản lý</li>
                </ol>
            </nav>
        </div>
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <asp:Button ID="btThem" CssClass="btn btn-gradient-primary btn-fw mb-4" PostBackUrl="~/Admin/ThemBlog.aspx" runat="server" Text="Thêm bài viết" /><br />
                        <asp:GridView ID="BlogGridView" runat="server"
                            AllowPaging="True" PageSize="10"
                            OnPageIndexChanging="GridView1_PageIndexChanging"
                            AutoGenerateColumns="False" Width="100%">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="ID" />
                                <asp:BoundField DataField="title" HeaderText="Tiêu đề" />
                                <asp:BoundField DataField="thumb" HeaderText="Hình ảnh" />
                                <asp:BoundField DataField="date" HeaderText="Ngày đăng" />
                                <asp:BoundField DataField="author" HeaderText="Tác giả" />
                                <%--<asp:CheckBoxField DataField="Permission" HeaderText="Permission" />--%>

                                <asp:TemplateField HeaderText="Xoá">
                                    <ItemTemplate>
                                        <asp:Button ID="buXoa" CssClass="btn btn-gradient-primary btn-sm" CommandName="xoa" CommandArgument='<%# Bind("id") %>' Text="Xoá"
                                            OnCommand="Xoa_click" runat="server" OnClientClick="return confirm('xoa di!')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sửa">
                                    <ItemTemplate>
                                        <asp:Button ID="btnSua" CssClass="btn btn-gradient-primary btn-sm" CommandName="sua" CommandArgument='<%# Bind("id") %>' Text="Sửa"
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

                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
