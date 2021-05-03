using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class TypesUI : ITypesUI
    {
        private readonly ITypesBL _ITypesBL;

        public TypesUI(ITypesBL ITypesBL)
        {
            _ITypesBL = ITypesBL;
        }

        public IEnumerable<Types> GetTypes()
        {
            return _ITypesBL.GetTypes();
        }

        public Types GetType(int id)
        {
            return _ITypesBL.GetType(id);
        }

        public Types PostType(Types type)
        {
            return _ITypesBL.PostType(type);
        }
    }
}
