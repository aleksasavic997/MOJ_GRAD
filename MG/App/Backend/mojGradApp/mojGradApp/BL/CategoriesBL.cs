using mojGradApp.BL.Interfaces;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class CategoriesBL : ICategoriesBL
    {
        private readonly ICategoriesDAL _ICategoriesDAL;

        public CategoriesBL(ICategoriesDAL ICategoriesDAL)
        {
            _ICategoriesDAL = ICategoriesDAL;
        }

        public Categories GetCategory(int id)
        {
            return _ICategoriesDAL.GetCategory(id);
        }

        public IEnumerable<Categories> GetCategories()
        {
            return _ICategoriesDAL.GetCategories();
        }

        public Categories PostCategory(Categories category)
        {
            return _ICategoriesDAL.PostCategory(category);
        }

        public bool AddOrDeleteCategoryFollow(CategoryFollows catFollow)
        {
            return _ICategoriesDAL.AddOrDeleteCategoryFollow(catFollow);
        }

        public IEnumerable<Categories> GetCategoriesYouFollow(int userID)
        {
            return _ICategoriesDAL.GetCategoriesYouFollow(userID);
        }

        public IEnumerable<Categories> GetCategoriesYouDontFollow(int userID)
        {
            return _ICategoriesDAL.GetCategoriesYouDontFollow(userID);
        }

        public bool IsThereAFollow(int userID, int categoryID)
        {
            return _ICategoriesDAL.IsThereAFollow(userID, categoryID);
        }

        public bool FollowCategories(List<Categories> categories, string username)
        {
            return _ICategoriesDAL.FollowCategories(categories, username);
        }
    }
}
