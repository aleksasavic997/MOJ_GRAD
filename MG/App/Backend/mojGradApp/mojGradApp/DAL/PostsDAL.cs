using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class PostsDAL : IPostsDAL
    {
        private readonly ApplicationDbContext mgd;

        public PostsDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public List<Posts> GetAllPosts()
        {
            return mgd.Post.Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).Include(ca => ca.Category).Include(p => p.PostReports).ToList();
        }

        public IEnumerable<Posts> GetPosts()
        {
            return mgd.Post.ToList();
        }

        public Posts GetPost(int id)
        {
            return mgd.Post.Where(x => x.Id == id).FirstOrDefault();
        }

        public Posts GetPostByID(int id)
        {
            return mgd.Post.Where(x => x.Id == id).Include(p => p.PostReports).Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).Include(ca => ca.Category).FirstOrDefault();
        }

        public Posts PostPost(Posts post)
        {
            mgd.Post.Add(post);
            mgd.SaveChanges();

            return post;
        }

        public bool DeletePost(int id)
        {
            var post = mgd.Post.Where(x => x.Id == id).FirstOrDefault();
            if(post != null)
            {
                mgd.Post.Remove(post);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public List<Posts> GetPostsByUserID(int id)
        {
            return mgd.Post.Where(x => x.UserID == id).Include(p => p.PostReports).Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).Include(ca => ca.Category).ToList();
        }

        public List<Posts> GetPostsByUserID(int id, int typeId)
        {
            return mgd.Post.Where(x => x.UserID == id && x.TypeID == typeId).Include(p => p.PostReports).
                Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).
                Include(c => c.Comments).Include(ca => ca.Category).ToList();
        }

        public List<Posts> GetPostsByCategoryID(int id)
        {
            return mgd.Post.Where(x => x.CategoryID == id).Include(u => u.User).Include(p => p.PostReports).
                Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                Include(ca => ca.Category).ToList();
        }

        public List<Posts> GetPostsByCityID(int id)
        {
            return mgd.Post.Where(x => x.CityID == id).Include(u => u.User).Include(p => p.PostReports).
                Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                Include(ca => ca.Category).ToList();
        }

        public List<Posts> GetPostsByCityIdAndCategoryId(int cityId, int categoryId)
        {
            if(cityId == 0 && categoryId == 0)
            {
                return mgd.Post.Include(u => u.User).Include(p => p.PostReports).
                Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                Include(ca => ca.Category).ToList();
            }
            else if(categoryId == 0 && cityId != 0)
            {
                return mgd.Post.Where(x => x.CityID == cityId).Include(u => u.User).Include(p => p.PostReports).
                Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                Include(ca => ca.Category).ToList();
            }
            else if(cityId == 0 && categoryId != 0)
            {
                return mgd.Post.Where(x => x.CategoryID == categoryId).Include(u => u.User).Include(p => p.PostReports).
                Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                Include(ca => ca.Category).ToList();
            }
            else
            {
                return mgd.Post.Where(x => x.CityID == cityId && x.CategoryID == categoryId).Include(u => u.User).Include(p => p.PostReports).
                Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                Include(ca => ca.Category).ToList();
            }
        }

        public List<Posts> GetReportedPosts()
        {
            List<Posts> postList = new List<Posts>();

            var postReportIDs = mgd.PostReport.Where(x => x.IsApproved == false).Select(x => x.PostID).ToList().Distinct();

            foreach (var id in postReportIDs)
            {
                if (mgd.PostReport.Where(x => x.PostID == id && x.IsApproved == true).FirstOrDefault() == null)
                {
                    postList.Add(mgd.Post.Where(x => x.Id == id)
                        .Include(p => p.PostReports).Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type)
                        .Include(c => c.Comments).Include(ca => ca.Category).Include(pr => pr.PostReports).FirstOrDefault());
                }
                else
                {
                    if (mgd.UserReport.Where(x => x.ReportedUserID == id && x.IsApproved == false).Count() > 2)
                    {
                        postList.Add(mgd.Post.Where(x => x.Id == id)
                            .Include(p => p.PostReports).Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type)
                            .Include(c => c.Comments).Include(ca => ca.Category).Include(pr => pr.PostReports).FirstOrDefault());
                    }
                }
            }

            return postList;
        }

        public List<Posts> GetReportedPostsByUserID(int userID)
        {
            List<Posts> postList = new List<Posts>();

            var postReportIDs = mgd.PostReport.Where(x => x.IsApproved == false).Select(x => x.PostID).ToList().Distinct();
            var postsOfUser = mgd.Post.Where(x => x.UserID == userID && postReportIDs.Contains(x.Id)).ToList();

            foreach (var post in postsOfUser)
            {
                if (mgd.PostReport.Where(x => x.PostID == post.Id && x.IsApproved == true).FirstOrDefault() == null)
                {
                    postList.Add(mgd.Post.Where(x => x.Id == post.Id)
                        .Include(p => p.PostReports).Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type)
                        .Include(c => c.Comments).Include(ca => ca.Category).Include(pr => pr.PostReports).FirstOrDefault());
                }
                else
                {
                    if (mgd.UserReport.Where(x => x.ReportedUserID == post.Id && x.IsApproved == false).Count() > 2)
                    {
                        postList.Add(mgd.Post.Where(x => x.Id == post.Id)
                            .Include(p => p.PostReports).Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type)
                            .Include(c => c.Comments).Include(ca => ca.Category).Include(pr => pr.PostReports).FirstOrDefault());
                    }
                }
            }

            return postList;
        }

        public bool ChangePostInfo(Posts post)
        {
            var p = mgd.Post.Where(x => x.Id == post.Id).FirstOrDefault();
            if (p != null)
            {
                p.Title = post.Title;
                p.Description = post.Description;
                p.ImagePath = post.ImagePath;
                mgd.Post.Update(p);
                mgd.SaveChanges();
                return true;
            }
            return false;
        }
        public void CheckRang(int userID)
        {
            var user = mgd.User.Where(x => x.Id == userID).FirstOrDefault();

            if (user != null)
            {
                int rank = 0;

                int points = mgd.Point.Where(x => x.UserID == user.Id).Sum(x => x.Number);
                int addedPoints = mgd.Point.Where(x => x.UserID == user.Id).OrderByDescending(x => x.Time).Select(x => x.Number).FirstOrDefault();
                int pastPoints;
                if (addedPoints > 0)
                    pastPoints = points - addedPoints;
                else
                    pastPoints = points + (-1) * addedPoints;

                if (points >= 300 && (pastPoints < 300))
                {
                    rank = 4;
                }
                else if (points < 300 && points >= 200 && ((pastPoints < 200) || (pastPoints >= 300)))
                {
                    rank = 3;
                }
                else if (points < 200 && points >= 100 && ((pastPoints < 100) || (pastPoints >= 200)))
                {
                    rank = 2;
                }
                else if (points < 100 && pastPoints >= 100)
                {
                    rank = 1;
                }
                
                if(rank != 0)
                {
                    RankChanges rc = new RankChanges
                    {
                        UserID = user.Id,
                        RankID = rank,
                        Time = DateTime.Now,
                        IsRead = false
                    };

                    mgd.RankChange.Add(rc);
                    mgd.SaveChanges();
                }
            }
        }

        public int AddChallengeSolution(Posts solution, int challengeID)
        {
            var challenge = mgd.Post.Where(p => p.Id == challengeID).FirstOrDefault();

            if(challenge != null && challenge.TypeID == 1)
            {
                Posts sol = PostPost(solution);

                var user = mgd.User.Where(x => x.Id == sol.UserID).FirstOrDefault();
                if(user != null)
                {
                    Points po = new Points
                    {
                        UserID = user.Id,
                        Number = 50,
                        Time = sol.Time
                    };
                    mgd.Point.Add(po);
                    mgd.SaveChanges();

                    CheckRang(user.Id);
                }

                ChallengeAndSolutions cas = new ChallengeAndSolutions
                {
                    ChallengePostID = challenge.Id,
                    SolutionPostID = sol.Id,
                    IsApproved = true,
                    IsRead = false
                };
                mgd.ChallengeAndSolution.Add(cas);
                mgd.SaveChanges();

                return sol.Id;
            }

            return 0;
        }

        public List<Posts> GetChallengeOrSolution(int postID, int isApproved)
        {
            List<Posts> lp = new List<Posts>();
            var post = mgd.Post.Where(x => x.Id == postID).FirstOrDefault();
            if(post != null)
            {
                if (post.TypeID == 2)
                {
                    var cas = mgd.ChallengeAndSolution.Where(x => x.SolutionPostID == postID).FirstOrDefault();
                    if (cas != null)
                    {
                        lp.Add(GetPostByID(cas.ChallengePostID));
                    }

                    return lp;
                }
                else
                {
                    bool approved = true;
                    if (isApproved == 0)
                    {
                        approved = false;
                    }

                    var solutionIDs = mgd.ChallengeAndSolution.Where(x => x.ChallengePostID == postID && x.IsApproved == approved).Select(x => x.SolutionPostID).ToList();
                    var solutionPosts = mgd.Post.Where(x => solutionIDs.Contains(x.Id)).ToList();

                    foreach (var sol in solutionPosts)
                    {
                        lp.Add(GetPostByID(sol.Id));
                    }

                    return lp;
                }
            }
            return null;
        }

        public bool CloseChallenge(int challengeID)
        {
            var challenge = mgd.Post.Where(p => p.Id == challengeID).FirstOrDefault();

            if (challenge != null && challenge.TypeID == 1)
            {
                challenge.TypeID = 3;
                mgd.Post.Update(challenge);
                mgd.SaveChanges();

                return true;
            }

            return false;
        }

        public bool ChallengeRejected(int challengeID, int solutionID)
        {
            var cas = mgd.ChallengeAndSolution.Where(x => x.SolutionPostID == solutionID && x.ChallengePostID == challengeID).FirstOrDefault();

            if(cas != null)
            {
                cas.IsApproved = false;
                mgd.ChallengeAndSolution.Update(cas);
                mgd.SaveChanges();

                var po = mgd.Post.Where(x => x.Id == cas.SolutionPostID).FirstOrDefault();
                if(po != null)
                {
                    var u = mgd.User.Where(x => x.Id == po.UserID).FirstOrDefault();
                    if(u != null)
                    {
                        int points = mgd.Point.Where(x => x.UserID == u.Id).Sum(x => x.Number);
                        if(points != 0)
                        {
                            if (points - 50 >= 0)
                            {
                                points = 50;
                            }

                            Points p = new Points
                            {
                                Number = (-1) * points,
                                UserID = u.Id,
                                Time = DateTime.Now
                            };
                            mgd.Point.Add(p);
                            mgd.SaveChanges();

                            CheckRang(u.Id);
                        }
                    }
                }
                
                return true;
            }

            return false;
        }

        public List<Posts> GetPostsForInstutuions(int institutionID)
        {
            var ins = mgd.User.Where(x => x.Id == institutionID).FirstOrDefault();
            if(ins != null)
            {
                var categoryIDs = mgd.CategoryFollow.Where(x => x.UserID == institutionID).Select(x => x.CategoryID).ToList();
                return mgd.Post.Where(x => categoryIDs.Contains(x.CategoryID) && x.CityID == ins.CityID).Include(p => p.PostReports).
                Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
            }
            return null;
        }

        public bool IsSolutionApproved(int solutionID)
        {
            var cas = mgd.ChallengeAndSolution.Where(x => x.SolutionPostID == solutionID).FirstOrDefault();
            if(cas != null)
            {
                return cas.IsApproved;
            }
            return false;
        }

        public List<Posts> GetFilteredPosts(List<Categories> cl, int UserID, int cityID, int fromFollowers, int activeChallenge)
        {
            if (cl.Count == 0)
            {
                if (fromFollowers == 0)
                {
                    if (activeChallenge == 0)
                    {
                        return mgd.Post.Where(x => x.CityID == cityID).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                    }
                    else
                    {
                        return mgd.Post.Where(x => x.CityID == cityID && x.TypeID == 1).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                    }
                }
                else
                {
                    var follIDs = mgd.Follow.Where(x => x.UserFollowID == UserID).Select(x => x.FollowedUserID).ToList();
                    follIDs.Add(UserID);

                    if (activeChallenge == 0)
                    {
                        return mgd.Post.Where(x => x.CityID == cityID && follIDs.Contains(x.UserID)).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                    }
                    else
                    {
                        return mgd.Post.Where(x => x.CityID == cityID && x.TypeID == 1 && follIDs.Contains(x.UserID)).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                    }
                }
            }
            else
            {
                var catIDs = cl.Select(x => x.Id).ToList();

                if(fromFollowers == 0)
                {
                    if(activeChallenge == 0)
                    {
                        return mgd.Post.Where(x => x.CityID == cityID && catIDs.Contains(x.CategoryID)).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                    }
                    else
                    {
                        return mgd.Post.Where(x => x.CityID == cityID && catIDs.Contains(x.CategoryID) && x.TypeID == 1).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                    }
                }
                else
                {
                    var follIDs = mgd.Follow.Where(x => x.UserFollowID == UserID).Select(x => x.FollowedUserID).ToList();
                    follIDs.Add(UserID);

                    if (activeChallenge == 0)
                    {
                        return mgd.Post.Where(x => x.CityID == cityID && catIDs.Contains(x.CategoryID) && follIDs.Contains(x.UserID)).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                    }
                    else
                    {
                        return mgd.Post.Where(x => x.CityID == cityID && catIDs.Contains(x.CategoryID) && x.TypeID == 1 && follIDs.Contains(x.UserID)).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                    }
                }
            }
        }

        public List<Posts> GetMostImportantPost(int cityID, int typeID)
        {
            if(cityID == 0)
            {
                if(typeID == 0)
                {
                    return mgd.Post.Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                }
                else
                {
                    return mgd.Post.Where(x => x.TypeID == typeID).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                }
            }
            else
            {
                if (typeID == 0)
                {
                    return mgd.Post.Where(x => x.CityID == cityID).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                }
                else
                {
                    return mgd.Post.Where(x => x.TypeID == typeID && x.CityID == cityID).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
                }
            }
        }

        public List<Posts> GetMostImportantPostByUsesID(int userID, int typeID)
        {
            if(typeID == 0)
            {
                return mgd.Post.Where(x => x.UserID == userID).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
            }
            else
            {
                return mgd.Post.Where(x => x.TypeID == typeID && x.UserID == userID).Include(p => p.PostReports).
                            Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type).Include(c => c.Comments).
                            Include(ca => ca.Category).Include(pr => pr.PostReports).ToList();
            }
        }

        public bool DissmissPostReports(int postID)
        {
            var postReports = mgd.PostReport.Where(x => x.PostID == postID && x.IsApproved == false).ToList();

            if (postReports != null)
            {
                foreach (var item in postReports)
                {
                    item.IsApproved = true;
                    mgd.PostReport.Update(item);
                    mgd.SaveChanges();
                }

                return true;
            }

            return false;
        }

        public List<Posts> GetApprovedReportedPosts()
        {
            List<Posts> postList = new List<Posts>();

            var postReportIDs = mgd.PostReport.Where(x => x.IsApproved == true).Select(x => x.PostID).ToList().Distinct();

            foreach (var id in postReportIDs)
            {
                if (mgd.PostReport.Where(x => x.PostID == id && x.IsApproved == false).FirstOrDefault() == null)
                {
                    postList.Add(mgd.Post.Where(x => x.Id == id)
                        .Include(p => p.PostReports).Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type)
                        .Include(c => c.Comments).Include(ca => ca.Category).Include(pr => pr.PostReports).FirstOrDefault());
                }
                else
                {
                    if (mgd.UserReport.Where(x => x.ReportedUserID == id && x.IsApproved == true).Count() < 2)
                    {
                        postList.Add(mgd.Post.Where(x => x.Id == id)
                            .Include(p => p.PostReports).Include(u => u.User).Include(pr => pr.PostReactions).Include(t => t.Type)
                            .Include(c => c.Comments).Include(ca => ca.Category).Include(pr => pr.PostReports).FirstOrDefault());
                    }
                }
            }

            return postList;
        }

        public bool SaveOrUnsavePost(SavedPosts sp)
        {
            var checkPost = mgd.Post.Where(x => x.Id == sp.PostID).FirstOrDefault();

            if(checkPost != null)
            {
                var saved = mgd.SavedPost.Where(x => x.PostID == sp.PostID && x.UserID == sp.UserID).FirstOrDefault();

                if (saved != null)
                {
                    mgd.SavedPost.Remove(saved);
                    mgd.SaveChanges();

                    return true;
                }
                else
                {
                    mgd.SavedPost.Add(sp);
                    mgd.SaveChanges();

                    return true;
                }
            }

            return false;
        }

        public IEnumerable<SavedPosts> GetSavedPosts(int userID)
        {
            return mgd.SavedPost.Where(x => x.UserID == userID).ToList().OrderByDescending(x => x.Time);
        }

        public bool CheckIfSaved(int userID, int postID)
        {
            var s = mgd.SavedPost.Where(x => x.UserID == userID && x.PostID == postID).FirstOrDefault();

            if(s == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }
}
