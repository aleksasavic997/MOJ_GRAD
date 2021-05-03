using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class TypesBL : ITypesBL
    {
        private readonly ITypesDAL _ITypesDAL;

        public TypesBL(ITypesDAL ITypesDAL)
        {
            _ITypesDAL = ITypesDAL;
        }

        public IEnumerable<Types> GetTypes()
        {
            return _ITypesDAL.GetTypes();
        }

        public Types GetType(int id)
        {
            return _ITypesDAL.GetType(id);
        }

        public Types PostType(Types type)
        {
            return _ITypesDAL.PostType(type);
        }
    }
}
