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
    public class CommentReactionsController : ControllerBase
    {
        private readonly ICommentReactionsUI _ICommentReactionsUI;

        public CommentReactionsController(ICommentReactionsUI ICommentReactionsUI)
        {
            _ICommentReactionsUI = ICommentReactionsUI;
        }


        // GET: api/CommentReactions
        [Authorize]
        [HttpGet]
        public IEnumerable<CommentReaction> GetCommentReactions()
        {
            return _ICommentReactionsUI.GetCommentReactions();
        }


        // POST: api/CommentRections
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public ActionResult<CommentReaction> PostCommentReaction(CommentReaction commentReaction)
        {
            CommentReaction cl = _ICommentReactionsUI.AddCommentReaction(commentReaction);

            return CreatedAtAction("GetCommentLikes", new { id = cl.Id }, cl);
        }

        [Authorize]
        [Route("NewCommentReaction")]
        [HttpPost]
        public bool AddCommentReaction(CommentReaction commentReaction)
        {
            return _ICommentReactionsUI.AddOrDeleteCommentReaction(commentReaction);
        }
    }
}
