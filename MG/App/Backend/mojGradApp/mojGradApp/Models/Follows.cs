using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class Follows
    {
        public int Id { get; set; }
        public int UserFollowID { get; set; }
        public int FollowedUserID { get; set; }
        public DateTime Time { get; set; }
        public bool IsRead { get; set; }

        public virtual UserDatas UserFollow { get; set; }
        public virtual UserDatas FollowedUser { get; set; }
    }
}
