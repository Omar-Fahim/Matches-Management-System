using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Sports_Association_Manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Delete_Match.aspx");
        }

        protected void Add_Match(object sender, EventArgs e)
        {
            Response.Redirect("Add_Match.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Upcoming_Matches_view.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Matches_already_played.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("Clubs_never_played.aspx");
        }
    }
}