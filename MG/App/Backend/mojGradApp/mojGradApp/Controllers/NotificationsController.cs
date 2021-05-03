using System;
using System.Collections.Generic;
using System.Linq;
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
    public class NotificationsController : ControllerBase
    {
        private readonly INotificationsUI _INotificationsUI;

        public NotificationsController(INotificationsUI INotificationsUI)
        {
            _INotificationsUI = INotificationsUI;
        }

        private IEnumerable<NotificationInfo> GetNotifications(int id, bool isRead, int number = 0)
        {
            List<PostReactions> postReactionList = GetPostReactionsByUserID(id, isRead);
            List<CommentReaction> commentReactionList = GetCommentReactionByUserID(id, isRead);
            List<Follows> followList = GetFollowByUserID(id, isRead);
            List<Comments> commentList = GetCommentsByUserID(id, isRead);
            List<ChallengeAndSolutions> casList = GetChallengeAndSolutionsByUserID(id, isRead);
            List<RankChanges> rankChangeList = GetRankChangesByUserID(id, isRead);

            List<NotificationInfo> notifications = new List<NotificationInfo>();

            foreach (var item in postReactionList)
            {
               notifications.Add(new NotificationInfo(item));
            }

            foreach (var item in commentReactionList)
            {
                notifications.Add(new NotificationInfo(item));
            }

            foreach (var item in followList)
            {
                notifications.Add(new NotificationInfo(item));
            }

            foreach (var item in commentList)
            {
                notifications.Add(new NotificationInfo(item));
            }

            foreach (var item in casList)
            {
                notifications.Add(new NotificationInfo(item));
            }

            foreach (var item in rankChangeList)
            {
                notifications.Add(new NotificationInfo(item));
            }

            if (number == 0)
            {
                return notifications.OrderByDescending(x => x.Time);
            }
            else
            {
                return notifications.OrderByDescending(x => x.Time).Take(number);
            }
        }


        [Authorize]
        [Route("AllReadNotifications/{id}")]
        [HttpGet]
        public IEnumerable<NotificationInfo> GetAllReadNotifications(int id)
        {
            bool isRead = true;
            return GetNotifications(id, isRead);
        }

        
        [Authorize]
        [Route("AllNotReadNotifications/{id}")]
        [HttpGet]
        public IEnumerable<NotificationInfo> GetAllNotReadNotifications(int id)
        {
            bool isRead = false;
            return GetNotifications(id, isRead);
        }


        [Authorize]
        [Route("FirstN_ReadNotifications/{id}")]
        [HttpGet]
        public IEnumerable<NotificationInfo> GetFirst_N_ReadNotifications(int id)
        {
            bool isRead = true;
            int number = 2;
            return GetNotifications(id, isRead, number);
        }

        [Authorize]
        [Route("ChangeToRead")]
        [HttpPost]
        public bool ChangeToRead(NotificationInfo notificationInfo)
        {
            return _INotificationsUI.ChangeToRead(notificationInfo);
        }

        [Authorize]
        [Route("ReadAll/userID={userID}")]
        [HttpGet]
        public bool ReadAll(int userID)
        {
            IEnumerable<NotificationInfo> notificationInfoList = GetAllNotReadNotifications(userID);

            foreach (var notifiactionInfo in notificationInfoList)
            {
                if (_INotificationsUI.ChangeToRead(notifiactionInfo) != true)
                {
                    return false;
                }  
            }

            return true;
        }


        private List<Follows> GetFollowByUserID(int userID, bool isRead)
        {
            return _INotificationsUI.GetFollowsByUserID(userID, isRead);
        }

        private List<PostReactions> GetPostReactionsByUserID(int userID, bool isRead)
        {
            return _INotificationsUI.GetPostReactionsByUserID(userID, isRead);
        }

        private List<CommentReaction> GetCommentReactionByUserID(int userID, bool isRead)
        {
            return _INotificationsUI.GetCommentReactionByUserID(userID, isRead);
        }

        private List<Comments> GetCommentsByUserID(int userID, bool isRead)
        {
            return _INotificationsUI.GetCommentsByUserID(userID, isRead);
        }

        private List<ChallengeAndSolutions> GetChallengeAndSolutionsByUserID(int userID, bool isRead)
        {
            return _INotificationsUI.GetChallengeAndSolutions(userID, isRead);
        }

        private List<RankChanges> GetRankChangesByUserID(int userID, bool isRead)
        {
            return _INotificationsUI.GetRankChangesByUserID(userID, isRead);
        }
    }
}
