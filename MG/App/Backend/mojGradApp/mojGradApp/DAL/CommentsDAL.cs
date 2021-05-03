using Microsoft.EntityFrameworkCore;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class CommentsDAL : ICommentsDAL
    {
        private readonly ApplicationDbContext mgd;
        private readonly int numberOfDislikes = 2;

        public CommentsDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public bool AddComment(Comments comm)
        {
            var postCheck = mgd.Post.Where(x => x.Id == comm.PostID).FirstOrDefault();

            if(postCheck != null)
            {
                mgd.Comment.Add(comm);
                mgd.SaveChangesAsync();
                return true;
            }

            return false;
        }

        public bool DeleteComment(int id)
        {
            var comment = mgd.Comment.Where(x => x.Id == id).FirstOrDefault();
            if (comment != null)
            {
                mgd.Comment.Remove(comment);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public bool DissmissCommentReports(int commentID)
        {
            var commentReports = mgd.CommentReaction.Where(x => x.CommentID == commentID && x.Type == -1 && x.IsApproved == false).ToList();

            if (commentReports != null)
            {
                foreach (var item in commentReports)
                {
                    item.IsApproved = true;
                    mgd.CommentReaction.Update(item);
                    mgd.SaveChanges();
                }

                return true;
            }

            return false;
        }

        public Comments FindCommentByID(int id)
        {
            return mgd.Comment.Where(x => x.Id == id).FirstOrDefault();
        }

        public List<Comments> GetAllComments(int userID)
        {
            List<Comments> commentList = new List<Comments>();

            if(userID == 0)
            {
                var commentsWithDislikes = mgd.CommentReaction.Where(x => x.Type == -1 && x.IsApproved == false).Select(x => x.CommentID).ToList().Distinct();

                foreach (var id in commentsWithDislikes)
                {
                    if(mgd.CommentReaction.Where(x => x.CommentID == id && x.Type == -1 && x.IsApproved == true).FirstOrDefault() == null)
                    {
                        commentList.Add(mgd.Comment.Where(x => x.Id == id)
                            .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).FirstOrDefault());
                    }
                    else
                    {
                        if (mgd.CommentReaction.Where(x => x.CommentID == id && x.Type == -1 && x.IsApproved == false).Count() >= numberOfDislikes)
                        {
                            commentList.Add(mgd.Comment.Where(x => x.Id == id)
                                .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).FirstOrDefault());
                        }
                    }
                }
            }
            else
            {
                var commentsWithDislikes = mgd.CommentReaction.Where(x => x.Comment.UserID == userID && x.Type == -1 && x.IsApproved == false).Select(x => x.CommentID).ToList().Distinct();

                foreach (var id in commentsWithDislikes)
                {
                    if (mgd.CommentReaction.Where(x => x.Comment.UserID == userID && x.CommentID == id && x.Type == -1 && x.IsApproved == true).FirstOrDefault() == null)
                    {
                        commentList.Add(mgd.Comment.Where(x => x.Id == id)
                            .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).FirstOrDefault());
                    }
                    else
                    {
                        if (mgd.CommentReaction.Where(x => x.Comment.UserID == userID && x.CommentID == id && x.Type == -1 && x.IsApproved == false).Count() >= numberOfDislikes)
                        {
                            commentList.Add(mgd.Comment.Where(x => x.Id == id)
                                .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).FirstOrDefault());
                        }
                    }
                }
            }

            return commentList;
        }

        public List<Comments> GetApprovedReportedComments(int userID)
        {
            List<Comments> commentList = new List<Comments>();

            if (userID == 0)
            {
                var commentsWithDislikes = mgd.CommentReaction.Where(x => x.Type == -1 && x.IsApproved == true).Select(x => x.CommentID).ToList().Distinct();

                foreach (var id in commentsWithDislikes)
                {
                    if (mgd.CommentReaction.Where(x => x.CommentID == id && x.Type == -1 && x.IsApproved == false).FirstOrDefault() == null)
                    {
                        commentList.Add(mgd.Comment.Where(x => x.Id == id)
                            .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).FirstOrDefault());
                    }
                    else
                    {
                        if (mgd.CommentReaction.Where(x => x.CommentID == id && x.Type == -1 && x.IsApproved == false).Count() < numberOfDislikes)
                        {
                            commentList.Add(mgd.Comment.Where(x => x.Id == id)
                                .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).FirstOrDefault());
                        }
                    }
                }
            }
            else
            {
                var commentsWithDislikes = mgd.CommentReaction.Where(x => x.Comment.UserID == userID && x.Type == -1 && x.IsApproved == true).Select(x => x.CommentID).ToList().Distinct();

                foreach (var id in commentsWithDislikes)
                {
                    if (mgd.CommentReaction.Where(x => x.Comment.UserID == userID && x.CommentID == id && x.Type == -1 && x.IsApproved == false).FirstOrDefault() == null)
                    {
                        commentList.Add(mgd.Comment.Where(x => x.Id == id)
                            .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).FirstOrDefault());
                    }
                    else
                    {
                        if (mgd.CommentReaction.Where(x => x.Comment.UserID == userID && x.CommentID == id && x.Type == -1 && x.IsApproved == false).Count() < numberOfDislikes)
                        {
                            commentList.Add(mgd.Comment.Where(x => x.Id == id)
                                .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).FirstOrDefault());
                        }
                    }
                }
            }

            return commentList;
        }

        public IEnumerable<Comments> GetComment()
        {
            return mgd.Comment.ToList();
        }

        public List<Comments> GetCommentsByPostID(int id)
        {
           return  mgd.Comment.Where(x => x.PostID == id)
                .Include(p => p.Post).Include(u => u.User).Include(cl => cl.CommentReaction).ToList();
        }
    }
}
