namespace Group2.Class
{
    public class CartItem
    {
        public int CartItemId { get; set; }
        public int CartId { get; set; }
        public int ProductId { get; set; }
        public int ColorId { get; set; }
        public int Quantity { get; set; }
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public string ColorName { get; set; }
        public string ImageUrl { get; set; }
        public decimal Total { get; set; }
        public CartItem()
        {
            
        }
    }

}