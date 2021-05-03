using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class PostReactionsDAL : IPostReactionsDAL
    {
        private readonly ApplicationDbContext mgd;

        public PostReactionsDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public bool AddOrDeletePostReaction(PostReactions postReaction)
        {
            var postCheck = mgd.Post.Where(x => x.Id == postReaction.PostID).FirstOrDefault();

            if(postCheck != null)
            {
                var pr = mgd.PostReaction.Where(x => x.PostID == postReaction.PostID && x.UserID == postReaction.UserID).FirstOrDefault();
            
                if(pr != null)
                {
                    mgd.PostReaction.Remove(pr);
                    mgd.SaveChanges();

                    return true;
                }
                else
                {
                    mgd.PostReaction.Add(postReaction);
                    mgd.SaveChanges();

                    return true;
                }
            }

            return false;
        }

        public IEnumerable<PostReactions> GetPostReaction()
        {
            return mgd.PostReaction.ToList();
        }

    }
}
