using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models.InfoModels
{
    public class CategoryStatistic
    {
        public int Id { get; set; }
        public String Name { get; set; }
        public int ChallengeNumber { get; set; }
        public int SolutionNumber { get; set; }
        public int PostNumber { get; set; }
        public int ReactionNumber { get; set; }
    }
}
