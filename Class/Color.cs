using System;

namespace Group2.Class
{
    [Serializable]
    public class Color
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string HexCode { get; set; }
        public int ProductId {  get; set; }
        public string ImageUrl { get; set; }
    }
}