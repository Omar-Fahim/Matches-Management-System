<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addStadium.aspx.cs" Inherits="WebApplication1.addStadium" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Add Stadium" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <asp:Label ID="Label4" runat="server" Text="Enter Stadium Name :"></asp:Label>
        <br />
        <asp:TextBox ID="stadName" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Enter Stadium Location :"></asp:Label>
        <br />
        <asp:TextBox ID="stadLoc" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label6" runat="server" Text="Enter Stadium Capacity:"></asp:Label>
        <br />
        <asp:TextBox ID="stadCap" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="addStad" runat="server" Text="Add" OnClick="add" />
        <br />
        <br />
        <asp:Button ID="home3" runat="server" OnClick="back" Text="Return To Home Page" />
    </form>
</body>
</html>
