using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Application.Data;
using Application.Models;

namespace Application.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DogadjajsController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public DogadjajsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/Dogadjajs
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Dogadjaj>>> GetBDogadjaj()
        {
            return await _context.BDogadjaj.ToListAsync();
        }

        // GET: api/Dogadjajs/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Dogadjaj>> GetDogadjaj(int id)
        {
            var dogadjaj = await _context.BDogadjaj.FindAsync(id);

            if (dogadjaj == null)
            {
                return NotFound();
            }

            return dogadjaj;
        }

        // PUT: api/Dogadjajs/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDogadjaj(int id, Dogadjaj dogadjaj)
        {
            if (id != dogadjaj.Id)
            {
                return BadRequest();
            }

            _context.Entry(dogadjaj).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DogadjajExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Dogadjajs
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPost]
        public async Task<ActionResult<Dogadjaj>> PostDogadjaj(Dogadjaj dogadjaj)
        {
            _context.BDogadjaj.Add(dogadjaj);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDogadjaj", new { id = dogadjaj.Id }, dogadjaj);
        }

        // DELETE: api/Dogadjajs/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Dogadjaj>> DeleteDogadjaj(int id)
        {
            var dogadjaj = await _context.BDogadjaj.FindAsync(id);
            if (dogadjaj == null)
            {
                return NotFound();
            }

            _context.BDogadjaj.Remove(dogadjaj);
            await _context.SaveChangesAsync();

            return dogadjaj;
        }

        private bool DogadjajExists(int id)
        {
            return _context.BDogadjaj.Any(e => e.Id == id);
        }
    }
}
