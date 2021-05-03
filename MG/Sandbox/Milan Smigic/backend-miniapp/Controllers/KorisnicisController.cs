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
    public class KorisnicisController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public KorisnicisController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/Korisnicis
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Korisnici>>> GetKorisnik()
        {
            return await _context.Korisnik.ToListAsync();
        }

        // GET: api/Korisnicis/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Korisnici>> GetKorisnici(int id)
        {
            var korisnici = await _context.Korisnik.FindAsync(id);

            if (korisnici == null)
            {
                return NotFound();
            }

            return korisnici;
        }

        // PUT: api/Korisnicis/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutKorisnici(int id, Korisnici korisnici)
        {
            if (id != korisnici.id)
            {
                return BadRequest();
            }

            _context.Entry(korisnici).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!KorisniciExists(id))
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

        // POST: api/Korisnicis
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPost]
        public async Task<ActionResult<Korisnici>> PostKorisnici(Korisnici korisnici)
        {
            _context.Korisnik.Add(korisnici);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetKorisnici", new { id = korisnici.id }, korisnici);
        }

        // DELETE: api/Korisnicis/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Korisnici>> DeleteKorisnici(int id)
        {
            var korisnici = await _context.Korisnik.FindAsync(id);
            if (korisnici == null)
            {
                return NotFound();
            }

            _context.Korisnik.Remove(korisnici);
            await _context.SaveChangesAsync();

            return korisnici;
        }

        private bool KorisniciExists(int id)
        {
            return _context.Korisnik.Any(e => e.id == id);
        }

        [Route("login")]
        [HttpPost]
        public async Task<ActionResult<bool>> KorisnikCheck(Prijava prijava)
        {
            var korisnici = await _context.Korisnik.ToListAsync();
            var kor = korisnici.Where(x => x.username.Equals(prijava.username) && x.password.Equals(prijava.password)).FirstOrDefault();

            if (kor == null)
                return false;
            return true;
        }
    }

    public class Prijava
    {
        public String username { get; set; }
        public String password { get; set; }
    }
}
