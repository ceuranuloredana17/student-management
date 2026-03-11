<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="WebApplication2.Students" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Students</title>
</head>

<body>
    <form id="form1" runat="server">

        <asp:GridView 
        ID="GridViewStudents" 
        runat="server">
        </asp:GridView>

    </form>
</body>
</html>