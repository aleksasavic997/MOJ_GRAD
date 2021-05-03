using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL.Interfaces
{
    public interface IPostReportsDAL
    {
        bool AddPostReport(PostReports postReport);
        IEnumerable<PostReports> GetPostReport();
    }
}
