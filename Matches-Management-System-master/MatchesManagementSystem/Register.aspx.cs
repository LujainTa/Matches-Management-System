using System;

namespace MatchesManagementSystem
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RegisterAsSportsAssociationManager(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAsSportsAssociationManager.aspx");
        }

        protected void RegisterAsClubRepresentative(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAsClubRepresentative.aspx");
        }

        protected void RegisterAsStadiumManager(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAsStadiumManager.aspx");
        }

        protected void RegisterAsFan(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAsFan.aspx");
        }
    }
}