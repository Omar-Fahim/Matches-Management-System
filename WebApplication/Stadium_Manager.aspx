<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Stadium_Manager.aspx.cs" Inherits="WebApplication1.Stadium_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Stadium Manager" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <asp:Button ID="Button1" runat="server" OnClick="showStadInfo" Text="View Stadium info" />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" OnClick="viewRequests" Text="View  Requests" />
    </form>
</body>
</html>
