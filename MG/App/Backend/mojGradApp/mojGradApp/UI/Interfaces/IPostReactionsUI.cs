using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI.Interfaces
{
    public interface IPostReactionsUI
    {
        IEnumerable<PostReactions> GetPostReaction();
        bool AddOrDeletePostReaction(PostReactions postReaction);
    }
}
