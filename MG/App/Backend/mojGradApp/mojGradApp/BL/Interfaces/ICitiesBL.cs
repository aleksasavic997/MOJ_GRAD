using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface ICitiesBL
    {
        IEnumerable<Cities> GetCities();
        Cities PostCity(Cities city);
        Cities GetCity(int id);
    }
}
