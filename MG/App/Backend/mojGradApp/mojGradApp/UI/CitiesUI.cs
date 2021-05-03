using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class CitiesUI : ICitiesUI
    {
        private readonly ICitiesBL _ICitiesBL;

        public CitiesUI(ICitiesBL ICitiesBL)
        {
            _ICitiesBL = ICitiesBL;
        }

        public Cities GetCity(int id)
        {
            return _ICitiesBL.GetCity(id);
        }

        public IEnumerable<Cities> GetCities()
        {
            return _ICitiesBL.GetCities();
        }

        public Cities PostCity(Cities city)
        {
            return _ICitiesBL.PostCity(city);
        }
    }
}
