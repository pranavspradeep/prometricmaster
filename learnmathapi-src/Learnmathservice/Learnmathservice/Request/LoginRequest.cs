using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Learnmathservice.Request
{
    public class LoginRequest
    {
        public string Mobile { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public string DeviceId { get; set; }
    }
}