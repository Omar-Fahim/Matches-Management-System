<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sports_Association_Manager.aspx.cs" Inherits="WebApplication1.Sports_Association_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Welcome sports manager"></asp:Label>

            <br />
            <br />
            <asp:Button ID="AddMatch" runat="server" OnClick ="Add_Match" Text="Add Match" />
            <br />
            <br />
            <asp:Button runat="server" Text="Delete Match " OnClick="Unnamed1_Click" />

            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="View upcoming matches" OnClick="Button1_Click" />
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" Text="View matches already played" OnClick="Button2_Click" />
            <br />
            <br />
            <asp:Button ID="Button3" runat="server" Text="View clubs that never scheduled to play" OnClick="Button3_Click" />
            <br />
            <br />

        </div>
    </form>
</body>
</html>
