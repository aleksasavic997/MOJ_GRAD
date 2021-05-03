using Microsoft.EntityFrameworkCore;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class FollowsDAL : IFollowsDAL
    {
        private readonly ApplicationDbContext mgd;

        public FollowsDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public bool AddFollow(Follows follow)
        {
            var userCheck = mgd.User.Where(x => x.Id == follow.FollowedUserID).FirstOrDefault();

            if(userCheck != null)
            {
                var f = mgd.Follow.Where(x => x.UserFollowID == follow.UserFollowID && x.FollowedUserID == follow.FollowedUserID).FirstOrDefault();

                if(f != null)
                {
                    mgd.Follow.Remove(f);
                    mgd.SaveChanges();

                    return true;
                }
                else
                {
                    mgd.Follow.Add(follow);
                    mgd.SaveChanges();

                    return true;
                }
            }

            return false;
        }

        public List<UserDatas> GetAllFollowersByUser1ID(int id)
        {
            var followerIDs = mgd.Follow.Where(x => x.UserFollowID == id).Select(x => x.FollowedUserID).ToList();

            return mgd.User.Where(x => followerIDs.Contains(x.Id)).
                Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported)
                .Include(c => c.City).Include(po => po.Point).Include(x => x.Posts).ToList();
        }

        public List<UserDatas> GetWhoIsFollowingUser(int id)
        {
            var followerIDs = mgd.Follow.Where(x => x.FollowedUserID == id).Select(x => x.UserFollowID).ToList();

            return mgd.User.Where(x => followerIDs.Contains(x.Id)).
                Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported)
                .Include(c => c.City).Include(po => po.Point).Include(x => x.Posts).ToList();
        }

        public IEnumerable<Follows> GetFollows()
        {
            return mgd.Follow.ToList();
        }

        public List<Posts> GetPostsOfFollowersByUserID(int id)
        {
            var followerIDs = mgd.Follow.Where(x => x.UserFollowID == id).Select(x => x.FollowedUserID).ToList();

            return mgd.Post.Where(x => followerIDs.Contains(x.UserID)).
                Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
        }

        public bool IsThereAFollow(int userFollowID, int followingUserID)
        {
            var f = mgd.Follow.Where(x => x.UserFollowID == userFollowID && x.FollowedUserID == followingUserID).FirstOrDefault();

            if (f != null)
                return true;

            return false;
        }
    }
}
