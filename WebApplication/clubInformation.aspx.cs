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
    public partial class clubInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand ShowClub = new SqlCommand("getClub", conn);
            ShowClub.CommandType = CommandType.StoredProcedure;
            String user = Session["user"].ToString();
            ShowClub.Parameters.Add(new SqlParameter("@User", user));
            SqlParameter Exist = ShowClub.Parameters.Add("@Exist", SqlDbType.Int);
       

            Exist.Direction = ParameterDirection.Output;


            conn.Open();
            ShowClub.ExecuteNonQuery();
            conn.Close();
            
            

            if (Exist.Value.ToString() == "1")
            {
                conn.Open();
                int i = 0;
            
                SqlDataReader rdr = (ShowClub).ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    String ID = rdr.GetInt32(rdr.GetOrdinal("ID")) +"";
                    String name = rdr.GetString(rdr.GetOrdinal("name"));
                    String location = rdr.GetString(rdr.GetOrdinal("location"));
                    String ID_CR = rdr.GetInt32(rdr.GetOrdinal("ID_CR"))+"";
                  

               
                    Label IDL = new Label();
                    Label nameL = new Label();
                    Label locationL = new Label();
                    Label ID_CRL = new Label();

                    IDL.Text = "ID: " + ID;
                    nameL.Text = "Name: "+name;
                    locationL.Text = "Location: "+location;
                    ID_CRL.Text = "Club_Representative_ID: "+ID_CR;
                   

                    IDL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    IDL.Style[HtmlTextWriterStyle.Top] = i + "px";
                    i += 40;
                    nameL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    nameL.Style[HtmlTextWriterStyle.Top] = i + "px";


                    i += 40;


                  
                    locationL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    locationL.Style[HtmlTextWriterStyle.Top] = i + "px";



                    i += 40;


                    ID_CRL.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    ID_CRL .Style[HtmlTextWriterStyle.Top] = i + "px";

                    i += 40;




                
                    form1.Controls.Add(IDL);

                
                    form1.Controls.Add(nameL);

                   
                    form1.Controls.Add(locationL);

                
                    form1.Controls.Add(ID_CRL);
                   

                }
            }
            else
            {


                Response.Write("Sorry ! , You are not assigned to a club");

            }



            }
        }
    }
