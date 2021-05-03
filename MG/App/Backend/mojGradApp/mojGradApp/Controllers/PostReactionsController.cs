using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PostReactionsController : ControllerBase
    {
        private readonly IPostReactionsUI _IPostReactionsUI;

        public PostReactionsController(IPostReactionsUI IPostReactionsUI)
        {
            _IPostReactionsUI = IPostReactionsUI;
        }

        // GET: api/PostReactions
        [Authorize]
        [HttpGet]
        public IEnumerable<PostReactions> GetPostReactions()
        {
            return _IPostReactionsUI.GetPostReaction(); 
        }

        [Authorize]
        [Route("NewPostReaction")]
        [HttpPost]
        public bool AddPostReaction(PostReactions postReaction)
        {
            return _IPostReactionsUI.AddOrDeletePostReaction(postReaction);
        }
    }
}
