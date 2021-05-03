using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface ICommentReactionsBL
    {
        CommentReaction AddCommentReaction(CommentReaction commentReaction);
        IEnumerable<CommentReaction> GetCommentReactions();
        bool AddOrDeleteCommentReaction(CommentReaction commentReaction);
    }
}
