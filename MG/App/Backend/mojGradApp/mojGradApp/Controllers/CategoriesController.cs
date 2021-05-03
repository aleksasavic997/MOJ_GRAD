using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using Microsoft.EntityFrameworkCore;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly ICategoriesUI _ICategoriesUI;

        public CategoriesController(ICategoriesUI ICategoriesUI)
        {
            _ICategoriesUI = ICategoriesUI;
        }

        // GET: api/Categories
        //[Authorize]
        [HttpGet]
        public IEnumerable<Categories> GetCategories()
        {
            return _ICategoriesUI.GetCategories();
        }


        // GET: api/Categories/5
        [Authorize]
        [HttpGet("{id}")]
        public ActionResult<Categories> GetCategory(int id)
        {
            var categories = _ICategoriesUI.GetCategory(id);

            if (categories == null)
            {
                return NotFound();
            }

            return categories;
        }


        // POST: api/Categories
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public ActionResult<Categories> PostCategory(Categories categorie)
        {
            Categories c = _ICategoriesUI.PostCategory(categorie);

            return CreatedAtAction("GetCategories", new { id = c.Id }, c);
        }

        [Authorize]
        [Route("FollowCategories/username={username}")]
        [HttpPost]
        public bool FollowCategories(List<Categories> categories, String username)
        {
            return _ICategoriesUI.FollowCategories(categories, username);
        }

        [Authorize]
        [Route("AddOrDeleteCategoryFollow")]
        [HttpPost]
        public bool AddOrDeleteCategoryFollow(CategoryFollows catFollow)
        {
            return _ICategoriesUI.AddOrDeleteCategoryFollow(catFollow);
        }

        [Authorize]
        [Route("GetCategoriesYouFollow/{userID}")]
        [HttpGet]
        public IEnumerable<Categories> GetCategoriesYouFollow(int userID)
        {
            return _ICategoriesUI.GetCategoriesYouFollow(userID);
        }

        [Authorize]
        [Route("GetCategoriesYouDontFollow/{userID}")]
        [HttpGet]
        public IEnumerable<Categories> GetCategoriesYouDontFollow(int userID)
        {
            return _ICategoriesUI.GetCategoriesYouDontFollow(userID);
        }

        [Authorize]
        [Route("IsThereAFollow/{userID}/{categoryID}")]
        [HttpGet]
        public bool IsThereAFollow(int userID, int categoryID)
        {
            return _ICategoriesUI.IsThereAFollow(userID, categoryID);
        }
    }
}
