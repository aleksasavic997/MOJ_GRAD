using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface ITypesBL
    {
        IEnumerable<Types> GetTypes();
        Types PostType(Types type);
        Types GetType(int id);
    }
}
