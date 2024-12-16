namespace Group2.Class
{
    public class Product
    {
        public int Id { get; set; }
        public string SKU { get; set; }
        public int CategoryId { get; set; }
        public string Name { get; set; }
        public int Price { get; set; }

        public int Stock { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }
        public string[] Gallery { get; set; }
    }
}