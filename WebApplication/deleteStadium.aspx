<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="deleteStadium.aspx.cs" Inherits="WebApplication1.deleteStadium" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Delete Stadium" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <p>
        <asp:Label ID="Label4" runat="server" Text="Enter Stadium Name :"></asp:Label>
        <br />
        <asp:TextBox ID="stadN" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="dstad" runat="server" OnClick="delete" Text="Delete" />
        <br />
        <br />
        <asp:Button ID="home4" runat="server" OnClick="back" Text="Return To Home Page" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
