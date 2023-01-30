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
    public partial class deleteClub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void delete(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);
            String name = cnTwo.Text;
            SqlCommand deleteClubProc = new SqlCommand("vClubDelete", conn);
            deleteClubProc.CommandType = CommandType.StoredProcedure;
            deleteClubProc.Parameters.Add(new SqlParameter("@cn", name));

            SqlParameter empty = deleteClubProc.Parameters.Add("@empty", SqlDbType.Int);
            SqlParameter exists = deleteClubProc.Parameters.Add("@exists", SqlDbType.Int);
            empty.Direction = ParameterDirection.Output;
            exists.Direction = ParameterDirection.Output;
            

            conn.Open();
            deleteClubProc.ExecuteNonQuery();
            conn.Close();
            
              if (empty.Value.ToString() == "1")
            {
                Response.Write("Club name can't be empty");
            }
            else
            {
                if (exists.Value.ToString() == "0")
                {
                    Response.Write("Club does not exists");
                }
                else
                {
                    Response.Write("Club deleted successfully");
                }
            }
             
             
             
             
        }

        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("System_Admin.aspx");
        }
    }
}