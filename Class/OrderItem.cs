namespace Group2.Class
{
    public class OrderItem
    {
        public int Id { get; set; }
        public int Quantity { get; set; }
        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public decimal Price { get; set; }
        public decimal Total { get; set; }
        public string ProductName { get; set; }
        public string ColorName { get; set; }
        public string ImageUrl { get; set; }
        public OrderItem()
        {
            
        }
    }
}