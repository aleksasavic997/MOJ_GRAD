using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using mojGradApp.Models;
using mojGradApp.UI.Interfaces;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RanksController : ControllerBase
    {
        private readonly IRanksUI _IRanksUI;

        public RanksController(IRanksUI IRanksUI)
        {
            _IRanksUI = IRanksUI;
        }

        [Authorize]
        [HttpGet]
        public IEnumerable<Ranks> GetRanks()
        {
            return _IRanksUI.GetRanks();
        }


        // GET: api/Cities/5
        [Authorize]
        [HttpGet("{id}")]
        public ActionResult<Ranks> GetRank(int id)
        {
            var rank = _IRanksUI.GetRank(id);

            if (rank == null)
            {
                return NotFound();
            }

            return rank;
        }

    }
}