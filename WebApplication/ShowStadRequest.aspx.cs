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
    public partial class ShowStadRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand ShowStadium = new SqlCommand("viewAvailableStadiumsOnProc", conn);
            ShowStadium.CommandType = CommandType.StoredProcedure;

            DateTime date = Convert.ToDateTime(Session["Date"]);

            ShowStadium.Parameters.Add(new SqlParameter("@Date", date));
            int i = 200;

            conn.Open();
            SqlDataReader rdr = (ShowStadium).ExecuteReader(System.Data.CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                

                String name = rdr.GetString(rdr.GetOrdinal("Name"));
                String Location = rdr.GetString(rdr.GetOrdinal("Location"));
                int Capacity = rdr.GetInt32(rdr.GetOrdinal("Capacity"));

                Label nameL = new Label();
                nameL.Text = "Name: " + name + " Location: " + Location + " Capacity: " + Capacity;





                nameL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                nameL.Style[HtmlTextWriterStyle.Top] = i + "px";

                Button b = new Button();
                b.Click += new EventHandler(Send_Click);



                b.Text = "Send Request";
                i += 40;

                b.ID = name;
                b.Style[HtmlTextWriterStyle.Position] = "Absolute";
                b.Style[HtmlTextWriterStyle.Top] = i + "px";

                form1.Controls.Add(nameL);


                form1.Controls.Add(b);


                i += 60;

            }
        }

        private void Send_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand getMyClub = new SqlCommand("getCname", conn);
            getMyClub.CommandType = CommandType.StoredProcedure;

            getMyClub.Parameters.Add(new SqlParameter("@User", Session["user"].ToString()));
            SqlParameter clubname = getMyClub.Parameters.Add("Cname", SqlDbType.VarChar, 20);
            clubname.Direction = ParameterDirection.Output;
            conn.Open();
            getMyClub.ExecuteNonQuery();
            conn.Close();
            string tmp = (sender as Button).ID;




            if (clubname.Value.ToString() == "Not_Existing")
                Response.Write("Sorry ! you are not assigned to a club");
            else
            {
                SqlCommand doMExist = new SqlCommand("doMExist", conn);
                doMExist.CommandType = CommandType.StoredProcedure;
                doMExist.Parameters.Add(new SqlParameter("@Cname", clubname.Value.ToString()));
                doMExist.Parameters.Add(new SqlParameter("@Date", Convert.ToDateTime(Session["Date"])));
                SqlParameter Exist = doMExist.Parameters.Add("@Out", SqlDbType.Int);
                Exist.Direction = ParameterDirection.Output;
               
                conn.Open();
                doMExist.ExecuteNonQuery();
                conn.Close();
              

                if (Exist.Value.ToString() == "0")
                    Response.Write("Sorry ! There is no match at the specified time");
                else
                {
                    SqlCommand SendRequest = new SqlCommand("addHostRequestOmar", conn);
                    SendRequest.CommandType = CommandType.StoredProcedure;
                    SendRequest.Parameters.Add(new SqlParameter("@club_name", clubname.Value.ToString()));
                    SendRequest.Parameters.Add(new SqlParameter("@stad_name", tmp));
                    SendRequest.Parameters.Add(new SqlParameter("@date", Convert.ToDateTime(Session["Date"])));
                    SqlParameter Pend = SendRequest.Parameters.Add("@Pend", SqlDbType.Int);
                    SqlParameter SM = SendRequest.Parameters.Add("@SM", SqlDbType.Int);

                    Pend.Direction = ParameterDirection.Output;
                    SM.Direction = ParameterDirection.Output;

                    conn.Open();
                    SendRequest.ExecuteNonQuery();
                    conn.Close();
                    if(SM.Value.ToString() == "0")
                    {
                        Response.Write("The Stadium is not assigned to a Stadium Manager");
                    }
                   else if (Pend.Value.ToString() == "1")
                    {
                        Response.Write("There is a request already in place");
                    }
                    else
                    {
                        Response.Write("Request is sent successfully");

                    }

                      
                }
            }
        }
    }
}