using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class ChallengeAndSolutions
    {
        public int Id { get; set; }
        public int ChallengePostID { get; set; }
        public int SolutionPostID { get; set; }
        public bool IsApproved { get; set; }
        public bool IsRead { get; set; }

        public virtual Posts ChallengePost { get; set; }
        public virtual Posts SolutionPost { get; set; }
    }
}
