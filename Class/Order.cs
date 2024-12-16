using System;

namespace Group2.Class
{
    public class Order
    {
        public int Id { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalPrice { get; set; }
        public int UserId {  get; set; }
        public int OrderStatus {  get; set; }
        public string Address { get; set; }
        public int PaymentId {  get; set; }
        public string Phone { get; set; }
        public Order()
        {
            
        }
    }
}