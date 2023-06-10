<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdmin.aspx.cs" Inherits="MatchesManagementSystem.SystemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: wheat">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="HomeTitle" runat="server" Text="You are logged in as a System Admin" BackColor="Gray" BorderColor="Black" BorderWidth="3px" Height="60px" Width="99.9%" Font-Size="30pt" Style="margin-left: auto; margin-right: auto; text-align: center"></asp:Label>
        </div>
        <asp:TextBox ID="addClubNameTextBox" runat="server" placeholder="Club Name" Height="52px" Width="24%" Style="text-align: center" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:TextBox ID="addClubLocationTextBox" runat="server" placeholder="Club Location" Height="52px" Width="24%" Style="margin-top: -5px; text-align: center; margin-left: 5px" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="addClubButton" runat="server" Height="58px" Text="Add Club" Width="49%" Style="margin-left: 10px; margin-top: 10px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="addClubButtonOnClick"/>

        <asp:TextBox ID="deleteClubNameTextBox" runat="server" placeholder="Club Name" Height="52px" Width="49%" Style="text-align: center" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="deleteClubButton" runat="server" Height="58px" Text="Delete Club" Width="49%" Style="margin-left: 10px; margin-top: 10px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="deleteClubButtonOnClick"/>

        <asp:TextBox ID="addStadiumNameTextBox" runat="server" placeholder="Stadium Name" Height="52px" Width="15.5%" Style="text-align: center" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:TextBox ID="addStadiumLocationTextBox" runat="server" placeholder="Stadium Location" Height="52px" Width="15.5%" Style="margin-top: -5px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:TextBox ID="addStadiumCapacityTextBox" runat="server" placeholder="Stadium Capacity" Height="52px" Width="15.5%" Style="margin-top: -5px; text-align: center; margin-left: 3px" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="addStadiumButton" runat="server" Height="58px" Text="Add Stadium" Width="49%" Style="margin-left: 10px; margin-top: 10px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="addStadiumButtonOnClick"/>

        <asp:TextBox ID="deleteStadiumNameTextBox" runat="server" placeholder="Stadium Name" Height="52px" Width="49%" Style="text-align: center" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="deleteStadiumButton" runat="server" Height="58px" Text="Delete Stadium" Width="49%" Style="margin-left: 5px; margin-top: 10px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="deleteStadiumButtonOnClick"/>

        <asp:TextBox ID="blockFanTextBox" runat="server" placeholder="National ID Number" Height="52px" Width="49%" Style="text-align: center" BorderColor="Black" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="blockFanButton" runat="server" Height="58px" Text="Block Fan" Width="49%" Style="margin-left: 5px; margin-top: 10px" BackColor="Cyan" BorderColor="Black" BorderWidth="3px" Font-Size="20pt" OnClick="blockFanButtonOnClick"/>
    </form>
</body>
</html>
