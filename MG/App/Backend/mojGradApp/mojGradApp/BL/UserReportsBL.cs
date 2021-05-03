using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class UserReportsBL : IUserReportsBL
    {
        private readonly IUserReportsDAL _IUserReportsDAL;

        public UserReportsBL(IUserReportsDAL IUserReportsDAL)
        {
            _IUserReportsDAL = IUserReportsDAL;
        }

        public bool AddUserReport(UserReports userReport)
        {
            return _IUserReportsDAL.AddUserReport(userReport);
        }

        public IEnumerable<UserReports> GetUserReports()
        {
            return _IUserReportsDAL.GetUserReports();
        }
    }
}
