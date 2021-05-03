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
    public class PostReportsController : ControllerBase
    {
        private readonly IPostReportsUI _IPostReportsUI;

        public PostReportsController(IPostReportsUI IPostReportsUI)
        {
            _IPostReportsUI = IPostReportsUI;
        }

        // GET: api/PostReports
        [Authorize]
        [HttpGet]
        public IEnumerable<PostReports> GetPostReport()
        {
            return _IPostReportsUI.GetPostReport(); 
        }


        // POST: api/PostReports
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public bool PostPostReports(PostReports postReport)
        {
            return _IPostReportsUI.AddPostReport(postReport);
        }

        
    }
}
