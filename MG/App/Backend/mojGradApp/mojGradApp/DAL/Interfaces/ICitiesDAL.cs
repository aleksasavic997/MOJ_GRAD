using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL.Interfaces
{
    public interface ICitiesDAL
    {
        IEnumerable<Cities> GetCities();
        Cities PostCity(Cities city);
        Cities GetCity(int id);
    }
}
