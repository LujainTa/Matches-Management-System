<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MatchesManagementSystem.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color:wheat">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="HomeTitle" runat="server" Text="Matches Management System" BackColor="Gray" BorderColor="Black" BorderWidth="3px" Height="60px" Width="99.9%" Font-Size="30pt" style="margin-left: auto; margin-right: auto; text-align: center"></asp:Label>
        </div>
        <asp:Button ID="Register" runat="server" Text="Register Now!" style="margin-left: 93.5%; margin-top: 0.5%; border-radius: 25px" Width="100" Height="30" OnClick="RegisterOnClick"/>
        <asp:TextBox ID="Username" runat="server" Placeholder="Username" style="margin-left: 44%; margin-top: 10%; border-radius: 25px" Width="200" Height="30"></asp:TextBox>
        <asp:TextBox ID="Password" runat="server" Placeholder="Password" style="margin-left: 44%; margin-top: 1%; border-radius: 25px" Width="200" Height="30" TextMode="Password"></asp:TextBox>
        <asp:Button ID="LoginButton" runat="server" Text="Login" style="margin-left: 47.5%; margin-top: 1%; border-radius: 25px" Width="100" Height="30" OnClick="LoginOnClick"/>
    </form>
</body>
</html>
