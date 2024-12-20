<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/QuanTri.Master" AutoEventWireup="true" CodeBehind="ThongKe.aspx.cs" Inherits="Group2.Admin.ThongKe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Include ApexCharts -->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-5 card">
                <div class="card-body">
                    <h5 class="card-title">Thống kê đơn hàng theo ngày</h5>
                    <div id="dayChart1">
                    </div>
                </div>
            </div>
            <div class="col-7 card">
                <div class="card-body">
                    <h5 class="card-title">Thống kê doanh thu theo ngày</h5>
                    <div id="dayChart2">
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-5 card">
                <div class="card-body">
                    <h5 class="card-title">Thống kê đơn hàng theo tháng</h5>
                    <div id="monthChart1">
                    </div>
                </div>
            </div>
            <div class="col-7 card">
                <div class="card-body">
                    <h5 class="card-title">Thống kê doanh thu theo tháng</h5>
                    <div id="monthChart2">
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-5 card">
                <div class="card-body">
                    <h5 class="card-title">Thống kê đơn hàng theo năm</h5>
                    <div id="yearChart1">
                    </div>
                </div>
            </div>
            <div class="col-7 card">
                <div class="card-body">
                    <h5 class="card-title">Thống kê doanh thu theo năm</h5>
                    <div id="yearChart2">
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <p class="font-weight-bold">Sản phẩm bán chạy</p>
                        <asp:GridView ID="HotSaleGridView" runat="server" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate>
                                        <%# Eval("Item1.Id") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tên">
                                    <ItemTemplate>
                                        <%# Eval("Item1.Name") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Giá">
                                    <ItemTemplate>
                                        <%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Item1.Price"))) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ảnh">
                                    <ItemTemplate>
                                        <asp:Image Width="96px" Height="96px" ID="Image1" runat="server" ImageUrl='<%# "~/Image/ProductImage/" + Eval("Item1.Image") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Đã bán">
                                    <ItemTemplate>
                                        <%# Eval("Item2") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <p class="font-weight-bold">Sản phẩm không bán được:</p>
                        <asp:GridView ID="NotSoldGridView" runat="server" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="ID" />
                                <asp:BoundField DataField="Name" HeaderText="Tên" />
                                <asp:TemplateField HeaderText="Giá">
                                    <ItemTemplate>
                                        <%# Group2.Class.Extension.FormatCurrency(Convert.ToInt32(Eval("Price"))) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ảnh">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="anhhh" runat="server" Text='<%# Bind("Image") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Image Width="96px" Height="96px" ID="Image1" runat="server" ImageUrl='<%# "~/Image/ProductImage/" + Eval("Image") %>' />
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
        <div class="row mt-4">
            <div class="col-8 border">
                <div class="card">
                    <div class="card-body">
                        <p class="font-weight-bold">Sản phẩm bán chạy nhất</p>
                        <div class="row">
                            <div class="col-3">
                                <asp:Image Width="100%" ID="anhsp" runat="server" />
                            </div>
                            <div class="col-9">
                                <p class="font-weight-bold text-center">
                                    <asp:Label ID="lbName" runat="server"></asp:Label>
                                </p>
                                <p>
                                    <label>Đã bán:</label>
                                    <asp:Label ID="lbquan" runat="server"></asp:Label>
                                </p>
                                <p>
                                    <label>Giá:</label>
                                    <asp:Label ID="lbPrice" runat="server"></asp:Label>
                                    VND
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-4 border">
                <div class="card">
                    <div class="card-body">
                        <p class="font-weight-bold">Khách mua nhiều nhất</p>
                        <p class="font-weight-bold">
                            Tên khách hàng: <asp:Label ID="lbnamkh" runat="server"></asp:Label>
                        </p>
                        <p class="font-weight-bold">Số lượng mua: <asp:Label ID="lbcount" runat="server"></asp:Label></p>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Include jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- JavaScript to create the chart -->
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            var yearChartData = <%= YearChartDataJson %>;

            // Extracting data for each series
            var years = yearChartData.map(item => item[0]);
            var orderCounts = yearChartData.map(item => item[1]);
            var totalRevenues = yearChartData.map(item => item[2]);
            new ApexCharts(document.querySelector("#yearChart1"), {
                series: [{
                    name: "Số đơn hàng",
                    data: orderCounts
                }],
                chart: {
                    type: 'bar',
                    height: 350
                },
                plotOptions: {
                    bar: {
                        borderRadius: 4,
                        horizontal: true,
                    }
                },
                dataLabels: {
                    enabled: false
                },
                xaxis: {
                    categories: years
                }
            }).render();

            new ApexCharts(document.querySelector("#yearChart2"), {
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('de-DE').format(val) + " VND";
                        }
                    }
                },
                series: [{
                    name: "Doanh thu",
                    data: totalRevenues
                }],
                chart: {
                    height: 350,
                    type: 'line',
                    zoom: {
                        enabled: false
                    }
                },
                dataLabels: {
                    enabled: false
                },
                stroke: {
                    curve: 'straight'
                },
                grid: {
                    row: {
                        colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
                        opacity: 0.5
                    },
                },
                xaxis: {
                    categories: years,
                },
                yaxis: {
                    labels: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('de-DE').format(val) + " VND";
                        }
                    }
                }
            }).render();
        });

        document.addEventListener("DOMContentLoaded", () => {
            var monthChartData = <%= MonthChartDataJson %>;

            // Extracting data for each series
            var months = monthChartData.map(item => item[0]);
            var orderCounts = monthChartData.map(item => item[1]);
            var totalRevenues = monthChartData.map(item => item[2]);
            new ApexCharts(document.querySelector("#monthChart1"), {
                series: [{
                    name: "Số đơn hàng",
                    data: orderCounts
                }],
                chart: {
                    type: 'bar',
                    height: 350
                },
                plotOptions: {
                    bar: {
                        borderRadius: 4,
                        horizontal: true,
                    }
                },
                dataLabels: {
                    enabled: false
                },
                xaxis: {
                    categories: months
                }
            }).render();

            new ApexCharts(document.querySelector("#monthChart2"), {
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('de-DE').format(val) + " VND";
                        }
                    }
                },
                series: [{
                    name: "Doanh thu",
                    data: totalRevenues
                }],
                chart: {
                    height: 350,
                    type: 'line',
                    zoom: {
                        enabled: false
                    }
                },
                dataLabels: {
                    enabled: false
                },
                stroke: {
                    curve: 'straight'
                },
                grid: {
                    row: {
                        colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
                        opacity: 0.5
                    },
                },
                xaxis: {
                    categories: months,
                },
                yaxis: {
                    labels: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('de-DE').format(val) + " VND";
                        }
                    }
                }
            }).render();
        });
        document.addEventListener("DOMContentLoaded", () => {
            var dayChartData = <%= DayChartDataJson %>;

            // Extracting data for each series
            var days = dayChartData.map(item => item[0]);
            var orderCounts = dayChartData.map(item => item[1]);
            var totalRevenues = dayChartData.map(item => item[2]);
            new ApexCharts(document.querySelector("#dayChart1"), {
                series: [{
                    name: "Số đơn hàng",
                    data: orderCounts
                }],
                chart: {
                    type: 'bar',
                    height: 350
                },
                plotOptions: {
                    bar: {
                        borderRadius: 4,
                        horizontal: true,
                    }
                },
                dataLabels: {
                    enabled: false
                },
                xaxis: {
                    categories: days
                }
            }).render();

            new ApexCharts(document.querySelector("#dayChart2"), {
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('de-DE').format(val) + " VND";
                        }
                    }
                },
                series: [{
                    name: "Doanh thu",
                    data: totalRevenues
                }],
                chart: {
                    height: 350,
                    type: 'line',
                    zoom: {
                        enabled: false
                    }
                },
                dataLabels: {
                    enabled: false
                },
                stroke: {
                    curve: 'straight'
                },
                grid: {
                    row: {
                        colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
                        opacity: 0.5
                    },
                },
                xaxis: {
                    categories: days,
                },
                yaxis: {
                    labels: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('de-DE').format(val) + " VND";
                        }
                    }
                }
            }).render();
        });
    </script>
</asp:Content>
