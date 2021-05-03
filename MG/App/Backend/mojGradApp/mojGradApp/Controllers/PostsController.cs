using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization.Formatters;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PostsController : ControllerBase
    {
        private readonly IPostsUI _IPostsUI;

        public PostsController(IPostsUI IPostsUI)
        {
            _IPostsUI = IPostsUI;
        }

        // GET: api/Posts
        [Authorize]
        [HttpGet]
        public IEnumerable<PostInfo> GetPosts()
        {
            var posts = _IPostsUI.GetAllPosts();
            List<PostInfo> listPost = new List<PostInfo>();

            foreach (var post in posts.OrderByDescending(t => t.Time))
            {
                listPost.Add(new PostInfo(post));
            }

            return listPost;
        }

        // GET: api/Posts/5
        [Authorize]
        [HttpGet("{id}/userId={userID}")]
        public ActionResult<PostInfo> GetPost(int id, int userID)
        {
            var post = _IPostsUI.GetPostByID(id);

            if (post == null)
            {
                return NotFound();
            }

            return new PostInfo(post, userID);
        }


        // POST: api/Posts
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public bool PostPost(Posts post)
        {
            var p = _IPostsUI.PostPost(post);

            if(p != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        // DELETE: api/Posts/5
        [Authorize]
        [HttpDelete("{id}")]
        public bool DeletePostByID(int id)
        {
            return _IPostsUI.DeletePost(id);
        }

        [Authorize]
        [Route("user/{id}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetPostsByUserID(int id)
        {
            var posts = _IPostsUI.GetPostsByUserID(id);
            List<PostInfo> listPost = new List<PostInfo>();

            foreach (var post in posts.OrderByDescending(t => t.Time))
            {
                listPost.Add(new PostInfo(post));
            }

            return listPost;
        }

        [Authorize]
        [Route("UserPostsFilteredByType/userID={userID}/typeID={typeID}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetUserPostsFilteredByType(int userID, int typeID)
        {
            var posts = _IPostsUI.GetPostsByUserID(userID, typeID);
            List<PostInfo> listPost = new List<PostInfo>();

            foreach (var post in posts.OrderByDescending(t => t.Time))
            {
                listPost.Add(new PostInfo(post));
            }

            return listPost;
        }

        [Authorize]
        [Route("category/{id}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetPostsByCategoryID(int id)
        {
            var posts = _IPostsUI.GetPostsByCategoryID(id);
            List<PostInfo> listPost = new List<PostInfo>();

            foreach (var post in posts.OrderByDescending(t => t.Time))
            {
                listPost.Add(new PostInfo(post));
            }

            return listPost;
        }

        [Authorize]
        [Route("city/{id}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetPostsByCityID(int id)
        {
            var posts = _IPostsUI.GetPostsByCityID(id);
            List<PostInfo> listPost = new List<PostInfo>();

            foreach (var post in posts.OrderByDescending(t => t.Time))
            {
                listPost.Add(new PostInfo(post));
            }

            return listPost;
        }

        [Authorize]
        [Route("city/{cityId}/category/{categoryId}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetPostsByCityIdAndCategoryId(int cityId, int categoryId)
        {
            var posts = _IPostsUI.GetPostsByCityIdAndCategoryId(cityId, categoryId);
            List<PostInfo> listPost = new List<PostInfo>();

            foreach (var post in posts.OrderByDescending(t => t.Time))
            {
                listPost.Add(new PostInfo(post));
            }

            return listPost;
        }

        [Authorize]
        [Route("GetReportedPosts")]
        [HttpGet]
        public IEnumerable<PostInfo> GetReportedPosts()
        {
            var reportedPosts = _IPostsUI.GetReportedPosts();
            List<PostInfo> listReportedPosts = new List<PostInfo>();

            foreach (var post in reportedPosts)
            {
                listReportedPosts.Add(new PostInfo(post));
            }

            return listReportedPosts.OrderByDescending(rc => rc.ReportCount);
        }


        [Authorize]
        [Route("GetReportedPostsByUserID/userID={userID}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetReportedPostsByUserID(int userID)
        {
            var reportedPosts = _IPostsUI.GetReportedPostsByUserID(userID);
            List<PostInfo> listReportedPosts = new List<PostInfo>();

            foreach (var post in reportedPosts)
            {
                listReportedPosts.Add(new PostInfo(post));
            }

            return listReportedPosts.OrderByDescending(rc => rc.ReportCount);
        }


        [Authorize]
        [Route("ChangePostInfo")]
        [HttpPost]
        public bool ChangePostInfo(Posts post)
        {
            return _IPostsUI.ChangePostInfo(post);
        }

        [Authorize]
        [Route("AddChallengeSolution/ChallengeID={challengeID}")]
        [HttpPost]
        public int AddChallengeSolution(Posts solution, int challengeID)
        {
            return _IPostsUI.AddChallengeSolution(solution, challengeID);
        }

        [Authorize]
        [Route("GetChallengeOrSolution/postID={postID}/IsApproved={IsApproved}")]
        [HttpGet]
        public ActionResult<List<PostInfo>> GetChallengeOrSolution(int postID, int IsApproved)
        {
            var posts = _IPostsUI.GetChallengeOrSolution(postID, IsApproved);

            if (posts == null)
            {
                return NotFound();
            }

            List<PostInfo> lp = new List<PostInfo>();
            foreach (var post in posts)
            {
                lp.Add(new PostInfo(post));
            }
            return lp;
        }

        [Authorize]
        [Route("CloseChallenge/challengeID={challengeID}")]
        [HttpPost]
        public bool CloseChallenge(int challengeID)
        {
            return _IPostsUI.CloseChallenge(challengeID);
        }

        [Authorize]
        [Route("ChallengeRejected/challengeID={challengeID}/solutionID={solutionID}")]
        [HttpPost]
        public bool ChallengeRejected(int challengeID, int solutionID)
        {
            return _IPostsUI.ChallengeRejected(challengeID, solutionID);
        }

        [Authorize]
        [Route("IsSolutionApproved/solutionID={solutionID}")]
        [HttpGet]
        public bool IsSolutionApproved(int solutionID)
        {
            return _IPostsUI.IsSolutionApproved(solutionID);
        }


        [Authorize]
        [Route("getPostsForInstitution/institutionID={institutionID}")]
        [HttpGet]
        public List<PostInfo> GetPostsForInstutuions(int institutionID)
        {
            var posts = _IPostsUI.GetPostsForInstutuions(institutionID);

            List<PostInfo> lp = new List<PostInfo>();
            foreach (var post in posts)
            {
                lp.Add(new PostInfo(post));
            }
            return lp;
        }

        [Authorize]
        [Route("getFilteredPosts/UserID={UserID}/cityID={cityID}/fromFollowers={fromFollowers}/activeChallenge={activeChallenge}/sortByReactions={sortByReactions}")]
        [HttpPost]
        public IEnumerable<PostInfo> GetFilteredPosts(List<Categories> cl, int UserID, int cityID, int fromFollowers, int activeChallenge, int sortByReactions)
        {
            //fromFollowers can be 0 or 1, activeChallenge can be 0 or 1, sortByReactions can be 0 or 1

            var posts = _IPostsUI.GetFilteredPosts(cl, UserID, cityID, fromFollowers, activeChallenge);

            List<PostInfo> listPostInfo = new List<PostInfo>();

            foreach (var post in posts)
            {
                listPostInfo.Add(new PostInfo(post));
            }

            if(sortByReactions == 0)
            {
                return listPostInfo.OrderByDescending(rc => rc.Time);
            }
            else
            {
                return listPostInfo.OrderByDescending(rc => rc.ReactionsNumber);
            }
        }

        [Authorize]
        [Route("GetMostImportantPost/cityID={cityID}/typeID={typeID}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetMostImportantPost(int cityID, int typeID)
        {
            int reactionNumberMinimum = 2;
            var posts = _IPostsUI.GetMostImportantPost(cityID, typeID);
            List<PostInfo> listPostInfo = new List<PostInfo>();

            foreach (var post in posts)
            {
                PostInfo pi = new PostInfo(post);
                if (pi.ReactionsNumber > reactionNumberMinimum)
                {
                    listPostInfo.Add(pi);
                }
            }

            return listPostInfo.OrderByDescending(rc => rc.ReactionsNumber);
        }

        [Authorize]
        [Route("GetMostImportantPostByUsesID/userID={userID}/typeID={typeID}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetMostImportantPostByUsesID(int userID, int typeID)
        {
            int reactionNumberMinimum = 2;
            var posts = _IPostsUI.GetMostImportantPostByUsesID(userID, typeID);
            List<PostInfo> listPostInfo = new List<PostInfo>();

            foreach (var post in posts)
            {
                PostInfo pi = new PostInfo(post);
                if(pi.ReactionsNumber > reactionNumberMinimum)
                {
                    listPostInfo.Add(pi);
                }
            }

            return listPostInfo.OrderByDescending(rc => rc.ReactionsNumber);
        }


        [Authorize]
        [Route("DissmissPostReports/postID={postID}")]
        [HttpGet]
        public bool DissmissPostReports(int postID)
        {
            return _IPostsUI.DissmissPostReports(postID);
        }

        [Authorize]
        [Route("GetApprovedReportedPosts")]
        [HttpGet]
        public IEnumerable<PostInfo> GetApprovedReportedPosts()
        {
            var approvedReportedPosts = _IPostsUI.GetApprovedReportedPosts();
            List<PostInfo> postList = new List<PostInfo>();

            foreach (var post in approvedReportedPosts)
            {
                postList.Add(new PostInfo(post));
            }

            return postList.OrderByDescending(rc => rc.ReportCount);
        }

        [Authorize]
        [Route("SaveOrUnsave")]
        [HttpPost]
        public bool SaveOrUnsavePost(SavedPosts sp)
        {
            return _IPostsUI.SaveOrUnsavePost(sp);
        }

        [Authorize]
        [Route("GetSavedPosts/userID={userID}")]
        [HttpGet]
        public IEnumerable<PostInfo> GetSavedPosts(int userID)
        {
            var savedPosts = _IPostsUI.GetSavedPosts(userID);
            List<PostInfo> postList = new List<PostInfo>();

            foreach (var savedPost in savedPosts)
            {
                postList.Add(new PostInfo(_IPostsUI.GetPostByID(savedPost.PostID)));
            }

            return postList;
        }

        [Authorize]
        [Route("CheckIfSaved/UserID={userID}/PostID={postID}")]
        [HttpGet]
        public bool CheckIfSaved(int userID, int postID)
        {
            return _IPostsUI.CheckIfSaved(userID, postID);
        }
    }
}
