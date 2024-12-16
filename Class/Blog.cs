using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Group2.Class
{
    public class Blog
    {
        public int id { get; set; }
        public string title { get; set; }

        public string content { get; set; }

        public string thumb { get; set; }

        public DateTime date { get; set; }

        public string author { get; set; }
    }
}