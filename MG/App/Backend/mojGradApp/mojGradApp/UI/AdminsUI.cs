using mojGradApp.BL.Interfaces;
using mojGradApp.Controllers;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using mojGradApp.UI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.UI
{
    public class AdminsUI : IAdminsUI
    {
        private readonly IAdminsBL _IAdminsBL;

        public AdminsUI(IAdminsBL IAdminsBL)
        {
            _IAdminsBL = IAdminsBL;
        }

        public Admins CheckAdmin(Login login)
        {
            return _IAdminsBL.CheckAdmin(login);
        }

        public IEnumerable<Admins> GetAdmins()
        {
            return _IAdminsBL.GetAdmins();
        }

        public Admins GetAdmin(int id)
        {
            return _IAdminsBL.GetAdmin(id);
        }

        public bool PostAdmin(Admins admin)
        {
            return _IAdminsBL.PostAdmin(admin);
        }

        public bool AddSponsor(Sponsors sponsor)
        {
            return _IAdminsBL.AddSponsor(sponsor);
        }

        public bool DeleteSponsor(int sponsorID)
        {
            return _IAdminsBL.DeleteSponsor(sponsorID);
        }

        public IEnumerable<Sponsors> GetAllSponsors()
        {
            return _IAdminsBL.GetAllSponsors();
        }

        public Sponsors GetSponsor(int sponsorID)
        {
            return _IAdminsBL.GetSponsor(sponsorID);
        }

        public IEnumerable<CategoryStatistic> GetCategoryStatistics()
        {
            return _IAdminsBL.GetCategoryStatistics();
        }

        public bool ChangeAdminInfo(Admins admin)
        {
            return _IAdminsBL.ChangeAdminInfo(admin);
        }

        public bool ChangeSponsorInformation(Sponsors sponsor)
        {
            return _IAdminsBL.ChangeSponsorInformation(sponsor);
        }
    }
}
