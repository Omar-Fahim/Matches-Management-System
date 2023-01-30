using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class systemAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addClub(object sender, EventArgs e)
        {
            Response.Redirect("addClub.aspx");
        }

        protected void deleteClub(object sender, EventArgs e)
        {
            Response.Redirect("deleteClub.aspx");
        }

        protected void addStadium(object sender, EventArgs e)
        {
            Response.Redirect("addStadium.aspx");
        }

        protected void deleteStadium(object sender, EventArgs e)
        {
            Response.Redirect("deleteStadium.aspx");
        }

        protected void blockFan(object sender, EventArgs e)
        {
            Response.Redirect("blockFan.aspx");
        }
    }
}