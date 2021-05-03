using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class PostReactionsUI : IPostReactionsUI
    {
        private readonly IPostReactionsBL _IPostReactionsBL;

        public PostReactionsUI(IPostReactionsBL IPostReactionsBL)
        {
            _IPostReactionsBL = IPostReactionsBL;
        }

        public bool AddOrDeletePostReaction(PostReactions postReaction)
        {
            return _IPostReactionsBL.AddOrDeletePostReaction(postReaction);
        }

        public IEnumerable<PostReactions> GetPostReaction()
        {
            return _IPostReactionsBL.GetPostReaction();
        }

    }
}
