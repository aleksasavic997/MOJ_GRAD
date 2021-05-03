using mojGradApp.Controllers;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.BL.Interfaces
{
    public interface IAdminsBL
    {
        IEnumerable<Admins> GetAdmins();
        bool PostAdmin(Admins admins);
        Admins CheckAdmin(Login login);
        Admins GetAdmin(int id);
        bool AddSponsor(Sponsors sponsor);
        bool DeleteSponsor(int sponsorID);
        IEnumerable<Sponsors> GetAllSponsors();
        Sponsors GetSponsor(int sponsorID);
        IEnumerable<CategoryStatistic> GetCategoryStatistics();
        bool ChangeAdminInfo(Admins admin);
        bool ChangeSponsorInformation(Sponsors sponsor);
    }
}
