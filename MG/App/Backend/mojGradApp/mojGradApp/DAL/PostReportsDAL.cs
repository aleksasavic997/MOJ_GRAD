using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class PostReportsDAL : IPostReportsDAL
    {
        private readonly ApplicationDbContext mgd;

        public PostReportsDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public bool AddPostReport(PostReports postReport)
        {
            var postCheck = mgd.Post.Where(x => x.Id == postReport.PostID).FirstOrDefault();

            if(postCheck != null)
            {
                var pr = mgd.PostReport.Where(x => x.PostID == postReport.PostID && x.UserID == postReport.UserID).FirstOrDefault();
                if (pr != null)
                {
                    mgd.PostReport.Remove(pr);
                    mgd.SaveChanges();
                    return true;
                }
                else
                {
                    mgd.PostReport.Add(postReport);
                    mgd.SaveChanges();
                    return true;
                }
            }

            return false;
        }

        public IEnumerable<PostReports> GetPostReport()
        {
            return mgd.PostReport.ToList();
        }
    }
}
