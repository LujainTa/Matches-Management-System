<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepresentative.aspx.cs" Inherits="MatchesManagementSystem.ClubRepresentative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: wheat">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="HomeTitle" runat="server" Text="You are logged in as a Club Representative" BackColor="Gray" BorderColor="Black" BorderWidth="3px" Height="60px" Width="99.9%" Font-Size="30pt" Style="margin-left: auto; margin-right: auto; text-align: center"></asp:Label>
        </div>
        <asp:Button ID="ViewAvaStadiums" runat="server" OnClick="ViewAvastad" Text="View all available stadiums" Height="21px" />
        <asp:TextBox ID="StartTime" runat="server" placeholder="Start Time"  TextMode="DateTimeLocal"  ></asp:TextBox>
        <asp:Button ID="AllClub" runat="server" Text="ClubInformation" OnClick="AllClub_Click" />
        <asp:Button ID="Upcom" runat="server" Text="UpcomingMatchesOfClub" OnClick="Upcom_Click" />
        <p>
            <asp:Button ID="Sendre" runat="server" Text="SendRequest" OnClick="Sendre_Click" />
            <asp:TextBox ID="Hname" runat="server"   Placeholder="ClubName" > </asp:TextBox>
            <asp:TextBox ID="StadiumName" runat="server" Placeholder="StadiumName"></asp:TextBox>
            <asp:TextBox ID="STime" runat="server" placeholder="Start Time"  TextMode="DateTimeLocal" ></asp:TextBox>
        </p>
    </form>
</body>
</html>
