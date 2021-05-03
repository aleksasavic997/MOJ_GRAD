using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL.Interfaces
{
    public interface ITypesDAL
    {
        IEnumerable<Types> GetTypes();
        Types PostType(Types type);
        Types GetType(int id);
    }
}
