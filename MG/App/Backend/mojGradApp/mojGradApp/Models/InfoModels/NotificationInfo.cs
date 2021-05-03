using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models.InfoModels
{
    public class NotificationInfo
    {
        readonly int postReactionChallenge = 1;
        readonly int postReactionSolution = 2;
        readonly int solutionForChallenge = 3;
        readonly int commentLike = 4;
        readonly int commentDislike = 5;
        readonly int commentForPost = 6;
        readonly int followType = 7;
        readonly int rankChangeType = 8;


        public int Id { get; set; }
        public int Type { get; set; }
        public string Content { get; set; }
        public DateTime Time { get; set; }
        public String rankName { get; set; }

        public int UserID { get; set; }
        public int PostID { get; set; }
        //public int CommentID { get; set; }

        public string TimePassed { get; set; }

        public NotificationInfo() { }

        public NotificationInfo(PostReactions postReaction)
        {
            this.Id = postReaction.Id;
            //this.Type = postType;
            this.PostID = postReaction.PostID;
            this.Time = postReaction.Time;
            this.TimePassed = GetTimePassed(postReaction.Time);

            this.Content = postReaction.User.Username + " ";
            if(postReaction.Post.TypeID == 2)
            {
                this.Content += "pohvaljuje vaše rešenje izazova " + postReaction.Post.Title;
                this.Type = postReactionSolution;
            }
            else
            {
                this.Content += "reaguje na vaš izazov " + postReaction.Post.Title;
                this.Type = postReactionChallenge;
            }
        }

        public NotificationInfo(CommentReaction commentReaction)
        {
            this.Id = commentReaction.Id;
            //this.Type = commentType;
            this.PostID = commentReaction.Comment.PostID;
            this.Time = commentReaction.Time;
            this.TimePassed = GetTimePassed(commentReaction.Time);

            this.Content = commentReaction.User.Username + " ";
            if (commentReaction.Type == 1)
            {
                this.Content += "se sviđa vaš komentar " + commentReaction.Comment.Content;
                this.Type = commentLike;
            }
            else
            {
                this.Content += "se ne sviđa vaš komentar " + commentReaction.Comment.Content;
                this.Type = commentDislike;
            }
        }

        public NotificationInfo(Follows follow)
        {
            this.Id = follow.Id;
            this.Type = followType;
            this.UserID = follow.UserFollowID;
            this.Time = follow.Time;
            this.TimePassed = GetTimePassed(follow.Time);

            this.Content = follow.UserFollow.Username + " vas sada prati";
        }

        public NotificationInfo(ChallengeAndSolutions cas)
        {
            this.Id = cas.Id;
            this.Type = solutionForChallenge;
            this.PostID = cas.SolutionPostID;
            this.Time = cas.SolutionPost.Time;
            this.TimePassed = GetTimePassed(this.Time);

            this.Content = cas.SolutionPost.User.Username + " je odgovorio na vaš izazov " + cas.ChallengePost.Title;
        }

        public NotificationInfo(Comments comment)
        {
            this.Id = comment.Id;
            this.Type = commentForPost;
            this.PostID = comment.PostID;
            this.Time = comment.Time;
            this.TimePassed = GetTimePassed(this.Time);

            this.Content = comment.User.Username + " je dodao komentar na vašu objavu " + comment.Post.Title;
        }

        public NotificationInfo(RankChanges rankChange)
        {
            this.Id = rankChange.Id;
            this.Type = rankChangeType;
            this.UserID = rankChange.UserID;
            this.rankName = rankChange.Rank.Name;
            this.Time = rankChange.Time;
            this.TimePassed = GetTimePassed(this.Time);

            if(rankChange.RankID != 1)
            {
                this.Content = "Vaš rang je sada " + this.rankName;
            }
            else
            {
                this.Content = "Aktivirajte se, trenutno nemate rang";
            }
        }

        private string GetTimePassed(DateTime dt)
        {
            string timePassed;
            TimeSpan ts = DateTime.Now.Subtract(dt);
            timePassed = ts.Seconds + "s";
            if (ts.TotalSeconds > 60)
            {
                timePassed = ts.Minutes + "min";
                if (ts.TotalMinutes > 60)
                {
                    timePassed = ts.Hours + "h";
                    if (ts.TotalHours > 24)
                    {
                        timePassed = ts.Days + "d";
                        if (ts.TotalDays > 31)
                        {
                            timePassed = (int)(ts.TotalDays / 30) + "m";
                            if (ts.TotalDays > 365)
                            {
                                timePassed = (int)(ts.TotalDays / 365) + "y";
                            }
                        }
                    }
                }
            }
            return timePassed;
        }

    }
}
