using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class CommentReactionsBL : ICommentReactionsBL
    {
        private readonly ICommentReactionsDAL _ICommentReactionsDAL;

        public CommentReactionsBL(ICommentReactionsDAL ICommentReactionsDAL)
        {
            _ICommentReactionsDAL = ICommentReactionsDAL;
        }

        public CommentReaction AddCommentReaction(CommentReaction commentReaction)
        {
            return _ICommentReactionsDAL.AddCommentReaction(commentReaction);
        }

        public bool AddOrDeleteCommentReaction(CommentReaction commentReaction)
        {
            return _ICommentReactionsDAL.AddOrDeleteCommentReaction(commentReaction);
        }

        public IEnumerable<CommentReaction> GetCommentReactions()
        {
            return _ICommentReactionsDAL.GetCommentReactions();
        }
    }
}
