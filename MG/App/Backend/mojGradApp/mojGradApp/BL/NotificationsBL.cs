using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class NotificationsBL : INotificationsBL
    {
        private readonly INotificationsDAL _INotificationsDAL;

        public NotificationsBL(INotificationsDAL INotificationsDAL)
        {
            _INotificationsDAL = INotificationsDAL;
        }


        public List<CommentReaction> GetCommentReactionByUserID(int userID, bool isRead)
        {
            return _INotificationsDAL.GetCommentReactionByUserID(userID, isRead);
        }

        public List<Follows> GetFollowsByUserID(int userID, bool isRead)
        {
            return _INotificationsDAL.GetFollowsByUserID(userID, isRead);
        }

        public List<PostReactions> GetPostReactionsByUserID(int userID, bool isRead)
        {
            return _INotificationsDAL.GetPostReactionsByUserID(userID, isRead);
        }

        public bool ChangeToRead(NotificationInfo notificationInfo)
        {
            return _INotificationsDAL.ChangeToRead(notificationInfo);
        }

        public List<ChallengeAndSolutions> GetChallengeAndSolutions(int userID, bool isRead)
        {
            return _INotificationsDAL.GetChallengeAndSolutions(userID, isRead);
        }

        public List<Comments> GetCommentsByUserID(int userID, bool isRead)
        {
            return _INotificationsDAL.GetCommentsByUserID(userID, isRead);
        }

        public List<RankChanges> GetRankChangesByUserID(int userID, bool isRead)
        {
            return _INotificationsDAL.GetRankChangesByUserID(userID, isRead);
        }
    }
}
