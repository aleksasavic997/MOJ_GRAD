using mojGradApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI.Interfaces
{
    public interface ICategoriesUI
    {
        IEnumerable<Categories> GetCategories();
        Categories PostCategory(Categories category);
        Categories GetCategory(int id);
        bool AddOrDeleteCategoryFollow(CategoryFollows catFollow);
        IEnumerable<Categories> GetCategoriesYouFollow(int userID);
        IEnumerable<Categories> GetCategoriesYouDontFollow(int userID);
        bool IsThereAFollow(int userID, int categoryID);
        bool FollowCategories(List<Categories> categories, string username);
    }
}
