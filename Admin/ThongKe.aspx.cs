using Group2.Class;
using Group2.Class.Statistic;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web.UI;

namespace Group2.Admin
{
    public partial class ThongKe : Page
    {
        public DataUtil data = new DataUtil();
        protected string YearChartDataJson { get; set; }
        protected string MonthChartDataJson { get; set; }
        protected string DayChartDataJson { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                YearChartDataJson = GetYearChartDataJson(data.GetYearlyStatistics());
                MonthChartDataJson = GetMonthChartDataJson(data.GetMonthlyStatistics());
                DayChartDataJson = GetDayChartDataJson(data.GetDailyStatistics());
                hienthi();
                Tuple<int, int> Tuple = data.GetProductHighest();
                Product HottestProduct = data.getProductById(Tuple.Item1);
                anhsp.ImageUrl = "~/Image/ProductImage/" + HottestProduct.Image;
                int quan = Tuple.Item2;
                lbName.Text = HottestProduct.Name;
                lbquan.Text = quan.ToString();
                lbPrice.Text = HottestProduct.Price.ToString("N0", new CultureInfo("vi-VN"));
                Tuple<int, int> Tuple2 = data.GetUserHighest();
                User HottestUser = data.GetUserById(Tuple2.Item1);
                int quanbuy = Tuple2.Item2;
                lbnamkh.Text = HottestUser.Username;
                lbcount.Text = quanbuy.ToString();
            }
        }
        public void hienthi()
        {
            NotSoldGridView.DataSource = data.GetListNotSold(5);
            HotSaleGridView.DataSource = data.getListHotSaleProduct(5);
            DataBind();
            
        }
        private string GetYearChartDataJson(List<YearlyStatistic> yearlyStatistics)
        {
            List<object[]> chartData = new List<object[]>();
            foreach (YearlyStatistic stat in yearlyStatistics)
            {
                chartData.Add(new object[] { stat.StatisticYear, stat.OrderCount, stat.TotalRevenue });
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(chartData);
        }

        private string GetMonthChartDataJson(List<MonthlyStatistic> monthlyStatistics)
        {
            List<object[]> chartData = new List<object[]>();
            foreach (MonthlyStatistic stat in monthlyStatistics)
            {
                chartData.Add(new object[] { stat.StatisticMonth, stat.OrderCount, stat.TotalRevenue });
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(chartData);
        }

        private string GetDayChartDataJson(List<DailyStatistic> dailyStatistics)
        {
            List<object[]> chartData = new List<object[]>();
            foreach (DailyStatistic stat in dailyStatistics)
            {
                chartData.Add(new object[] { stat.StatisticDate, stat.OrderCount, stat.TotalRevenue });
            }
            return Newtonsoft.Json.JsonConvert.SerializeObject(chartData);
        }
    }
}
