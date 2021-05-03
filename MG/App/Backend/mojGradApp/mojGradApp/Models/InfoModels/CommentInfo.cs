using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models.InfoModels
{
    public class CommentInfo
    {
        public int Id { get; set; }
        public int PostID { get; set; }
        public int UserID { get; set; }
        public string Content { get; set; }
        public DateTime Time { get; set; }

        public string Username { get; set; }
        public int CommentLikes { get; set; }
        public int CommentDislikes { get; set; }
        public int IsLiked { get; set; }
        public string ProfilePhoto { get; set; }

        public CommentInfo(Comments comment)
        {
            this.Id = comment.Id;
            this.PostID = comment.PostID;
            this.UserID = comment.UserID;
            this.Content = comment.Content;
            this.Time = comment.Time;
            this.Username = comment.User.Username;
            this.CommentLikes = comment.CommentReaction.Count(x => x.CommentID == this.Id && x.Type == 1);
            this.CommentDislikes = comment.CommentReaction.Count(x => x.CommentID == this.Id && x.Type == -1);
            this.ProfilePhoto = comment.User.ProfilePhotoPath;
        }

        public CommentInfo(Comments comment, int userID) : this(comment)
        {
            if (comment.CommentReaction.Where(x => x.UserID == userID && x.Type == -1).FirstOrDefault() != null)
                this.IsLiked = -1;
            else if (comment.CommentReaction.Where(x => x.UserID == userID && x.Type == 1).FirstOrDefault() != null)
                this.IsLiked = 1;
            else
                this.IsLiked = 0;
        }
    }
}
