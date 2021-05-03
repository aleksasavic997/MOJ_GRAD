using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class UserTypes
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public virtual List<UserDatas> UserDatas { get; set; }
    }
}
