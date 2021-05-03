using Microsoft.EntityFrameworkCore;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class RanksDAL : IRanksDAL
    {
        private readonly ApplicationDbContext mgd;

        public RanksDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public Ranks GetRank(int id)
        {
            return mgd.Rank.Where(x => x.Id == id).FirstOrDefault();
        }

        public IEnumerable<Ranks> GetRanks()
        {
            return mgd.Rank.ToList();
        }

}
}
