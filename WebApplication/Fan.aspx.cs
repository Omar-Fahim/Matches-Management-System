using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Security.Cryptography;

namespace WebApplication1
{
    public partial class Fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DateTime test;
            try {  test = DateTime.Parse(Endtime.Value); }
            catch (Exception) { Response.Write("Please Choose a Date");return; }
            Session["dates"] = test;
          
            Response.Redirect("Fan2.aspx");
        }

        
    }
}