using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Stadium_Manager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void showStadInfo(object sender, EventArgs e)
        {
            Response.Redirect("showStadInfo.aspx");
        }

        protected void viewRequests(object sender, EventArgs e)
        {
            Response.Redirect("viewRequests.aspx");
        }
    }
}