using mojGradApp.DAL.Interfaces;
using mojGradApp.Data;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL
{
    public class CategoriesDAL : ICategoriesDAL
    {
        private readonly ApplicationDbContext mgd;

        public CategoriesDAL(ApplicationDbContext context)
        {
            mgd = context;
        }

        public Categories GetCategory(int id)
        {
            return mgd.Category.Find(id);
        }

        public IEnumerable<Categories> GetCategories()
        {
            return mgd.Category.ToList();
        }

        public Categories PostCategory(Categories category)
        { 
            mgd.Category.Add(category);
            mgd.SaveChangesAsync();

            return category;
        }

        public bool AddOrDeleteCategoryFollow(CategoryFollows catFollow)
        {
            var cf = mgd.CategoryFollow.Where(x => x.UserID == catFollow.UserID && x.CategoryID == catFollow.CategoryID).FirstOrDefault();

            if (cf != null)
            {
                mgd.CategoryFollow.Remove(cf);
                mgd.SaveChanges();

                return false;
            }
            else
            {
                mgd.CategoryFollow.Add(catFollow);
                mgd.SaveChanges();

                return true;
            }
        }

        public IEnumerable<Categories> GetCategoriesYouFollow(int userID)
        {
            var categoryIDs = mgd.CategoryFollow.Where(x => x.UserID == userID).Select(x => x.CategoryID).ToList();

            return mgd.Category.Where(x => categoryIDs.Contains(x.Id)).ToList();
        }

        public IEnumerable<Categories> GetCategoriesYouDontFollow(int userID)
        {
            var categoryIDs = mgd.CategoryFollow.Where(x => x.UserID == userID).Select(x => x.CategoryID).ToList();
            IEnumerable<Categories> allCategories = GetCategories();
            List<Categories> categoriesYouDontFollow = new List<Categories>();

            foreach (var category in allCategories)
            {
                if (categoryIDs.Contains(category.Id)) ;
                else
                    categoriesYouDontFollow.Add(category);
            }

            return categoriesYouDontFollow;
        }

        public bool IsThereAFollow(int userID, int categoryID)
        {
            var cf = mgd.CategoryFollow.Where(x => x.UserID == userID && x.CategoryID == categoryID).FirstOrDefault();

            if (cf != null)
                return true;

            return false;
        }

        public bool FollowCategories(List<Categories> categories, string username)
        {
            var user = mgd.User.Where(x => x.Username == username).FirstOrDefault();
            
            if(user != null)
            {
                var existingCategoryIDs = mgd.CategoryFollow.Where(x => x.UserID == user.Id).Select(x => x.CategoryID).ToList();
                var newCategoryIDs = categories.Select(x => x.Id).ToList();

                foreach (var existingCatID in existingCategoryIDs)
                {
                    if(newCategoryIDs.Contains(existingCatID) == false)
                    {
                        var cf = mgd.CategoryFollow.Where(x => x.CategoryID == existingCatID && x.UserID == user.Id).FirstOrDefault();
                        
                        if(cf != null)
                        {
                            mgd.CategoryFollow.Remove(cf);
                            mgd.SaveChanges();
                        }
                    }
                }

                foreach (var newCatID in newCategoryIDs)
                {
                    if(existingCategoryIDs.Contains(newCatID) == false)
                    {
                        CategoryFollows cf = new CategoryFollows
                        {
                            UserID = user.Id,
                            CategoryID = newCatID
                        };

                        mgd.CategoryFollow.Add(cf);
                        mgd.SaveChanges();
                    }
                }

                return true;
            }

            return false;
        }
    }
}
