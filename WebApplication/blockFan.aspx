<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="blockFan.aspx.cs" Inherits="WebApplication1.blockFan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Block Fan" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <asp:Label ID="Label4" runat="server" Text="Enter Fan National ID Number :"></asp:Label>
        <br />
        <asp:TextBox ID="fnid" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="bf" runat="server" OnClick="block" Text="Block" />
        <br />
        <br />
        <asp:Button ID="home4" runat="server" OnClick="back" Text="Return To Home Page" />
        <br />
    </form>
</body>
</html>
