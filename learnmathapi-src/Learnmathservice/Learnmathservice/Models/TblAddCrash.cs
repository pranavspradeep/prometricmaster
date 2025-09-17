using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Learnmathservice.Models
{
    [Table("tbl_AddCrash", Schema = "dbo")]
    public class TblAddCrash
    {
        [Key]
        public int Id { get; set; }

        public string TEACHER_FIRST_NAME { get; set; }
        public string TEACHER_LASTNAME { get; set; }
        public string TEACHER_DOB { get; set; }
        public string TEACHER_SEX { get; set; }
        public string TEACHER_EMAIL { get; set; }
        public string TEACHER_CONTACT { get; set; }
        public string TEACHER_ADDRESS { get; set; }
        public string TEACHER_COUNTRY { get; set; }
        public string TEACHER_CITY { get; set; }
        public string TEACHER_STREET { get; set; }
        public string TEACHER_ZIP { get; set; }
        public string TEACHER_WHERE_HERE_ABOUT { get; set; }
        public int? Status { get; set; }
        public int? dailylogin { get; set; }
        public string Course { get; set; }
        public string Datefrom { get; set; }
        public string Dateto { get; set; }
        public string Subject { get; set; }
        public string Photo { get; set; }
        public string device_key { get; set; }
        public int? device_request_status { get; set; }
        public int? device_status { get; set; }
        public int? WebEnable { get; set; }
        public string Yearentry { get; set; }
        public string Program { get; set; }
        public string Inqrelate { get; set; }
        public string Myinq { get; set; }
        public string Fatherlastname { get; set; }
        public string Motherfirstname { get; set; }
        public string Motherlastname { get; set; }
        public string Mothercontact { get; set; }
        public int? chkemail { get; set; }
        public int? chkmob { get; set; }
        public int? chksms { get; set; }
        public int? chkpost { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string FatherFname { get; set; }
        public string Fathercontact { get; set; }
        public string Country { get; set; }
        public string Location { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string Postcode { get; set; }
        public string Passport { get; set; }
        public string Parentusername { get; set; }
        public string Parentpassword { get; set; }
        public string Nationality { get; set; }
        public string Comment { get; set; }
        public string Experience { get; set; }
        public string Courses { get; set; }
        public string Parent_name { get; set; }
        public string Parent_contact { get; set; }
        public string Religion { get; set; }
        public string Qualification { get; set; }
        public string DeviceId { get; set; }
    }

}