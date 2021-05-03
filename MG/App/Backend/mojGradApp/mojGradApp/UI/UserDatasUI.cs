using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using mojGradApp.BL.Interfaces;
using mojGradApp.Controllers;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class UserDatasUI : IUserDatasUI
    {
        private readonly IUserDatasBL _IUserDatasBL;

        public UserDatasUI(IUserDatasBL IUserDatasBL)
        {
            _IUserDatasBL = IUserDatasBL;
        }

        public bool ChangeUserInfo(UserDatas user)
        {
            return _IUserDatasBL.ChangeUserInfo(user);
        }

        public bool CheckEmail(UserEmail email)
        {
            return _IUserDatasBL.CheckEmail(email);
        }

        public UserDatas CheckUser(Login login, int UserTypeID)
        {
            return _IUserDatasBL.CheckUser(login, UserTypeID);
        }

        public bool CheckUsername(UsernameReg username)
        {
            return _IUserDatasBL.CheckUsername(username);
        }

        public List<UserDatas> GetAllUsers(int userTypeID, int userID)
        {
            return _IUserDatasBL.GetAllUsers(userTypeID, userID);
        }

        public UserDatas GetUserByID(int id)
        {
            return _IUserDatasBL.GetUserByID(id);
        }

        public IEnumerable<UserDatas> GetUserDatas()
        {
            return _IUserDatasBL.GetUserDatas();
        }

        public UserDatas GetUserData(int id)
        {
            return _IUserDatasBL.GetUserData(id);
        }

        public bool PostUserData(UserDatas userData)
        {
            return _IUserDatasBL.PostUserData(userData);
        }
		
		public bool DeleteUser(int id)
        {
            return _IUserDatasBL.DeleteUser(id);
        }

        public List<UserDatas> GetReportedUsers()
        {
            return _IUserDatasBL.GetReportedUsers();
        }

        public List<UserDatas> GetUsersThatReactedOnPost(int postID)
        {
            return _IUserDatasBL.GetUsersThatReactedOnPost(postID);
        }

        public List<UserDatas> GetUsersThatLikedOrDislikedComment(int commentID, int reactionType)
        {
            return _IUserDatasBL.GetUsersThatLikedOrDislikedComment(commentID, reactionType);
        }

        public List<UserDatas> GetUsersByCityID(int userTypeID, int cityID, int userID, int categoryID, int verification)
        {
            return _IUserDatasBL.GetUsersByCityID(userTypeID, cityID, userID, categoryID, verification);
        }

        public bool CheckIfAlreadyLogged(int userID)
        {
            return _IUserDatasBL.CheckIfAlreadyLogged(userID);
        }

        public bool Logout(int userID)
        {
            return _IUserDatasBL.Logout(userID);
        }

        public string CheckRang(int userID)
        {
            var rankName = _IUserDatasBL.CheckRang(userID);

            if (rankName != null)
                return rankName;

            return null;
        }

        public IEnumerable<UserDatas> GetBest(int userTypeID, int days, int userNumber)
        {
            return _IUserDatasBL.GetBest(userTypeID, days, userNumber);
        }

        public int GetPointsForUser(int userID, int days)
        {
            return _IUserDatasBL.GetPointsForUser(userID, days);
        }

        public List<UserDatas> GetFollowSugestions(int userID, int userTypeID)
        {
            return _IUserDatasBL.GetFollowSugestions(userID, userTypeID);
        }

        public bool DissmissUserReports(int userID)
        {
            return _IUserDatasBL.DissmissUserReports(userID);
        }

        public List<UserDatas> GetApprovedReportedUsers()
        {
            return _IUserDatasBL.GetApprovedReportedUsers();
        }

        public void Verify(int id)
        {
            _IUserDatasBL.Verify(id);
        }

        //-------------------------------------- MESSAGES ---------------------------------------//
        public bool SendMessage(Messages message)
        {
            return _IUserDatasBL.SendMessage(message);
        }

        public bool DeleteMessage(int messageID)
        {
            return _IUserDatasBL.DeleteMessage(messageID);
        }

        public IEnumerable<UserDatas> GetAllUsersYouChattedWith(int userID)
        {
            return _IUserDatasBL.GetAllUsersYouChattedWith(userID);
        }

        public IEnumerable<Messages> GetAllMessages(int user1ID, int user2ID)
        {
            return _IUserDatasBL.GetAllMessages(user1ID, user2ID);
        }

        public int GetNumberOfUnreadMessages(int user1ID, int user2ID)
        {
            return _IUserDatasBL.GetNumberOfUnreadMessages(user1ID, user2ID);
        }

        public bool ReadMessages(int user1ID, int user2ID)
        {
            return _IUserDatasBL.ReadMessages(user1ID, user2ID);
        }
        //----------------------------------- END OF MESSAGES ------------------------------------//

        public IEnumerable<UserDatas> NotVerifiedInstitutions()
        {
            return _IUserDatasBL.NotVerifiedInstitutions();
        }

        public IEnumerable<UserStatisticInfo> GetUserStatistics(int cityID, int byDay, int byMonth, int byYear)
        {
            return _IUserDatasBL.GetUserStatistics(cityID, byDay, byMonth, byYear);
        }

        public bool ResetForgottenPassword(string username)
        {
            return _IUserDatasBL.ResetForgottenPassword(username);
        }

        public IEnumerable<UserDatas> InstitutionsByCityAndCategory(int cityID, int categoryID, int userTypeID)
        {
            return _IUserDatasBL.InstitutionsByCityAndCategory(cityID, categoryID, userTypeID);
        }
    }
}
