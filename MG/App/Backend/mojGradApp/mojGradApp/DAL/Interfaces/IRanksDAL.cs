using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL.Interfaces
{
    public interface IRanksDAL
    {
        IEnumerable<Ranks> GetRanks();
        Ranks GetRank(int id);
    }
}
