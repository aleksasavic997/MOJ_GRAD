using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class Cities
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public virtual List<UserDatas> UserDatas { get; set; }
        public virtual List<Posts> Posts { get; set; }
        public virtual List<UserStatistics> UserStatistics { get; set; }
    }
}
