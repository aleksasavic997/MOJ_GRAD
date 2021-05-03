using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class Categories
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public virtual List<CategoryFollows> CategoryFollows { get; set; }

        //public virtual List<Posts> Posts { get; set; }
    }

}
