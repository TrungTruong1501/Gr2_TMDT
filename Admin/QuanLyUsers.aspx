<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyUsers.aspx.cs" Inherits="Group2.Admin.QuanLyUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- partial -->
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Người dùng</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Người dùng</a></li>
                    <li class="breadcrumb-item active">Quản lý</li>
                </ol>
            </nav>
        </div>
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <asp:Button ID="btThem" CssClass="btn btn-gradient-primary btn-fw mb-4" PostBackUrl="~/Admin/ThemUsers.aspx" runat="server" Text="Thêm User" /><br />
                        <asp:GridView ID="UserGridView" runat="server"
                            AllowPaging="True" PageSize="10"
                            OnPageIndexChanging="GridView1_PageIndexChanging"
                            AutoGenerateColumns="False" Width="100%">
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="ID" />
                                <asp:BoundField DataField="FirstName" HeaderText="Họ" />
                                <asp:BoundField DataField="LastName" HeaderText="Tên" />
                                <asp:BoundField DataField="Username" HeaderText="Tên đăng nhập" />
                                <asp:BoundField DataField="Email" HeaderText="Email" />
                                <asp:BoundField DataField="Address" HeaderText="Địa chỉ" />
                                <asp:BoundField DataField="Phone" HeaderText="Số điện thoại" />
                                <asp:TemplateField HeaderText="Quyền">
                                    <ItemTemplate>
                                        <asp:CheckBox CssClass="form-check form-check-primary" ID="cbBoard" Checked='<%# Convert.ToBoolean(Eval("Permission")) %>' runat="server" Enabled="false" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Xoá">
                                    <ItemTemplate>
                                        <asp:Button ID="buXoa" CssClass="btn btn-gradient-primary btn-sm" CommandName="xoa" CommandArgument='<%# Bind("Id") %>' Text="Xoá"
                                            OnCommand="Xoa_click" runat="server" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa?')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sửa">
                                    <ItemTemplate>
                                        <asp:Button ID="btnSua" CssClass="btn btn-gradient-primary btn-sm" CommandName="sua" CommandArgument='<%# Bind("Id") %>' Text="Sửa"
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

    <script src="../../assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="../../assets/js/off-canvas.js"></script>
    <script src="../../assets/js/hoverable-collapse.js"></script>
    <script src="../../assets/js/misc.js"></script>

</asp:Content>
