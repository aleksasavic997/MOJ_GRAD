using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class NotificationsUI : INotificationsUI
    {
        private readonly INotificationsBL _INotificationsBL;

        public NotificationsUI(INotificationsBL INotificationsBL)
        {
            _INotificationsBL = INotificationsBL;
        }

        public List<CommentReaction> GetCommentReactionByUserID(int userID, bool isRead)
        {
            return _INotificationsBL.GetCommentReactionByUserID(userID, isRead);
        }

        public List<Follows> GetFollowsByUserID(int userID, bool isRead)
        {
            return _INotificationsBL.GetFollowsByUserID(userID, isRead);
        }

        public List<PostReactions> GetPostReactionsByUserID(int userID, bool isRead)
        {
            return _INotificationsBL.GetPostReactionsByUserID(userID, isRead);
        }

        public bool ChangeToRead(NotificationInfo notificationInfo)
        {
            return _INotificationsBL.ChangeToRead(notificationInfo);
        }

        public List<ChallengeAndSolutions> GetChallengeAndSolutions(int userID, bool isRead)
        {
            return _INotificationsBL.GetChallengeAndSolutions(userID, isRead);
        }

        public List<Comments> GetCommentsByUserID(int userID, bool isRead)
        {
            return _INotificationsBL.GetCommentsByUserID(userID, isRead);
        }

        public List<RankChanges> GetRankChangesByUserID(int userID, bool isRead)
        {
            return _INotificationsBL.GetRankChangesByUserID(userID, isRead);
        }
    }
}
