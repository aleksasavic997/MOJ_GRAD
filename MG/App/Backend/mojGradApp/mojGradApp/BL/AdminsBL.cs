using mojGradApp.BL.Interfaces;
using mojGradApp.Controllers;
using mojGradApp.DAL.Interfaces;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL
{
    public class AdminsBL : IAdminsBL
    {
        private readonly IAdminsDAL _IAdminsDAL;

        public AdminsBL(IAdminsDAL IAdminsDAL)
        {
            _IAdminsDAL = IAdminsDAL;
        }

        public Admins CheckAdmin(Login login)
        {
            return _IAdminsDAL.CheckAdmin(login);
        }

        public IEnumerable<Admins> GetAdmins()
        {
            return _IAdminsDAL.GetAdmins();
        }

        public Admins GetAdmin(int id)
        {
            return _IAdminsDAL.GetAdmin(id);
        }

        public bool PostAdmin(Admins admin)
        {
            return _IAdminsDAL.PostAdmin(admin);
        }

        public bool AddSponsor(Sponsors sponsor)
        {
            return _IAdminsDAL.AddSponsor(sponsor);
        }

        public bool DeleteSponsor(int sponsorID)
        {
            return _IAdminsDAL.DeleteSponsor(sponsorID);
        }

        public IEnumerable<Sponsors> GetAllSponsors()
        {
            return _IAdminsDAL.GetAllSponsors();
        }

        public Sponsors GetSponsor(int sponsorID)
        {
            return _IAdminsDAL.GetSponsor(sponsorID);
        }

        public IEnumerable<CategoryStatistic> GetCategoryStatistics()
        {
            return _IAdminsDAL.GetCategoryStatistics();
        }

        public bool ChangeAdminInfo(Admins admin)
        {
            return _IAdminsDAL.ChangeAdminInfo(admin);
        }

        public bool ChangeSponsorInformation(Sponsors sponsor)
        {
            return _IAdminsDAL.ChangeSponsorInformation(sponsor);
        }
    }
}
