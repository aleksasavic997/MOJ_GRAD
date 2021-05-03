using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class TypesDAL : ITypesDAL
    {
        private readonly ApplicationDbContext mgd;

        public TypesDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public IEnumerable<Types> GetTypes()
        {
            return mgd.Type.ToList();
        }

        public Types GetType(int id)
        {
            return mgd.Type.Find(id);
        }

        public Types PostType(Types type)
        {
            mgd.Type.Add(type);
            mgd.SaveChanges();

            return type;
        }
    }
}
