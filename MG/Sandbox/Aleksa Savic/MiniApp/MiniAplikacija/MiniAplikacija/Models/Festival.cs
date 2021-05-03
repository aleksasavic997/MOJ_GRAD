using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniAplikacija.Models
{
    public class Festival
    {
        [Key]
        public int idFest { get; set; }
        public string nazivFestivala { get; set; }
    }
}
