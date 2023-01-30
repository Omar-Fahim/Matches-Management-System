<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Delete_Match.aspx.cs" Inherits="WebApplication1.Delete_Match" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Delete Match Page"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Host Club Name"></asp:Label>
            <br />
            <asp:TextBox ID="HostClub" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Guest Club Name"></asp:Label>
            <br />
            <asp:TextBox ID="GuestClub" runat="server" ></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Start Time"></asp:Label>
            <br />
            <asp:TextBox ID="StartTime" textmode="DateTimeLocal" runat="server" ></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="End Time"></asp:Label>
            <br />
            <asp:TextBox ID="EndTime" textmode="DateTimeLocal" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Delete Match" OnClick="DeleteMatch" />
            <br />
        </div>
    </form>
</body>
</html>
