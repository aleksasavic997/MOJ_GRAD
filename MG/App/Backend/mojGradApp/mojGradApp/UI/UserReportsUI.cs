using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class UserReportsUI : IUserReportsUI
    {
        private readonly IUserReportsBL _IUserReportsBL;

        public UserReportsUI(IUserReportsBL IUserReportsBL)
        {
            _IUserReportsBL = IUserReportsBL;
        }

        public bool AddUserReport(UserReports userReport)
        {
            return _IUserReportsBL.AddUserReport(userReport);
        }

        public IEnumerable<UserReports> GetUserReports()
        {
            return _IUserReportsBL.GetUserReports();
        }
    }
}
