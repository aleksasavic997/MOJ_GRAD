using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class Posts
    {
        public int Id { get; set; }
        public int UserID { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int CategoryID { get; set; }
        public DateTime Time { get; set; }
        public string Location { get; set; }
        public int TypeID { get; set; }
        public string ImagePath { get; set; }
        public int CityID { get; set; }
        public double Longitude { get; set; }
        public double Latitude { get; set; }

        public virtual Categories Category { get; set; }
        public virtual UserDatas User { get; set; }
        public virtual Types Type { get; set; }
        public virtual Cities City { get; set; }

        public virtual List<Comments> Comments { get; set; }
        public virtual List<SavedPosts> SavedPost { get; set; }
        public virtual List<PostReactions> PostReactions { get; set; }
        public virtual List<PostReports> PostReports { get; set; }

        [InverseProperty("ChallengePost")]
        public virtual List<ChallengeAndSolutions> ChallengePost { get; set; }

        [InverseProperty("SolutionPost")]
        public virtual ChallengeAndSolutions SolutionPost { get; set; }
    }
}
