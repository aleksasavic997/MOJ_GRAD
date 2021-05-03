using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface IPostReactionsBL
    {
        IEnumerable<PostReactions> GetPostReaction();
        bool AddOrDeletePostReaction(PostReactions postReaction);
    }
}
