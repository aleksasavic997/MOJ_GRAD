using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class UserReportsDAL : IUserReportsDAL
    {
        private readonly ApplicationDbContext mgd;

        public UserReportsDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public bool AddUserReport(UserReports userReport)
        {
            var userCheck = mgd.User.Where(x => x.Id == userReport.ReportedUserID).FirstOrDefault();

            if(userCheck != null)
            {
                var ur = mgd.UserReport.Where(x => x.ReportedUserID == userReport.ReportedUserID && x.UserID == userReport.UserID).FirstOrDefault();
                if (ur != null)
                {
                    mgd.UserReport.Remove(ur);
                    mgd.SaveChanges();
                    return true;
                }
                else
                {
                    mgd.UserReport.Add(userReport);
                    mgd.SaveChanges();
                    return true;
                }
            }

            return false;
        }

        public IEnumerable<UserReports> GetUserReports()
        {
            return mgd.UserReport.ToList();
        }
    }
}
