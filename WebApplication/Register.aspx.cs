using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void sam(object sender, EventArgs e)
        {
            Response.Redirect(("Sports_Association_Manager_Registeration.aspx"));
        }
        protected void cr(object sender, EventArgs e)
        {
            Response.Redirect("crRegisteration.aspx");
        }
        protected void sm(object sender, EventArgs e)
        {
            Response.Redirect("smRegisteration.aspx");
        }
        protected void fan(object sender, EventArgs e)
        {
            Response.Redirect("fanRegisteration.aspx");
        }
    }
}