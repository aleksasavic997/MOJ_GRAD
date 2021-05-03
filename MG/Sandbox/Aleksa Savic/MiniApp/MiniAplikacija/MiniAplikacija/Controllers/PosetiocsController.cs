using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MiniAplikacija.Data;
using MiniAplikacija.Models;

namespace MiniAplikacija.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PosetiocsController : ControllerBase
    {
        private readonly ApplicationDBContext _context;

        public PosetiocsController(ApplicationDBContext context)
        {
            _context = context;
        }

        // GET: api/Posetiocs
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Posetioc>>> Getposetioci()
        {
            return await _context.posetioci.ToListAsync();
        }

        // GET: api/Posetiocs/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Posetioc>> GetPosetioc(int id)
        {
            var posetioc = await _context.posetioci.FindAsync(id);

            if (posetioc == null)
            {
                return NotFound();
            }

            return posetioc;
        }

        // PUT: api/Posetiocs/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPosetioc(int id, Posetioc posetioc)
        {
            if (id != posetioc.idPosetioca)
            {
                return BadRequest();
            }

            _context.Entry(posetioc).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PosetiocExists(id))
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

        // POST: api/Posetiocs
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPost]
        public async Task<ActionResult<Posetioc>> PostPosetioc(Posetioc posetioc)
        {
            _context.posetioci.Add(posetioc);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPosetioc", new { id = posetioc.idPosetioca }, posetioc);
        }

        // DELETE: api/Posetiocs/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Posetioc>> DeletePosetioc(int id)
        {
            var posetioc = await _context.posetioci.FindAsync(id);
            if (posetioc == null)
            {
                return NotFound();
            }

            _context.posetioci.Remove(posetioc);
            await _context.SaveChangesAsync();

            return posetioc;
        }

        private bool PosetiocExists(int id)
        {
            return _context.posetioci.Any(e => e.idPosetioca == id);
        }

        [Route("login")]
        [HttpPost]
        public async Task<ActionResult<bool>> ProveriPosetioca(Login login)
        {
            var posetioci = await _context.posetioci.ToListAsync();
            var posetioc = posetioci.Where(p => p.Username.Equals(login.Username) && p.Password.Equals(login.Password)).FirstOrDefault();

            if (posetioc == null)
                return false;
            else
                return true;
        }
    }
    public class Login
    {
        public String Username { get; set; }
        public String Password { get; set; }
    }
}
