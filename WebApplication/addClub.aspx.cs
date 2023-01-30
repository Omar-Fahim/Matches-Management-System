using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class addClub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void add(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);
            String name = clubName.Text;
            String location = clubLocation.Text;
            SqlCommand addClubProc = new SqlCommand("vClubAdd", conn);
            addClubProc.CommandType = CommandType.StoredProcedure;
            addClubProc.Parameters.Add(new SqlParameter("@cn", name));
            addClubProc.Parameters.Add(new SqlParameter("@cl", location));

            SqlParameter empty = addClubProc.Parameters.Add("@empty", SqlDbType.Int);
            SqlParameter exists = addClubProc.Parameters.Add("@exists", SqlDbType.Int);
            empty.Direction = ParameterDirection.Output;
            exists.Direction = ParameterDirection.Output;
            

            conn.Open();
            try
            {
                addClubProc.ExecuteNonQuery();
            }
            catch (Exception) {
                Response.Write("Invalid Data !");
                return;
            }
            conn.Close();


            if (empty.Value.ToString() == "1")
            {
                Response.Write("Club name and location can't be empty");
            }
            else
            {
                if (exists.Value.ToString() == "1")
                {
                    Response.Write("Club already exists");
                }
                else
                {
                    Response.Write("Club added successfully");
                }
            }
        }

        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("System_Admin.aspx");
        }
    }
}