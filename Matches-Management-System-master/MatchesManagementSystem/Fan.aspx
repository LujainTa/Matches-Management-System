<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="MatchesManagementSystem.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: wheat">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="HomeTitle" runat="server" Text="You are logged in as a Fan" BackColor="Gray" BorderColor="Black" BorderWidth="3px" Height="60px" Width="99.9%" Font-Size="30pt" Style="margin-left: auto; margin-right: auto; text-align: center"></asp:Label>
        </div>
        
      
   
   
        <asp:Button ID="ViewAll" runat="server" Text="ViewAllAvaivMatches" OnClick="ViewAll_Click"  />
        
      
   
   
        <asp:TextBox ID="StartTime" runat="server" placeholder="Start Time"  TextMode="DateTimeLocal"></asp:TextBox>
        
      
   
   
        <p>
            <asp:Button ID="Purchase" runat="server" Text="Purchase" OnClick="Purchase_Click" />
            <asp:TextBox ID="Hname" runat="server" Placeholder="HostClubName"></asp:TextBox>
            <asp:TextBox ID="Gname" runat="server" Placeholder="GuestClubName"></asp:TextBox>
            <asp:TextBox ID="FanID" runat="server" Placeholder="FanNationalID"></asp:TextBox>
            <asp:TextBox ID="Stime" runat="server" placeholder="Start Time"  TextMode="DateTimeLocal"  ></asp:TextBox>
        </p>
        
      
   
   
    </form>
</body>
</html>
