using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminsController : ControllerBase
    {
        private readonly IAdminsUI _IAdminsUI;
        private IConfiguration _config;

        public AdminsController(IAdminsUI IAdminsUI, IConfiguration config)
        {
            _IAdminsUI = IAdminsUI;
            _config = config;
        }

        // GET: api/Admins
        [Authorize]
        [HttpGet]
        public IEnumerable<Admins> GetAdmins()
        {
            return _IAdminsUI.GetAdmins();
        }


        // GET: api/Admins/5
        [Authorize]
        [HttpGet("{id}")]
        public ActionResult<Admins> GetAdmin(int id)
        {
            var admins = _IAdminsUI.GetAdmin(id);

            if (admins == null)
            {
                return NotFound();
            }

            return admins;
        }


        // POST: api/Admins
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [Route("addAdmin")]
        [HttpPost]
        public bool PostAdmin(Admins admin)
        {
            return _IAdminsUI.PostAdmin(admin);
        }

        //[Authorize]
        [Route("login")]
        [HttpPost]
        public IActionResult Login(Login login)
        {
            IActionResult response = Unauthorized();

            var admin = CheckAdmin(login);

            if (admin != null)
            {
                var tokenStr = GenerateJSONWebToken(admin);
                response = Ok(new { token = tokenStr });
            }
            return response;
        }

        private string GenerateJSONWebToken(Admins admin)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, admin.Username),
                new Claim(JwtRegisteredClaimNames.GivenName, "admin"),
                new Claim(JwtRegisteredClaimNames.NameId, admin.Id.ToString()),
                new Claim(JwtRegisteredClaimNames.Jti,Guid.NewGuid().ToString())
            };

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Issuer"],
                claims,
                expires: DateTime.Now.AddMinutes(120),
                signingCredentials: credentials);

            var encodeToken = new JwtSecurityTokenHandler().WriteToken(token);
            return encodeToken;
        }

        //[Authorize]
        [HttpPost]
        public Admins CheckAdmin(Login login)
        {
            return _IAdminsUI.CheckAdmin(login);
        }


        [Authorize]
        [Route("addSponsor")]
        [HttpPost]
        public bool AddSponsor(Sponsors sponsor)
        {
            return _IAdminsUI.AddSponsor(sponsor);
        }

        [Authorize]
        [Route("deleteSponsor/sponsorID={sponsorID}")]
        [HttpGet]
        public bool DeleteSponsor(int sponsorID)
        {
            return _IAdminsUI.DeleteSponsor(sponsorID);
        }

        [Authorize]
        [Route("GetAllSponsors")]
        [HttpGet]
        public IEnumerable<Sponsors> GetAllSponsors()
        {
            return _IAdminsUI.GetAllSponsors();
        }

        [Authorize]
        [Route("GetSponsor/sponsorID={sponsorID}")]
        [HttpGet]
        public ActionResult<Sponsors> GetSponsor(int sponsorID)
        {
            var sponsor = _IAdminsUI.GetSponsor(sponsorID);

            if(sponsor == null)
            {
                return NotFound();
            }

            return sponsor;
        }

        [Authorize]
        [Route("ChangeSponsorInformation")]
        [HttpPost]
        public bool ChangeSponsorInformation(Sponsors sponsor)
        {
            return _IAdminsUI.ChangeSponsorInformation(sponsor);
        }

        [Authorize]
        [Route("GetCategoryStatistics")]
        [HttpGet]
        public IEnumerable<CategoryStatistic> GetCategoryStatistics()
        {
            return _IAdminsUI.GetCategoryStatistics();
        }

        [Authorize]
        [Route("ChangeInfo")]
        [HttpPost]
        public bool ChangeAdminInfo(Admins admin)
        {
            return _IAdminsUI.ChangeAdminInfo(admin);
        }
    }
}
