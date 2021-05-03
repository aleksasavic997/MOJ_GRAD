using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class PostReportsBL : IPostReportsBL
    {
        private readonly IPostReportsDAL _IPostReportsDAL;

        public PostReportsBL(IPostReportsDAL IPostReportsDAL)
        {
            _IPostReportsDAL = IPostReportsDAL;
        }

        public bool AddPostReport(PostReports postReport)
        {
            return _IPostReportsDAL.AddPostReport(postReport);
        }

        public IEnumerable<PostReports> GetPostReport()
        {
            return _IPostReportsDAL.GetPostReport();
        }
    }
}
