using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface IFollowsBL
    {
        bool AddFollow(Follows follow);
        List<UserDatas> GetAllFollowersByUser1ID(int id);
        List<Posts> GetPostsOfFollowersByUserID(int id);
        IEnumerable<Follows> GetFollows();
        bool IsThereAFollow(int userFollowID, int followingUserID);
        List<UserDatas> GetWhoIsFollowingUser(int id);
    }
}
