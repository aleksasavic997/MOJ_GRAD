using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MyApp123.Data;
using MyApp123.Models;

namespace MyApp123.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SerijesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public SerijesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/Serijes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Serije>>> GetSerija()
        {
            return await _context.Serija.ToListAsync();
        }

        // GET: api/Serijes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Serije>> GetSerije(int id)
        {
            var serije = await _context.Serija.FindAsync(id);

            if (serije == null)
            {
                return NotFound();
            }

            return serije;
        }

        // PUT: api/Serijes/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSerije(int id, Serije serije)
        {
            if (id != serije.id)
            {
                return BadRequest();
            }

            _context.Entry(serije).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SerijeExists(id))
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

        // POST: api/Serijes
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPost]
        public async Task<ActionResult<Serije>> PostSerije(Serije serije)
        {
            _context.Serija.Add(serije);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSerije", new { id = serije.id }, serije);
        }

        // DELETE: api/Serijes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Serije>> DeleteSerije(int id)
        {
            var serije = await _context.Serija.FindAsync(id);
            if (serije == null)
            {
                return NotFound();
            }

            _context.Serija.Remove(serije);
            await _context.SaveChangesAsync();

            return serije;
        }

        private bool SerijeExists(int id)
        {
            return _context.Serija.Any(e => e.id == id);
        }
    }
}
