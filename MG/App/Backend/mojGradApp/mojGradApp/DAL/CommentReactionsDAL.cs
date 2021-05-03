using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class CommentReactionsDAL : ICommentReactionsDAL
    {
        private readonly ApplicationDbContext mgd;

        public CommentReactionsDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public CommentReaction AddCommentReaction(CommentReaction commentReaction)
        {
            mgd.CommentReaction.Add(commentReaction);
            mgd.SaveChanges();

            return commentReaction;
        }

        public bool AddOrDeleteCommentReaction(CommentReaction commentReaction)
        {
            var commentCheck = mgd.Comment.Where(x => x.Id == commentReaction.CommentID).FirstOrDefault();

            if(commentCheck != null)
            {
                var cr = mgd.CommentReaction.Where(x => x.CommentID == commentReaction.CommentID && x.UserID == commentReaction.UserID).FirstOrDefault();

                if (cr == null)
                {
                    mgd.CommentReaction.Add(commentReaction);
                    mgd.SaveChanges();

                    return true;
                }
                else
                {
                    if (commentReaction.Type == cr.Type)
                    {
                        mgd.CommentReaction.Remove(cr);
                        mgd.SaveChanges();

                        return true;
                    }
                    else
                    {
                        cr.Type = commentReaction.Type;
                        mgd.CommentReaction.Update(cr);
                        mgd.SaveChanges();

                        return true;
                    }
                }
            }

            return false;
        }

        public IEnumerable<CommentReaction> GetCommentReactions()
        {
            return mgd.CommentReaction.ToList();
        }
    }
}
