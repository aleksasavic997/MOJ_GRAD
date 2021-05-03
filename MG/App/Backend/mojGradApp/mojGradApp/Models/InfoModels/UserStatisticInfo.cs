using Org.BouncyCastle.Asn1.Mozilla;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models.InfoModels
{
    public class UserStatisticInfo
    {
        public int NumberOfCitizens { get; set; }
        public int NumberOfInstitutions { get; set; }
        public int CityID { get; set; }
        public String CityName { get; set; }
        public DateTime Time { get; set; }
        public int Day { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
        public int TotalNumber { get; set; }

        public UserStatisticInfo() { }

        public UserStatisticInfo(UserStatistics us, bool withCity) 
        {
            NumberOfCitizens = us.NumberOfCitizens;
            NumberOfInstitutions = us.NumberOfInstitutions;
            if(withCity == true)
            {
                CityID = us.CityID;
                CityName = us.City.Name;
            }
            Time = us.Time;
            Day = us.Time.Day;
            Month = us.Time.Month;
            Year = us.Time.Year;
            TotalNumber = us.NumberOfCitizens + us.NumberOfInstitutions;
        }
    }
}
