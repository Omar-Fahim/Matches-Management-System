<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="smRegisteration.aspx.cs" Inherits="WebApplication1.smRegisteration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Stadium Manager Registeration" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
         <asp:Label ID="Label4" runat="server" Text="Enter Your name :"></asp:Label>
         <br />
         <asp:TextBox ID="smName" runat="server"></asp:TextBox>
         <br />
         <asp:Label ID="Label5" runat="server" Text="Enter you username :"></asp:Label>
         <br />
         <asp:TextBox ID="smUserName" runat="server"></asp:TextBox>
         <br />
         <asp:Label ID="Label6" runat="server" Text="Enter your Password :"></asp:Label>
         <br />
         <asp:TextBox ID="smPass" runat="server"></asp:TextBox>
         <br />
         <asp:Label ID="Label7" runat="server" Text="Enter the Stadium Name :"></asp:Label>
         <br />
         <asp:TextBox ID="sSName" runat="server"></asp:TextBox>
         <br />
         <br />
         <asp:Button ID="Button1" runat="server" OnClick="done" Text="done" />
         <br />
    </form>
</body>
</html>
