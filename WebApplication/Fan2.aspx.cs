using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Fan2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

           
            SqlCommand avMatchProc = new SqlCommand("availableMatchesDate", conn);
            avMatchProc.CommandType = CommandType.StoredProcedure;
            avMatchProc.Parameters.Add(new SqlParameter("@matchdate", Session["dates"]));
            conn.Open();
            SqlDataReader rdr = avMatchProc.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {

                String hclubname = rdr.GetString(rdr.GetOrdinal("host_club"));
                String gclubname = rdr.GetString(rdr.GetOrdinal("guest_club"));
                String stadname = rdr.GetString(rdr.GetOrdinal("Stadium_Name"));
                DateTime mdate = rdr.GetDateTime(rdr.GetOrdinal("Start_time"));
                String stadloc = rdr.GetString(rdr.GetOrdinal("Stadium_Location"));
                int mid = rdr.GetInt32(rdr.GetOrdinal("match_id"));
              
                Label hcn = new Label();
                hcn.Text = "Host club name: " + hclubname;
                //hcn.Style.Add("margin", "20px");
                //hcn.Style[HtmlTextWriterStyle.Position] = "Absolute";
                //hcn.Style[HtmlTextWriterStyle.Top] = "20";
                form1.Controls.Add(hcn);

                Label gcn = new Label();
                gcn.Text = "Guest club name: " + gclubname;
                gcn.Style.Add("margin", "20px");
                //gcn.Style[HtmlTextWriterStyle.Position] = "Absolute";
                //gcn.Style[HtmlTextWriterStyle.Top] = "80";
                form1.Controls.Add(gcn);

                Label sn = new Label();
                sn.Text = "Stadium name: " + stadname;
                sn.Style.Add("margin", "20px");
                //sn.Style[HtmlTextWriterStyle.Position] = "Absolute";
                //sn.Style[HtmlTextWriterStyle.Top] = "140";
                form1.Controls.Add(sn);

                Label sl = new Label();
                sl.Text = "Stadium location: " + stadloc;
                sl.Style.Add("margin", "20px");
                form1.Controls.Add(sl);

                Label md = new Label();
                md.Text = "Match date: " + mdate.ToString();
                md.Style.Add("margin", "20px");
                //md.Style[HtmlTextWriterStyle.Position] = "Absolute";
                //md.Style[HtmlTextWriterStyle.Top] = "200";
                form1.Controls.Add(md);

                Button b = new Button();
                b.Click += new EventHandler(this.button_click);
                b.ID = mid.ToString();
                b.Text = "Purchase ticket";
                b.Style.Add("margin", "20px");
                //b.Style[HtmlTextWriterStyle.Position] = "Absolute";
                //b.Style[HtmlTextWriterStyle.Top] = "320";
                form1.Controls.Add(b);

                Label lineskip = new Label();
                lineskip.Text = "<br />";
                form1.Controls.Add(lineskip);

            }
         
        }

        void button_click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            Button btn = sender as Button;
            SqlCommand buyTickFan = new SqlCommand("buyTickFan", conn);
            buyTickFan.CommandType = CommandType.StoredProcedure;
            buyTickFan.Parameters.Add(new SqlParameter("@uname", Session["user"]));
            buyTickFan.Parameters.Add(new SqlParameter("@mid", btn.ID));

            conn.Open();
            buyTickFan.ExecuteNonQuery();
            conn.Close();

            Response.Write("You have purchased this ticket.");
        }
    }
}