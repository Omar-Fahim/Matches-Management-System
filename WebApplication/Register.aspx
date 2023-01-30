<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication1.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Who are you?" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <asp:Button ID="samB" runat="server" OnClick="sam" Text="Sports Association Manager" />
        <br />
        <br />
        <asp:Button ID="crB" runat="server" OnClick="cr" Text="Club Representative" />
        <br />
        <br />
        <asp:Button ID="smB" runat="server" OnClick="sm" Text="Stadium Manager" />
        <br />
        <br />
        <asp:Button ID="fanB" runat="server" OnClick="fan" Text="Fan" />
    </form>
</body>
</html>
