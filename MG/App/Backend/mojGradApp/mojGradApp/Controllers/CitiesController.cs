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
    public class CitiesController : ControllerBase
    {
        private readonly ICitiesUI _ICitiesUI;

        public CitiesController(ICitiesUI ICitiesUI)
        {
            _ICitiesUI = ICitiesUI;
        }

        // GET: api/Cities
        // [Authorize]
        [HttpGet]
        public IEnumerable<Cities> GetCities()
        {
            return _ICitiesUI.GetCities();
        }


        // GET: api/Cities/5
        [Authorize]
        [HttpGet("{id}")]
        public ActionResult<Cities> GetCity(int id)
        {
            var cities = _ICitiesUI.GetCity(id);

            if (cities == null)
            {
                return NotFound();
            }

            return cities;
        }


        // POST: api/Cities
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public ActionResult<Cities> PostCity(Cities city)
        {
            Cities c = _ICitiesUI.PostCity(city);

            return CreatedAtAction("GetCities", new { id = c.Id }, c);
        }

    }
}
