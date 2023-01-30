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
    public partial class deleteStadium : System.Web.UI.Page
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
            String name = stadN.Text;
            SqlCommand addStadProc = new SqlCommand("vDeleteStad", conn);
            addStadProc.CommandType = CommandType.StoredProcedure;
            addStadProc.Parameters.Add(new SqlParameter("@cn", name));

            SqlParameter empty = addStadProc.Parameters.Add("@empty", SqlDbType.Int);
            SqlParameter exists = addStadProc.Parameters.Add("@exists", SqlDbType.Int);
            empty.Direction = ParameterDirection.Output;
            exists.Direction = ParameterDirection.Output;


            conn.Open();
            try
            {
                addStadProc.ExecuteNonQuery();
            }
            catch (Exception)
            {
                Response.Write("Invalid Data !");
                return;
            }
            conn.Close();

            if (empty.Value.ToString() == "1")
            {
                Response.Write("Stadium Name can't be empty");
            }
            else
            {
                if (exists.Value.ToString() == "0")
                {
                    Response.Write("Stadium does not exists");
                }
                else
                {
                    Response.Write("Stadium deleted successfully");
                }
            }
        }

        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("System_Admin.aspx");
        }
    }
}