<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManager.aspx.cs" Inherits="MatchesManagementSystem.StadiumManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: wheat">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="HomeTitle" runat="server" Text="You are logged in as a Stadium Manager" BackColor="Gray" BorderColor="Black" BorderWidth="3px" Height="60px" Width="99.9%" Font-Size="30pt" Style="margin-left: auto; margin-right: auto; text-align: center"></asp:Label>
        </div>
        <asp:Button ID="ViewAllStadInfo" runat="server" Text="ViewAllStadinfo" OnClick="ViewAllStadInfo_Click" />
        <asp:Button ID="ViewAllReq" runat="server" Text="ViewAllRequests" OnClick="ViewAllReq_Click" Width="174px" />
        <p>
            <asp:Button ID="AcceptReq" runat="server" Text="AcceptRequest" OnClick="AcceptReq_Click" />
            <asp:TextBox ID="Hostname" runat="server"  Placeholder="HostClubName"></asp:TextBox>
            <asp:TextBox ID="GuestName" runat="server" Placeholder="GusetClubName"></asp:TextBox>
            <asp:TextBox ID="Starttime" runat="server" placeholder="Start Time"  TextMode="DateTimeLocal"  ></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="RejectReq" runat="server" Text="RejectRequest" OnClick="RejectReq_Click"  />
            <asp:TextBox ID="Hname" runat="server"  Placeholder="HostClubName"></asp:TextBox>
            <asp:TextBox ID="Gname" runat="server" Placeholder="GusetClubName"></asp:TextBox>
            <asp:TextBox ID="STime" runat="server" placeholder="Start Time"  TextMode="DateTimeLocal" ></asp:TextBox>
        </p>
    </form>
</body>
</html>
