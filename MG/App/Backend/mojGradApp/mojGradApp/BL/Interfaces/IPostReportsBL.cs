using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface IPostReportsBL
    {
        bool AddPostReport(PostReports postReport);
        IEnumerable<PostReports> GetPostReport();
    }
}
