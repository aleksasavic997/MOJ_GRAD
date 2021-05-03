using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniAplikacija.Models
{
    public class Posetioc
    {
        [Key]
        public int idPosetioca { get; set; }
        public string ime { get; set; }
        public string prezime { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
    }
}
