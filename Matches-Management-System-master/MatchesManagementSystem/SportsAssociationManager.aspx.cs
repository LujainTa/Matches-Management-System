using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace MatchesManagementSystem
{
    public partial class SportsAssociationManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addMatchButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (!(addMatchHostClubNameTextBox.Text.Equals("") || addMatchGuestClubNameTextBox.Text.Equals("") || addMatchStartTimeTextBox.Text.Equals("") || addMatchEndTimeTextBox.Text.Equals("")))
            {
                String hostClubName = addMatchHostClubNameTextBox.Text;
                String guestClubName = addMatchGuestClubNameTextBox.Text;
                DateTime startTime = DateTime.Parse(addMatchStartTimeTextBox.Text);
                DateTime endTime = DateTime.Parse(addMatchEndTimeTextBox.Text);

                SqlCommand loginproc = new SqlCommand("addNewMatch", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@hostClubName", hostClubName));
                loginproc.Parameters.Add(new SqlParameter("@guestClubName", guestClubName));
                loginproc.Parameters.Add(new SqlParameter("@start_time", startTime));
                loginproc.Parameters.Add(new SqlParameter("@end_time", endTime));

                conn.Open();
                try
                {
                    loginproc.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Response.Write("Incorect Information");
                }
                conn.Close();

                
            }
            else
            {
                Response.Write("Fill All Boxes");
            }
        }

        protected void deleteMatchButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (!(deleteMatchHostClubNameTextBox.Text.Equals("") || deleteMatchGuestClubNameTextBox.Text.Equals("") || deleteMatchStartTimeTextBox.Text.Equals("") || deleteMatchEndTimeTextBox.Text.Equals("")))
            {
                String hostClubName = deleteMatchHostClubNameTextBox.Text;
                String guestClubName = deleteMatchGuestClubNameTextBox.Text;
                DateTime startTime = DateTime.Parse(deleteMatchStartTimeTextBox.Text);
                DateTime endTime = DateTime.Parse(deleteMatchEndTimeTextBox.Text);
                

                SqlCommand loginproc = new SqlCommand("deleteMatch", conn);
                loginproc.CommandType = CommandType.StoredProcedure;
                loginproc.Parameters.Add(new SqlParameter("@hostClubName", hostClubName));
                loginproc.Parameters.Add(new SqlParameter("@guestClubName", guestClubName));
                loginproc.Parameters.Add(new SqlParameter("@start_time", startTime));
                loginproc.Parameters.Add(new SqlParameter("@end_time", endTime));

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
                Response.Write("Fill All Boxes");
            }
        }

        protected void viewUpcomingMatchesButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!clubUpcomingMatches.Text.Equals(""))
            {
                String clubName = clubUpcomingMatches.Text;
                SqlCommand regproc = new SqlCommand("select * from upcomingMatchesOfClub (@club_name)", conn);
                regproc.Parameters.AddWithValue("@club_name", clubName);

                conn.Open();

                SqlDataReader r = regproc.ExecuteReader(CommandBehavior.CloseConnection);

                while (r.Read())
                {
                    string hostName = r.GetString(r.GetOrdinal("Host Name"));
                    string guestName = r.GetString(r.GetOrdinal("Guest Name"));
                    string stadiumName = r.GetString(r.GetOrdinal("Stadium Name"));
                    DateTime startTime = r.GetDateTime(r.GetOrdinal("Start Time"));

                    Label hostClub = new Label();
                    hostClub.Text = hostName;
                    Label guestClub = new Label();
                    guestClub.Text = guestName;
                    Label stadium = new Label();
                    stadium.Text = stadiumName;
                    Label start = new Label();
                    start.Text = startTime.ToString();

                    form1.Controls.Add(hostClub);
                    form1.Controls.Add(guestClub);
                    form1.Controls.Add(stadium);
                    form1.Controls.Add(start);
                }
            }
            else
            {
                Response.Write("Fill All Boxes");
            }

        }

        protected void alreadyPlayedMatchesButtonOnClick(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!alreadyPlayedMatches.Text.Equals(""))
            {


                String clubName = alreadyPlayedMatches.Text;
                SqlCommand regproc = new SqlCommand("select * from alreadyPlayedMatches (@club_name)", conn);
                regproc.Parameters.AddWithValue("@club_name", clubName);

                conn.Open();

                SqlDataReader r = regproc.ExecuteReader(CommandBehavior.CloseConnection);

                while (r.Read())
                {
                    string hostName = r.GetString(r.GetOrdinal("Host Name"));
                    string guestName = r.GetString(r.GetOrdinal("Guest Name"));
                    string stadiumName = r.GetString(r.GetOrdinal("Stadium Name"));
                    DateTime startTime = r.GetDateTime(r.GetOrdinal("Start Time"));

                    Label hostClub = new Label();
                    hostClub.Text = hostName + " VS ";
                    Label guestClub = new Label();
                    guestClub.Text = guestName + " ";
                    Label stadium = new Label();
                    stadium.Text = stadiumName + " ";
                    Label start = new Label();
                    start.Text = startTime.ToString() + " ";

                    form1.Controls.Add(hostClub);
                    form1.Controls.Add(guestClub);
                    form1.Controls.Add(stadium);
                    form1.Controls.Add(start);
                }
            }
            else
            {
                Response.Write("Fill All Boxes");
            }
        }

        protected void viewPairNeverScheduled_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand regproc = new SqlCommand("select * from clubsNeverMatched", conn);

            conn.Open();

            SqlDataReader r = regproc.ExecuteReader(CommandBehavior.CloseConnection);

            while (r.Read())
            {
                string Pair = r.GetString(r.GetOrdinal("ClubsNeverMatched"));
              

                Label Pairs = new Label();
                Pairs.Text = Pair;
                

                form1.Controls.Add(Pairs);
             
            }
        }
    }
}