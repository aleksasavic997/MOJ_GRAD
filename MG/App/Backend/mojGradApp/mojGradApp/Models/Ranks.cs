using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class Ranks
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public virtual List<RankChanges> RankChange { get; set; }
    }
}
