using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class RanksBL : IRanksBL
    {
        private readonly IRanksDAL _IRanksDAL;

        public RanksBL(IRanksDAL IRanksDAL)
        {
            _IRanksDAL = IRanksDAL;
        }
        
        Ranks IRanksBL.GetRank(int id)
        {
            return _IRanksDAL.GetRank(id);
        }

        IEnumerable<Ranks> IRanksBL.GetRanks()
        {
            return _IRanksDAL.GetRanks();
        }
    }
}
