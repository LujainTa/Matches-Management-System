using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace MatchesManagementSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!(Username.Text.Equals("") || Password.Text.Equals("")))
            {
                String user = Username.Text;
                String pass = Password.Text;


                SqlCommand loginproc = new SqlCommand("userlogin", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@username", user));
                loginproc.Parameters.Add(new SqlParameter("@password", pass));

                SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
                SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);

                success.Direction = ParameterDirection.Output;
                type.Direction = ParameterDirection.Output;

                conn.Open();
                loginproc.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "0")

                {
                    Response.Write("<span id='Label1'' style='height:16px; width:300px; Z-INDEX: 302; LEFT: 44%; POSITION: absolute; TOP: 30%'>Invalid username or password</span>");
                }
                if (success.Value.ToString() == "1")
                {
                    if (type.Value.ToString() == "1")
                    {

                        Response.Redirect("SystemAdmin.aspx");
                    }
                    else if (type.Value.ToString() == "2")
                    {
                        Session["UserName"] = user;
                        Response.Redirect("SportsAssociationManager.aspx");
                    }
                    else if (type.Value.ToString() == "3")
                    {
                        Session["UserName"] = user;
                        Response.Redirect("ClubRepresentative.aspx");
                    }
                    else if (type.Value.ToString() == "4")
                    {
                        Session["UserName"] = user;
                        Response.Redirect("StadiumManager.aspx");
                    }
                    else if (type.Value.ToString() == "5")
                    {
                        Session["UserName"] = user;
                        Response.Redirect("Fan.aspx");
                    }
                    else if (type.Value.ToString() == "6")
                    {

                        Response.Write("You Are Blocked");
                    }
                }
            }
            else
            {
                Response.Write("Fill ALL Boxes");
            }
        }
        protected void RegisterOnClick(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}