using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication1
{
    public partial class Sports_Association_Manager_Registeration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RegisterSAM(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            string namee = Name.Text;
            string usernamee = Username.Text;
            string passwordd = Password.Text;

            SqlCommand loginProc = new SqlCommand("addAssociationManager1", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@name", namee));
            loginProc.Parameters.Add(new SqlParameter("@username", usernamee));
            loginProc.Parameters.Add(new SqlParameter("@pass", passwordd));



            SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "0")
            {
                Response.Write("Enter valid data");
            }
            else
            {
                Response.Redirect("Sports_Association_Manager.aspx");
            }
        }
    }
}