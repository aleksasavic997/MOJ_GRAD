using Microsoft.EntityFrameworkCore;
using MiniAplikacija.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MiniAplikacija.Data
{
    public class ApplicationDBContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite(@"Data Source = BazaZaMiniApp.db;");
        }
        public DbSet<Festival> festivali { get; set; }
        public DbSet<Posetioc> posetioci { get; set; }
    }
}
