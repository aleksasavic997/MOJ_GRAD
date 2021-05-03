using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models.InfoModels
{
    public class PostInfo
    {
        public int Id { get; set; }
        public int UserID { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public int CategoryID { get; set; }
        public DateTime Time { get; set; }
        public string TimePassed { get; set; }
        public string Location { get; set; }
        public int TypeID { get; set; }
        public string ImagePath { get; set; }
        public int CityID { get; set; }
        public double Longitude { get; set; }
        public double Latitude { get; set; }

        public string Username { get; set; }
        public int ReactionsNumber { get; set; }
        public string TypeName { get; set; }
        public int CommentsNumber { get; set; }
        public string CategoryName { get; set; }
        public string UserProfilePhoto { get; set; }
        public int ReportCount { get; set; }
        public int IsReacted { get; set; }
        public int IsReported { get; set; }
        public int IsSaved { get; set; }

        public PostInfo(Posts post)
        {
            this.Id = post.Id;
            this.UserID = post.UserID;
            this.Title = post.Title;
            this.Description = post.Description;
            this.CategoryID = post.CategoryID;
            this.Time = post.Time;
            this.TimePassed = GetTimePassed(this.Time);
            this.Location = post.Location;
            this.TypeID = post.TypeID;
            this.ImagePath = post.ImagePath;
            this.CityID = post.CityID;
            this.Username = post.User.Username;
            this.ReactionsNumber = post.PostReactions.Count();
            this.TypeName = post.Type.Name;
            this.CommentsNumber = post.Comments.Count();
            this.CategoryName = post.Category.Name;
            this.UserProfilePhoto = post.User.ProfilePhotoPath;
            this.Longitude = post.Longitude;
            this.Latitude = post.Latitude;
            this.ReportCount = post.PostReports.Count(x => x.PostID == this.Id);
        }

        public PostInfo(Posts post, int userID) : this(post)
        {
            if (post.PostReactions.FirstOrDefault(x => x.PostID == post.Id && x.UserID == userID) != null)
                this.IsReacted = 1;
            else
                this.IsReacted = 0;

            if (post.PostReports.FirstOrDefault(x => x.PostID == post.Id && x.UserID == userID) != null)
                this.IsReported = 1;
            else
                this.IsReported = 0;

            /*if (post.SavedPost.FirstOrDefault(x => x.PostID == post.Id && x.UserID == userID) != null)
                this.IsSaved = 1;
            else
                this.IsSaved = 0;*/
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