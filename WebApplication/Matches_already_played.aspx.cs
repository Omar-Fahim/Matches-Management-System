using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Matches_already_played : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            {
                string mainconn = ConfigurationManager.ConnectionStrings["MS2"].ConnectionString;
                SqlConnection sqlconn = new SqlConnection(mainconn);

                //string sqlQuery = "select * from [dbo].[match] where Start_time > CURRENT_TIMESTAMP";
                string sqlQuery = "select c1.name as 'Host Club' , c2.name as 'Guest Club ' , Start_time as 'Start time' ,End_time as 'End time' from [dbo].[match] m inner join [dbo].[club] c1 on m.ID_C1 = c1.ID inner join [dbo].[club] c2 on m.ID_C2 = c2.ID\r\nwhere End_time < CURRENT_TIMESTAMP";

                SqlCommand sqlcomm = new SqlCommand(sqlQuery, sqlconn);

                sqlconn.Open();
                SqlDataAdapter sda = new SqlDataAdapter(sqlcomm);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                StringBuilder sb = new StringBuilder();
                sb.Append("<center>");
                sb.Append("<h1>Matches already played</h1>");
                sb.Append("<table border=1>");
                sb.Append("<tr>");
                foreach (DataColumn dc in dt.Columns)
                {
                    sb.Append("<th>");
                    sb.Append(dc.ColumnName.ToUpper());
                    sb.Append("</th>");

                }

                sb.Append("</tr>");

                foreach (DataRow dr in dt.Rows)
                {
                    sb.Append("<tr>");
                    foreach (DataColumn dc in dt.Columns)
                    {
                        sb.Append("<th>");
                        sb.Append(dr[dc.ColumnName].ToString());
                        sb.Append("</th>");

                    }
                    sb.Append("</tr>");

                }
                sb.Append("</table>");
                sb.Append("</center>");
                Panel1.Controls.Add(new Label { Text = sb.ToString() });

                sqlconn.Close();
            }
        }
    }
}