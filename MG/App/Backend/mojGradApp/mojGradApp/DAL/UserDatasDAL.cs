using Microsoft.AspNetCore.Builder.Extensions;
using Microsoft.EntityFrameworkCore;
using MimeKit;
using mojGradApp.Controllers;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Runtime.InteropServices.ComTypes;
using MailKit.Net.Smtp;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;
using System.Security.Cryptography;
using System.Text;

namespace mojGradApp.DAL
{
    public class UserDatasDAL : IUserDatasDAL
    {
        private readonly ApplicationDbContext mgd;

        public UserDatasDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public bool ChangeUserInfo(UserDatas user)
        {
            var u = mgd.User.Where(x => x.Id == user.Id).FirstOrDefault();
            if(u != null)
            {
                if(user.UserTypeID == 1)
                {
                    u.Name = user.Name;
                    u.Lastname = user.Lastname;
                    u.Username = user.Username;
                    u.Password = user.Password;
                    u.Email = user.Email;
                    u.ProfilePhotoPath = user.ProfilePhotoPath;
                    u.Phone = user.Phone;
                    u.CityID = user.CityID;
                }
                else
                {
                    u.Address = user.Address;
                    u.Email = user.Email;
                    u.Name = user.Name;
                    u.Phone = user.Phone;
                    u.ProfilePhotoPath = user.ProfilePhotoPath;
                    u.Username = user.Username;
                    u.Password = user.Password;
                    u.CityID = user.CityID;
                }
                
                mgd.User.Update(u);
                mgd.SaveChanges();
                return true;
            }
            return false;
        }

        public bool CheckEmail(UserEmail email)
        {
            var users = mgd.User.ToList();
            var user = users.Where(u => u.Email.Equals(email.Email)).FirstOrDefault();
            if (user == null)
                return false;
            return true;
        }

        public UserDatas CheckUser(Login login, int UserTypeID)
        {
            var user = mgd.User.Where(u => u.UserTypeID == UserTypeID && u.Username.Equals(login.Username) && u.Password.Equals(login.Password)).FirstOrDefault();

            return user;
        }

        public bool CheckUsername(UsernameReg username)
        {
            var users = mgd.User.ToList();
            var user = users.Where(u => u.Username.Equals(username.Username)).FirstOrDefault();
            if (user == null)
                return false; 
            return true;
        }

        public List<UserDatas> GetAllUsers(int userTypeID, int userID)
        {
            return mgd.User.Where(x => x.UserTypeID == userTypeID && x.Id != userID)
                .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
        }

        public UserDatas GetUserByID(int id)
        {
            return mgd.User.Where(x => x.Id == id)
                .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).FirstOrDefault();
        }

        public IEnumerable<UserDatas> GetUserDatas()
        {
            return mgd.User.ToList();
        }

        public UserDatas GetUserData(int id)
        {
            return mgd.User.Find(id);
        }

        public bool PostUserData(UserDatas userData)
        {
            var u = mgd.User.Where(x => x.Username == userData.Username || x.Email == userData.Email).FirstOrDefault();

            if(u == null)
            {
                userData.Time = DateTime.Now;
                mgd.User.Add(userData);
                mgd.SaveChanges();

                var stat = mgd.UserStatistic.Where(x => x.CityID == userData.CityID && x.Time == userData.Time.Date).FirstOrDefault();

                if(stat != null)
                {
                    if(userData.UserTypeID == 1)
                    {
                        stat.NumberOfCitizens++;
                        mgd.UserStatistic.Update(stat);
                        mgd.SaveChanges();
                    }
                    else
                    {
                        stat.NumberOfInstitutions++;
                        mgd.UserStatistic.Update(stat);
                        mgd.SaveChanges();
                    }
                }
                else
                {
                    var s = mgd.UserStatistic.Where(x => x.Time < userData.Time.Date && x.CityID == userData.CityID).OrderByDescending(x => x.Time).FirstOrDefault();

                    if(s != null)
                    {
                        UserStatistics us = new UserStatistics
                        {
                            NumberOfCitizens = s.NumberOfCitizens ,
                            NumberOfInstitutions = s.NumberOfInstitutions,
                            CityID = s.CityID,
                            Time = userData.Time.Date
                        };

                        if (userData.UserTypeID == 1)
                        {
                            us.NumberOfCitizens++;
                        }
                        else
                        {
                            us.NumberOfInstitutions++;
                        }

                        mgd.UserStatistic.Add(us);
                        mgd.SaveChanges();
                    }
                    else
                    {
                        UserStatistics us = new UserStatistics
                        {
                            NumberOfCitizens = mgd.User.Where(x => x.CityID == userData.CityID && x.UserTypeID == 1).Count(),
                            NumberOfInstitutions = mgd.User.Where(x => x.CityID == userData.CityID && x.UserTypeID == 2).Count(),
                            CityID = userData.CityID,
                            Time = userData.Time.Date
                        };

                        mgd.UserStatistic.Add(us);
                        mgd.SaveChanges();
                    }
                }

                return true;
            }

            return false;
        }
		
