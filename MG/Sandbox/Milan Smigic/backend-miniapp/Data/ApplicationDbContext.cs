using Microsoft.EntityFrameworkCore;
using MyApp123.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MyApp123.Data
{
    public class ApplicationDbContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite(@"Data Source = baza.db");
        }

        public DbSet<Korisnici> Korisnik { get; set; }
        public DbSet<Serije> Serija { get; set; }
    }
}
