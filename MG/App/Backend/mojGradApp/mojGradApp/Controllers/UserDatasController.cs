using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using MailKit.Net.Smtp;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.CookiePolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using MimeKit;
using mojGradApp.Data;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserDatasController : ControllerBase
    {
        private readonly IUserDatasUI _IUserDatasUI;
        private IConfiguration _config;

        public UserDatasController(IUserDatasUI IUserDatasUI, IConfiguration config)
        {
            _IUserDatasUI = IUserDatasUI;
            _config = config;
        }

        // GET: api/UserDatas
        [Authorize]
        [Route("citizens/userId={userID}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetUsersThatAreCitizens(int userID)
        {
            int userTypeID = 1;
            return GetUsersByUserTypeID(userTypeID, userID).OrderByDescending(x => x.Points);
        }

        [Authorize]
        [Route("followSugestions/userId={userID}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetFollowSugestions(int userID)
        {
            int userTypeID = 1; //citizens
            var users =_IUserDatasUI.GetFollowSugestions(userID, userTypeID);

            List<UserInfo> listUser = new List<UserInfo>();

            foreach (var user in users)
            {
                listUser.Add(new UserInfo(user));
            }

            return listUser;
        }

        [Authorize]
        [Route("institutions")]
        [HttpGet]
        public IEnumerable<UserInfo> GetUsersThatAreInstitutions()
        {
            int userTypeID = 2;
            return GetUsersByUserTypeID(userTypeID);
        }


        [Authorize]
        private IEnumerable<UserInfo> GetUsersByUserTypeID(int userTypeID, int userID = 0)
        {
            var users = _IUserDatasUI.GetAllUsers(userTypeID, userID);
            List<UserInfo> listUser = new List<UserInfo>();

            foreach (var user in users)
            {
                if (userID != 0)
                    listUser.Add(new UserInfo(user, userID));
                else
                    listUser.Add(new UserInfo(user));
            }

            return listUser;
        }

        [Authorize]
        [Route("citizens/cityID={cityID}/userId={userID}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetAllCitizensFromOneCity(int cityID, int userID)
        {
            int userTypeID = 1;
            return GetUsersByCityID(cityID, userTypeID, userID);
        }

        [Authorize]
        [Route("institutions/city/{cityID}/category/{categoryID}/verificated/{verification}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetAllInstitutionsFromOneCityByCategory(int cityID, int categoryID, int verification)
        {
            int userTypeID = 2;
            return GetUsersByCityID(cityID, userTypeID, 0, categoryID, verification);
        }

        [Authorize]
        [Route("institutions/city/{cityID}/category/{categoryID}")]
        [HttpGet]
        public IEnumerable<UserInfo> InstitutionsByCityAndCategory(int cityID, int categoryID)
        {
            int userTypeID = 2;
            List<UserInfo> listUser = new List<UserInfo>();

            var users = _IUserDatasUI.InstitutionsByCityAndCategory(cityID, categoryID, userTypeID);

            foreach (var user in users)
            {
                listUser.Add(new UserInfo(user));
            }

            return listUser;
        }

        [Authorize]
        [Route("institutions/verification/id={id}")]
        [HttpPost]
        public bool VerifyInstitution(int id)
        {
            var institution = _IUserDatasUI.GetUserByID(id);
            if (institution != null && institution.IsVerified == false)
            {
                _IUserDatasUI.Verify(id);
                var message = new MimeMessage();
                message.From.Add(new MailboxAddress("Moj grad", "aplikacijamojgrad@gmail.com"));
                message.To.Add(new MailboxAddress("Moj grad", institution.Email));
                message.Subject = "Moj grad";
                message.Body = new TextPart("plain")
                {
                    Text = "Vaš zahtev za registraciju je prihvaćen.\nMoj grad."
                };
                using (var client = new SmtpClient())
                {
                    client.Connect("smtp.gmail.com", 587, false);
                    client.Authenticate("aplikacijamojgrad@gmail.com", "mojgrad12345");
                    client.Send(message);
                    client.Disconnect(true);
                }
                return true;
            }
            return false;
        }

        [Authorize]
        [Route("forgottenpassword/username={username}")]
        [HttpPost]
        public bool ResetForgottenPassword(string username)
        {
           return  _IUserDatasUI.ResetForgottenPassword(username);
        }

        private IEnumerable<UserInfo> GetUsersByCityID(int cityID, int userTypeID, int userID = 0, int categoryID = 0, int verification = 0)
        {
            List<UserDatas> users = _IUserDatasUI.GetUsersByCityID(userTypeID, cityID, userID, categoryID, verification);
            List<UserInfo> listUser = new List<UserInfo>();

            foreach (var user in users)
            {
                listUser.Add(new UserInfo(user));
            }

            return listUser;
        }


        // GET: api/UserDatas/5
        [Authorize]
        [HttpGet("{id}")]
        public ActionResult<UserInfo> GetUserData(int id)
        {
            var userDatas = _IUserDatasUI.GetUserByID(id);

            if (userDatas == null)
            {
                return NotFound();
            }

            return new UserInfo(userDatas);
        }


        // POST: api/UserDatas
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public bool PostUserData(UserDatas userData)
        {
            return _IUserDatasUI.PostUserData(userData);
        }

        //[Authorize]
        [Route("login/UserTypeID={UserTypeID}")]
        [HttpPost]
        public IActionResult Login(Login login, int UserTypeID)
        {
            IActionResult response = Unauthorized();

            var user = CheckUser(login, UserTypeID);

            if (user != null)
            {
                var tokenStr = GenerateJSONWebToken(user);
                response = Ok(new { token = tokenStr });
            }
            return response;
        }

        
        public UserDatas CheckUser(Login login, int UserTypeID)
        {
            return _IUserDatasUI.CheckUser(login, UserTypeID);
        }

        [Authorize]
        [Route("login/IsLogged/{userID}")]
        [HttpPost]
        public bool IsUserLogged(int userID)
        {
            return _IUserDatasUI.CheckIfAlreadyLogged(userID);
        }

        [Authorize]
        [Route("logout/{userID}")]
        [HttpPost]
        public bool Logout(int userID)
        {
            return _IUserDatasUI.Logout(userID);
        }


        private string GenerateJSONWebToken(UserDatas user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
                new Claim(JwtRegisteredClaimNames.GivenName, "user"),
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
        [Route("email")]
        [HttpPost]
        public bool CheckEmail(UserEmail email)
        {
            return _IUserDatasUI.CheckEmail(email);
        }

        //[Authorize]
        [Route("username")]
        [HttpPost]
        public bool CheckUsername(UsernameReg username)
        {
            return _IUserDatasUI.CheckUsername(username);
        }

        [Authorize]
        [Route("ChangeInfo")]
        [HttpPost]
        public bool ChangeUserInfo(UserDatas user)
        {
            return _IUserDatasUI.ChangeUserInfo(user);
        }

        [Authorize]
        [Route("GetReportedUsers")]
        [HttpGet]
        public IEnumerable<UserInfo> GetReportedUsers()
        {
            var reportedUsers = _IUserDatasUI.GetReportedUsers();
            List<UserInfo> listReportedUsers = new List<UserInfo>();

            foreach (var user in reportedUsers)
            {
                listReportedUsers.Add(new UserInfo(user));
            }

            return listReportedUsers.OrderByDescending(rc => rc.ReportCount);
        }


        // DELETE: api/UserDatas/5
        [Authorize]
        [HttpDelete("{id}")]
        public bool DeleteUserDatas(int id)
        {
            return _IUserDatasUI.DeleteUser(id);
        }

        [Authorize]
        [Route("GetUsersThatReacted/post/{postID}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetUsersThatReactedOnPost(int postID)
        {
            var users = _IUserDatasUI.GetUsersThatReactedOnPost(postID);
            List<UserInfo> listUser = new List<UserInfo>();

            foreach (var user in users)
            {
                listUser.Add(new UserInfo(user));
            }

            return listUser;
        }

        [Authorize]
        [Route("GetUsersThatLiked/comment/{commentID}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetUsersThatLikedComment(int commentID)
        {
            int reactionType = 1;
            return GetUsersThatReactedOnComment(commentID, reactionType);
        }

        [Authorize]
        [Route("GetUsersThatDisliked/comment/{commentID}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetUsersThatDislikedComment(int commentID)
        {
            int reactionType = -1;
            return GetUsersThatReactedOnComment(commentID, reactionType);
        }

        private IEnumerable<UserInfo> GetUsersThatReactedOnComment(int commentID, int reactionType)
        {
            var users = _IUserDatasUI.GetUsersThatLikedOrDislikedComment(commentID, reactionType);
            List<UserInfo> listUser = new List<UserInfo>();

            foreach (var user in users)
            {
                listUser.Add(new UserInfo(user));
            }

            return listUser;
        }

        [Authorize]
        [Route("CheckRang/userID={userID}")]
        [HttpGet]
        public String CheckRang(int userID)
        {
            return _IUserDatasUI.CheckRang(userID);
        }


        [Authorize]
        [Route("GetBest/userTypeID={userTypeID}/days={days}/userNumber={userNumber}")]
        [HttpGet]
        public IEnumerable<UserInfo> GetBest(int userTypeID, int days, int userNumber)
        {
            var users = _IUserDatasUI.GetBest(userTypeID, days, userNumber);
            List<UserInfo> listUser = new List<UserInfo>();
           
            foreach (var user in users.ToList())
            {
                listUser.Add(new UserInfo(user));
            }

            return listUser;
        }

        [Authorize]
        [Route("GetPointsForUser/userID={userID}/days={days}")]
        [HttpGet]
        public int GetPointsForUser(int userID, int days)
        {
            return _IUserDatasUI.GetPointsForUser(userID, days);
        }

        [Authorize]
        [Route("DissmissUserReports/userID={userID}")]
        [HttpGet]
        public bool DissmissUserReports(int userID)
        {
            return _IUserDatasUI.DissmissUserReports(userID);
        }

        [Authorize]
        [Route("GetApprovedReportedUsers")]
        [HttpGet]
        public IEnumerable<UserInfo> GetApprovedReportedUsers()
        {
            var approvedReportedUsers = _IUserDatasUI.GetApprovedReportedUsers();
            List<UserInfo> userList = new List<UserInfo>();

            foreach (var user in approvedReportedUsers)
            {
                userList.Add(new UserInfo(user));
            }

            return userList.OrderByDescending(rc => rc.ReportCount);
        }


        //-------------------------------------- MESSAGES ---------------------------------------//
        [Authorize]
        [Route("SendMessage")]
        [HttpPost]
        public bool SendMessage(Messages message)
        {
            return _IUserDatasUI.SendMessage(message);
        }

        [Authorize]
        [Route("DeleteMessage/messageID={messageID}")]
        [HttpGet]
        public bool DeleteMessage(int messageID)
        {
            return _IUserDatasUI.DeleteMessage(messageID);
        }

        [Authorize]
        [Route("GetAllUsersYouChattedWith/userID={userID}")]
        [HttpGet]
        public IEnumerable<UserDatas> GetAllUsersYouChattedWith(int userID)
        {
            return _IUserDatasUI.GetAllUsersYouChattedWith(userID);
        }

        [Authorize]
        [Route("GetAllMessages/user1ID={user1ID}/user2ID={user2ID}/numberOfMessages={numberOfMessages}")]
        [HttpGet]
        public IEnumerable<Messages> GetAllMessages(int user1ID, int user2ID, int numberOfMessages)
        {
            IEnumerable<Messages> messages = _IUserDatasUI.GetAllMessages(user1ID, user2ID);

            return messages.Take(numberOfMessages);
        }

        [Authorize]
        [Route("GetNumberOfUnreadMessages/user1ID={user1ID}/user2ID={user2ID}")]
        [HttpGet]
        public int GetNumberOfUnreadMessages(int user1ID, int user2ID)
        {
            return _IUserDatasUI.GetNumberOfUnreadMessages(user1ID, user2ID);
        }

        [Authorize]
        [Route("ReadMessages/user1ID={user1ID}/user2ID={user2ID}")]
        [HttpGet]
        public bool ReadMessages(int user1ID, int user2ID)
        {
            return _IUserDatasUI.ReadMessages(user1ID, user2ID);
        }
        //----------------------------------- END OF MESSAGES ------------------------------------//

        [Authorize]
        [Route("NotVerifiedInstitutions")]
        [HttpGet]
        public IEnumerable<UserDatas> NotVerifiedInstitutions()
        {
            return _IUserDatasUI.NotVerifiedInstitutions();
        }

        [Authorize]
        [Route("GetUserStatistics/cityID={cityID}/byDay={byDay}/byMonth={byMonth}/byYear={byYear}")]
        [HttpGet]
        public IEnumerable<UserStatisticInfo> GetUserStatistics(int cityID, int byDay, int byMonth, int byYear)
        {
            return _IUserDatasUI.GetUserStatistics(cityID,  byDay, byMonth, byYear);
        }
    }
    public class Login
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class UserEmail
    {
        public string Email { get; set; }
    }

    public class UsernameReg
    {
        public string Username { get; set; }
    }

}
