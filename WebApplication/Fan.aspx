<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="WebApplication1.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br /> <label style="margin:0px 0px 20px 100px;" for="Endtime">Enter a Match Date (DD/MM/YYYY):  <br /> 
                  </label>
            <input id ="Endtime" type="datetime-local" style="margin:0px 0px 20px 100px;" runat="server"/>
            <br />
        </div>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Check matches" OnClick="Button1_Click" style="margin:0px 0px 0px 100px;" />
        <br />
    </form>
</body>
</html>
