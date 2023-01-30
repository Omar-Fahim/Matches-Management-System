<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="deleteClub.aspx.cs" Inherits="WebApplication1.deleteClub" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Delete Club" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <asp:Label ID="Label4" runat="server" Text="Enter Club Name :"></asp:Label>
        <br />
        <asp:TextBox ID="cnTwo" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="d" runat="server" OnClick="delete" Text="Delete" />
        <br />
        <br />
        <asp:Button ID="home2" runat="server" OnClick="back" Text="Return To Home Page" />
    </form>
</body>
</html>
