using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
namespace mojGradApp.UI
{
    public class RanksUI : IRanksUI
    {
        private readonly IRanksBL _IRanksBL;

        public RanksUI(IRanksBL IRanksBL)
        {
            _IRanksBL = IRanksBL;
        }

        public Ranks GetRank(int id)
        {
            return _IRanksBL.GetRank(id);
        }

        public IEnumerable<Ranks> GetRanks()
        {
            return _IRanksBL.GetRanks();
        }
    }
}
