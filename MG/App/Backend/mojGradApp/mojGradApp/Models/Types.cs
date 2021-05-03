using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class Types
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public virtual List<Posts> Posts { get; set; }
    }
}
