using Microsoft.AspNetCore.Mvc;
using mojGradApp.BL.Interfaces;
using mojGradApp.Controllers;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class UserDatasBL : IUserDatasBL
    {
        private readonly IUserDatasDAL _IUserDatasDAL;

        public UserDatasBL(IUserDatasDAL IUserDatasDAL)
        {
            _IUserDatasDAL = IUserDatasDAL;
        }

        public bool ChangeUserInfo(UserDatas user)
        {
            return _IUserDatasDAL.ChangeUserInfo(user);
        }

        public bool CheckEmail(UserEmail email)
        {
            return _IUserDatasDAL.CheckEmail(email);
        }

        public UserDatas CheckUser(Login login, int UserTypeID)
        {
            return _IUserDatasDAL.CheckUser(login, UserTypeID);
        }

        public bool CheckUsername(UsernameReg username)
        {
            return _IUserDatasDAL.CheckUsername(username);
        }

        public List<UserDatas> GetAllUsers(int userTypeID, int userID)
        {
            return _IUserDatasDAL.GetAllUsers(userTypeID, userID);
        }

        public UserDatas GetUserByID(int id)
        {
            return _IUserDatasDAL.GetUserByID(id);
        }

        public IEnumerable<UserDatas> GetUserDatas()
        {
            return _IUserDatasDAL.GetUserDatas();
        }

        public UserDatas GetUserData(int id)
        {
            return _IUserDatasDAL.GetUserData(id);
        }

        public bool PostUserData(UserDatas userData)
        {
            return _IUserDatasDAL.PostUserData(userData);
        }
		
		public bool DeleteUser(int id)
        {
            return _IUserDatasDAL.DeleteUser(id);
        }

        public List<UserDatas> GetReportedUsers()
        {
            return _IUserDatasDAL.GetReportedUsers();
        }

        public List<UserDatas> GetUsersThatReactedOnPost(int postID)
        {
            return _IUserDatasDAL.GetUsersThatReactedOnPost(postID);
        }

        public List<UserDatas> GetUsersThatLikedOrDislikedComment(int commentID, int reactionType)
        {
            return _IUserDatasDAL.GetUsersThatLikedOrDislikedComment(commentID, reactionType);
        }

        public List<UserDatas> GetUsersByCityID(int userTypeID, int cityID, int userID, int categoryID, int verification)
        {
            return _IUserDatasDAL.GetUsersByCityID(userTypeID, cityID, userID, categoryID, verification);
        }

        public bool CheckIfAlreadyLogged(int userID)
        {
            return _IUserDatasDAL.CheckIfAlreadyLogged(userID);
        }

        public bool Logout(int userID)
        {
            return _IUserDatasDAL.Logout(userID);
        }

        public string CheckRang(int userID)
        {
            return _IUserDatasDAL.CheckRang(userID);
        }

        public IEnumerable<UserDatas> GetBest(int userTypeID, int days, int userNumber)
        {
            return _IUserDatasDAL.GetBest(userTypeID, days, userNumber);
        }

        public int GetPointsForUser(int userID, int days)
        {
            return _IUserDatasDAL.GetPointsForUser(userID, days);
        }

        public List<UserDatas> GetFollowSugestions(int userID, int userTypeID)
        {
            return _IUserDatasDAL.GetFollowSugestions(userID, userTypeID);
        }

        public bool DissmissUserReports(int userID)
        {
            return _IUserDatasDAL.DissmissUserReports(userID);
        }

        public List<UserDatas> GetApprovedReportedUsers()
        {
            return _IUserDatasDAL.DissmissUserReports();
        }

        public void Verify(int id)
        {
            _IUserDatasDAL.Verify(id);
        }

        //-------------------------------------- MESSAGES ---------------------------------------//
        public bool SendMessage(Messages message)
        {
            return _IUserDatasDAL.SendMessage(message);
        }

        public bool DeleteMessage(int messageID)
        {
            return _IUserDatasDAL.DeleteMessage(messageID);
        }

        public IEnumerable<UserDatas> GetAllUsersYouChattedWith(int userID)
        {
            return _IUserDatasDAL.GetAllUsersYouChattedWith(userID);
        }

        public IEnumerable<Messages> GetAllMessages(int user1ID, int user2ID)
        {
            return _IUserDatasDAL.GetAllMessages(user1ID, user2ID);
        }

        public bool ReadMessages(int user1ID, int user2ID)
        {
            return _IUserDatasDAL.ReadMessages(user1ID, user2ID);
        }

        public int GetNumberOfUnreadMessages(int user1ID, int user2ID)
        {
            return _IUserDatasDAL.GetNumberOfUnreadMessages(user1ID, user2ID);
        }
        //----------------------------------- END OF MESSAGES ------------------------------------//

        public IEnumerable<UserDatas> NotVerifiedInstitutions()
        {
            return _IUserDatasDAL.NotVerifiedInstitutions();
        }

        public IEnumerable<UserStatisticInfo> GetUserStatistics(int cityID, int byDay, int byMonth, int byYear)
        {
            return _IUserDatasDAL.GetUserStatistics(cityID, byDay, byMonth, byYear);
        }

        public bool ResetForgottenPassword(string username)
        {
            return _IUserDatasDAL.ResetForgottenPassword(username);
        }

        public IEnumerable<UserDatas> InstitutionsByCityAndCategory(int cityID, int categoryID, int userTypeID)
        {
            return _IUserDatasDAL.InstitutionsByCityAndCategory(cityID, categoryID, userTypeID);
        }
    }
}
