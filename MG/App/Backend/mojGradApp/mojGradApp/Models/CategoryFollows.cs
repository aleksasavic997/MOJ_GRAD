using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class CategoryFollows
    {
        public int Id { get; set; }
        public int UserID { get; set; }
        public int CategoryID { get; set; }

        public virtual UserDatas User { get; set; }
        public virtual Categories Category { get; set; }
    }
}
