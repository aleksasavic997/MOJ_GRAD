using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class CommentsUI : ICommentsUI
    {
        private readonly ICommentsBL _ICommentsBL;

        public CommentsUI(ICommentsBL ICommentsBL)
        {
            _ICommentsBL = ICommentsBL;
        }

        public bool AddComment(Comments comm)
        {
            return _ICommentsBL.AddComment(comm);
        }

        public bool DeleteComment(int id)
        {
            return _ICommentsBL.DeleteComment(id);
        }

        public bool DissmissCommentReports(int commentID)
        {
            return _ICommentsBL.DissmissCommentReports(commentID);
        }

        public Comments FindCommentByID(int id)
        {
            return _ICommentsBL.FindCommentByID(id);
        }

        public List<Comments> GetAllComments(int userID)
        {
            return _ICommentsBL.GetAllComments(userID);
        }

        public List<Comments> GetApprovedReportedComments(int userID)
        {
            return _ICommentsBL.GetApprovedReportedComments(userID);
        }

        public IEnumerable<Comments> GetComment()
        {
            return _ICommentsBL.GetComment();
        }

        public List<Comments> GetCommentsByPostID(int id)
        {
            return _ICommentsBL.GetCommentsByPostID(id);
        }
    }
}
