using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MatchesManagementSystem
{
    public partial class Fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ViewAll_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!(StartTime.Text.Equals("")))
            {
                SqlCommand proc = new SqlCommand("select * from availableMatchesToAttend (@date)", conn);
                DateTime start = DateTime.Parse(StartTime.Text);
                proc.Parameters.AddWithValue("@date", start);
                conn.Open();
                SqlDataReader r = proc.ExecuteReader(CommandBehavior.CloseConnection);
                while (r.Read())
                {
                    String hostclubname = r.GetString(r.GetOrdinal("HostClubName"));
                    String guestclubname = r.GetString(r.GetOrdinal("GuestClubName"));
                    DateTime starttime = r.GetDateTime(r.GetOrdinal("start_time"));
                    String stad = r.GetString(r.GetOrdinal("name"));

                    Label Host = new Label();
                    Label Guest = new Label();
                    Label Starttime = new Label();
                    Label StadiumName = new Label();

                    Host.Text = hostclubname;
                    Guest.Text = guestclubname;
                    Starttime.Text = starttime.ToString();
                    StadiumName.Text = stad;
                    form1.Controls.Add(Host);
                    form1.Controls.Add(Guest);
                    form1.Controls.Add(Starttime);

                    form1.Controls.Add(StadiumName);

                }
            }
            else
            {
                Response.Write("Fill ALL Boxes");
            }
        }

        protected void Purchase_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!(Stime.Text.Equals("") || FanID.Text.Equals("") || Hname.Text.Equals("") || Gname.Text.Equals("")))
            {
                String id = FanID.Text;
                String Host = Hname.Text;
                String guest = Gname.Text;
                DateTime start = DateTime.Parse(Stime.Text);
                SqlCommand proc = new SqlCommand("purchaseTicket", conn);
                proc.CommandType = CommandType.StoredProcedure;
                proc.Parameters.Add(new SqlParameter("@fan_nationalid", id));
                proc.Parameters.Add(new SqlParameter("@host_clubname", Host));
                proc.Parameters.Add(new SqlParameter("@guest_clubname", guest));
                proc.Parameters.Add(new SqlParameter("@starttime", start));
                conn.Open();
                try
                {
                    proc.ExecuteNonQuery();
                }
                catch(Exception ex)
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