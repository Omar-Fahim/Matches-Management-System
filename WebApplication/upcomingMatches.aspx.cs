using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace WebApplication1
{
    public partial class upcomingMatches : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand ShowMatch = new SqlCommand("ViewMatches", conn);
            ShowMatch.CommandType = CommandType.StoredProcedure;
            String user = Session["user"].ToString();
            ShowMatch.Parameters.Add(new SqlParameter("@User", user));
            SqlParameter Exist = ShowMatch.Parameters.Add("@ExistR", SqlDbType.Int);


            Exist.Direction = ParameterDirection.Output;


            conn.Open();
            ShowMatch.ExecuteNonQuery();
            conn.Close();



            if (Exist.Value.ToString() == "1")
            {
                int i = 0;
                conn.Open();
                SqlDataReader rdr = (ShowMatch).ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    String hostClub = rdr.GetString(rdr.GetOrdinal("Host Club name")) ;
                    String guestClub = rdr.GetString(rdr.GetOrdinal("Competing Club name"));
                    DateTime start_Time = rdr.GetDateTime(rdr.GetOrdinal("Start_time"));
                    DateTime end_Time = rdr.GetDateTime(rdr.GetOrdinal("End_time")) ;
                    Object stadiumName = rdr.GetSqlValue(rdr.GetOrdinal("Stadium Name"));
                  

                    Label hostClubL = new Label();
                    Label guestClubL = new Label();
                    Label start_TimeL = new Label();
                    Label end_TimeL = new Label();
                   Label stadiumNameL = new Label();

                    hostClubL.Text = "Host Club Name: "+hostClub;
                    guestClubL.Text = "Guest Club Name: "+guestClub;
                    start_TimeL.Text = "Start Time: "+start_Time ;
                    end_TimeL.Text = "End Time: "+end_Time;

                    stadiumNameL.Text = "Stadium Name: "+stadiumName.ToString();
                    if (stadiumName.ToString() == "Null")
                    {
                        stadiumNameL.Text = "Stadium Name: Not Available";

                    }

                    stadiumNameL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    stadiumNameL.Style[HtmlTextWriterStyle.Top] = i + "px";
                    i += 40;

                    hostClubL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    hostClubL.Style[HtmlTextWriterStyle.Top] = i + "px";
                    i += 40;
                    guestClubL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    guestClubL.Style[HtmlTextWriterStyle.Top] = i + "px";
                    i += 40;

                    start_TimeL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    start_TimeL.Style[HtmlTextWriterStyle.Top] = i + "px";
                    i += 40;

                    end_TimeL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    end_TimeL.Style[HtmlTextWriterStyle.Top] = i + "px";
                    i += 80;

                    form1.Controls.Add(hostClubL);

                    form1.Controls.Add(guestClubL);

                    form1.Controls.Add(start_TimeL);

                    form1.Controls.Add(end_TimeL);
                    
                    
                     form1.Controls.Add(stadiumNameL);
             
                    
                }
            }
            else
            {


                Response.Write("Sorry ! , You are not assigned to a club");

            }
        }
    }
}