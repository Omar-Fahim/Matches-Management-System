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
    public partial class addStadium : System.Web.UI.Page
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
            String name = stadName.Text;
            String loc = stadLoc.Text;
            String cap = stadCap.Text;
             SqlCommand addStadProc = new SqlCommand("vAddStad", conn);
             addStadProc.CommandType = CommandType.StoredProcedure;
             addStadProc.Parameters.Add(new SqlParameter("@cn", name));
            addStadProc.Parameters.Add(new SqlParameter("@cl", loc));
            addStadProc.Parameters.Add(new SqlParameter("@cap", cap));

            SqlParameter empty = addStadProc.Parameters.Add("@empty", SqlDbType.Int);
             SqlParameter exists = addStadProc.Parameters.Add("@exists", SqlDbType.Int);
             empty.Direction = ParameterDirection.Output;
             exists.Direction = ParameterDirection.Output;


             conn.Open();
            try
            {
               addStadProc.ExecuteNonQuery();
            }
            catch (Exception) {
                Response.Write("Invalid Data !");
                return;
            }
            conn.Close();

               if (empty.Value.ToString() == "1")
             {
                 Response.Write("Stadium Name , Location and Capacity can't be empty");
             }
             else
             {
                 if (exists.Value.ToString() == "1")
                 {
                     Response.Write("Stadium already exists");
                 }
                 else
                 {
                     Response.Write("Stadium added successfully");
                 }
             }
        }

        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("System_Admin.aspx");
        }
    }
}