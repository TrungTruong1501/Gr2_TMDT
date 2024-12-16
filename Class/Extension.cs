using System;
using System.Globalization;
using System.Web;

namespace Group2.Class
{
    public static class Extension
    {
        public static bool ShowAccountOptions()
        { 
            return HttpContext.Current.Session ["Customer"] != null;
        }
        public static string FormatCurrency(int value)
        {
            return value.ToString("N0", new CultureInfo("vi-VN"));
        }
        public static string FormatDate(DateTime date)
        {
            return date.ToString("dd-MM-yyyy");
        }
    }
}