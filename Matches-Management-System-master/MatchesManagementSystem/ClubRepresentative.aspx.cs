using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Metadata.W3cXsd2001;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

namespace MatchesManagementSystem
{
    public partial class ClubRepresentative : System.Web.UI.Page
    {
          
        protected void Page_Load(object sender, EventArgs e)
        {
          

        }

        protected void ViewAvastad(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!(StartTime.Text.Equals("")))
            {
                DateTime start = DateTime.Parse(StartTime.Text);

                SqlCommand proc = new SqlCommand("select * from viewAvailableStadiumsOn (@date)", conn);

                proc.Parameters.AddWithValue("@date", start);

                conn.Open();
                
                try
                {
                    SqlDataReader r = proc.ExecuteReader(CommandBehavior.CloseConnection);
                    while (r.Read())
                    {
                        string stadname = r.GetString(r.GetOrdinal("name"));
                        string location = r.GetString(r.GetOrdinal("location"));
                        int capacity = r.GetInt32(r.GetOrdinal("capacity"));
                        Label name = new Label();
                        name.Text = stadname;

                        Label loc = new Label();
                        loc.Text = location;

                        Label cap = new Label();
                        cap.Text = capacity.ToString();

                        form1.Controls.Add(name);
                        form1.Controls.Add(loc);
                        form1.Controls.Add(cap);



                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Incorrect Information");
                }
               
                
            }
            else
            {
                Response.Write("Fill ALL Boxes");
            }

        }



        protected void AllClub_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String user =  (string)Session["UserName"];
            SqlCommand proc = new SqlCommand("select * from allClubRepresentatives", conn);

            String Clubname="";
            conn.Open();
            SqlDataReader r = proc.ExecuteReader(CommandBehavior.CloseConnection);
            while (r.Read())
            {
                String usertmp=r.GetString(r.GetOrdinal("username")); 
                String clubn = r.GetString(r.GetOrdinal("ClubName"));
                if(usertmp.Equals(user))
                {
                    Clubname = clubn;
                }
            }
            conn.Close();
            conn.Open();
            SqlCommand proc2 = new SqlCommand("select * from allClubs", conn);
            SqlDataReader r2 = proc2.ExecuteReader(CommandBehavior.CloseConnection);
            while (r2.Read()) 
            {
                String name=r2.GetString(r2.GetOrdinal("name"));    
                String location =r2.GetString(r2.GetOrdinal("location")); 
                if(name.Equals(Clubname))
                {
                    Label cname = new Label();
                    cname.Text = Clubname;
                    Label loc= new Label(); 
                    loc.Text = location;
                    form1.Controls.Add(cname);  
                    form1.Controls.Add(loc);    
                
                }

             }



        }

        protected void Sendre_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (!(Hname.Text.Equals("") || StadiumName.Text.Equals("") || STime.Text.Equals("")))
            {
                DateTime start = DateTime.Parse(STime.Text);
                String Host = Hname.Text;
                String Stad = StadiumName.Text;


                SqlCommand proc = new SqlCommand("addHostRequest", conn);

                proc.CommandType = CommandType.StoredProcedure;
                proc.Parameters.Add(new SqlParameter("@clubName", Host));
                proc.Parameters.Add(new SqlParameter("@stadiumName", Stad));
                proc.Parameters.Add(new SqlParameter("@startingTime", start));



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

        protected void Upcom_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MatchesManagementSystem"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String user = (string)Session["UserName"];
            SqlCommand proc = new SqlCommand("select * from allClubRepresentatives", conn);

            String Clubname = "";
            conn.Open();
            SqlDataReader r = proc.ExecuteReader(CommandBehavior.CloseConnection);
            while (r.Read())
            {
                String usertmp = r.GetString(r.GetOrdinal("username"));
                String clubn = r.GetString(r.GetOrdinal("ClubName"));
                if (usertmp.Equals(user))
                {
                    Clubname = clubn;
                }
            }
            conn.Close();
          
            SqlCommand proc2 = new SqlCommand("select * from upcomingMatchesOfClub(@club_name)", conn);
            proc2.Parameters.AddWithValue("@club_name", Clubname);

             conn.Open();
            SqlDataReader r2 = proc2.ExecuteReader(CommandBehavior.CloseConnection);
            
            while (r2.Read())
            {
                String hostclubname = r2.GetString(r2.GetOrdinal("cname"));
                String guestclubname = r2.GetString(r2.GetOrdinal("name"));
                DateTime starttime = r2.GetDateTime(r2.GetOrdinal("start_time"));
                String sn = r2.GetString(r2.GetOrdinal("sn"));

                Label Host = new Label();
                Label Guest = new Label();
                Label Starttime = new Label();
                Label StadiumName= new Label(); 
                
                     Host.Text= hostclubname;
                    Guest.Text= guestclubname;
                    Starttime.Text = starttime.ToString();
                StadiumName.Text = sn;
                    form1.Controls.Add(Host);
                    form1.Controls.Add(Guest);
                    form1.Controls.Add(Starttime);
                   
                   form1.Controls.Add(StadiumName);

                    

                
                


            }

            
        }
    }
}