		public bool DeleteUser(int id)
        {
            var user = mgd.User.Where(x => x.Id == id).FirstOrDefault();
            if(user != null)
            {
                var stat = mgd.UserStatistic.Where(x => x.CityID == user.CityID && x.Time == user.Time.Date).FirstOrDefault();

                if (stat != null)
                {
                    if (user.UserTypeID == 1)
                    {
                        stat.NumberOfCitizens--;
                        mgd.UserStatistic.Update(stat);
                        mgd.SaveChanges();
                    }
                    else
                    {
                        stat.NumberOfInstitutions--;
                        mgd.UserStatistic.Update(stat);
                        mgd.SaveChanges();
                    }
                }
                else
                {
                    var s = mgd.UserStatistic.Where(x => x.Time < user.Time.Date && x.CityID == user.CityID).OrderByDescending(x => x.Time).FirstOrDefault();

                    if (s != null)
                    {
                        UserStatistics us = new UserStatistics
                        {
                            NumberOfCitizens = s.NumberOfCitizens,
                            NumberOfInstitutions = s.NumberOfInstitutions,
                            CityID = s.CityID,
                            Time = user.Time.Date
                        };

                        if (user.UserTypeID == 1)
                        {
                            us.NumberOfCitizens--;
                        }
                        else
                        {
                            us.NumberOfInstitutions--;
                        }

                        mgd.UserStatistic.Add(us);
                        mgd.SaveChanges();
                    }
                    else
                    {
                        UserStatistics us = new UserStatistics
                        {
                            NumberOfCitizens = mgd.User.Where(x => x.CityID == user.CityID && x.Time.Date == user.Time.Date && x.UserTypeID == 1).Count(),
                            NumberOfInstitutions = mgd.User.Where(x => x.CityID == user.CityID && x.Time.Date == user.Time.Date && x.UserTypeID == 2).Count(),
                            CityID = user.CityID,
                            Time = user.Time.Date
                        };

                        if (user.UserTypeID == 1)
                        {
                            us.NumberOfCitizens--;
                        }
                        else
                        {
                            us.NumberOfInstitutions--;
                        }

                        mgd.UserStatistic.Add(us);
                        mgd.SaveChanges();
                    }
                }

                mgd.User.Remove(user);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public List<UserDatas> GetReportedUsers()
        {
            List<UserDatas> userList = new List<UserDatas>();

            var userReportIDs = mgd.UserReport.Where(x => x.IsApproved == false).Select(x => x.ReportedUserID).ToList().Distinct();

            foreach (var id in userReportIDs)
            {
                if (mgd.UserReport.Where(x => x.ReportedUserID == id && x.IsApproved == true).FirstOrDefault() == null)
                {
                    userList.Add(mgd.User.Where(x => x.Id == id)
                        .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported)
                        .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts).FirstOrDefault());
                }
                else
                {
                    if (mgd.UserReport.Where(x => x.ReportedUserID == id && x.IsApproved == false).Count() > 2)
                    {
                        userList.Add(mgd.User.Where(x => x.Id == id)
                            .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported)
                            .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts).FirstOrDefault());
                    }
                }
            }

            return userList;
        }

        public List<UserDatas> GetUsersThatReactedOnPost(int postID)
        {
            var usersThatReactedIDs = mgd.PostReaction.Where(x => x.PostID == postID).Select(x => x.UserID).ToList();

            return mgd.User.Where(x => usersThatReactedIDs.Contains(x.Id))
                .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
        }

        public List<UserDatas> GetUsersThatLikedOrDislikedComment(int commentID, int reactionType)
        {
            var usersThatReactedIDs = mgd.CommentReaction.Where(x => x.CommentID == commentID && x.Type == reactionType).Select(x => x.UserID).ToList();

            return mgd.User.Where(x => usersThatReactedIDs.Contains(x.Id))
               .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
               .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
        }

        public List<UserDatas> GetUsersByCityID(int userTypeID, int cityID, int userID, int categoryID, int verification)
        {
            if (cityID == 0 && categoryID == 0)
            {
                if(verification == 0)
                {
                    return mgd.User.Where(x => x.UserTypeID == userTypeID)
                        .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                        .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
                }
                else
                {
                    return mgd.User.Where(x => x.UserTypeID == userTypeID && x.IsVerified == true)
                        .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                        .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
                }
            }
            else if(categoryID == 0)
            {
                if (verification == 0)
                {
                    return mgd.User.Where(x => x.UserTypeID == userTypeID && x.CityID == cityID && x.Id != userID)
                        .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                        .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
                }
                else
                {
                    return mgd.User.Where(x => x.UserTypeID == userTypeID && x.CityID == cityID && x.Id != userID && x.IsVerified == true)
                        .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                        .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
                }
            }
            else
            {
                var users = mgd.CategoryFollow.Where(x => x.CategoryID == categoryID).ToList();
                if(users != null)
                {
                    var userIDs = users.Select(x => x.UserID).ToList();

                    if (verification == 0)
                    {
                        return mgd.User.Where(x => x.UserTypeID == userTypeID && x.CityID == cityID && userIDs.Contains(x.Id))
                            .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                            .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
                    }
                    else
                    {
                        return mgd.User.Where(x => x.UserTypeID == userTypeID && x.CityID == cityID && userIDs.Contains(x.Id) && x.IsVerified == true)
                            .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                            .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
                    }
                }
                
                return null;
            }
        }

        public bool CheckIfAlreadyLogged(int userID)
        {
            var user = mgd.User.Where(u => u.Id == userID).FirstOrDefault();

            if(user != null)
            {
                if (user.UserTypeID == 1 && user.IsLogged == false)
                {
                    user.IsLogged = true;
                    mgd.User.Update(user);
                    mgd.SaveChanges();

                    return true;
                }
                else if (user.UserTypeID != 1)
                    return true;
                else
                    return false;
            }

            return false;
        }

        public bool Logout(int userID)
        {
            var user = mgd.User.Where(u => u.Id == userID).FirstOrDefault();

            if(user != null)
            {
                user.IsLogged = false;
                mgd.User.Update(user);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public string CheckRang(int userID)
        {
            var user = mgd.User.Where(x => x.Id == userID).FirstOrDefault();

            if (user != null)
            {
                int points = mgd.Point.Where(x => x.UserID == user.Id).Sum(x => x.Number);
                int addedPoints = mgd.Point.Where(x => x.UserID == user.Id).OrderByDescending(x => x.Time).Select(x => x.Number).FirstOrDefault();
                int pastPoints;
                if (addedPoints > 0)
                    pastPoints = points - addedPoints;
                else
                    pastPoints = points + (-1)*addedPoints;

                if (points >= 300 && (pastPoints < 300))
                {
                    return "Zlato";
                }
                else if (points < 300 && points >= 200 && ((pastPoints < 200) || (pastPoints >= 300)))
                {
                    return "Srebro";
                }
                else if (points < 200 && points >= 100 && ((pastPoints < 100) || (pastPoints >= 200)))
                {
                    return "Bronza";
                }
                else if (points < 100 && pastPoints >= 100)
                {
                    return "Nema ranga";
                }
                else
                    return "false";
            }

            return "false";
        }

        public IEnumerable<UserDatas> GetBest(int userTypeID, int days, int userNumber)
        {
            List<UserDatas> topUsers = new List<UserDatas>();
            var users = mgd.User.Where(x => x.UserTypeID == userTypeID).Select(u => new
                {
                    Id = u.Id,
                    PointsFromPeriod = mgd.Point.Where(p => (DateTime.Now.Day - p.Time.Day <= days) && p.UserID == u.Id).Sum(x => x.Number)
                }
            ).ToList().OrderByDescending(u => u.PointsFromPeriod);

            foreach (var user in users)
            {
                if (userNumber == 0)
                    break;

                if (user.PointsFromPeriod > 0)
                {
                    var u = mgd.User.Where(x => x.Id == user.Id).
                        Include(c => c.City).Include(po => po.Point).Include(p => p.Posts).
                        Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).FirstOrDefault();

                    if (u != null)
                    {
                        topUsers.Add(u);
                        userNumber--;
                    }
                }
            }

            return topUsers;
        }

        public int GetPointsForUser(int userID, int days)
        {
            int points = mgd.Point.Where(p => p.UserID == userID && (DateTime.Now.Day - p.Time.Day <= days)).Sum(x => x.Number);
            return points >= 0 ? points : 0;
        }

        public List<UserDatas> GetFollowSugestions(int userID, int userTypeID)
        {
            var user = mgd.User.Where(x => x.Id == userID).FirstOrDefault();
            if(user != null)
            {
                var followIDs = mgd.Follow.Where(x => x.UserFollowID == user.Id).Select(x => x.FollowedUserID);

                List<UserDatas> usersFromSameCity = mgd.User.Where(x => x.UserTypeID == userTypeID && x.CityID == user.CityID && x.Id != user.Id && !(followIDs.Contains(x.Id)))
                    .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts).Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
                
                var fromSameCityIDs = usersFromSameCity.Select(x => x.Id);

                List<UserDatas> otherUsers = mgd.User.Where(x => x.UserTypeID == userTypeID && x.Id != user.Id && !(followIDs.Contains(x.Id)) && !(fromSameCityIDs.Contains(x.Id)))
                    .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts).Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();

                foreach (var item in otherUsers)
                {
                    usersFromSameCity.Add(item);
                }

                return usersFromSameCity;
            }

            return null;
        }

        public bool DissmissUserReports(int userID)
        {
            var userReports = mgd.UserReport.Where(x => x.ReportedUserID == userID && x.IsApproved == false).ToList();

            if(userReports != null)
            {
                foreach (var item in userReports)
                {
                    item.IsApproved = true;
                    mgd.UserReport.Update(item);
                    mgd.SaveChanges();
                }

                return true;
            }

            return false;
        }

        public List<UserDatas> DissmissUserReports()
        {
            List<UserDatas> userList = new List<UserDatas>();

            var userReportIDs = mgd.UserReport.Where(x => x.IsApproved == true).Select(x => x.ReportedUserID).ToList().Distinct();

            foreach (var id in userReportIDs)
            {
                if (mgd.UserReport.Where(x => x.ReportedUserID == id && x.IsApproved == false).FirstOrDefault() == null)
                {
                    userList.Add(mgd.User.Where(x => x.Id == id)
                        .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported)
                        .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts).FirstOrDefault());
                }
                else
                {
                    if (mgd.UserReport.Where(x => x.ReportedUserID == id && x.IsApproved == true).Count() < 2)
                    {
                        userList.Add(mgd.User.Where(x => x.Id == id)
                            .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported)
                            .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts).FirstOrDefault());
                    }
                }
            }

            return userList;
        }

        public void Verify(int id)
        {
            var user = mgd.User.Where(x => x.Id == id).FirstOrDefault();
            user.IsVerified = true;
            mgd.User.Update(user);
            mgd.SaveChanges();
        }

        //-------------------------------------- MESSAGES ---------------------------------------//
        public bool SendMessage(Messages message)
        {
            var receiver = mgd.User.Where(x => x.Id == message.ReceiverID).FirstOrDefault();

            if(receiver != null)
            {
                mgd.Message.Add(message);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public bool DeleteMessage(int messageID)
        {
            var message = mgd.Message.Where(x => x.Id == messageID).FirstOrDefault();
            if (message != null)
            {
                mgd.Message.Remove(message);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public IEnumerable<UserDatas> GetAllUsersYouChattedWith(int userID)
        {
            List<UserDatas> userList = new List<UserDatas>();

            IEnumerable<Messages> msgS = mgd.Message.Where(x => x.ReceiverID == userID).ToList().OrderByDescending(x => x.Time);
            IEnumerable<Messages> msgR = mgd.Message.Where(x => x.SenderID == userID).ToList().OrderByDescending(x => x.Time);

            msgR.Concat(msgS);

            msgR.OrderByDescending(x => x.Time);
            var userIDs = msgR.Select(x => x.SenderID == userID ? x.ReceiverID : x.SenderID).Distinct();

            foreach (var uID in userIDs)
            {
                var user = mgd.User.Where(x => x.Id == uID).FirstOrDefault();

                if(user != null)
                {
                    userList.Add(user);
                }
            }

            return userList;
        }

        public IEnumerable<Messages> GetAllMessages(int user1ID, int user2ID)
        {
            return mgd.Message.Where(x => (x.SenderID == user1ID && x.ReceiverID == user2ID) 
                                            || (x.ReceiverID == user1ID && x.SenderID == user2ID))
                                            .ToList().OrderByDescending(x => x.Time);
        }

        public int GetNumberOfUnreadMessages(int user1ID, int user2ID)
        {
            if(user2ID == 0)
            {
                return mgd.Message.Where(x => x.ReceiverID == user1ID && x.IsRead == false).Count();
            }
            else
            {
                return mgd.Message.Where(x => x.ReceiverID == user1ID && x.SenderID == user2ID && x.IsRead == false).Count();
            }
        }

        public bool ReadMessages(int user1ID, int user2ID)
        {
            var msgs = mgd.Message.Where(x => x.ReceiverID == user1ID && x.SenderID == user2ID && x.IsRead == false).ToList();

            if(msgs != null)
            {
                foreach (var msg in msgs)
                {
                    msg.IsRead = true;
                    mgd.Message.Update(msg);
                    mgd.SaveChanges();
                }

                return true;
            }

            return false;
        }
        //----------------------------------- END OF MESSAGES ------------------------------------//

        public IEnumerable<UserDatas> NotVerifiedInstitutions()
        {
            var inst = mgd.User.Where(x => x.UserTypeID == 2 && x.IsVerified != null && x.IsVerified == false).ToList();

            return inst.OrderByDescending(x => x.Time);
        }

        public IEnumerable<UserStatisticInfo> GetUserStatistics(int cityID, int byDay, int byMonth, int byYear)
        {
            if (byYear == 0)
            {
                byYear = DateTime.Now.Year;
            }

            List<UserStatisticInfo> statInfo = new List<UserStatisticInfo>();
            
            if (cityID == 0)
            {
                var cityIDs = mgd.City.Select(x => x.Id).ToList();

                if (byDay == 1 && byMonth == 0)
                {
                    var days = mgd.UserStatistic.Where(x => x.Time.Year == byYear).Select(x => x.Time).Distinct().ToList();
                    
                    foreach (var day in days)
                    {
                        UserStatistics us = new UserStatistics
                        {
                            NumberOfCitizens = mgd.UserStatistic.Where(x => x.Time == day).Sum(x => x.NumberOfCitizens),
                            NumberOfInstitutions = mgd.UserStatistic.Where(x => x.Time == day).Sum(x => x.NumberOfInstitutions),
                            CityID = 1,
                            Time = day
                        };

                        foreach (var cID in cityIDs)
                        {
                            if(mgd.UserStatistic.Where(x => x.Time == day && x.CityID == cID).FirstOrDefault() == null)
                            {
                                var pom = mgd.UserStatistic.Where(x => x.Time < day && x.CityID == cID).OrderByDescending(x => x.Time).FirstOrDefault();
                                
                                if(pom != null)
                                {
                                    us.NumberOfCitizens += pom.NumberOfCitizens;
                                    us.NumberOfInstitutions += pom.NumberOfInstitutions;
                                }
                            }
                        }

                        statInfo.Add(new UserStatisticInfo(us, false));
                    }
                }
                else if (byDay == 1 && byMonth != 0)
                {
                    var daysFromMonth = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.Time.Month == byMonth).Select(x => x.Time).Distinct().ToList();

                    foreach (var day in daysFromMonth)
                    {
                        UserStatistics us = new UserStatistics
                        {
                            NumberOfCitizens = mgd.UserStatistic.Where(x => x.Time == day).Sum(x => x.NumberOfCitizens),
                            NumberOfInstitutions = mgd.UserStatistic.Where(x => x.Time == day).Sum(x => x.NumberOfInstitutions),
                            CityID = 1,
                            Time = day
                        };

                        foreach (var cID in cityIDs)
                        {
                            if (mgd.UserStatistic.Where(x => x.Time == day && x.CityID == cID).FirstOrDefault() == null)
                            {
                                var pom = mgd.UserStatistic.Where(x => x.Time < day && x.CityID == cID).OrderByDescending(x => x.Time).FirstOrDefault();

                                if (pom != null)
                                {
                                    us.NumberOfCitizens += pom.NumberOfCitizens;
                                    us.NumberOfInstitutions += pom.NumberOfInstitutions;
                                }
                            }
                        }

                        statInfo.Add(new UserStatisticInfo(us, false));
                    }
                }
                else if (byDay == 0 && byMonth != 0)
                {
                    for (int i = 1; i <= 12; i++)
                    {
                        var month = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.Time.Month == i).OrderByDescending(x => x.Time).FirstOrDefault();

                        if(month != null)
                        {
                            UserStatistics us = new UserStatistics
                            {
                                NumberOfCitizens = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.Time.Month == i).Sum(x => x.NumberOfCitizens),
                                NumberOfInstitutions = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.Time.Month == i).Sum(x => x.NumberOfInstitutions),
                                CityID = 1,
                                Time = month.Time.Date
                            };

                            statInfo.Add(new UserStatisticInfo(us, false));
                        }
                    }
                }
            }
            else
            {
                if (byDay == 1 && byMonth == 0)
                {
                    var days = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.CityID == cityID).Select(x => x.Time).Distinct().ToList();

                    foreach (var day in days)
                    {
                        UserStatistics us = new UserStatistics
                        {
                            NumberOfCitizens = mgd.UserStatistic.Where(x => x.Time == day && x.CityID == cityID).Sum(x => x.NumberOfCitizens),
                            NumberOfInstitutions = mgd.UserStatistic.Where(x => x.Time == day && x.CityID == cityID).Sum(x => x.NumberOfInstitutions),
                            CityID = 1,
                            Time = day
                        };

                        statInfo.Add(new UserStatisticInfo(us, false));
                    }
                }
                else if (byDay == 1 && byMonth != 0)
                {
                    var daysFromMonth = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.Time.Month == byMonth && x.CityID == cityID).Select(x => x.Time).Distinct().ToList();

                    foreach (var day in daysFromMonth)
                    {
                        UserStatistics us = new UserStatistics
                        {
                            NumberOfCitizens = mgd.UserStatistic.Where(x => x.Time == day && x.CityID == cityID).Sum(x => x.NumberOfCitizens),
                            NumberOfInstitutions = mgd.UserStatistic.Where(x => x.Time == day && x.CityID == cityID).Sum(x => x.NumberOfInstitutions),
                            CityID = 1,
                            Time = day
                        };

                        statInfo.Add(new UserStatisticInfo(us, false));
                    }
                }
                else if (byDay == 0 && byMonth != 0)
                {
                    for (int i = 1; i <= 12; i++)
                    {
                        var month = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.Time.Month == i && x.CityID == cityID).OrderByDescending(x => x.Time).FirstOrDefault();

                        if (month != null)
                        {
                            UserStatistics us = new UserStatistics
                            {
                                NumberOfCitizens = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.Time.Month == i && x.CityID == cityID).Sum(x => x.NumberOfCitizens),
                                NumberOfInstitutions = mgd.UserStatistic.Where(x => x.Time.Year == byYear && x.Time.Month == i && x.CityID == cityID).Sum(x => x.NumberOfInstitutions),
                                CityID = 1,
                                Time = month.Time.Date
                            };

                            statInfo.Add(new UserStatisticInfo(us, false));
                        }
                    }
                }
            }

            return statInfo.OrderBy(x => x.Time);
        }



        public bool ResetForgottenPassword(string username)
        {
            
                UserDatas user = mgd.User.Where(x => x.Username.Equals(username)).FirstOrDefault();
                RandomPassword randomPass = new RandomPassword();
                if (user != null)
                {
                    string password = randomPass.GeneratePassword(true, true, true, 10);
                    var message = new MimeMessage();
                    message.From.Add(new MailboxAddress("Moj grad", "aplikacijamojgrad@gmail.com"));
                    message.To.Add(new MailboxAddress("Moj grad", user.Email));
                    message.Subject = "Nova lozinka";
                    message.Body = new TextPart("plain")
                    {
                        Text = "Šaljemo Vam novu lozinku kojom možete da pristupite nalogu na aplikaciji Moj grad!\nMolimo Vas da zamenite lozinku kada se prijavite.\n" +
                        "lozinka: " + password + "\nMoj grad."
                    };
                    using (var client = new SmtpClient())
                    {
                        client.Connect("smtp.gmail.com", 587, false);
                        client.Authenticate("aplikacijamojgrad@gmail.com", "mojgrad12345");
                        client.Send(message);
                        client.Disconnect(true);
                    }
                    String newPassword = randomPass.Hash(password);
                    user.Password = newPassword;
                    mgd.User.Update(user);
                    mgd.SaveChanges();
                    //successful
                    return true;
                }
                //user doesn't exist
                return false;
        }

        public IEnumerable<UserDatas> InstitutionsByCityAndCategory(int cityID, int categoryID, int userTypeID)
        {
            if (cityID == 0 && categoryID == 0)
            {
                return mgd.User.Where(x => x.UserTypeID == userTypeID)
                    .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                    .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
            }
            else if (cityID == 0 && categoryID != 0)
            {
                var usersIDs = mgd.CategoryFollow.Where(x => x.CategoryID == categoryID).Select(x => x.UserID).ToList();

                return mgd.User.Where(x => x.UserTypeID == userTypeID && usersIDs.Contains(x.Id))
                    .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                    .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
            }
            else if (cityID != 0 && categoryID == 0)
            {
                return mgd.User.Where(x => x.UserTypeID == userTypeID && x.CityID == cityID)
                    .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                    .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
            }
            else
            {
                var usersIDs = mgd.CategoryFollow.Where(x => x.CategoryID == categoryID).Select(x => x.UserID).ToList();

                return mgd.User.Where(x => x.UserTypeID == userTypeID && usersIDs.Contains(x.Id) && x.CityID == cityID)
                    .Include(c => c.City).Include(po => po.Point).Include(p => p.Posts)
                    .Include(utr => utr.UsersThatReport).Include(utar => utar.UsersThatAreReported).ToList();
            }
        }
    }

    public class RandomPassword
    {
        const string LOWER_CASE = "abcdefghijklmnopqursuvwxyz";
        const string UPPER_CASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        const string NUMBERS = "123456789";

        public string GeneratePassword(bool useLowercase, bool useUppercase, bool useNumbers,
            int passwordSize)
        {
            char[] _password = new char[passwordSize];
            string charSet = ""; // Initialise to blank
            System.Random _random = new Random();
            int counter;
            if (useLowercase) charSet += LOWER_CASE;
            if (useUppercase) charSet += UPPER_CASE;
            if (useNumbers) charSet += NUMBERS;
            for (counter = 0; counter < passwordSize; counter++)
            {
                _password[counter] = charSet[_random.Next(charSet.Length - 1)];
            }
            return String.Join(null, _password);
        }
        public string Hash(string input)
        {
            using (SHA1Managed sha1 = new SHA1Managed())
            {
                var hash = sha1.ComputeHash(Encoding.UTF8.GetBytes(input));
                var sb = new StringBuilder(hash.Length * 2);
                foreach (byte b in hash)
                {
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }
    }
}
