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
    public partial class Add_Match : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddMatchmethod(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            string hostClubNamee = HostClubName.Text;
            string guestClubName = GuestClubName.Text;
            string startTimee = StartTime.Text;
            string endTimee = EndTime.Text;
            string startTimee1 = "";
            string endTimee1 = "";

            if (startTimee == "" || endTimee == "")
            {
                Response.Write("Enter valid data");
            }
            else
            {


                for (int i = 0; i < startTimee.Length; i++)
                {
                    if (startTimee[i] != 'T')
                        startTimee1 = startTimee1 + startTimee[i];
                    else
                        startTimee1 = startTimee1 + ' ';


                }
                startTimee1 = startTimee1 + ":00";

                for (int i = 0; i < endTimee.Length; i++)
                {
                    if (endTimee[i] != 'T')
                        endTimee1 = endTimee1 + endTimee[i];
                    else
                        endTimee1 = endTimee1 + ' ';


                }
                endTimee1 = endTimee1 + ":00";

                SqlCommand loginProc = new SqlCommand("addNewMatch1", conn);
                loginProc.CommandType = CommandType.StoredProcedure;
                loginProc.Parameters.Add(new SqlParameter("@c1n", hostClubNamee));
                loginProc.Parameters.Add(new SqlParameter("@c2n", guestClubName));
                loginProc.Parameters.Add(new SqlParameter("@date", startTimee1));
                loginProc.Parameters.Add(new SqlParameter("@enddate", endTimee1));


                SqlParameter success = loginProc.Parameters.Add("@success", SqlDbType.Int);

                success.Direction = ParameterDirection.Output;

                conn.Open();
                try
                {
                    loginProc.ExecuteNonQuery();
                }
                catch (Exception)
                {
                    Response.Write("Invalid Data");
                    return;
                }
                conn.Close();

                if (success.Value.ToString() == "0")
                {
                    Response.Write("Enter valid data");
                }
                else
                {
                    Response.Redirect("Sports_Association_Manager.aspx");
                    Response.Write("Match added");

                }
            }
        }
    }
}