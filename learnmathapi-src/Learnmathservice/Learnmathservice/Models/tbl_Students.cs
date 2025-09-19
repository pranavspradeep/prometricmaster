using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Learnmathservice.Models
{
    [Table("tbl_Student", Schema = "dbo")]
    public class tbl_Student
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime? DOB { get; set; }
        public string Gender { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public string Photo { get; set; }
        public DateTime? Admission { get; set; }
        public int Status { get; set; }
        public int? Branch_id { get; set; }
        public string Branchadmin { get; set; }
        public string Parent { get; set; }
        public string School { get; set; }
        public DateTime? Date { get; set; }
        public string Reason { get; set; }
        public string Code { get; set; }
        public string Whatsaap { get; set; }
        public string Sslcyr { get; set; }
        public string Sslcsub { get; set; }
        public string Sslcboa { get; set; }
        public string Hseyr { get; set; }
        public string Hsesub { get; set; }
        public string Hseboa { get; set; }
        public string Tecyr { get; set; }
        public string Tecsub { get; set; }
        public string Tecboa { get; set; }
        public string Degyr { get; set; }
        public string Degsub { get; set; }
        public string Degboa { get; set; }
        public string Parentmob { get; set; }
        public int? Counselorid1 { get; set; }
        public int? Counselorid2 { get; set; }
        public string Password { get; set; }
        public int? Depid { get; set; }
        public int? Courseid { get; set; }
        public string Place { get; set; }
        public string State { get; set; }
        public string Sslcimg { get; set; }
        public string Hseimg { get; set; }
        public string Graduationimg { get; set; }
        public string Aadhaarimg { get; set; }
        public string Sslcsc { get; set; }
        public string Hsesc { get; set; }
        public string Degsc { get; set; }
        public string Tecsc { get; set; }
        public string Tecreg { get; set; }
        public string Sslcreg { get; set; }
        public string Hsereg { get; set; }
        public string Degreg { get; set; }
        public string Father { get; set; }
        public string Mother { get; set; }
        public string sex { get; set; }
        public string source { get; set; }
        public string Mode { get; set; }
        public int? Bid { get; set; }
        public bool flag { get; set; }

        public string deviceid { get; set; }
    }
}