<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="System_Admin.aspx.cs" Inherits="WebApplication1.systemAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="What do you want to do?" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <asp:Button ID="ac" runat="server" OnClick="addClub" Text="Add Club" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="dc" runat="server" OnClick="deleteClub" Text="Delete Club" />
        <br />
        <br />
        <br />
        <asp:Button ID="as" runat="server" OnClick="addStadium" Text="Add stadium" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="ds" runat="server" OnClick="deleteStadium" Text="Delete stadium" />
        <br />
        <br />
        <br />
        <asp:Button ID="bf" runat="server" OnClick="blockFan" Text="Block Fan" />
    </form>
</body>
</html>
