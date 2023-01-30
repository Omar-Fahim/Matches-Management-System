using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class availableStadiums : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

      

        protected void Button1_Click(object sender, EventArgs e)
        {
            DateTime DT;
            try { DT = DateTime.Parse(Endtime.Value); }
            catch (Exception) { Response.Write("Please choose a valid date");return; }
            
          
            String Date = Convert.ToString(DT);
            Session["Date"] = Date;


            Response.Redirect("ShowStadRequest.aspx");

        }







       
    }
}