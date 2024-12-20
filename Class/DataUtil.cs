using Group2.Class.Statistic;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using static iTextSharp.text.pdf.AcroFields;
namespace Group2.Class
{
    public class DataUtil
    {
        public SqlConnection con;
        public DataUtil()
        {
            string sqlCon = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            con = new SqlConnection(sqlCon);
        }
        private string ComputeMd5Hash(string input)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] inputBytes = Encoding.UTF8.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                StringBuilder sb = new StringBuilder();
                foreach (byte b in hashBytes)
                {
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }
        public bool checkUsername(string username)
        {
            con.Open();
            string sql = "select * from [User] where username = @username ";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("username", username);
            SqlDataReader dr = cmd.ExecuteReader();
            bool rs = dr.HasRows;
            con.Close();
            return rs;
        }
        public User checkUser(string username, string password)
        {
            con.Open();
            string hashedPassword = ComputeMd5Hash(password);
            string checkuser = "select * from [User] where username = @un and password = @pw";
            SqlCommand cmd = new SqlCommand(checkuser, con);
            cmd.Parameters.AddWithValue("un", username);
            cmd.Parameters.AddWithValue("pw", hashedPassword);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                User u = new User();
                while (dr.Read())
                {
                    u.Id = (int)dr["user_id"];
                    u.Username = (string)dr["username"];
                    u.Email = (string)dr["Email"];
                    u.FirstName = dr.IsDBNull(dr.GetOrdinal("first_name")) ? "" : dr.GetString(dr.GetOrdinal("first_name"));
                    u.LastName = dr.IsDBNull(dr.GetOrdinal("last_name")) ? "" : dr.GetString(dr.GetOrdinal("last_name"));
                    u.Password = (string)dr["password"];
                    u.Permission = (int)dr["permission"];
                    u.Address = (string)dr["address"];
                    u.Phone = (string)dr["phone_number"];
                }
                return u;
            }
            else
            {
                return null;
            }
        }
        public List<Product> getListProduct()
        {
            List<Product> dt = new List<Product>();
            string sql = "select * from Product where RowState ='Unchanged' ORDER BY product_id DESC  ";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product bok = new Product();
                bok.Id = (int)dr["product_id"];
                bok.SKU = (string)dr["SKU"];
                bok.CategoryId = (int)dr["category_id"];
                bok.Name = (string)dr["name"];
                bok.Price = (int)dr["price"];
                bok.Stock = (int)dr["stock"];
                bok.Image = (string)dr["image"];
                dt.Add(bok);
            }
            con.Close();
            return dt;
        }
        public List<Product> searchProducts(string keyword)
        {
            List<Product> listPro = new List<Product>();
            string sql = "select * from Product where name like @keyword and RowState ='Unchanged'";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("keyword", "%" + keyword + "%");
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product pro = new Product();
                pro.Id = (int)dr["product_id"];
                pro.CategoryId = (int)dr["category_id"];
                pro.SKU = (string)dr["SKU"];
                pro.Name = (string)dr["name"];
                pro.Price = (int)dr["price"];
                pro.Description = (string)dr["description"];
                pro.Stock = (int)dr["stock"];
                pro.Image = (string)dr["image"];
                listPro.Add(pro);
            }
            con.Close();
            return listPro;
        }
        public List<Product> getListNewestProduct()
        {
            List<Product> dt = new List<Product>();
            string sql = "select top 10 * from Product where RowState ='Unchanged' order by product_id DESC";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product bok = new Product();
                bok.Id = (int)dr["product_id"];
                bok.CategoryId = (int)dr["category_id"];
                bok.Name = (string)dr["name"];
                bok.Price = (int)dr["price"];
                bok.Description = (string)dr["description"];
                bok.Image = (string)dr["image"];
                dt.Add(bok);
            }
            con.Close();
            return dt;
        }
        public List<Tuple<Product, int>> getListHotSaleProduct(int top = -1)
        {
            List<Tuple<Product, int>> dt = new List<Tuple<Product, int>>();
            string sql = "SELECT ";
            if (top > 0)
            {
                sql += " TOP " + top + " ";
            }
            sql += "oi.product_id, p.category_id, p.name, p.price,p.description, p.image,"
               + " SUM(oi.Quantity) AS sold_count"
               + " FROM Order_item oi JOIN [Order] o ON oi.order_id = o.order_id"
               + " JOIN [Product] p ON oi.product_id = p.product_id"
               + " WHERE o.order_status = 2"
               + " GROUP BY oi.product_id,p.category_id, p.name, p.price,p.description, p.image"
               + " ORDER BY sold_count DESC";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product bok = new Product();
                bok.Id = (int)dr["product_id"];
                bok.CategoryId = (int)dr["category_id"];
                bok.Name = (string)dr["name"];
                bok.Price = (int)dr["price"];
                bok.Description = (string)dr["description"];
                bok.Image = (string)dr["image"];
                int sold = (int)dr["sold_count"];
                dt.Add(Tuple.Create(bok, sold));
            }
            con.Close();
            return dt;
        }
        public List<Product> GetListRelatedProduct(int id)
        {
            Product product = getProductById(id);
            int category_id = product.CategoryId;
            List<Product> dt = new List<Product>();
            string sql = "select * from Product where category_id = @cateId and product_id != @productId";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("cateId", category_id);
            cmd.Parameters.AddWithValue("productId", id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product bok = new Product();
                bok.Id = (int)dr["product_id"];
                bok.CategoryId = (int)dr["category_id"];
                bok.Name = (string)dr["name"];
                bok.Price = (int)dr["price"];
                bok.Description = (string)dr["description"];
                bok.Image = (string)dr["image"];
                dt.Add(bok);
            }
            con.Close();
            return dt;
        }
        public List<Product> getListProductByCategory(int id)
        {
            List<Product> dt = new List<Product>();
            string sql = "select * from Product where category_id = @id and RowState ='Unchanged'";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product bok = new Product();
                bok.Id = (int)dr["product_id"];
                bok.CategoryId = (int)dr["category_id"];
                bok.Name = (string)dr["name"];
                bok.Price = (int)dr["price"];
                bok.Description = (string)dr["description"];
                bok.Image = (string)dr["image"];
                dt.Add(bok);
            }
            con.Close();
            return dt;
        }
        public List<Product> getListNewestProductByCategory(int id)
        {
            List<Product> dt = new List<Product>();
            string sql = "select top 10 * from Product where category_id = @id and RowState ='Unchanged' order by product_id DESC";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product bok = new Product();
                bok.Id = (int)dr["product_id"];
                bok.CategoryId = (int)dr["category_id"];
                bok.Name = (string)dr["name"];
                bok.Price = (int)dr["price"];
                bok.Description = (string)dr["description"];
                bok.Image = (string)dr["image"];
                dt.Add(bok);
            }
            con.Close();
            return dt;
        }
        public List<Product> getProductByPrice(int priceFrom, int priceTo)
        {
            List<Product> listPro = new List<Product>();
            string sql = "SELECT * FROM Product WHERE price BETWEEN @priceFrom AND @priceTo";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@priceFrom", priceFrom);
            cmd.Parameters.AddWithValue("@priceTo", priceTo);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product pro = new Product();
                pro.Id = (int)dr["product_id"];
                pro.CategoryId = (int)dr["category_id"];
                pro.Name = (string)dr["name"];
                pro.Price = (int)dr["price"];
                pro.Description = (string)dr["description"];
                pro.Image = (string)dr["image"];
                listPro.Add(pro);
            }


            return listPro;
        }
        public List<Color> getListColor(int id)
        {
            List<Color> colors = new List<Color>();
            string sql = "select * from Color where product_id = @id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Color color = new Color();
                color.Id = (int)dr["color_id"];
                color.Name = (string)dr["color_name"];
                color.ProductId = (int)dr["product_id"];
                color.HexCode = (string)dr["color_hex"];
                color.ImageUrl = (string)dr["image_url"];
                colors.Add(color);
            }
            con.Close();
            return colors;
        }
        public string getImageUrlByColorId(int id)
        {
            string sql = "select image_url from Color where color_id = @id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", id);
            SqlDataReader dr = cmd.ExecuteReader();
            string imageUrl = "";
            while (dr.Read())
            {
                imageUrl = (string)dr["image_url"];
            }
            con.Close();
            return imageUrl;
        }
        public string getCategoryName(int id)
        {
            string sql = "SELECT c.name FROM Category c JOIN Product p ON c.category_id = p.category_id WHERE p.product_id = @id";
            string name = "";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                name = (string)dr["name"];
            }
            con.Close();
            return name;
        }
        public List<CartItem> getCart(int cart_id)
        {
            List<CartItem> items = new List<CartItem>();
            string sql = "SELECT ci.cart_item_id, ci.product_id, p.name , p.price , ci.quantity,c.color_name,c.image_url, (ci.quantity * p.price) AS total"
                + " FROM CartItem ci JOIN Product p ON ci.product_id = p.product_id JOIN Color c ON ci.color_id = c.color_id WHERE ci.user_id = @id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", cart_id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                CartItem item = new CartItem();
                item.CartItemId = (int)dr["cart_item_id"];
                item.ProductId = (int)dr["product_id"];
                item.ProductName = (string)dr["name"];
                item.Price = (int)dr["price"];
                item.ColorName = (string)dr["color_name"];
                item.Quantity = (int)dr["quantity"];
                item.ImageUrl = (string)dr["image_url"];
                item.Total = (int)dr["total"];
                items.Add(item);
            }
            con.Close();
            return items;
        }


        public void addToCart(int user_id, int product_id, int quantity, int color_id)
        {
            int oldQuantity = checkCart(user_id, product_id, color_id);
            if (oldQuantity > 0)
            {
                con.Open();
                string sql = "Update CartItem SET quantity = @quantity where user_id = @user_id and product_id = @product_id and color_id = @color_id";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("user_id", user_id);
                cmd.Parameters.AddWithValue("product_id", product_id);
                cmd.Parameters.AddWithValue("quantity", quantity + oldQuantity);
                cmd.Parameters.AddWithValue("color_id", color_id);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else
            {
                con.Open();
                string sql = "Insert into CartItem (user_id,product_id,quantity,color_id) values (@user_id,@product_id,@quantity,@color_id)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("user_id", user_id);
                cmd.Parameters.AddWithValue("product_id", product_id);
                cmd.Parameters.AddWithValue("quantity", quantity);
                cmd.Parameters.AddWithValue("color_id", color_id);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        public int checkCart(int user_id, int product_id, int color_id)
        {
            con.Open();
            string checkcart = "select * from CartItem where user_id = @user_id and product_id = @product_id and color_id = @color_id";
            SqlCommand cmd = new SqlCommand(checkcart, con);
            cmd.Parameters.AddWithValue("user_id", user_id);
            cmd.Parameters.AddWithValue("product_id", product_id);
            cmd.Parameters.AddWithValue("color_id", color_id);
            SqlDataReader dr = cmd.ExecuteReader();
            int quantity = 0;
            while (dr.Read())
            {
                quantity = (int)dr["quantity"];
            }
            con.Close();
            return quantity;
        }
        public void removeCartItem(int id)
        {
            con.Open();
            string sql = "Delete from CartItem where cart_item_id = @id";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", id);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        //-------------------------------------------Product---------------------------------------------------
        public void deleteProduct(int Id)
        {
            con.Open();
            string sql1 = "update Product set RowState ='Deleted' where product_id=@Id";
            SqlCommand cmd = new SqlCommand(sql1, con);
            cmd.Parameters.AddWithValue("Id", Id);
            cmd.ExecuteNonQuery();

            con.Close();
        }
        public int addProduct(Product product)
        {
            con.Open();
            string sql = "INSERT INTO Product (category_id, SKU, name, price, description, stock, image,gallery) VALUES (@CategoryId, @SKU, @Name, @Price, @Description, @Stock, @Image, @Gallery); SELECT SCOPE_IDENTITY();";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@CategoryId", product.CategoryId);
            cmd.Parameters.AddWithValue("@SKU", product.SKU);
            cmd.Parameters.AddWithValue("@Name", product.Name);
            cmd.Parameters.AddWithValue("@Price", product.Price);
            cmd.Parameters.AddWithValue("@Description", product.Description);
            cmd.Parameters.AddWithValue("@Stock", product.Stock);
            cmd.Parameters.AddWithValue("@Image", product.Image);
            cmd.Parameters.AddWithValue("@Gallery", String.Join(",", product.Gallery));


            int productId = (int)Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();
            return productId;
        }
        public void updateProductGallery(int productId, string[] gallery)
        {
            con.Open();
            string sql = "UPDATE Product SET gallery = @Gallery WHERE product_id = @ProductId";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@Gallery", string.Join(",", gallery));
            cmd.Parameters.AddWithValue("@ProductId", productId);

            cmd.ExecuteNonQuery();
            con.Close();
        }
        public Product getProductById(int Id)
        {
            string sql = "select * from Product where product_id=@Id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("Id", Id);
            SqlDataReader dr = cmd.ExecuteReader();
            Product product = new Product();
            if (dr.Read())
            {
                product.Id = (int)dr["product_id"];
                product.SKU = (string)dr["SKU"];
                product.CategoryId = (int)dr["category_id"];
                product.Name = (string)dr["name"];
                product.Price = (int)dr["price"];
                product.Description = (string)dr["description"];
                product.Image = (string)dr["image"];
                product.Stock = (int)dr["stock"];
                string galleryString = (string)dr["gallery"];
                var list = galleryString.Split(',');
                product.Gallery = list;
            }
            con.Close();
            return product;
        }
        public void updateProduct(Product b)
        {
            con.Open();
            string sql1 = "update Product set SKU=@SKU,category_id=@CategoryId,name=@Name,price=@Price,description=@Description,stock=@Stock," +
                "image=@Image where product_id=@Id";
            SqlCommand cmd = new SqlCommand(sql1, con);
            cmd.Parameters.AddWithValue("@CategoryId", b.CategoryId);
            cmd.Parameters.AddWithValue("@SKU", b.SKU);
            cmd.Parameters.AddWithValue("@Name", b.Name);
            cmd.Parameters.AddWithValue("@Price", b.Price);
            cmd.Parameters.AddWithValue("@Description", b.Description);
            cmd.Parameters.AddWithValue("@Stock", b.Stock);
            cmd.Parameters.AddWithValue("@Image", b.Image);
            cmd.Parameters.AddWithValue("@Id", b.Id);

            cmd.ExecuteNonQuery();
            con.Close();
        }
        public List<Color> getListColorD()
        {
            List<Color> list = new List<Color>();
            string sql = "SELECT DISTINCT color_name, color_hex FROM Color";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Color c = new Color();

                c.Name = (string)dr["color_name"];
                c.HexCode = (string)dr["color_hex"];

                list.Add(c);
            }
            con.Close();
            return list;
        }
        public void addColor(int productId, string colorName, string colorHex, string imageUrl)
        {
            con.Open();
            string sql = "INSERT INTO [Color] (product_id, color_name, color_hex, image_url) VALUES (@ProductId, @ColorName, @ColorHex, @ImageUrl)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@ColorName", colorName);
            cmd.Parameters.AddWithValue("@ColorHex", colorHex);
            cmd.Parameters.AddWithValue("@ImageUrl", imageUrl);

            cmd.ExecuteNonQuery();
            con.Close();
        }

        //-----------------------------------------------Users----------------------------
        public List<User> getListUser()
        {
            List<User> list = new List<User>();
            string sql = "select * from [User]";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                User user = new User();
                user.Id = (int)dr["user_id"];
                user.FirstName = Convert.IsDBNull(dr["first_name"]) ? null : (string)dr["first_name"];
                user.LastName = Convert.IsDBNull(dr["last_name"]) ? null : (string)dr["last_name"];
                user.Email = (string)dr["email"];
                user.Username = (string)dr["username"];
                user.Password = (string)dr["password"];
                user.Address = Convert.IsDBNull(dr["address"]) ? null : (string)dr["address"];
                user.Phone = Convert.IsDBNull(dr["phone_number"]) ? null : (string)dr["phone_number"];
                user.Permission = Convert.ToInt32(dr["permission"]);
                list.Add(user);
            }
            con.Close();
            return list;
        }
        public void addUser(User u)
        {
            con.Open();
            string hashedPassword = ComputeMd5Hash(u.Password);
            string sql = "insert into [User] (first_name,last_name,email,username,password,address,phone_number,permission) values (@First,@Last,@Email,@Username,@Password,@Address,@Phone,@Permission)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("First", (object)u.FirstName ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Last", (object)u.LastName ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Email", u.Email);
            cmd.Parameters.AddWithValue("Username", u.Username);
            cmd.Parameters.AddWithValue("Password", hashedPassword);
            cmd.Parameters.AddWithValue("Address", (object)u.Address ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Phone", (object)u.Phone ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Permission", u.Permission);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public void DeleteUser(int Id)
        {
            con.Open();
            string sql1 = "delete from [User] where user_id=@Id";
            SqlCommand cmd = new SqlCommand(sql1, con);
            cmd.Parameters.AddWithValue("Id", Id);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public User GetUserById(int Id)
        {
            List<User> a = new List<User>();
            string sql = "select * from [User] where user_id=@Id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("Id", Id);
            User user = null;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                user = new User();
                user.Id = (int)dr["user_id"];
                user.FirstName = Convert.IsDBNull(dr["first_name"]) ? null : (string)dr["first_name"];
                user.LastName = Convert.IsDBNull(dr["last_name"]) ? null : (string)dr["last_name"];
                user.Email = (string)dr["email"];
                user.Username = (string)dr["username"];
                user.Password = (string)dr["password"];
                user.Address = Convert.IsDBNull(dr["address"]) ? null : (string)dr["address"];
                user.Phone = Convert.IsDBNull(dr["phone_number"]) ? null : (string)dr["phone_number"];
                user.Permission = Convert.ToInt32(dr["permission"]);
                a.Add(user);
            }
            con.Close();
            return user;
        }
        public void UpdateUser(User u)
        {
            con.Open();
            string hashedPassword = ComputeMd5Hash(u.Password);
            string sql1 = "update [User] set first_name =@First,last_name=@Last,email=@Email,username=@Username,password=@Password,address=@Address,phone_number=@Phone,permission=@Permission where user_id=@Id";
            SqlCommand cmd = new SqlCommand(sql1, con);
            cmd.Parameters.AddWithValue("First", (object)u.FirstName ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Last", (object)u.LastName ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Email", u.Email);
            cmd.Parameters.AddWithValue("Username", u.Username);
            cmd.Parameters.AddWithValue("Password", hashedPassword);
            cmd.Parameters.AddWithValue("Address", (object)u.Address ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Phone", (object)u.Phone ?? DBNull.Value);
            cmd.Parameters.AddWithValue("Permission", u.Permission);
            cmd.Parameters.AddWithValue("Id", u.Id);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        //-----------------------------------------------Blog----------------------------
        public List<Blog> getBlog()
        {
            List<Blog> blog = new List<Blog>();
            string sql = "select * from Blog";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Blog bg = new Blog();
                bg.id = (int)dr["id"];
                bg.title = (string)dr["title"];
                bg.content = (string)dr["contentBlog"];
                bg.thumb = (string)dr["thumbnail"];
                bg.date = Convert.ToDateTime(dr["date"]);
                bg.author = (string)dr["author"];
                blog.Add(bg);
            }
            con.Close();
            return blog;

        }
        public void addBlog(Blog bg)
        {
            con.Open();
            string sql = "insert into [Blog] (title,contentBlog,thumbnail,date,author) values (@title,@content,@thum,@date,@author)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("title", bg.title);
            cmd.Parameters.AddWithValue("content", bg.content);
            cmd.Parameters.AddWithValue("thum", bg.thumb);
            cmd.Parameters.AddWithValue("date", bg.date.ToString("yyyy/MM/dd"));
            cmd.Parameters.AddWithValue("author", bg.author);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public void delBlog(int Id)
        {
            con.Open();
            string sql1 = "delete from Blog where id=@Id";
            SqlCommand cmd = new SqlCommand(sql1, con);
            cmd.Parameters.AddWithValue("Id", Id);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public Blog getBlogById(int Id)
        {
            List<Blog> blog = new List<Blog>();
            string sql = "select * from Blog where id=@Id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", Id);
            Blog bg = null;

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                bg = new Blog();
                bg.id = (int)dr["id"];
                bg.title = (string)dr["title"];
                bg.content = (string)dr["contentBlog"];
                bg.thumb = (string)dr["thumbnail"];
                bg.date = Convert.ToDateTime(dr["date"]);
                bg.author = (string)dr["author"];
                blog.Add(bg);
            }
            con.Close();
            return bg;
        }
        public void updateBlog(Blog bg)
        {
            con.Open();
            string sql1 = "update Blog set title=@title,contentBlog=@content,thumbnail=@thum,date=@date,author=@author where id=@id";
            SqlCommand cmd = new SqlCommand(sql1, con);
            cmd.Parameters.AddWithValue("title", bg.title);
            cmd.Parameters.AddWithValue("content", bg.content);
            cmd.Parameters.AddWithValue("thum", bg.thumb);
            cmd.Parameters.AddWithValue("date", bg.date.ToString("yyyy/MM/dd"));
            cmd.Parameters.AddWithValue("author", bg.author);
            cmd.Parameters.AddWithValue("id", bg.id);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        //-----------------------------------------------Category----------------------------
        public List<Category> getListCategory()
        {
            List<Category> a = new List<Category>();
            string sql = "select * from Category where category_id is not NULL";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Category bok = new Category();
                bok.CategoryId = (int)dr["category_id"];
                bok.Name = (string)dr["name"];
                bok.Image = (string)dr["image"];
                //bok.maThuongHieu = (int)dr["maThuongHieu"];
                a.Add(bok);
            }
            con.Close();
            return a;
        }
        public bool CheckCategoryUsage(int CategoryId)
        {
            con.Open();
            string sql = "SELECT COUNT(*) FROM Product WHERE category_id = @id";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@id", CategoryId);
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            return count > 0;
        }

        public bool DeleteCategoryById(int CategoryId, out string message)
        {
            if (CheckCategoryUsage(CategoryId))
            {
                message = "Không thể xóa danh mục này vì đã được sử dụng cho sản phẩm.";
                return false;
            }
            else
            {
                con.Open();
                string sql1 = "DELETE FROM Category WHERE category_id = @ID";
                SqlCommand cmd = new SqlCommand(sql1, con);
                cmd.Parameters.AddWithValue("@ID", CategoryId);
                cmd.ExecuteNonQuery();
                con.Close();
                message = "Xóa danh mục thành công.";
                return true;
            }
        }

        public Category GetCategoryById(int CategoryId)
        {
            List<Category> category = new List<Category>();
            string sql = "select * from Category where category_id=@Id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("Id", CategoryId);
            Category ct = null;

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                ct = new Category();
                ct.CategoryId = (int)dr["category_id"];
                ct.Name = (string)dr["name"];
                ct.Image = (string)dr["image"];
                category.Add(ct);
            }
            con.Close();
            return ct;
        }
        public void SuaCategory(Category ct)
        {
            con.Open();
            string sql1 = "update Category set name=@name, image=@img where category_id=@id";
            SqlCommand cmd = new SqlCommand(sql1, con);
            cmd.Parameters.AddWithValue("name", ct.Name);
            cmd.Parameters.AddWithValue("img", ct.Image);
            cmd.Parameters.AddWithValue("id", ct.CategoryId);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public void AddCategory(Category u)
        {
            con.Open();
            string sql = "insert into Category (name,image) values (@name,@image)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("name", u.Name);
            cmd.Parameters.AddWithValue("image", u.Image);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        //-----------------------------------------------Order----------------------------
        public List<Payment> getListPayment()
        {
            List<Payment> list = new List<Payment>();
            string sql = "select * from Payment ";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Payment payment = new Payment();
                payment.Id = (int)dr["payment_id"];
                payment.Name = (string)dr["name"];
                list.Add(payment);
            }
            con.Close();
            return list;
        }
        public Order getOrder(int order_id)
        {
            string sql = "SELECT * FROM [Order] WHERE order_id = @id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", order_id);
            SqlDataReader dr = cmd.ExecuteReader();
            Order order = new Order();
            while (dr.Read())
            {
                order.Id = (int)dr["order_id"];
                order.OrderDate = (DateTime)dr["order_date"];
                order.TotalPrice = (int)dr["total_price"];
                order.UserId = (int)dr["user_id"];
            }
            con.Close();
            return order;
        }
        public List<Order> getListOrder()
        {
            string sql = "SELECT * FROM [Order] where order_status != -1 ORDER BY order_id DESC";
            List<Order> list = new List<Order>();
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Order order = new Order();
                order.Id = (int)dr["order_id"];
                order.OrderDate = (DateTime)dr["order_date"];
                order.TotalPrice = (int)dr["total_price"];
                order.UserId = (int)dr["user_id"];
                order.OrderStatus = (int)dr["order_status"];
                order.Phone = (string)dr["phone"];
                order.Address = dr.IsDBNull(dr.GetOrdinal("address")) ? "" : dr.GetString(dr.GetOrdinal("address")); ;
                order.PaymentId = dr.IsDBNull(dr.GetOrdinal("payment_id")) ? 0 : dr.GetInt32(dr.GetOrdinal("payment_id"));
                list.Add(order);
            }
            con.Close();
            return list;
        }
        public List<Order> getOrderByUserId(int user_id)
        {
            List<Order> items = new List<Order>();
            string sql = "SELECT * FROM [Order] WHERE user_id = @id AND order_status != -1 ORDER BY order_id DESC";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", user_id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Order item = new Order();
                item.Id = (int)dr["order_id"];
                item.OrderDate = (DateTime)dr["order_date"];
                item.TotalPrice = (int)dr["total_price"];
                item.UserId = (int)dr["user_id"];
                item.OrderStatus = (int)dr["order_status"];
                item.Address = dr.IsDBNull(dr.GetOrdinal("address")) ? "" : dr.GetString(dr.GetOrdinal("address")); ;
                item.PaymentId = dr.IsDBNull(dr.GetOrdinal("payment_id")) ? 0 : dr.GetInt32(dr.GetOrdinal("payment_id"));
                items.Add(item);
            }
            con.Close();
            return items;
        }
        public List<OrderItem> getOrderItem(int order_id)
        {
            List<OrderItem> items = new List<OrderItem>();
            string sql = "SELECT oi.order_item_id, oi.product_id, p.name, p.price, oi.quantity, c.color_name, c.image_url, (oi.quantity * p.price) AS total"
            + " FROM order_item oi"
            + " JOIN Product p ON oi.product_id = p.product_id"
            + " JOIN Color c ON oi.color_id = c.color_id"
            + " JOIN [Order] o ON oi.order_id = o.order_id"
            + " WHERE o.order_id = @id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("id", order_id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                OrderItem item = new OrderItem();
                item.Id = (int)dr["order_item_id"];
                item.ProductId = (int)dr["product_id"];
                item.ProductName = (string)dr["name"];
                item.Price = (int)dr["price"];
                item.ColorName = (string)dr["color_name"];
                item.Quantity = (int)dr["quantity"];
                item.ImageUrl = (string)dr["image_url"];
                item.Total = (int)dr["total"];
                items.Add(item);
            }
            con.Close();
            return items;
        }
        public void DeletePendingOrders()
        {

            con.Open();
            SqlTransaction transaction = con.BeginTransaction();
            try
            {
                // Xóa các mục liên quan trong bảng order_item
                string deleteOrderItemsSql = @"
            DELETE FROM order_item
            WHERE order_id IN (
                SELECT order_id
                FROM [Order]
                WHERE order_status = -1
            )";

                SqlCommand deleteOrderItemsCmd = new SqlCommand(deleteOrderItemsSql, con, transaction);
                deleteOrderItemsCmd.ExecuteNonQuery();

                // Xóa các đơn hàng trong bảng Order
                string deleteOrdersSql = @"
            DELETE FROM [Order]
            WHERE order_status = -1";

                SqlCommand deleteOrdersCmd = new SqlCommand(deleteOrdersSql, con, transaction);
                deleteOrdersCmd.ExecuteNonQuery();

                // Commit transaction
                transaction.Commit();
            }
            catch
            {
                // Rollback transaction if there's any error
                transaction.Rollback();
                throw;
            }

        }
        public int CreateOrder(int userId)
        {
            con.Open();
            SqlTransaction transaction = con.BeginTransaction();
            try
            {
                string calculateTotalPriceSql = @"
                SELECT SUM(p.price * ci.quantity)
                FROM CartItem ci
                JOIN Product p ON ci.product_id = p.product_id
                WHERE ci.user_id = @userId";
                SqlCommand calculateTotalPriceCmd = new SqlCommand(calculateTotalPriceSql, con, transaction);
                calculateTotalPriceCmd.Parameters.AddWithValue("userId", userId);
                decimal totalPrice = (int)calculateTotalPriceCmd.ExecuteScalar();
                // Tạo đơn hàng mới
                string createOrderSql = @"
                INSERT INTO [Order] (order_date, total_price, user_id, order_status, payment_id, address)
                VALUES (GETDATE(), @totalPrice, @userId, @orderStatus , NULL, NULL);
                SELECT SCOPE_IDENTITY();";
                SqlCommand createOrderCmd = new SqlCommand(createOrderSql, con, transaction);
                createOrderCmd.Parameters.AddWithValue("totalPrice", totalPrice);
                createOrderCmd.Parameters.AddWithValue("userId", userId);
                createOrderCmd.Parameters.AddWithValue("orderStatus", -1);
                int orderId = Convert.ToInt32(createOrderCmd.ExecuteScalar());

                // Di chuyển các mục từ giỏ hàng sang OrderItem
                string moveCartItemsSql = @"
                INSERT INTO order_item (quantity, price, product_id,color_id, order_id)
                SELECT ci.quantity, p.price, ci.product_id, ci.color_id, @orderId
                FROM CartItem ci
                JOIN Product p ON ci.product_id = p.product_id
                WHERE ci.user_id = @userId";
                SqlCommand moveCartItemsCmd = new SqlCommand(moveCartItemsSql, con, transaction);
                moveCartItemsCmd.Parameters.AddWithValue("orderId", orderId);
                moveCartItemsCmd.Parameters.AddWithValue("userId", userId);
                moveCartItemsCmd.ExecuteNonQuery();

                transaction.Commit();
                return orderId;
            }
            catch
            {
                transaction.Rollback();
                throw;
            }
        }


        public void CompleteOrder(int orderId, int userId, int payment, string address, string phone)
        {
            con.Open();
            SqlTransaction transaction = con.BeginTransaction();

            try
            {
                // Lấy tổng giá từ đơn hàng đã tạo
                string getTotalPriceSql = "SELECT total_price FROM [Order] WHERE order_id = @orderId";
                SqlCommand getTotalPriceCmd = new SqlCommand(getTotalPriceSql, con, transaction);
                getTotalPriceCmd.Parameters.AddWithValue("orderId", orderId);
                decimal totalPrice = (int)getTotalPriceCmd.ExecuteScalar();

                // Cập nhật order với shipment và address
                string updateOrderShipmentSql = "UPDATE [Order] SET payment_id = @payment_id, address = @address, order_status = @status, phone = @phone" +
                    " WHERE order_id = @orderId";
                SqlCommand updateOrderShipmentCmd = new SqlCommand(updateOrderShipmentSql, con, transaction);
                updateOrderShipmentCmd.Parameters.AddWithValue("payment_id", payment);
                updateOrderShipmentCmd.Parameters.AddWithValue("address", address);
                updateOrderShipmentCmd.Parameters.AddWithValue("orderId", orderId);
                updateOrderShipmentCmd.Parameters.AddWithValue("status", 1);
                updateOrderShipmentCmd.Parameters.AddWithValue("phone", phone);
                updateOrderShipmentCmd.ExecuteNonQuery();

                // Xóa các mục khỏi giỏ hàng của người dùng
                string clearCartSql = "DELETE FROM CartItem WHERE user_id = @userId";
                SqlCommand clearCartCmd = new SqlCommand(clearCartSql, con, transaction);
                clearCartCmd.Parameters.AddWithValue("userId", userId);
                clearCartCmd.ExecuteNonQuery();

                transaction.Commit();
            }
            catch
            {
                transaction.Rollback();
                throw;
            }
        }
        public void UpdateProductQuantities(int orderId)
        {
            con.Open();
            string updateProductQuantitiesSql = @"
            UPDATE p
            SET p.stock = p.stock - oi.total_quantity
            FROM Product p
            JOIN (
                SELECT product_id, SUM(quantity) AS total_quantity
                FROM order_item
                WHERE order_id = @orderId
                GROUP BY product_id
            ) oi ON p.product_id = oi.product_id";

            SqlCommand updateProductQuantitiesCmd = new SqlCommand(updateProductQuantitiesSql, con);
            updateProductQuantitiesCmd.Parameters.AddWithValue("@orderId", orderId);
            updateProductQuantitiesCmd.ExecuteNonQuery();
            con.Close();
        }
        public void ConfirmOrder(int orderId)
        {
            con.Open();
            SqlTransaction transaction = con.BeginTransaction();
            try
            {
                // Cập nhật trạng thái đơn hàng thành 'Confirmed'
                string updateOrderStatusSql = "UPDATE [Order] SET order_status = 2 WHERE order_id = @orderId";
                SqlCommand updateOrderStatusCmd = new SqlCommand(updateOrderStatusSql, con, transaction);
                updateOrderStatusCmd.Parameters.AddWithValue("orderId", orderId);
                updateOrderStatusCmd.ExecuteNonQuery();
                transaction.Commit();
            }
            catch
            {
                transaction.Rollback();
                throw;
            }
            finally
            {
                con.Close();
            }

        }
        public void DeleteOrder(int orderId)
        {
            con.Open();
            SqlTransaction transaction = con.BeginTransaction();
            try
            {
                // Cập nhật trạng thái đơn hàng thành 'Confirmed'
                string updateOrderStatusSql = "UPDATE [Order] SET order_status = 0 WHERE order_id = @orderId";
                SqlCommand updateOrderStatusCmd = new SqlCommand(updateOrderStatusSql, con, transaction);
                updateOrderStatusCmd.Parameters.AddWithValue("orderId", orderId);
                updateOrderStatusCmd.ExecuteNonQuery();

                transaction.Commit();
            }
            catch
            {
                transaction.Rollback();
                throw;
            }
            con.Close();
        }
        //-----------------------------------------------Whislist----------------------------
        public List<Wishlist> GetListWishlist(int user_id)
        {
            List<Wishlist> list = new List<Wishlist>();
            string sql = "select p.product_id,[name],[image]  from Product p " +
                " join Wishlist w on p.product_id = w.product_id where user_id = @user_id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("user_id", user_id);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Wishlist whislist = new Wishlist();
                whislist.ProductId = (int)dr["product_id"];
                whislist.Name = (string)dr["name"];
                whislist.Image = (string)dr["image"];
                list.Add(whislist);
            }
            con.Close();
            return list;
        }
        public void AddWishlist(int product_id, int user_id)
        {
            string sql = "insert into Wishlist(product_id,user_id) values (@product_id,@user_id)";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("product_id", product_id);
            cmd.Parameters.AddWithValue("user_id", user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public void RemoveWishlist(int product_id, int user_id)
        {
            string sql = "delete from Wishlist where product_id =  @product_id and user_id = @user_id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("product_id", product_id);
            cmd.Parameters.AddWithValue("user_id", user_id);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public bool CheckWishlist(int product_id, int user_id)
        {
            string sql = "select * from Wishlist where product_id =  @product_id and user_id = @user_id";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("product_id", product_id);
            cmd.Parameters.AddWithValue("user_id", user_id);
            SqlDataReader dr = cmd.ExecuteReader();
            bool check = dr.HasRows;
            con.Close();
            if (check)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        //-----------------------------------------------Statistical----------------------------
        public Tuple<int, int> GetUserHighest()
        {
            string sql = "SELECT TOP 1 u.user_id, u.username, COUNT(o.order_id) AS OrderCount"
                + " FROM [User] u JOIN [Order] o ON u.user_id = o.user_id"
                + " GROUP BY u.user_id,u.username ORDER BY OrderCount DESC;";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            string username = "";
            int id = 0;
            int count = 0;
            while (dr.Read())
            {
                username = (string)dr["username"];
                id = (int)dr["user_id"];
                count = (int)dr["Ordercount"];
            }
            con.Close();
            return Tuple.Create(id, count);
        }
        public Tuple<int, int> GetProductHighest()
        {
            string sql = "SELECT TOP 1 oi.product_id, SUM(oi.Quantity) AS sold_count"
                + " FROM Order_item oi JOIN [Order] o ON oi.order_id = o.order_id"
                + " WHERE o.order_status = 2"
                + " GROUP BY oi.product_id"
                + " ORDER BY sold_count DESC";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            int id = 0;
            int count = 0;
            while (dr.Read())
            {
                id = (int)dr["product_id"];
                count = (int)dr["sold_count"];

            }
            con.Close();
            return Tuple.Create(id, count);
        }
        public List<Product> GetListNotSold(int top = -1)
        {
            string sql = "SELECT ";
            List<Product> dt = new List<Product>();
            if (top > 0)
            {
                sql += " TOP " + top + " ";
            }
            sql += "p.product_id, p.category_id, p.image, p.name, p.price FROM Product p"
                + " LEFT JOIN Order_item oi ON p.product_id = oi.product_id"
                + " LEFT JOIN [Order] o ON oi.order_id = o.order_id AND o.order_status = 2"
                + " WHERE oi.product_id IS NULL";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Product bok = new Product();
                bok.Id = (int)dr["product_id"];
                bok.CategoryId = (int)dr["category_id"];
                bok.Name = (string)dr["name"];
                bok.Price = (int)dr["price"];
                bok.Image = (string)dr["image"];
                dt.Add(bok);
            }
            con.Close();
            return dt;
        }
        public List<DailyStatistic> GetDailyStatistics()
        {
            List<DailyStatistic> statistics = new List<DailyStatistic>();
            con.Open();
            string sql = "SELECT CONVERT(VARCHAR(10), order_date, 120) AS OrderDay,"
            + " COUNT(order_id) AS OrderCount, SUM(total_price) AS TotalRevenue"
            + " FROM [Order]"
            + " WHERE order_status = 2 AND YEAR(order_date) = 2024 AND MONTH(order_date) = 6"
            + " GROUP BY CONVERT(VARCHAR(10), order_date, 120)"
            + " ORDER BY OrderDay;";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                DailyStatistic stat = new DailyStatistic
                {
                    StatisticDate = dr.GetString(0),
                    OrderCount = dr.GetInt32(1),
                    TotalRevenue = dr.GetInt32(2)
                };
                statistics.Add(stat);
            }
            con.Close();
            return statistics;
        }

        public List<MonthlyStatistic> GetMonthlyStatistics()
        {
            List<MonthlyStatistic> statistics = new List<MonthlyStatistic>();

            con.Open();
            string sql = "SELECT YEAR(order_date) AS StatisticYear,MONTH(order_date) AS StatisticMonth,"
                        + " COUNT(order_id) AS OrderCount,SUM(total_price) AS TotalRevenue"
                        + " FROM [Order] WHERE order_status = 2 AND YEAR(order_date) = 2024"
                        + " GROUP BY YEAR(order_date),MONTH(order_date)"
                        + " ORDER BY StatisticYear, StatisticMonth ";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                MonthlyStatistic stat = new MonthlyStatistic
                {
                    StatisticYear = reader.GetInt32(0),
                    StatisticMonth = reader.GetInt32(1),
                    OrderCount = reader.GetInt32(2),
                    TotalRevenue = reader.GetInt32(3)
                };
                statistics.Add(stat);
            }
            con.Close();
            return statistics;
        }


        public List<YearlyStatistic> GetYearlyStatistics()
        {
            List<YearlyStatistic> statistics = new List<YearlyStatistic>();
            string sql = "SELECT YEAR(order_date) AS StatisticYear,"
                + " COUNT(order_id) AS OrderCount,SUM(total_price) AS TotalRevenue"
                + " FROM [Order] WHERE order_status = 2"
                + " GROUP BY YEAR(order_date)"
                + " ORDER BY StatisticYear";
            SqlCommand command = new SqlCommand(sql, con);
            con.Open();

            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                YearlyStatistic stat = new YearlyStatistic
                {
                    StatisticYear = reader.GetInt32(0),
                    OrderCount = reader.GetInt32(1),
                    TotalRevenue = reader.GetInt32(2)
                };
                statistics.Add(stat);
            }
            con.Close();
            return statistics;
        }
    }
}