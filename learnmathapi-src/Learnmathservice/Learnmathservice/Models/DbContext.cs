using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Learnmathservice.Models
{
    using System.Data.Entity;

    namespace Learnmathservice.Models
    {
        public class MyDbContext : DbContext
        {
            public MyDbContext() : base("name=DbConnection")
            {
            }


            public DbSet<TblAddCrash> TblAddCrash { get; set; } 
        }
    }
}