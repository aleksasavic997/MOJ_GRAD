using Microsoft.EntityFrameworkCore;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class NotificationsDAL : INotificationsDAL
    {
        private readonly ApplicationDbContext mgd;

        public NotificationsDAL(ApplicationDbContext context)
        {
            mgd = context;
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

        public bool ChangeToRead(NotificationInfo notificationInfo)
        {
            if(notificationInfo.Type == 1 || notificationInfo.Type == 2)
            {
                var postReaction = mgd.PostReaction.Where(x => x.Id == notificationInfo.Id).FirstOrDefault();
                if(postReaction != null)
                {
                    postReaction.IsRead = true;
                    mgd.PostReaction.Update(postReaction);
                    mgd.SaveChanges();
                    return true;
                }
                return false;
            }
            else if(notificationInfo.Type == 4 || notificationInfo.Type == 5)
            {
                var commentReaction = mgd.CommentReaction.Where(x => x.Id == notificationInfo.Id).FirstOrDefault();
                if (commentReaction != null)
                {
                    commentReaction.IsRead = true;
                    mgd.CommentReaction.Update(commentReaction);
                    mgd.SaveChanges();
                    return true;
                }
                return false;
            }
            else if(notificationInfo.Type == 3)
            {
                var cas = mgd.ChallengeAndSolution.Where(x => x.Id == notificationInfo.Id).FirstOrDefault();
                if (cas != null)
                {
                    cas.IsRead = true;
                    mgd.ChallengeAndSolution.Update(cas);
                    mgd.SaveChanges();
                    return true;
                }
                return false;
            }
            else if(notificationInfo.Type == 6)
            {
                var comment = mgd.Comment.Where(x => x.Id == notificationInfo.Id).FirstOrDefault();
                if (comment != null)
                {
                    comment.IsRead = true;
                    mgd.Comment.Update(comment);
                    mgd.SaveChanges();
                    return true;
                }
                return false;
            }
            else if (notificationInfo.Type == 8)
            {
                var rankChange = mgd.RankChange.Where(x => x.Id == notificationInfo.Id).FirstOrDefault();
                if (rankChange != null)
                {
                    rankChange.IsRead = true;
                    mgd.RankChange.Update(rankChange);
                    mgd.SaveChanges();
                    return true;
                }
                return false;
            }
            else
            {
                var follow = mgd.Follow.Where(x => x.Id == notificationInfo.Id).FirstOrDefault();
                if (follow != null)
                {
                    follow.IsRead = true;
                    mgd.Follow.Update(follow);
                    mgd.SaveChanges();
                    return true;
                }
                return false;
            }
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
