using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class PostsUI : IPostsUI
    {
        private readonly IPostsBL _IPostsBL;

        public PostsUI(IPostsBL IPostsBL)
        {
            _IPostsBL = IPostsBL;
        }

        public List<Posts> GetAllPosts()
        {
            return _IPostsBL.GetAllPosts();
        }


        public IEnumerable<Posts> GetPosts()
        {
            return _IPostsBL.GetPosts();
        }

        public Posts GetPostByID(int id)
        {
            return _IPostsBL.GetPostByID(id);
        }

        public Posts GetPost(int id)
        {
            return _IPostsBL.GetPost(id);
        }

        public Posts PostPost(Posts post)
        {
            return _IPostsBL.PostPost(post);
        }

        public bool DeletePost(int id)
        {
            return _IPostsBL.DeletePost(id);
        }

        public List<Posts> GetPostsByUserID(int id)
        {
            return _IPostsBL.GetPostsByUserID(id);
        }

        public List<Posts> GetPostsByUserID(int id, int typeId)
        {
            return _IPostsBL.GetPostsByUserID(id, typeId);
        }

        public List<Posts> GetPostsByCategoryID(int id)
        {
            return _IPostsBL.GetPostsByCategoryID(id);
        }

        public List<Posts> GetPostsByCityID(int id)
        {
            return _IPostsBL.GetPostsByCityID(id);
        }

        public List<Posts> GetPostsByCityIdAndCategoryId(int cityId, int categoryId)
        {
            return _IPostsBL.GetPostsByCityIdAndCategoryId(cityId, categoryId);
        }

        public List<Posts> GetReportedPosts()
        {
            return _IPostsBL.GetReportedPosts();
        }

        public bool ChangePostInfo(Posts post)
        {
            return _IPostsBL.ChangePostInfo(post);
        }

        public int AddChallengeSolution(Posts solution, int challengeID)
        {
            return _IPostsBL.AddChallengeSolution(solution, challengeID);
        }

        public List<Posts> GetChallengeOrSolution(int postID, int isApproved)
        {
            return _IPostsBL.GetChallengeOrSolution(postID, isApproved);
        }

        public bool CloseChallenge(int challengeID)
        {
            return _IPostsBL.CloseChallenge(challengeID);
        }

        public bool ChallengeRejected(int challengeID, int solutionID)
        {
            return _IPostsBL.ChallengeRejected(challengeID, solutionID);
        }

        public List<Posts> GetPostsForInstutuions(int institutionID)
        {
            return _IPostsBL.GetPostsForInstutuions(institutionID);
        }

        public bool IsSolutionApproved(int solutionID)
        {
            return _IPostsBL.IsSolutionApproved(solutionID);
        }

        public List<Posts> GetFilteredPosts(List<Categories> cl, int UserID, int cityID, int fromFollowers, int activeChallenge)
        {
            return _IPostsBL.GetFilteredPosts(cl, UserID, cityID, fromFollowers, activeChallenge);
        }

        public List<Posts> GetMostImportantPost(int cityID, int typeID)
        {
            return _IPostsBL.GetMostImportantPost(cityID, typeID);
        }

        public bool DissmissPostReports(int postID)
        {
            return _IPostsBL.DissmissPostReports(postID);
        }

        public List<Posts> GetApprovedReportedPosts()
        {
            return _IPostsBL.GetApprovedReportedPosts();
        }

        public bool SaveOrUnsavePost(SavedPosts sp)
        {
            return _IPostsBL.SaveOrUnsavePost(sp);
        }

        public IEnumerable<SavedPosts> GetSavedPosts(int userID)
        {
            return _IPostsBL.GetSavedPosts(userID);
        }

        public List<Posts> GetMostImportantPostByUsesID(int userID, int typeID)
        {
            return _IPostsBL.GetMostImportantPostByUsesID(userID, typeID);
        }

        public List<Posts> GetReportedPostsByUserID(int userID)
        {
            return _IPostsBL.GetReportedPostsByUserID(userID);
        }

        public bool CheckIfSaved(int userID, int postID)
        {
            return _IPostsBL.CheckIfSaved(userID, postID);
        }
    }
}
