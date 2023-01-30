<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="availableStadiums.aspx.cs" Inherits="WebApplication1.availableStadiums" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 289px;
        }
        #Endtime {
            margin-left: 0px;
        }
    </style>
</head>
<body style="height: 231px">
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Please Select a Date:"></asp:Label>
        &nbsp;<br />
        <br />
        <input id = "Endtime" type ="datetime-local" runat ="server" /><br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
    </form>
</body>
</html>
