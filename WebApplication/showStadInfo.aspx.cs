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
    public partial class showStadInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*if (Session["user"]==null)
            { Response.Redirect("Login.aspx"); }
            else 
            {
           // Page_Load code goes here if any
             }*/
            if (Session["user"]==null)
            { Response.Redirect("Login.aspx"); }
            else { 
            string connStr = WebConfigurationManager.ConnectionStrings["MS2"].ToString();
            // Console.Write(connStr);
            //System.Diagnostics.Debug.WriteLine(connStr);

            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand viewS = new SqlCommand("smC", conn);
            viewS.CommandType = CommandType.StoredProcedure;
            String name = Session["user"].ToString();
            // String name = "mnk2";
            viewS.Parameters.Add(new SqlParameter("@name", name));

            conn.Open();
            SqlDataReader rdr = viewS.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                String StadiumName = rdr.GetString(rdr.GetOrdinal("name"));
                int i = 0;
                Label l = new Label();
                l.Text = "Stadium Name : " + StadiumName;
                l.Style[HtmlTextWriterStyle.Position] = "Absolute";
                l.Style[HtmlTextWriterStyle.Top] = i + "px";



                int cap = rdr.GetInt32(rdr.GetOrdinal("Capacity"));
                Label ll = new Label();
                ll.Text = "Stadium Capacity : " + cap;
                ll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                ll.Style[HtmlTextWriterStyle.Top] = "40px";
                String loc = rdr.GetString(rdr.GetOrdinal("location"));
                Label lll = new Label();
                lll.Text = "Stadium Location : " + loc;

                Boolean stat = (bool)rdr.GetSqlBoolean(rdr.GetOrdinal("status"));
                Label llll = new Label();
                llll.Text = "Stadium Status : " + stat;

                int smid = rdr.GetInt32(rdr.GetOrdinal("ID_SM"));
                Label lllll = new Label();
                lllll.Text = "Stadium Manager ID : " + smid;
                lll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                lll.Style[HtmlTextWriterStyle.Top] = "80px";
                llll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                llll.Style[HtmlTextWriterStyle.Top] = "120px";
                lllll.Style[HtmlTextWriterStyle.Position] = "Absolute";
                lllll.Style[HtmlTextWriterStyle.Top] = "160px";
                form1.Controls.Add(l);
                //form1.Controls.Add(s);
                form1.Controls.Add(ll);
                // form1.Controls.Add(s2);
                form1.Controls.Add(lll);
                //  form1.Controls.Add(s3);
                form1.Controls.Add(llll);
                //  form1.Controls.Add(s4);
                form1.Controls.Add(lllll);
            }
        }
        }
    }
}