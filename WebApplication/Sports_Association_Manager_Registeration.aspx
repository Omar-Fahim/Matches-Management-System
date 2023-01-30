<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sports_Association_Manager_Registeration.aspx.cs" Inherits="WebApplication1.Sports_Association_Manager_Registeration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Sports Association Manager Registeration"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Name"></asp:Label>
            <br />
            <asp:TextBox ID="Name" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Username"></asp:Label>
            <br />
            <asp:TextBox ID="Username" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Password"></asp:Label>
            <br />
            <asp:TextBox ID="Password" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button3" runat="server" OnClick="RegisterSAM" Text="Register" />
            <br />
        </div>
    </form>
</body>
</html>
