using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Data;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AutomobilsController : ControllerBase
    {
        private readonly ApplicationDBContext _context;

        public AutomobilsController(ApplicationDBContext context)
        {
            _context = context;
        }

        // GET: api/Automobils
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Automobil>>> GetAutomobili()
        {
            return await _context.Automobili.ToListAsync();
        }

        // GET: api/Automobils/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Automobil>> GetAutomobil(int id)
        {
            var automobil = await _context.Automobili.FindAsync(id);

            if (automobil == null)
            {
                return NotFound();
            }

            return automobil;
        }

        // PUT: api/Automobils/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAutomobil(int id, Automobil automobil)
        {
            if (id != automobil.Id)
            {
                return BadRequest();
            }

            _context.Entry(automobil).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AutomobilExists(id))
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

        // POST: api/Automobils
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPost]
        public async Task<ActionResult<Automobil>> PostAutomobil(Automobil automobil)
        {
            _context.Automobili.Add(automobil);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetAutomobil", new { id = automobil.Id }, automobil);
        }

        // DELETE: api/Automobils/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Automobil>> DeleteAutomobil(int id)
        {
            var automobil = await _context.Automobili.FindAsync(id);
            if (automobil == null)
            {
                return NotFound();
            }

            _context.Automobili.Remove(automobil);
            await _context.SaveChangesAsync();

            return automobil;
        }

        private bool AutomobilExists(int id)
        {
            return _context.Automobili.Any(e => e.Id == id);
        }
    }
}
