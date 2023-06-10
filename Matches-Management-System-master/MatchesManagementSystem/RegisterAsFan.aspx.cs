using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace MatchesManagementSystem
{
    public partial class RegisterAsFan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (!(Name.Text.Equals("") || Username.Text.Equals("") || Password.Text.Equals("")  || NationalIDNumber.Text.Equals("") || Address.Text.Equals("") || PhoneNumber.Text.Equals("")))
            {
                String name = Name.Text;
                String user = Username.Text;
                String pass = Password.Text;
                String nationalIDNumber = NationalIDNumber.Text;
                DateTime birthDate = DateTime.Parse(BirthDate.Text);
                String address = Address.Text;
                int phoneNumber = Int32.Parse(PhoneNumber.Text);

                SqlCommand loginproc = new SqlCommand("addFan", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@name", name));
                loginproc.Parameters.Add(new SqlParameter("@username", user));
                loginproc.Parameters.Add(new SqlParameter("@password", pass));
                loginproc.Parameters.Add(new SqlParameter("@nationalIDNumber", nationalIDNumber));
                loginproc.Parameters.Add(new SqlParameter("@birthDate", birthDate));
                loginproc.Parameters.Add(new SqlParameter("@address", address));
                loginproc.Parameters.Add(new SqlParameter("@phoneNumber", phoneNumber));
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