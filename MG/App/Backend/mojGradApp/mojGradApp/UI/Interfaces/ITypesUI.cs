using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI.Interfaces
{
    public interface ITypesUI
    {
        IEnumerable<Types> GetTypes();
        Types PostType(Types type);
        Types GetType(int id);
    }
}
