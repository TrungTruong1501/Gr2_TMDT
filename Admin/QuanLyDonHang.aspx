<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="Group2.Admin.QuanLyDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- partial -->
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">Quản lý đơn hàng</h3>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Đơn hàng</a></li>
                    <li class="breadcrumb-item active">Quản lý</li>
                </ol>
            </nav>
        </div>
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <asp:GridView ID="grOrders" runat="server" DataKeyNames="ID"
                            AllowPaging="True" PageSize="10"
                            OnPageIndexChanging="GridView1_PageIndexChanging"
                            AutoGenerateColumns="False" Width="100%"
                            OnRowDataBound="grOrders_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Mã đơn" />
                                <asp:BoundField DataField="UserId" HeaderText="Mã KH" />
                                <asp:BoundField DataField="Phone" HeaderText="Điện thoại" />
                                <asp:TemplateField HeaderText="Ngày đặt">
                                    <ItemTemplate>
                                        <%# Group2.Class.Extension.FormatDate(Convert.ToDateTime(Eval("OrderDate"))) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Giá">
                                    <ItemTemplate>
                                        <%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("TotalPrice"))) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Trạng Thái">
                                    <ItemTemplate>
                                        <%# GetOrderStatus(Eval("OrderStatus")) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Chi tiết">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbView" CommandName="view" OnCommand="viewDetail_Click" CssClass="lbfunction"
                                            CommandArgument='<%# Bind("Id") %>' runat="server" Text="Xem" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Huỷ">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" CssClass="btn btn-danger btn-sm" CommandName="delete" CommandArgument='<%# Bind("Id") %>' Text="Huỷ"
                                            OnCommand="Delete_click" runat="server" OnClientClick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này ?')" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Duyệt">
                                    <ItemTemplate>
                                        <asp:Button ID="btnConfirm" CommandName="confirm" CssClass="btn btn-gradient-primary btn-sm"
                                            CommandArgument='<%# Bind("Id") %>' Text="Duyệt"
                                            OnCommand="Confirm_click" runat="server" />
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
                        <asp:Label ID="lbDetailTitle" runat="server" Text="" Font-Size="20px" Font-Bold="true" ForeColor="#29b279"></asp:Label>
                        <asp:Button ID="btnExportPdf" runat="server" Text="Xuất PDF" CssClass="btn btn-primary mt-4" OnClick="btnExportPdf_Click" />
                        <br />
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
