using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication1.Models;
using Microsoft.EntityFrameworkCore;

namespace WebApplication1.Data
{
    public class ApplicationDBContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionBuilder)
        {
            optionBuilder.UseSqlite(@"DataSource=Baza.db");
        }

        public DbSet<Automobil> Automobili { get; set; }
        public DbSet<Korisnik> Korisnici { get; set; }
    }
}
