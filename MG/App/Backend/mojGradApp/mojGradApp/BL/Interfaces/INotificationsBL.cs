using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface INotificationsBL
    {
        List<CommentReaction> GetCommentReactionByUserID(int userID, bool isRead);
        List<Follows> GetFollowsByUserID(int userID, bool isRead);
        List<PostReactions> GetPostReactionsByUserID(int userID, bool isRead);
        bool ChangeToRead(NotificationInfo notificationInfo);
        List<ChallengeAndSolutions> GetChallengeAndSolutions(int userID, bool isRead);
        List<Comments> GetCommentsByUserID(int userID, bool isRead);
        List<RankChanges> GetRankChangesByUserID(int userID, bool isRead);
    }
}
