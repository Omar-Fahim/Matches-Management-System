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
    public partial class smRegisteration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void done(object sender, EventArgs e)
        {
             string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);
            String name = smName.Text;
            String username = smUserName.Text;
            String pass = smPass.Text;
            String stadName = sSName.Text;
            SqlCommand addSMProc = new SqlCommand("vAddSM", conn);
            addSMProc.CommandType = CommandType.StoredProcedure;
            addSMProc.Parameters.Add(new SqlParameter("@name", name));
            addSMProc.Parameters.Add(new SqlParameter("@username", username));
            addSMProc.Parameters.Add(new SqlParameter("@pass", pass));
            addSMProc.Parameters.Add(new SqlParameter("@stad_name", stadName));

            SqlParameter error = addSMProc.Parameters.Add("@error", SqlDbType.Int);
            error.Direction = ParameterDirection.Output;
            

            conn.Open();
            addSMProc.ExecuteNonQuery();
            conn.Close();
            
              if (error.Value.ToString() == "1")
            {
                Response.Write("ERROR ! Please enter a Valid Data");
            }
            else
            {
                
                    Response.Write("Registered successfully");
            
            }
        }
    }
}