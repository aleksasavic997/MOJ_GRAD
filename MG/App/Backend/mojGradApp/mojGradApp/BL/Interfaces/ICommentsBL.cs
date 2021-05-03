using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface ICommentsBL
    {
        IEnumerable<Comments> GetComment();
        bool AddComment(Comments comm);
        List<Comments> GetAllComments(int userID);
        List<Comments> GetCommentsByPostID(int id);
        Comments FindCommentByID(int id);
        bool DeleteComment(int id);
        bool DissmissCommentReports(int commentID);
        List<Comments> GetApprovedReportedComments(int userID);
    }
}
