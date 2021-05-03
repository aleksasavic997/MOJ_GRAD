using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserReportsController : ControllerBase
    {
        private readonly IUserReportsUI _IUserReportsUI;

        public UserReportsController(IUserReportsUI IUserReportsUI)
        {
            _IUserReportsUI = IUserReportsUI;
        }

        // GET: api/UserReports
        [Authorize]
        [HttpGet]
        public  IEnumerable<UserReports> GetUserReports()
        {
            return _IUserReportsUI.GetUserReports(); 
        }


        // POST: api/UserReports
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public  bool PostUserReport(UserReports userReport)
        {
           return _IUserReportsUI.AddUserReport(userReport);
        }

        
    }
}
