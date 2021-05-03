using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class UserReports
    {
        public int Id { get; set; }
        public int UserID { get; set; }
        public int ReportedUserID { get; set; }
        public bool IsApproved { get; set; }

        public virtual UserDatas User { get; set; }
        public virtual UserDatas ReportedUser { get; set; }

    }
}
