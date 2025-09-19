using System.Linq;
using System.Net;
using System.Web.Http;
using Learnmathservice.Models;
using Learnmathservice.Models.Learnmathservice.Models;
using Learnmathservice.Request;

namespace Learnmathservice.Controllers
{
    [RoutePrefix("api/user")]
    public class UserController : ApiController
    {
        private readonly MyDbContext db = new MyDbContext();

        // POST: api/user/register
        [HttpPost]
        [Route("register")]
        public IHttpActionResult Register(tbl_Student model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            // Check if mobile already exists
            var exists = db.tbl_Students.Any(u => u.Email == model.Email);
            if (exists)
                return Content(HttpStatusCode.Conflict, "Email already registered.");
            model.flag = true;
            model.Status = 1;

            db.tbl_Students.Add(model);
            db.SaveChanges();

            return Ok("Registration successful.");
        }

        // POST: api/user/login
        [HttpPost]
        [Route("login")]
        public IHttpActionResult Login([FromBody] LoginRequest login)
        {
            if (login == null || string.IsNullOrWhiteSpace(login.Email) || string.IsNullOrWhiteSpace(login.Password) || string.IsNullOrWhiteSpace(login.DeviceId))
                return BadRequest("Email, Password, and DeviceId are required.");

            var user = db.tbl_Students.FirstOrDefault(u => u.Email == login.Email && u.Password == login.Password);
            if (user == null)
                return Unauthorized();
            //if(user.Phone == "8137008909")
            //    return Ok(new { Mobile = user.Phone });

            if (user.deviceid != login.DeviceId)
                return Content(HttpStatusCode.Forbidden, "Device ID mismatch.");

            return Ok(new { Mobile = user.Phone });
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
