using mojGradApp.BL.Interfaces;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class CategoriesUI : ICategoriesUI
    {
        private readonly ICategoriesBL _ICategoriesBL;

        public CategoriesUI(ICategoriesBL ICategoriesBL)
        {
            _ICategoriesBL = ICategoriesBL;
        }

        public Categories GetCategory(int id)
        {
            return _ICategoriesBL.GetCategory(id);
        }

        public IEnumerable<Categories> GetCategories()
        {
            return _ICategoriesBL.GetCategories();
        }

        public Categories PostCategory(Categories category)
        {
            return _ICategoriesBL.PostCategory(category);
        }

        public bool AddOrDeleteCategoryFollow(CategoryFollows catFollow)
        {
            return _ICategoriesBL.AddOrDeleteCategoryFollow(catFollow);
        }

        public IEnumerable<Categories> GetCategoriesYouFollow(int userID)
        {
            return _ICategoriesBL.GetCategoriesYouFollow(userID);
        }

        public IEnumerable<Categories> GetCategoriesYouDontFollow(int userID)
        {
            return _ICategoriesBL.GetCategoriesYouDontFollow(userID);
        }

        public bool IsThereAFollow(int userID, int categoryID)
        {
            return _ICategoriesBL.IsThereAFollow(userID, categoryID);
        }

        public bool FollowCategories(List<Categories> categories, string username)
        {
            return _ICategoriesBL.FollowCategories(categories, username);
        }
    }
}
