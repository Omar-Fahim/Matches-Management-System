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
    public partial class viewRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand viewR = new SqlCommand("smR", conn);
            //SqlCommand viewR = new SqlCommand("trys", conn);
            viewR.CommandType = CommandType.StoredProcedure;
            String name = Session["user"].ToString();
            //ring name = "mnk2";
            viewR.Parameters.Add(new SqlParameter("@name", name));
            int i = 0;
            conn.Open();
            SqlDataReader rdr = viewR.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                
                String crName = rdr.GetString(rdr.GetOrdinal("Sending Club Representitive Name"));
               // DateTime crName = rdr.GetDateTime(rdr.GetOrdinal("date"));
                Label l = new Label();
                l.Text = "Sending Club Representitive Name : " + crName;
                l.Style[HtmlTextWriterStyle.Position] = "Absolute";
                l.Style[HtmlTextWriterStyle.Top] = i + "px";
                form1.Controls.Add(l);
                i += 40;

                String hcn = rdr.GetString(rdr.GetOrdinal("Host Club Name"));
                // DateTime crName = rdr.GetDateTime(rdr.GetOrdinal("date"));
                Label ll = new Label();
                ll.Text = "Host Club Name : " + hcn;
                ll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                ll.Style[HtmlTextWriterStyle.Top] = i + "px";
                form1.Controls.Add(ll);
                i += 40;

                String gcn = rdr.GetString(rdr.GetOrdinal("Guest Club Name"));
                // DateTime crName = rdr.GetDateTime(rdr.GetOrdinal("date"));
                Label lll = new Label();
                lll.Text = "Guest Club Name : " + gcn;
                lll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                lll.Style[HtmlTextWriterStyle.Top] = i + "px";
                form1.Controls.Add(lll);
                i += 40;

                DateTime start = rdr.GetDateTime(rdr.GetOrdinal("Start_time"));
                Label llll = new Label();
                llll.Text = "Start Time : " + start;
                llll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                llll.Style[HtmlTextWriterStyle.Top] = i + "px";
                form1.Controls.Add(llll);
                i += 40;

                DateTime end = rdr.GetDateTime(rdr.GetOrdinal("End_time"));
                Label lllll = new Label();
                lllll.Text = "End Time : " + end;
                lllll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                lllll.Style[HtmlTextWriterStyle.Top] = i + "px";
                form1.Controls.Add(lllll);
                i += 40;

                String status = rdr.GetString(rdr.GetOrdinal("Status"));
                Label llllll = new Label();
                llllll.Text = "Request Status : " + status;
                llllll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                llllll.Style[HtmlTextWriterStyle.Top] = i + "px";
                form1.Controls.Add(llllll);
                i += 20;
                if (status == "unhandled")
                {
                    int id = rdr.GetInt32(rdr.GetOrdinal("Identifier"));
                    Button b = new Button();
                    b.Text = "Accept Request";
                    //b.OnClientClick = "accept";
                    b.Click += new EventHandler(accept);
                    b.ID = "" + id;
                    b.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    b.Style[HtmlTextWriterStyle.Top] = i + "px";
                    form1.Controls.Add(b);

                    Button b2 = new Button();
                    b2.Text = "Reject Request";
                    // b2.OnClientClick = "reject";
                    b.Click += new EventHandler(accept);
                    b2.ID = "0" + (id);
                    b2.Style[HtmlTextWriterStyle.Position] = "Absolute";
                    b2.Style[HtmlTextWriterStyle.Top] = (i + 35) + "px";
                    b2.Click += new EventHandler(reject);
                    form1.Controls.Add(b2);
                }


                i += 80;
            }
            Button b3 = new Button();
            b3.Text = "Return Home";
            // b.OnClientClick = "accept";
            b3.Click += new EventHandler(home);
            //b2.ID = "0" + (id);
            b3.Style[HtmlTextWriterStyle.Position] = "Absolute";
            b3.Style[HtmlTextWriterStyle.Top] = (i + 35) + "px";
            form1.Controls.Add(b3);
        }

        private void home(object sender, EventArgs e)
        {
            Response.Redirect("Stadium_Manager.aspx");
        }

        protected void accept(object sender, EventArgs e)
        {

            //System.Diagnostics.Debug.WriteLine (id2);
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);
            string id = (sender as Button).ID;
            int id2 = int.Parse(id);
            SqlCommand vr = new SqlCommand("ar", conn);
            vr.CommandType = CommandType.StoredProcedure;
            vr.Parameters.Add(new SqlParameter("@id", id2));
            
            

            conn.Open();
            try { vr.ExecuteNonQuery(); }
            catch { }
            conn.Close();
            Response.Redirect("viewRequests.aspx");
        }
        protected void reject(object sender, EventArgs e)
        {

            //System.Diagnostics.Debug.WriteLine (id2);
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);
            string id = (sender as Button).ID;
            int id2 = int.Parse(id);
            SqlCommand reject = new SqlCommand("rr", conn);
            reject.CommandType = CommandType.StoredProcedure;
            reject.Parameters.Add(new SqlParameter("@id", id2));



            conn.Open();
            try { reject.ExecuteNonQuery(); }
            catch { }
            conn.Close();
            Response.Redirect("viewRequests.aspx");
        }
    }
    
}