using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class PostReports
    {
        public int Id { get; set; }
        public int PostID { get; set; }
        public int UserID { get; set; }
        public bool IsApproved { get; set; }

        public virtual Posts Post { get; set; }
        public virtual UserDatas User { get; set; }
    }
}
