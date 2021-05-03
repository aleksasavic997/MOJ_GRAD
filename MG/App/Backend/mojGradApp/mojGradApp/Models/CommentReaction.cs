﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class CommentReaction
    {
        public int Id { get; set; }
        public int CommentID { get; set; }
        public int UserID { get; set; }
        public int Type { get; set; }
        public DateTime Time { get; set; }
        public bool IsRead { get; set; }
        public bool IsApproved { get; set; }

        public virtual Comments Comment { get; set; }
        public virtual UserDatas User { get; set; }
    }
}