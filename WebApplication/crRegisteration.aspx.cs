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
    public partial class crRegisteration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
       

        }

        protected void crRegister(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
          
            SqlConnection conn = new SqlConnection(connStr);
            String Username = username.Text;
            String Password = password.Text;
            String Club = club.Text;
            String Name = name.Text;
            if(Username == "" || Password == ""|| Name == "")
            {
                Response.Write("There is an Empty Field");
                return;
            }
            SqlCommand registerproc = new SqlCommand("vaddRepresentative",conn);
            registerproc.CommandType = CommandType.StoredProcedure;
            registerproc.Parameters.Add(new SqlParameter("@username", Username));
            registerproc.Parameters.Add(new SqlParameter("@password", Password));
            registerproc.Parameters.Add(new SqlParameter("@clubname", Club));
            registerproc.Parameters.Add(new SqlParameter("@Name", Name));
            SqlParameter Exists_User = registerproc.Parameters.Add("@Exists_User", SqlDbType.Int);
            SqlParameter Exists_Club = registerproc.Parameters.Add("@Exists_Club ", SqlDbType.Int);
            SqlParameter Already_Has_R = registerproc.Parameters.Add("@Already_Has_R ", SqlDbType.Int);
            Exists_User.Direction = ParameterDirection.Output;
            Exists_Club.Direction = ParameterDirection.Output;
            Already_Has_R.Direction = ParameterDirection.Output;
            conn.Open();
            registerproc.ExecuteNonQuery();
            conn.Close();
            if (Exists_User.Value.ToString() == "1")
                Response.Write("Username already Exists!");
            else if (Exists_Club.Value.ToString() == "0")
                Response.Write("There is no such a club !");
            else if (Already_Has_R.Value.ToString() == "1")
                Response.Write("The Specified club already has a Representative !");
            else
                Response.Redirect("Login.aspx");
        }
    }
}