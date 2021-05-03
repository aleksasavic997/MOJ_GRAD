using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class Comments
    {
        public int Id { get; set; }
        public int PostID { get; set; }
        public int UserID { get; set; }
        public string Content { get; set; }
        public DateTime Time { get; set; }
        public bool IsRead { get; set; }

        public virtual Posts Post { get; set; }
        public virtual UserDatas User { get; set; }

        public virtual List<CommentReaction> CommentReaction { get; set; }
    }
}
