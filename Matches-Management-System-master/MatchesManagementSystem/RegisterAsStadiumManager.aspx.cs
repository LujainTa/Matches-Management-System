using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace MatchesManagementSystem
{
    public partial class RegisterAsStadiumManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (Name.Text.Length > 0 && Username.Text.Length > 0 && Password.Text.Length > 0 && StadiumName.Text.Length > 0)
            {
                String name = Name.Text;
                String user = Username.Text;
                String pass = Password.Text;
                String stadiumName = StadiumName.Text;

                SqlCommand loginproc = new SqlCommand("addStadiumManager", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@name", name));
                loginproc.Parameters.Add(new SqlParameter("@stadiumName", stadiumName));
                loginproc.Parameters.Add(new SqlParameter("@username", user));
                loginproc.Parameters.Add(new SqlParameter("@password", pass));
                SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
                success.Direction = ParameterDirection.Output;

                conn.Open();
                try
                {
                    loginproc.ExecuteNonQuery();
                    if (success.Value.ToString() == "1")
                    {
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        Response.Write("Username Taken");
                    }

                }
                catch (Exception ex)
                {
                    Response.Write("Incorrect Information");
                }
                conn.Close();


            }
            else
            {
                Response.Write("Fill ALL Boxes");
            }
        }
    }
}