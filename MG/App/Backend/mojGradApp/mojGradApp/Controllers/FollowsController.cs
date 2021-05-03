using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FollowsController : ControllerBase
    {
        private readonly IFollowsUI _IFollowsUI;

        public FollowsController(IFollowsUI IFollowsUI)
        {
            _IFollowsUI = IFollowsUI;
        }

        // GET: api/Follows
        [Authorize]
        [HttpGet]
        public IEnumerable<Follows> GetFollows()
        {
            return _IFollowsUI.GetFollows();
        }

        [Authorize]
        [Route("user/{id}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetFollowersOfUser(int id)
        {
            var followers =_IFollowsUI.GetAllFollowersByUser1ID(id);
            List<UserInfo> userList = new List<UserInfo>();

            foreach (var user in followers)
            {
                userList.Add(new UserInfo(user));
            }

            return userList.OrderByDescending(x => x.Points);
        }

        [Authorize]
        [Route("whoIsFollowingUser/{id}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetWhoIsFollowingUser(int id)
        {
            var followers = _IFollowsUI.GetWhoIsFollowingUser(id);
            List<UserInfo> userList = new List<UserInfo>();

            foreach (var user in followers)
            {
                userList.Add(new UserInfo(user));
            }

            return userList.OrderByDescending(x => x.Points);
        }

        [Authorize]
        [Route("GetPostOfFollowersByUserID/{id}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetPostsOfFollowersByUserID(int id)
        {
            List<Posts> posts = _IFollowsUI.GetPostsOfFollowersByUserID(id);
            List<PostInfo> postList = new List<PostInfo>();

            foreach (var post in posts)
            {
                postList.Add(new PostInfo(post));
            }

            return postList.OrderByDescending(x => x.Time);
        }


        // POST api/Follows
        [Authorize]
        [HttpPost]
        public bool PostFollow(Follows follow)
        {
            return _IFollowsUI.AddFollow(follow);
        }

        [Authorize]
        [Route("IsThereAFollow/{userFollowID}/{followingUserID}")]
        [HttpGet]
        public bool IsThereAFollow(int userFollowID, int followingUserID)
        {
            return _IFollowsUI.IsThereAFollow(userFollowID, followingUserID);
        }
    }
}
