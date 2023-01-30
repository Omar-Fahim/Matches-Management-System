<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="crRegisteration.aspx.cs" Inherits="WebApplication1.crRegisteration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            width: 899px;
            height: 264px;
            margin-left: 0px;
            margin-bottom: 18px;
        }
    </style>
</head>
<body style="height: 248px">
    <form id="form1" runat="server">
        <asp:Label ID="Label6" runat="server" Text="Club Representative Registeration Page"></asp:Label>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Please Enter Your Credentials !"></asp:Label>
        <br />
        <asp:Label ID="Label5" runat="server" Text="Name"></asp:Label>
        <br />
        <asp:TextBox ID="name" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label1" runat="server" Text="UserName"></asp:Label>
        <br />
        <asp:TextBox ID="username" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>
        <br />
        <asp:TextBox ID="password" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="Club_Name"></asp:Label>
        <br />
        <asp:TextBox ID="club" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" onClick ="crRegister" Text="Register" />
    </form>
</body>
</html>
