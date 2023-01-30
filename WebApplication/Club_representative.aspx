<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Club_representative.aspx.cs" Inherits="WebApplication1.Club_representative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 253px;
        }
    </style>
</head>
<body style="height: 24px">
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Please Select The Reqiured Functionality"></asp:Label>
        <br />
        <asp:Button ID="Button1" runat="server" on click ="club info" Text="Club Information" OnClick="Button1_Click" />
        <br />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" on click = "matches info" Text="Matches Information" OnClick="Button2_Click" style="margin-left: 0px" />
        <br />
        <br />
        <br />
        <asp:Button ID="Button3" runat="server" on click = "available stadiums" Text="Available Stadiums" OnClick="Button3_Click" />
        <br />
    </form>
</body>
</html>
