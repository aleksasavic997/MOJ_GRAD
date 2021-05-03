using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class RankChanges
    {
        public int Id { get; set; }
        public int UserID { get; set; }
        public int RankID { get; set; }
        public DateTime Time { get; set; }
        public bool IsRead { get; set; }

        public virtual UserDatas User { get; set; }
        public virtual Ranks Rank { get; set; }
    }
}
