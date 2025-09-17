// ...existing using statements...
using System.Data.Entity;

namespace Learnmathservice.Models
{
    public class MyDbContext : DbContext
    {
        public MyDbContext() : base("name=MyDbContext")
        {
        }

       
        public DbSet<UserDetail> UserDetails { get; set; } // Add this line
    }
}
