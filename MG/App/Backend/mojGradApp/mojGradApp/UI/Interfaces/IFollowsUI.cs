using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI.Interfaces
{
    public interface IFollowsUI
    {
        bool AddFollow(Follows follow);
        List<UserDatas> GetAllFollowersByUser1ID(int id);
        List<Posts> GetPostsOfFollowersByUserID(int id);
        IEnumerable<Follows> GetFollows();
        bool IsThereAFollow(int userFollowID, int followingUserID);
        List<UserDatas> GetWhoIsFollowingUser(int id);
    }
}
