using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models
{
    public class UserDatas
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string? Lastname { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public DateTime Time { get; set; }
        public int CityID { get; set; }
        public string ProfilePhotoPath { get; set; }
        public string? Address { get; set; }
        public int UserTypeID { get; set; }
        public bool IsLogged { get; set; }
        public bool? IsVerified { get; set; }

        public virtual Cities City { get; set; }
        public virtual UserTypes UserType { get; set; }

        public virtual List<Points> Point { get; set; }
        public virtual List<SavedPosts> SavedPost { get; set; }
        public virtual List<RankChanges> RankChange { get; set; }
        public virtual List<CommentReaction> CommentReaction { get; set; }
        public virtual List<Comments> Comments { get; set; }
        public virtual List<PostReactions> PostReactions { get; set; }
        public virtual List<PostReports> PostReports { get; set; }
        public virtual List<Posts> Posts { get; set; }
        public virtual List<CategoryFollows> CategoryFollows { get; set; }

        [InverseProperty("User")]
        public virtual List<UserReports> UsersThatReport { get; set; }

        [InverseProperty("ReportedUser")]
        public virtual List<UserReports> UsersThatAreReported { get; set; }


        [InverseProperty("UserFollow")]
        public virtual List<Follows> UsersThatFollow { get; set; }

        [InverseProperty("FollowedUser")]
        public virtual List<Follows> UsersThatAreFollowed { get; set; }


        [InverseProperty("Sender")]
        public virtual List<Messages> Senders { get; set; }

        [InverseProperty("Receiver")]
        public virtual List<Messages> Receivers { get; set; }
    }
}
