using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class CitiesBL : ICitiesBL
    {
        private readonly ICitiesDAL _ICitiesDAL;

        public CitiesBL(ICitiesDAL ICitiesDAL)
        {
            _ICitiesDAL = ICitiesDAL;
        }

        public Cities GetCity(int id)
        {
            return _ICitiesDAL.GetCity(id);
        }

        public IEnumerable<Cities> GetCities()
        {
            return _ICitiesDAL.GetCities();
        }

        public Cities PostCity(Cities city)
        {
            return _ICitiesDAL.PostCity(city);
        }
    }
}
