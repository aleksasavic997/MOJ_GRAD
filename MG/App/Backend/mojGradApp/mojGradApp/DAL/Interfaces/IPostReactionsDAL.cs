using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL.Interfaces
{
    public interface IPostReactionsDAL
    {
        IEnumerable<PostReactions> GetPostReaction();
        bool AddOrDeletePostReaction(PostReactions postReaction);
    }
}
