using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class PostReportsUI : IPostReportsUI
    {
        private readonly IPostReportsBL _IPostReportsBL;

        public PostReportsUI(IPostReportsBL IPostReportsBL)
        {
            _IPostReportsBL = IPostReportsBL;
        }

        public bool AddPostReport(PostReports postReport)
        {
            return _IPostReportsBL.AddPostReport(postReport);
        }

        public IEnumerable<PostReports> GetPostReport()
        {
            return _IPostReportsBL.GetPostReport();
        }
    }
}
