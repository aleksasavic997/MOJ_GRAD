using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class CommentReactionsUI : ICommentReactionsUI
    {
        private readonly ICommentReactionsBL _ICommentReactionBL;

        public CommentReactionsUI(ICommentReactionsBL ICommentLikesBL)
        {
            _ICommentReactionBL = ICommentLikesBL;
        }

        public CommentReaction AddCommentReaction(CommentReaction commentReaction)
        {
            return _ICommentReactionBL.AddCommentReaction(commentReaction);
        }

        public bool AddOrDeleteCommentReaction(CommentReaction commentReaction)
        {
            return _ICommentReactionBL.AddOrDeleteCommentReaction(commentReaction);
        }

        public IEnumerable<CommentReaction> GetCommentReactions()
        {
            return _ICommentReactionBL.GetCommentReactions();
        }
    }
}
