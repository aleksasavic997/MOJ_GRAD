using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using static System.Net.Mime.MediaTypeNames;

namespace mojGradApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ImageUploadController : ControllerBase
    {
        public static IWebHostEnvironment _environment;

        public ImageUploadController(IWebHostEnvironment environment)
        {
            _environment = environment;
        }

        public class FileUploadAPI
        {
            public IFormFile files { get; set; }
        }

        [HttpPost]
        public async Task<string> Post([FromForm]FileUploadAPI objFile)
        {
            string path = "Upload/PostImages/";
            try
            {
                if (objFile.files.Length > 0)
                {
                    /*if (!Directory.Exists(_environment.WebRootPath + "\\Upload\\PostImages\\"))
                    {
                        Directory.CreateDirectory(_environment.WebRootPath + "\\Upload\\PostImages\\");
                    } */
                    //using (FileStream fileStream = System.IO.File.Create(_environment.WebRootPath + "\\Upload\\PostImages\\" + objFile.files.FileName))
                    using (FileStream fileStream = System.IO.File.Create($"{_environment.ContentRootPath}/wwwroot/" + "Upload/PostImages/" + objFile.files.FileName))
                    {
                        objFile.files.CopyTo(fileStream);
                        fileStream.Flush();
                        return path + objFile.files.FileName;
                    }
                }
                else
                {
                    return "Failed";
                }
            }
            catch (Exception ex)
            {

                return ex.Message.ToString();
            }

        }

        [Route("ProfilePhoto")]
        [HttpPost]
        public async Task<string> ProfilePhoto([FromForm]FileUploadAPI objFile)
        {
            string path = "Upload/UserProfileImage/";
            try
            {
                if (objFile.files.Length > 0)
                {
                    /*if (!Directory.Exists(_environment.WebRootPath + "\\Upload\\UserProfileImage\\"))
                    {
                        Directory.CreateDirectory(_environment.WebRootPath + "\\Upload\\UserProfileImage\\");
                    }
                    using (FileStream fileStream = System.IO.File.Create(_environment.WebRootPath + "\\Upload\\UserProfileImage\\" + objFile.files.FileName))*/
                    using (FileStream fileStream = System.IO.File.Create($"{_environment.ContentRootPath}/wwwroot/" + path + objFile.files.FileName))
                    {
                        objFile.files.CopyTo(fileStream);
                        fileStream.Flush();
                        return path + objFile.files.FileName;
                    }
                }
                else
                {
                    return "Failed";
                }
            }
            catch (Exception ex)
            {

                return ex.Message.ToString();
            }

        }

        [Route("PostWeb")]
        [HttpPost]
        public async Task<string> PostWeb(WebImage webImage)
        {
            if (webImage.Image != null || webImage.Image != "")
            {
                byte[] bytes = Convert.FromBase64String(webImage.Image);
                var path = "Upload//WebPostImages//" + Guid.NewGuid() + ".jpg";
                var filePath = Path.Combine($"{_environment.ContentRootPath}/wwwroot/" + path);
                System.IO.File.WriteAllBytes(filePath, bytes);
                return path;
            }
            return "";
        }

        [Route("InstitutionWeb")]
        [HttpPost]
        public async Task<string> InstitutionWeb(WebImage webImage)
        {
            if (webImage.Image != null || webImage.Image != "")
            {
                byte[] bytes = Convert.FromBase64String(webImage.Image);
                var path = "Upload//UserProfileImage//" + Guid.NewGuid() + ".jpg";
                var filePath = Path.Combine($"{_environment.ContentRootPath}/wwwroot/" + path);
                System.IO.File.WriteAllBytes(filePath, bytes);
                return path;
            }
            return "";
        }

    }

    public class WebImage
    {
        public string Image { get; set; }
    }
}