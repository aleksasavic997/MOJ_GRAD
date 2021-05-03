using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI.Interfaces
{
    public interface IPostsUI
    {
        IEnumerable<Posts> GetPosts();
        Posts PostPost(Posts post);
        Posts GetPost(int id);
        List<Posts> GetAllPosts();
        Posts GetPostByID(int id);
        bool DeletePost(int id);
        List<Posts> GetPostsByUserID(int id);
        List<Posts> GetPostsByUserID(int id, int typeId);
        List<Posts> GetPostsByCategoryID(int id);
        List<Posts> GetPostsByCityID(int id);
        List<Posts> GetPostsByCityIdAndCategoryId(int cityId, int categoryId);
        List<Posts> GetReportedPosts();
        bool ChangePostInfo(Posts post);
        int AddChallengeSolution(Posts solution, int challengeID);
        List<Posts> GetChallengeOrSolution(int postID, int isApproved);
        bool CloseChallenge(int challengeID);
        bool ChallengeRejected(int challengeID, int solutionID);
        List<Posts> GetPostsForInstutuions(int institutionID);
        bool IsSolutionApproved(int solutionID);
        List<Posts> GetFilteredPosts(List<Categories> cl, int UserID, int cityID, int fromFollowers, int activeChallenge);
        List<Posts> GetMostImportantPost(int cityID, int typeID);
        bool DissmissPostReports(int postID);
        List<Posts> GetApprovedReportedPosts();
        bool SaveOrUnsavePost(SavedPosts sp);
        IEnumerable<SavedPosts> GetSavedPosts(int userID);
        List<Posts> GetMostImportantPostByUsesID(int userID, int typeID);
        List<Posts> GetReportedPostsByUserID(int userID);
	bool CheckIfSaved(int userID, int postID);
    }
}
