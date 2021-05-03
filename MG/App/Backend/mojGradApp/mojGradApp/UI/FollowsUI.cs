using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class FollowsUI : IFollowsUI
    {
        private readonly IFollowsBL _IFollowsBL;

        public FollowsUI(IFollowsBL IFollowsBL)
        {
            _IFollowsBL = IFollowsBL;
        }

        public bool AddFollow(Follows follow)
        {
            return _IFollowsBL.AddFollow(follow);
        }

        public List<UserDatas> GetAllFollowersByUser1ID(int id)
        {
            return _IFollowsBL.GetAllFollowersByUser1ID(id);
        }

        public IEnumerable<Follows> GetFollows()
        {
            return _IFollowsBL.GetFollows();
        }

        public List<Posts> GetPostsOfFollowersByUserID(int id)
        {
            return _IFollowsBL.GetPostsOfFollowersByUserID(id);
        }

        public List<UserDatas> GetWhoIsFollowingUser(int id)
        {
            return _IFollowsBL.GetWhoIsFollowingUser(id);
        }

        public bool IsThereAFollow(int userFollowID, int followingUserID)
        {
            return _IFollowsBL.IsThereAFollow(userFollowID, followingUserID);
        }
    }
}
