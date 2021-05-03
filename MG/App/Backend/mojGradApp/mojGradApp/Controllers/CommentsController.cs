using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentsController : ControllerBase
    {
        private readonly ICommentsUI _ICommentsUI;

        public CommentsController(ICommentsUI ICommentsUI)
        {
            _ICommentsUI = ICommentsUI;
        }


        /* // GET: api/Comments
        //[Authorize]
        [HttpGet]
        public IEnumerable<CommentInfo> GetComments()
        {
            //userID can be sent to GetAllComments method
            var comments = _ICommentsUI.GetAllComments();
            List<CommentInfo> listComment = new List<CommentInfo>();

            foreach (var comment in comments.OrderByDescending(t => t.Time))
            {
                listComment.Add(new CommentInfo(comment));
            }

            return listComment;
        }*/


        // POST: api/Comments
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public bool PostComment(Comments comm)
        {
            return _ICommentsUI.AddComment(comm);
        }

        [Authorize]
        [Route("post/{id}")]
        [HttpGet]
        public IEnumerable<CommentInfo> GetCommentsByPostID(int id)
        {
            //returns a list of comments sorted by Time 
            return AllCommentsByPostIdSorted(id);
        }

        [Authorize]
        [Route("post/{id}/userId={userID}")]
        [HttpGet]
        public IEnumerable<CommentInfo> GetAllCommentsByPostID(int id, int userID)
        {
            return AllCommentsByPostIdSorted(id, userID); 
        }

        [Authorize]
        [Route("ByPostSortedByLikes/{id}")]
        [HttpGet]
        public IEnumerable<CommentInfo> GetCommentsByPostIdSortedByLikes(int id)
        {
            int sortByLikes = 1;
            int sortByDislikes = 0;
            return AllCommentsByPostIdSorted(id, sortByLikes, sortByDislikes);
        }

        [Authorize]
        [Route("ByPostSortedByDislikes/{id}")]
        [HttpGet]
        public IEnumerable<CommentInfo> GetCommentsByPostIdSortedByDislikes(int id)
        {
            int sortByLikes = 0;
            int sortByDislikes = 1;
            return AllCommentsByPostIdSorted(id, sortByLikes, sortByDislikes);
        }

        private IEnumerable<CommentInfo> AllCommentsByPostIdSorted(int id, int userID = 0, int sortByLikes = 0, int sortByDislikes = 0)
        {
            var comments = _ICommentsUI.GetCommentsByPostID(id);
            List<CommentInfo> listComment = new List<CommentInfo>();

            foreach (var comment in comments)
            {
                if(userID == 0)
                    listComment.Add(new CommentInfo(comment));
                else
                    listComment.Add(new CommentInfo(comment, userID));
            }

            if (sortByLikes != 0)
            {
                return listComment.OrderByDescending(l => l.CommentLikes);
            }
            else if (sortByDislikes != 0)
            {
                return listComment.OrderByDescending(d => d.CommentDislikes);
            }
            else
            {
                return listComment.OrderByDescending(t => t.Time);
            }

        }


        //DELETE: api/Comments/5
        [Authorize]
        [HttpDelete("{id}")]
        public bool DeleteCommentByID(int id)
        {
            return _ICommentsUI.DeleteComment(id);
        }

        
        [Authorize]
        [Route("commentsWithDislikes")]
        [HttpGet]
        public IEnumerable<CommentInfo> GetCommentsWithMoreThan_N_Dislikes(int userID = 0)
        {
            int n = 0;
            CommentInfo ci;
            var comments = _ICommentsUI.GetAllComments(userID);
            List<CommentInfo> listComment = new List<CommentInfo>();

            foreach (var comment in comments)
            {
                ci = new CommentInfo(comment);
                if (ci.CommentDislikes > n)
                    listComment.Add(ci);
            }

            return listComment.OrderByDescending(x => x.CommentDislikes);
        }

        [Authorize]
        [Route("commentsWithDislikes/userID={userID}")]
        [HttpGet]
        public IEnumerable<CommentInfo> GetCommentsWithMoreThan_N_DislikesForUser(int userID)
        {
            return GetCommentsWithMoreThan_N_Dislikes(userID);
        }

        [Authorize]
        [Route("DissmissCommentReports/commentID={commentID}")]
        [HttpGet]
        public bool DissmissCommentReports(int commentID)
        {
            return _ICommentsUI.DissmissCommentReports(commentID);
        }

        [Authorize]
        [Route("GetApprovedReportedComments/userID={userID}")]
        [HttpGet]
        public IEnumerable<CommentInfo> GetApprovedReportedComments(int userID)
        {
            var approvedReportedComments = _ICommentsUI.GetApprovedReportedComments(userID);
            List<CommentInfo> commentList = new List<CommentInfo>();

            foreach (var comment in approvedReportedComments)
            {
                commentList.Add(new CommentInfo(comment));
            }

            return commentList.OrderByDescending(rc => rc.CommentDislikes);
        }
    }
}
