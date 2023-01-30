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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
           // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);
            String name = username.Text;
            String pass = password.Text;
            SqlCommand loginProc = new SqlCommand("userLogin", conn);
            loginProc.CommandType = CommandType.StoredProcedure;
            loginProc.Parameters.Add(new SqlParameter("@username",name));
            loginProc.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter success = loginProc.Parameters.Add("@success",SqlDbType.Int);
            SqlParameter type = loginProc.Parameters.Add("@type", SqlDbType.Int);
            SqlParameter user = loginProc.Parameters.Add("@user", SqlDbType.VarChar,20);
            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;
            user.Direction = ParameterDirection.Output;

            conn.Open();
            loginProc.ExecuteNonQuery();
            conn.Close();
            System.Diagnostics.Debug.WriteLine(name.ToString());
           
            if (success.Value.ToString() =="")
            {
                Response.Write("Invalid Username or Password !");
            }
            else
            {
                Session["user"] = user.Value.ToString();
                if (type.Value.ToString()=="1")//System Admin
                {
                    Response.Redirect("System_Admin.aspx");
                }
                if (type.Value.ToString() == "2")//SAM
                {
                    Response.Redirect("Sports_Association_Manager.aspx");
                }
                if (type.Value.ToString() == "3")//CR
                {
                    Response.Redirect("Club_representative.aspx");
                }
                if (type.Value.ToString() == "4")//SM
                {
                    Response.Redirect("Stadium_Manager.aspx");
                }
                if (type.Value.ToString() == "5")//FAN
                {
                    Response.Redirect("Fan.aspx");
                }
                if (type.Value.ToString() == "6")//BLOCKED FAN
                {
                    Response.Write("Sorry you are blocked");
                }
            }
        }
        protected void Register(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}