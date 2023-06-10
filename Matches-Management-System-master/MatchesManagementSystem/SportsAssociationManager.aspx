<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsAssociationManager.aspx.cs" Inherits="MatchesManagementSystem.SportsAssociationManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: wheat">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="HomeTitle" runat="server" Text="You are logged in as a Sports Association Manager" BackColor="Gray" BorderColor="Black" BorderWidth="3px" Height="60px" Width="99.9%" Font-Size="30pt" Style="margin-left: auto; margin-right: auto; text-align: center"></asp:Label>
        </div>
        <asp:TextBox ID="addMatchHostClubNameTextBox" runat="server" placeholder="Host Club Name" Height="52px" Width="11.5%" Style="text-align: center" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:TextBox ID="addMatchGuestClubNameTextBox" runat="server" placeholder="Guest Club Name" Height="52px" Width="11.5%" Style="margin-top: -5px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:TextBox ID="addMatchStartTimeTextBox" runat="server" placeholder="Start Time" Height="52px" Width="11.5%" Style="margin-top: -5px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px" TextMode="DateTimeLocal"></asp:TextBox>
        <asp:TextBox ID="addMatchEndTimeTextBox" runat="server" placeholder="End Time" Height="52px" Width="11.5%" Style="margin-top: -5px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px" TextMode="DateTimeLocal"></asp:TextBox>
        <asp:Button ID="addMatchButton" runat="server" Height="58px" Text="Add Match" Width="49%" Style="margin-left: 10px; margin-top: 10px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="addMatchButtonOnClick" />

        <asp:TextBox ID="deleteMatchHostClubNameTextBox" runat="server" placeholder="Host Club Name" Height="52px" Width="11.5%" Style="text-align: center" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:TextBox ID="deleteMatchGuestClubNameTextBox" runat="server" placeholder="Guest Club Name" Height="52px" Width="11.5%" Style="margin-top: -5px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:TextBox ID="deleteMatchStartTimeTextBox" runat="server" placeholder="Start Time" Height="52px" Width="11.5%" Style="margin-top: -5px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px" TextMode="DateTimeLocal"></asp:TextBox>
        <asp:TextBox ID="deleteMatchEndTimeTextBox" runat="server" placeholder="End Time" Height="52px" Width="11.5%" Style="margin-top: -5px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px" TextMode="DateTimeLocal"></asp:TextBox>
        <asp:Button ID="deleteMatchButton" runat="server" Height="58px" Text="Delete Match" Width="49%" Style="margin-left: 10px; margin-top: 10px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="deleteMatchButtonOnClick" />

        <asp:TextBox ID="clubUpcomingMatches" runat="server" placeholder="Club Name" Height="52px" Width="49%" Style="text-align: center; margin-top: 10px" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="viewUpcomingMatches" runat="server" Text="View Upcoming Matches" Height="58px" Width="49%" Style="text-align: center; margin-top: 10px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="viewUpcomingMatchesButtonOnClick"></asp:Button>
        
        <asp:TextBox ID="alreadyPlayedMatches" runat="server" placeholder="Club Name" Height="52px" Width="49%" Style="margin-top: 10px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="alreadyPlayedMatchesButton" runat="server" Text="View Already Played Matches" Height="58px" Width="49%" Style="margin-top: 10px; text-align: center; margin-left: 3px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="alreadyPlayedMatchesButtonOnClick"></asp:Button>
        
       
        <asp:Button ID="viewPairNeverScheduled" runat="server" Text="View Clubs Never Matched" Height="58px" Width="49%" Style="margin-top: 10px; text-align: center; margin-left: 3px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="viewPairNeverScheduled_Click"></asp:Button>
    </form>
</body>
</html>
