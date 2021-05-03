using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class CommentsBL : ICommentsBL
    {
        private readonly ICommentsDAL _ICommentsDAL;

        public CommentsBL(ICommentsDAL ICommentsDAL)
        {
            _ICommentsDAL = ICommentsDAL;
        }

        public bool AddComment(Comments comm)
        {
            return _ICommentsDAL.AddComment(comm);
        }

        public bool DeleteComment(int id)
        {
            return _ICommentsDAL.DeleteComment(id);
        }

        public bool DissmissCommentReports(int commentID)
        {
            return _ICommentsDAL.DissmissCommentReports(commentID);
        }

        public Comments FindCommentByID(int id)
        {
            return _ICommentsDAL.FindCommentByID(id);
        }

        public List<Comments> GetAllComments(int userID)
        {
            return _ICommentsDAL.GetAllComments(userID);
        }

        public IEnumerable<Comments> GetComment()
        {
            return _ICommentsDAL.GetComment();
        }

        public List<Comments> GetCommentsByPostID(int id)
        {
            return _ICommentsDAL.GetCommentsByPostID(id);
        }

        public List<Comments> GetApprovedReportedComments(int userID)
        {
            return _ICommentsDAL.GetApprovedReportedComments(userID);
        }
    }
}
