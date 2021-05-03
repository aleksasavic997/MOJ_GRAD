using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class PostReactionsBL : IPostReactionsBL
    {
        private readonly IPostReactionsDAL _IPostReactionsDAL;

        public PostReactionsBL(IPostReactionsDAL IPostReactionsDAL)
        {
            _IPostReactionsDAL = IPostReactionsDAL;
        }

        public bool AddOrDeletePostReaction(PostReactions postReaction)
        {
            return _IPostReactionsDAL.AddOrDeletePostReaction(postReaction);
        }

        public IEnumerable<PostReactions> GetPostReaction()
        {
            return _IPostReactionsDAL.GetPostReaction();
        }

    }
}
