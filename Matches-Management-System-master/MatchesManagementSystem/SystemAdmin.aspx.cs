using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace MatchesManagementSystem
{
    public partial class SystemAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addClubButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (!(addClubNameTextBox.Text.Equals("") || addClubLocationTextBox.Text.Equals("")))
            {
                String name = addClubNameTextBox.Text;
                String location = addClubLocationTextBox.Text;

                SqlCommand loginproc = new SqlCommand("addClub", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@name", name));
                loginproc.Parameters.Add(new SqlParameter("@location", location));

                conn.Open();
                try
                {
                    loginproc.ExecuteNonQuery();

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

        protected void deleteClubButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (!(deleteClubNameTextBox.Text.Equals("")))
            {
                String name = deleteClubNameTextBox.Text; ;

                SqlCommand loginproc = new SqlCommand("deleteClub", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@name", name));

                conn.Open();
                try
                {
                   loginproc.ExecuteNonQuery();
                   

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

        protected void addStadiumButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (!(addStadiumNameTextBox.Text.Equals("") || addStadiumLocationTextBox.Text.Equals("") || addStadiumCapacityTextBox.Text.Equals("")))
            {
                String name = addStadiumNameTextBox.Text;
                String location = addStadiumLocationTextBox.Text;
                int capacity = Int32.Parse(addStadiumCapacityTextBox.Text);

                SqlCommand loginproc = new SqlCommand("addStadium", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@name", name));
                loginproc.Parameters.Add(new SqlParameter("@location", location));
                loginproc.Parameters.Add(new SqlParameter("@capacity", capacity));

                conn.Open();
                try
                {
                    loginproc.ExecuteNonQuery();

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

        protected void deleteStadiumButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (!(deleteStadiumNameTextBox.Text.Equals("")))
            {
                String name = deleteStadiumNameTextBox.Text; ;

                SqlCommand loginproc = new SqlCommand("deleteStadium", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@name", name));

                conn.Open();
                try
                {
                    loginproc.ExecuteNonQuery();

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

        protected void blockFanButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (!(blockFanTextBox.Text.Equals("")))
            {
                String nationalIDNumber = blockFanTextBox.Text;

                SqlCommand loginproc = new SqlCommand("blockFan", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@nationalID", nationalIDNumber));

                conn.Open();
                try
                {
                    loginproc.ExecuteNonQuery();

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