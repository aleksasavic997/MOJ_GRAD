using Microsoft.EntityFrameworkCore;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class CitiesDAL : ICitiesDAL
    {
        private readonly ApplicationDbContext mgd;

        public CitiesDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public Cities GetCity(int id)
        {
            return mgd.City.Where(x => x.Id == id).Include(u => u.UserDatas).FirstOrDefault();
        }

        public IEnumerable<Cities> GetCities()
        {
            return mgd.City.Include(u => u.UserDatas).ToList();
        }

        public Cities PostCity(Cities city)
        {
            mgd.City.Add(city);
            mgd.SaveChanges();

            return city;
        }
    }
}
