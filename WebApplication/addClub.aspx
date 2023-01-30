<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addClub.aspx.cs" Inherits="WebApplication1.addClub" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Add Club" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <asp:Label ID="Label4" runat="server" Text="Enter Club Name :"></asp:Label>
        <br />
        <asp:TextBox ID="clubName" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Enter Club Location :"></asp:Label>
        <br />
        <asp:TextBox ID="clubLocation" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="done" runat="server" OnClick="add" Text="Add" />
        <br />
        <br />
        <asp:Button ID="home" runat="server" OnClick="back" Text="Return To Home Page" />
    </form>
</body>
</html>
