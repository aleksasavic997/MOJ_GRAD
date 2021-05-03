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
    public class TypesController : ControllerBase
    {
        private readonly ITypesUI _ITypesUI;

        public TypesController(ITypesUI ITypesUI)
        {
            _ITypesUI = ITypesUI;
        }

        // GET: api/Types
        [Authorize]
        [HttpGet]
        public IEnumerable<Types> GetTypes()
        {
            return _ITypesUI.GetTypes();
        }

        // GET: api/Types/5
        [Authorize]
        [HttpGet("{id}")]
        public ActionResult<Types> GetType(int id)
        {
            var type = _ITypesUI.GetType(id);

            if (type == null)
            {
                return NotFound();
            }

            return type;
        }


        // POST: api/Types
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [Authorize]
        [HttpPost]
        public ActionResult<Types> PostType(Types type)
        {
            Types t = _ITypesUI.PostType(type);

            return CreatedAtAction("GetTypes", new { id = t.Id }, t);
        }


    }
}
