using mojGradApp.Controllers;
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
    public class AdminsDAL : IAdminsDAL
    {
        private readonly ApplicationDbContext mgd;

        public AdminsDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public Admins CheckAdmin(Login login)
        {
            var admins =  mgd.Admin.ToList();
            var admin = admins.Where(a => a.Username.Equals(login.Username) && a.Password.Equals(login.Password)).FirstOrDefault();

            return admin;
        }

        public IEnumerable<Admins> GetAdmins()
        {
            return mgd.Admin.ToList();
        }

        public Admins GetAdmin(int id)
        {
            return mgd.Admin.Find(id);
        }

        public bool PostAdmin(Admins admin)
        {
            var checkUser = mgd.User.Where(x => x.Username == admin.Username).FirstOrDefault();
            var checkAdmin = mgd.Admin.Where(x => x.Username == admin.Username).FirstOrDefault();

            if (checkUser == null && checkAdmin == null)
            {
                mgd.Admin.Add(admin);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public bool AddSponsor(Sponsors sponsor)
        {
            if(sponsor.Name == "" || sponsor.Description == "")
            {
                return false;
            }
            else
            {
                mgd.Sponsor.Add(sponsor);
                mgd.SaveChanges();

                return true;
            }
        }

        public bool DeleteSponsor(int sponsorID)
        {
            var sponsor = mgd.Sponsor.Where(x => x.Id == sponsorID).FirstOrDefault();

            if(sponsor != null)
            {
                mgd.Sponsor.Remove(sponsor);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public IEnumerable<Sponsors> GetAllSponsors()
        {
            return mgd.Sponsor.ToList();
        }

        public Sponsors GetSponsor(int sponsorID)
        {
            return mgd.Sponsor.Where(x => x.Id == sponsorID).FirstOrDefault();
        }

        public IEnumerable<CategoryStatistic> GetCategoryStatistics()
        {
            var categories = mgd.Category.ToList();
            List<CategoryStatistic> statList = new List<CategoryStatistic>();
            int solNumber;
            int reactNumber;

            foreach (var cat in categories)
            {
                solNumber = 0;
                var challengeIDs = mgd.Post.Where(x => x.CategoryID == cat.Id && (x.TypeID == 1 || x.TypeID == 3)).Select(x => x.Id).ToList().Distinct();

                foreach (var chID in challengeIDs)
                {
                    if(mgd.ChallengeAndSolution.Where(x => x.ChallengePostID == chID).FirstOrDefault() != null)
                    {
                        solNumber++;
                    }
                }

                reactNumber = 0;
                var postIDs = mgd.Post.Where(x => x.CategoryID == cat.Id).Select(x => x.Id).ToList();

                foreach (var pID in postIDs)
                {
                    reactNumber += mgd.PostReaction.Where(x => x.PostID == pID).Count();
                }

                CategoryStatistic cs = new CategoryStatistic
                {
                    Id = cat.Id,
                    Name = cat.Name,
                    ChallengeNumber = mgd.Post.Where(x => x.CategoryID == cat.Id && (x.TypeID == 1 || x.TypeID == 3)).Count(),
                    SolutionNumber = solNumber,
                    PostNumber = mgd.Post.Where(x => x.CategoryID == cat.Id).Count(),
                    ReactionNumber = reactNumber
                };

                statList.Add(cs);
            }

            return statList;
        }

        public bool ChangeAdminInfo(Admins admin)
        {
            var a = mgd.Admin.Where(x => x.Id == admin.Id).FirstOrDefault();

            if(a != null)
            {
                a.Username = admin.Username;
                a.Password = admin.Password;

                mgd.Admin.Update(a);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public bool ChangeSponsorInformation(Sponsors sponsor)
        {
            var s = mgd.Sponsor.Where(x => x.Id == sponsor.Id).FirstOrDefault();

            if (s != null)
            {
                s.Name = sponsor.Name;
                s.Description = sponsor.Description;
                s.ImagePath = sponsor.ImagePath;
                s.FacebookLink = sponsor.FacebookLink;
                s.TwitterLink = sponsor.TwitterLink;
                s.YouTubeLink = sponsor.YouTubeLink;
                s.InstagramLink = sponsor.InstagramLink;
                s.WebsiteLink = sponsor.WebsiteLink;

                mgd.Sponsor.Update(s);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }
    }
}
