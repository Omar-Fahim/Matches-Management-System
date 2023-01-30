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
    public partial class blockFan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void block(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);
            String name = fnid.Text;
            SqlCommand addStadProc = new SqlCommand("vBlockFan", conn);
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
                Response.Write("Fan national id can't be empty");
            }
            else
            {
                if (exists.Value.ToString() == "0")
                {
                    Response.Write("Fan does not exists");
                }
                else
                {
                    if (exists.Value.ToString() == "5")
                    {
                        Response.Write("Fan Already blocked");
                    }
                    else
                    {
                        Response.Write("Fan blocked successfully");
                    }
                }
            }
        }

        protected void back(object sender, EventArgs e)
        {
            Response.Redirect("System_Admin.aspx");
        }
    }
}