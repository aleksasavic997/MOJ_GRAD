using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class UserStatistics
    {
        public int Id { get; set; }
        public int NumberOfCitizens { get; set; }
        public int NumberOfInstitutions { get; set; }
        public int CityID { get; set; }
        public DateTime Time { get; set; }

        public virtual Cities City { get; set; }
    }
}
