using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;

namespace mojGradApp.Hubs
{
    public class NotificationHub : Hub
    {
        ApplicationDbContext mgd = new ApplicationDbContext();

        public void Send(int userID)
        {
            bool isRead = false;
            List<PostReactions> postReactionList = GetPostReactionsByUserID(userID, isRead);
            List<CommentReaction> commentReactionList = GetCommentReactionByUserID(userID, isRead);
            List<Follows> followList = GetFollowsByUserID(userID, isRead);
            List<Comments> commentList = GetCommentsByUserID(userID, isRead);
            List<ChallengeAndSolutions> casList = GetChallengeAndSolutions(userID, isRead);
            List<RankChanges> rankChangeList = GetRankChangesByUserID(userID, isRead);

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

            //Clients.All.SendCoreAsync("OnNotification", new object[] { notifications.OrderByDescending(x => x.Time)});
            /*
            Groups.AddToGroupAsync(Context.ConnectionId, "notification" + userID.ToString());
            Clients.Group("notification" + userID.ToString()).SendAsync("OnNotification", new object[] { notifications.OrderByDescending(x => x.Time) });*/

            Clients.User(userID.ToString()).SendCoreAsync("OnNotification", new object[] { notifications.OrderByDescending(x => x.Time) });


        }

        public override Task OnConnectedAsync()
        {
            return base.OnConnectedAsync();
        }

        public List<CommentReaction> GetCommentReactionByUserID(int userID, bool isRead)
        {
            return mgd.CommentReaction.Where(x => x.Comment.UserID == userID && x.IsRead == isRead)
                .Include(u => u.User).Include(c => c.Comment).ToList();
        }

        public List<Follows> GetFollowsByUserID(int userID, bool isRead)
        {
            return mgd.Follow.Where(x => x.FollowedUserID == userID && x.IsRead == isRead)
                .Include(uf => uf.UserFollow).ToList();
        }

        public List<PostReactions> GetPostReactionsByUserID(int userID, bool isRead)
        {
            return mgd.PostReaction.Where(x => x.Post.UserID == userID && x.IsRead == isRead)
                .Include(u => u.User).Include(p => p.Post).ToList();
        }

        public List<ChallengeAndSolutions> GetChallengeAndSolutions(int userID, bool isRead)
        {
            return mgd.ChallengeAndSolution.Where(x => x.ChallengePost.UserID == userID && x.IsRead == isRead)
                .Include(s => s.SolutionPost).Include(u => u.SolutionPost.User).Include(c => c.ChallengePost).ToList();
        }

        public List<Comments> GetCommentsByUserID(int userID, bool isRead)
        {
            return mgd.Comment.Where(x => x.Post.UserID == userID && x.IsRead == isRead)
                .Include(p => p.Post).Include(u => u.User).ToList();
        }

        public List<RankChanges> GetRankChangesByUserID(int userID, bool isRead)
        {
            return mgd.RankChange.Where(x => x.UserID == userID && x.IsRead == isRead)
                .Include(r => r.Rank).ToList();
        }
    }
}
