using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MatchesManagementSystem
{
    public partial class StadiumManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ViewAllStadInfo_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String user = (string)Session["UserName"];
            SqlCommand proc = new SqlCommand("select * from allStadiumManagers", conn);

            String Stadname = "";
            conn.Open();
            SqlDataReader r = proc.ExecuteReader(CommandBehavior.CloseConnection);
            while (r.Read())
            {
                String usertmp = r.GetString(r.GetOrdinal("username"));
                String stadn = r.GetString(r.GetOrdinal("StadiumName"));
                if (usertmp.Equals(user))
                {
                    Stadname = stadn;
                }
            }
            conn.Close();
            conn.Open();
            SqlCommand proc2 = new SqlCommand("select * from allStadiums", conn);
            SqlDataReader r2 = proc2.ExecuteReader(CommandBehavior.CloseConnection);
            while (r2.Read())
            {
                String name = r2.GetString(r2.GetOrdinal("name"));
                String location = r2.GetString(r2.GetOrdinal("location"));
                int capacity = r2.GetInt32(r2.GetOrdinal("capacity"));
                Boolean status = r2.GetBoolean(r2.GetOrdinal("status"));
                if (name.Equals(Stadname))
                {
                    Label sname = new Label();
                    sname.Text = Stadname;
                    Label loc = new Label();
                    loc.Text = location;
                    Label cap = new Label();
                    cap.Text = capacity.ToString();
                    Label stat = new Label();
                    if (status.ToString().Equals("True"))
                        stat.Text = "Available";
                    else
                        stat.Text = "Not Available";

                    form1.Controls.Add(sname);
                    form1.Controls.Add(loc);
                    form1.Controls.Add(cap);
                    form1.Controls.Add(stat);

                }

            }
        }

        protected void ViewAllReq_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String user = (string)Session["UserName"];
            SqlCommand proc = new SqlCommand("select * from requestsFromClub4(@stadmaname)", conn);

            proc.Parameters.AddWithValue("@stadmaname", user);
            conn.Open();
            SqlDataReader r = proc.ExecuteReader(CommandBehavior.CloseConnection);
            while (r.Read())
            {
                String hostclubname = r.GetString(r.GetOrdinal("hostclub"));
                String guestclubname = r.GetString(r.GetOrdinal("guestclub"));
                String crname = r.GetString(r.GetOrdinal("crname"));
                DateTime starttime = r.GetDateTime(r.GetOrdinal("start_time"));
                String stat = r.GetString(r.GetOrdinal("status"));
                Label Host = new Label();
                Host.Text = hostclubname;
                Label guest = new Label();
                guest.Text = guestclubname;
                Label cr = new Label();
                cr.Text = crname;
                Label Start = new Label();
                Start.Text = starttime.ToString();
                Label status = new Label();
                status.Text = stat;
                form1.Controls.Add(cr);
                form1.Controls.Add(Host);
                form1.Controls.Add(guest);
                form1.Controls.Add(Start);
                form1.Controls.Add(status);

            }
        }

        protected void AcceptReq_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!(Hostname.Text.Equals("") || GuestName.Text.Equals("") ||Starttime.Text.Equals("")))
            {
                String user = (string)Session["UserName"];
                String Host = Hostname.Text;
                String Guest = GuestName.Text;
                DateTime start = DateTime.Parse(Starttime.Text);
                SqlCommand proc = new SqlCommand("acceptRequest", conn);
                proc.CommandType = CommandType.StoredProcedure;
                proc.Parameters.Add(new SqlParameter("@stadium_manager_username", user));
                proc.Parameters.Add(new SqlParameter("@hosting_club_name", Host));
                proc.Parameters.Add(new SqlParameter("@competing_club_name", Guest));
                proc.Parameters.Add(new SqlParameter("@starting_time", start));
                conn.Open();
                try
                {
                    proc.ExecuteNonQuery();
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

        protected void RejectReq_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!(Hname.Text.Equals("") || Gname.Text.Equals("") || STime.Text.Equals("")))
            {
                String user = (string)Session["UserName"];
                String Host = Hname.Text;
                String Guest = Gname.Text;
                DateTime start = DateTime.Parse(STime.Text);
                SqlCommand proc = new SqlCommand("rejectRequest", conn);
                proc.CommandType = CommandType.StoredProcedure;
                proc.Parameters.Add(new SqlParameter("@stadium_manager_username", user));
                proc.Parameters.Add(new SqlParameter("@hosting_club_name", Host));
                proc.Parameters.Add(new SqlParameter("@competing_club_name", Guest));
                proc.Parameters.Add(new SqlParameter("@starting_time", start));
                conn.Open();
                try
                {
                    proc.ExecuteNonQuery();
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