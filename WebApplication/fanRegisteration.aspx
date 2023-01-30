<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fanRegisteration.aspx.cs" Inherits="WebApplication1.fanRegisteration" %>

<!DOCTYPE html>
<script runat="server">

    protected void register(object sender, EventArgs e)
    {

    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: auto; margin-right: auto; text-align: center;">
    <asp:Label ID="Label3" runat="server" Text="Fan Registeration" Font-Bold="true" Font-Size="X-Large"
        CssClass="StrongText"></asp:Label>
</div>
        <p>
            Please register below:</p>
        <p>
            (Note: All fields are required)</p>
        <p>
            Name:</p>
        <asp:TextBox ID="yessirname" runat="server"></asp:TextBox>
        <p>
            Username:</p>
        <p>
            <asp:TextBox ID="Username" runat="server"></asp:TextBox>
        </p>
        <p>
            Password:</p>
        <p>
            <asp:TextBox ID="Password" runat="server"></asp:TextBox>
        </p>
        <p>
            National ID number:</p>
        <p>
            <asp:TextBox ID="National_ID_Number" runat="server"></asp:TextBox>
        </p>
        <p>
            Phone number:</p>
        <p>
            <asp:TextBox ID="Phone_Number" runat="server"></asp:TextBox>
        </p>
        <p>
            &nbsp;<label for="Endtime">Birth date (DD/MM/YYYY): <br /> 
                  </label>
            <input id ="Endtime" type="datetime-local" runat="server"/>
        </p>
        <p>
            Address:</p>
        <p>
            <asp:TextBox ID="Address" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Register" />
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
