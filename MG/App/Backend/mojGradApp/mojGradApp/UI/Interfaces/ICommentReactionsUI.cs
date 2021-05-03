using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI.Interfaces
{
    public interface ICommentReactionsUI
    {
        IEnumerable<CommentReaction> GetCommentReactions();
        CommentReaction AddCommentReaction(CommentReaction commentReaction);
        bool AddOrDeleteCommentReaction(CommentReaction commentReaction);
    }
}
