<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MatchesManagementSystem.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: wheat">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="RegistrationTitle" runat="server" Text="Registration" BackColor="Gray" BorderColor="Black" BorderWidth="3px" Height="60px" Width="99.9%" Font-Size="30pt" Style="margin-left: auto; margin-right: auto; text-align: center"></asp:Label>
        </div>
        <asp:Label ID="RegisterAs" runat="server" Text="Register As" Style="margin-left: 44.5%; margin-top: 10%; border-radius: 25px; text-align: center" Width="180" Height="35" Font-Size="20pt" BackColor="LightGray" BorderColor="Black" BorderWidth="3px"></asp:Label>
        
        <asp:Button ID="SportsAssociationManager" runat="server" Text="Sports Association Manager" Style="margin-left: 43%; margin-top: 1%; border-radius: 25px" Width="240" Height="35" BorderColor="Black" BorderWidth="3px" OnClick="RegisterAsSportsAssociationManager"/>
        <asp:Button ID="ClubRepresentative" runat="server" Text="Club Representative" Style="margin-left: 43%; margin-top: 1%; border-radius: 25px" Width="240" Height="35" BorderColor="Black" BorderWidth="3px" OnClick="RegisterAsClubRepresentative"/>
        <asp:Button ID="StadiumManager" runat="server" Text="Stadium Manager" Style="margin-left: 43%; margin-top: 1%; border-radius: 25px" Width="240" Height="35" BorderColor="Black" BorderWidth="3px" OnClick="RegisterAsStadiumManager"/>
        <asp:Button ID="Fan" runat="server" Text="Fan" Style="margin-left: 43%; margin-top: 1%; border-radius: 25px" Width="240" Height="35" BorderColor="Black" BorderWidth="3px" OnClick="RegisterAsFan"/>
    </form>
</body>
</html>
