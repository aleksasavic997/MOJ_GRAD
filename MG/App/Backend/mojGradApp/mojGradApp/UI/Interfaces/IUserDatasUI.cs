using Microsoft.AspNetCore.Mvc;
using mojGradApp.Controllers;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI.Interfaces
{
    public interface IUserDatasUI
    {
        UserDatas CheckUser(Login login, int UserTypeID);
        IEnumerable<UserDatas> GetUserDatas();
        bool PostUserData(UserDatas userData);
        bool CheckEmail(UserEmail email);
        bool CheckUsername(UsernameReg username);
        UserDatas GetUserData(int id);
        List<UserDatas> GetAllUsers(int userTypeID, int userID);
        UserDatas GetUserByID(int id);
		bool DeleteUser(int id);
        bool ChangeUserInfo(UserDatas user);
        List<UserDatas> GetReportedUsers();
        List<UserDatas> GetUsersThatReactedOnPost(int postID);
        List<UserDatas> GetUsersThatLikedOrDislikedComment(int commentID, int reactionType);
        List<UserDatas> GetUsersByCityID(int userTypeID, int cityID, int userID, int categoryID, int verification);
        bool CheckIfAlreadyLogged(int userID);
        bool Logout(int userID);
        string CheckRang(int userID);
        IEnumerable<UserDatas> GetBest(int userTypeID, int days, int userNumber);
        int GetPointsForUser(int userID, int days);
        List<UserDatas> GetFollowSugestions(int userID, int userTypeID);
        bool DissmissUserReports(int userID);
        List<UserDatas> GetApprovedReportedUsers();
        void Verify(int id);
        bool SendMessage(Messages message);
        bool DeleteMessage(int messageID);
        IEnumerable<UserDatas> GetAllUsersYouChattedWith(int userID);
        IEnumerable<Messages> GetAllMessages(int user1ID, int user2ID);
        int GetNumberOfUnreadMessages(int user1ID, int user2ID);
        bool ReadMessages(int user1ID, int user2ID);
        IEnumerable<UserDatas> NotVerifiedInstitutions();
        IEnumerable<UserStatisticInfo> GetUserStatistics(int cityID, int byDay, int byMonth, int byYear);
        bool ResetForgottenPassword(string username);
        IEnumerable<UserDatas> InstitutionsByCityAndCategory(int cityID, int categoryID, int userTypeID);
    }
}
