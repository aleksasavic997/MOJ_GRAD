using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.Models.InfoModels
{
    public class UserInfo
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string? Lastname { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public int CityID { get; set; }
        public int Points { get; set; }
        public string ProfilePhotoPath { get; set; }
        public string? Address { get; set; }
        public int UserTypeID { get; set; }
        public bool? IsVerified { get; set; }

        public string CityName { get; set; }
        public string RankName { get; set; }
        public int ReportCount { get; set; }
        public int IsReported { get; set; }
        public int PostCount { get; set; }

        public UserInfo(UserDatas user)
        {
            this.Id = user.Id;
            this.Name = user.Name;
            this.Lastname = user.Lastname;
            this.Username = user.Username;
            this.Password = user.Password;
            this.Email = user.Email;
            this.Phone = user.Phone;
            this.CityID = user.CityID;
            int points = user.Point.Sum(x => x.Number);
            this.Points = points >=0 ? points : 0;
            this.Address = user.Address;
            this.CityName = user.City.Name;
            this.UserTypeID = user.UserTypeID;
            this.ProfilePhotoPath = user.ProfilePhotoPath;
            if (this.Points >= 300)
                this.RankName = "Zlato";
            else if (this.Points >= 200 && this.Points < 300)
                this.RankName = "Srebro";
            else if(this.Points >= 100 && this.Points < 200)
                this.RankName = "Bronza";
            else
                this.RankName = "Nema ranga";
            this.ReportCount = user.UsersThatAreReported.Count(x => x.ReportedUserID == this.Id);
            this.PostCount = user.Posts.Count(x => x.UserID == user.Id);
            this.IsVerified = user.IsVerified;
        }

        public UserInfo(UserDatas user, int userID) : this(user)
        {
            if (user.UsersThatAreReported.FirstOrDefault(x => x.ReportedUserID == user.Id && x.UserID == userID) != null)
                this.IsReported = 1;
            else
                this.IsReported = 0;
        }
    }
}
