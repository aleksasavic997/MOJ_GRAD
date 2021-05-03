using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class FollowsBL : IFollowsBL
    {
        private readonly IFollowsDAL _IFollowsDAL;

        public FollowsBL(IFollowsDAL IFollowsDAL)
        {
            _IFollowsDAL = IFollowsDAL;
        }

        public bool AddFollow(Follows follow)
        {
            return _IFollowsDAL.AddFollow(follow);
        }

        public List<UserDatas> GetAllFollowersByUser1ID(int id)
        {
            return _IFollowsDAL.GetAllFollowersByUser1ID(id);
        }

        public IEnumerable<Follows> GetFollows()
        {
            return _IFollowsDAL.GetFollows();
        }

        public List<Posts> GetPostsOfFollowersByUserID(int id)
        {
            return _IFollowsDAL.GetPostsOfFollowersByUserID(id);
        }

        public List<UserDatas> GetWhoIsFollowingUser(int id)
        {
            return _IFollowsDAL.GetWhoIsFollowingUser(id);
        }

        public bool IsThereAFollow(int userFollowID, int followingUserID)
        {
            return _IFollowsDAL.IsThereAFollow(userFollowID, followingUserID);
        }
    }
}
