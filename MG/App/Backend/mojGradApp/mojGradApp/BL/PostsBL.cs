using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class PostsBL : IPostsBL
    {
        private readonly IPostsDAL _IPostsDAL;

        public PostsBL(IPostsDAL IPostsDAL)
        {
            _IPostsDAL = IPostsDAL;
        }

        public List<Posts> GetAllPosts()
        {
            return _IPostsDAL.GetAllPosts();
        }


        public IEnumerable<Posts> GetPosts()
        {
            return _IPostsDAL.GetPosts();
        }

        public Posts GetPost(int id)
        {
            return _IPostsDAL.GetPost(id);
        }

        public Posts GetPostByID(int id)
        {
            return _IPostsDAL.GetPostByID(id);
        }

        public Posts PostPost(Posts post)
        {
            return _IPostsDAL.PostPost(post);
        }

        public bool DeletePost(int id)
        {
            return _IPostsDAL.DeletePost(id);
        }

        public List<Posts> GetPostsByUserID(int id)
        {
            return _IPostsDAL.GetPostsByUserID(id);
        }

        public List<Posts> GetPostsByUserID(int id, int typeId)
        {
            return _IPostsDAL.GetPostsByUserID(id, typeId);
        }

        public List<Posts> GetPostsByCategoryID(int id)
        {
            return _IPostsDAL.GetPostsByCategoryID(id);
        }

        public List<Posts> GetPostsByCityID(int id)
        {
            return _IPostsDAL.GetPostsByCityID(id);
        }

        public List<Posts> GetPostsByCityIdAndCategoryId(int cityId, int categoryId)
        {
            return _IPostsDAL.GetPostsByCityIdAndCategoryId(cityId, categoryId);
        }

        public List<Posts> GetReportedPosts()
        {
            return _IPostsDAL.GetReportedPosts();
        }

        public bool ChangePostInfo(Posts post)
        {
            return _IPostsDAL.ChangePostInfo(post);
        }

        public int AddChallengeSolution(Posts solution, int challengeID)
        {
            return _IPostsDAL.AddChallengeSolution(solution, challengeID);
        }

        public List<Posts> GetChallengeOrSolution(int postID, int isApproved)
        {
            return _IPostsDAL.GetChallengeOrSolution(postID, isApproved);
        }

        public bool CloseChallenge(int challengeID)
        {
            return _IPostsDAL.CloseChallenge(challengeID);
        }

        public bool ChallengeRejected(int challengeID, int solutionID)
        {
            return _IPostsDAL.ChallengeRejected(challengeID, solutionID);
        }

        public List<Posts> GetPostsForInstutuions(int institutionID)
        {
            return _IPostsDAL.GetPostsForInstutuions(institutionID);
        }

        public bool IsSolutionApproved(int solutionID)
        {
            return _IPostsDAL.IsSolutionApproved(solutionID);
        }

        public List<Posts> GetFilteredPosts(List<Categories> cl, int UserID, int cityID, int fromFollowers, int activeChallenge)
        {
            return _IPostsDAL.GetFilteredPosts(cl, UserID, cityID, fromFollowers, activeChallenge);
        }

        public List<Posts> GetMostImportantPost(int cityID, int typeID)
        {
            return _IPostsDAL.GetMostImportantPost(cityID, typeID);
        }

        public bool DissmissPostReports(int postID)
        {
            return _IPostsDAL.DissmissPostReports(postID);
        }

        public List<Posts> GetApprovedReportedPosts()
        {
            return _IPostsDAL.GetApprovedReportedPosts();
        }

        public bool SaveOrUnsavePost(SavedPosts sp)
        {
            return _IPostsDAL.SaveOrUnsavePost(sp);
        }

        public IEnumerable<SavedPosts> GetSavedPosts(int userID)
        {
            return _IPostsDAL.GetSavedPosts(userID);
        }

        public List<Posts> GetMostImportantPostByUsesID(int userID, int typeID)
        {
            return _IPostsDAL.GetMostImportantPostByUsesID(userID, typeID);
        }

        public List<Posts> GetReportedPostsByUserID(int userID)
        {
            return _IPostsDAL.GetReportedPostsByUserID(userID);
        }

        public bool CheckIfSaved(int userID, int postID)
        {
            return _IPostsDAL.CheckIfSaved(userID, postID);
        }
    }
}
