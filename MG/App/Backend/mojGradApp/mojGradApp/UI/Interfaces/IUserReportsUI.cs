using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI.Interfaces
{
    public interface IUserReportsUI
    {
        bool AddUserReport(UserReports userReport);
        IEnumerable<UserReports> GetUserReports();
    }
}
