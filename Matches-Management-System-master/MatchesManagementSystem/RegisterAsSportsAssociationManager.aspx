<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterAsSportsAssociationManager.aspx.cs" Inherits="MatchesManagementSystem.RegisterAsSportsAssociationManager" %>

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
        <asp:TextBox ID="Name" runat="server" Placeholder="Name" Style="margin-left: 44%; margin-top: 10%; border-radius: 25px" Width="200" Height="30"></asp:TextBox>
        <asp:TextBox ID="Username" runat="server" Placeholder="Username" Style="margin-left: 44%; margin-top: 1%; border-radius: 25px" Width="200" Height="30"></asp:TextBox>
        <asp:TextBox ID="Password" runat="server" Placeholder="Password" Style="margin-left: 44%; margin-top: 1%; border-radius: 25px" Width="200" Height="30" TextMode="Password"></asp:TextBox>
        <asp:Button ID="RegisterButton" runat="server" Text="Register" Style="margin-left: 47.5%; margin-top: 1%; border-radius: 25px" Width="100" Height="30" OnClick="Register" />
    </form>
</body>
</html>
