using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net;

namespace WebApplication1
{
    public partial class fanRegisteration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);
            SqlConnection conn = new SqlConnection(connStr);

            String name = yessirname.Text;
            String uname = Username.Text;
            String pass = Password.Text;
            String ssn = National_ID_Number.Text;
            DateTime tdate;
            int phonenum;
            try
            {
                phonenum = Int32.Parse(Phone_Number.Text);
                tdate = DateTime.Parse(Endtime.Value);
                if(tdate > DateTime.Now)
                {
                    Response.Write("Please Enter a Valid Date Of Birth");
                    return;
                }
            }
            catch(Exception)
            {
                Response.Write("Invalid Data");
                return;
            }
            
            String userAddress = Address.Text;

            SqlCommand regProc = new SqlCommand("fanRegisteration", conn);
            regProc.CommandType = CommandType.StoredProcedure;
            regProc.Parameters.Add(new SqlParameter("@username", uname));
            regProc.Parameters.Add(new SqlParameter("@password", pass));
            regProc.Parameters.Add(new SqlParameter("@name", name));
            regProc.Parameters.Add(new SqlParameter("@national_id_number", ssn));
            regProc.Parameters.Add(new SqlParameter("@phone_number", phonenum));
            regProc.Parameters.Add(new SqlParameter("@birthdate", tdate));
            regProc.Parameters.Add(new SqlParameter("@address", userAddress));

            SqlParameter success = regProc.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            try { regProc.ExecuteNonQuery(); }
            catch (Exception) { Response.Write("Invalid Data");return; }
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Response.Write("Registration successful, you'll be redirected to the login page shortly.");
                Response.AddHeader("REFRESH", "5;URL=Login.aspx");
            }
            else
            {
                Response.Write("Invalid credintials, please try again.");
            }
        }
    }
}