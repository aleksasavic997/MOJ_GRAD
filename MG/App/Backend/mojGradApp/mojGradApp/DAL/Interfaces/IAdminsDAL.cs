using mojGradApp.Controllers;
using mojGradApp.Models;
using mojGradApp.Models.InfoModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace mojGradApp.DAL.Interfaces
{
    public interface IAdminsDAL
    {
        IEnumerable<Admins> GetAdmins();
        bool PostAdmin(Admins admin);
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
