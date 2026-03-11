<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="WebApplication2.Student" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Students</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; padding: 20px; }
        .container { width: 1100px; margin: 0 auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .section { margin-bottom: 30px; }
        h3 { color: #333; border-bottom: 2px solid #507CD1; padding-bottom: 10px; margin-bottom: 20px; }
        .footer-input { width: 95%; padding: 5px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .footer-button { padding: 6px 15px; cursor: pointer; background-color: #507CD1; color: white; border: none; border-radius: 4px; font-weight: bold; }
        .footer-button:hover { background-color: #3e61a8; }
        .error-msg { color: #d9534f; font-size: 11px; display: block; margin-top: 2px; }
        .action-col { width: 130px; text-align: center; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
   
        <script runat="server">
            protected void Page_Load(object sender, EventArgs e) {
                this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            }
        </script>

        <div class="container">
            <div class="section">
                <h3>Filter & Operations</h3>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSourceFaculty" DataTextField="Faculty" 
                    DataValueField="Faculty" AppendDataBoundItems="True">
                    <asp:ListItem Value="">All Faculties</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="section">
                <h3>Student Records</h3>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource2" 
                    AutoGenerateColumns="False" DataKeyNames="Id" CellPadding="10" 
                    ForeColor="#333333" GridLines="None" Width="100%" AllowPaging="True" AllowSorting="True" ShowFooter="True">
                    
                    <Columns>
                        <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="action-col">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" />
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Sigur dorești ștergerea?');" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Update" />
                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" />
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Add New" CssClass="footer-button" ValidationGroup="vgAdd" />
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate><%# Eval("Id") %></ItemTemplate>
                            <ItemStyle Width="50px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="First Name">
                            <ItemTemplate><%# Eval("FirstName") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FirstName") %>' CssClass="footer-input"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" CssClass="footer-input" placeholder="First Name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="TextBox7" ErrorMessage="Nume lipsă" ForeColor="Red" Text="*" ValidationGroup="vgAdd" Display="Dynamic" />
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Last Name">
                            <ItemTemplate><%# Eval("LastName") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("LastName") %>' CssClass="footer-input"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" CssClass="footer-input" placeholder="Last Name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="TextBox8" ErrorMessage="Prenume lipsă" ForeColor="Red" Text="*" ValidationGroup="vgAdd" Display="Dynamic" />
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate><%# Eval("Email") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Email") %>' CssClass="footer-input"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" CssClass="footer-input" placeholder="Email"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv3" runat="server" ControlToValidate="TextBox9" ErrorMessage="Email lipsă" ForeColor="Red" Text="*" ValidationGroup="vgAdd" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="rev1" runat="server" ControlToValidate="TextBox9" ErrorMessage="Email invalid (@ lipsă)" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error-msg" ValidationGroup="vgAdd" Display="Dynamic" />
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Phone">
                            <ItemTemplate><%# Eval("Phone") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Phone") %>' CssClass="footer-input"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox10" runat="server" CssClass="footer-input" placeholder="Phone"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv4" runat="server" ControlToValidate="TextBox10" ErrorMessage="Telefon lipsă" ForeColor="Red" Text="*" ValidationGroup="vgAdd" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="rev2" runat="server" ControlToValidate="TextBox10" ErrorMessage="Minim 10 cifre" ValidationExpression="^\d{10,}$" CssClass="error-msg" ValidationGroup="vgAdd" Display="Dynamic" />
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Faculty">
                            <ItemTemplate><%# Eval("Faculty") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Faculty") %>' CssClass="footer-input"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="TextBox11" runat="server" CssClass="footer-input" placeholder="Faculty"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv5" runat="server" ControlToValidate="TextBox11" ErrorMessage="Facultate lipsă" ForeColor="Red" Text="*" ValidationGroup="vgAdd" Display="Dynamic" />
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Year">
                            <ItemTemplate><%# Eval("YearOfStudy") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("YearOfStudy") %>' Width="40px"></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="footer-input">
                                    <asp:ListItem>1</asp:ListItem><asp:ListItem>2</asp:ListItem><asp:ListItem>3</asp:ListItem>
                                </asp:DropDownList>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EFF3FB" />
                    <AlternatingRowStyle BackColor="White" />
                    <FooterStyle BackColor="#D1E0FF" />
                </asp:GridView>

               
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vgAdd" ForeColor="Red" HeaderText="Corectează erorile:" />
            </div>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT * FROM Students WHERE (@Faculty = '' OR Faculty = @Faculty)"
                UpdateCommand="UPDATE Students SET FirstName=@FirstName, LastName=@LastName, Email=@Email, Phone=@Phone, Faculty=@Faculty, YearOfStudy=@YearOfStudy WHERE Id=@Id"
                DeleteCommand="DELETE FROM Students WHERE Id=@Id"
                InsertCommand="INSERT INTO Students (FirstName, LastName, Email, Phone, Faculty, YearOfStudy) VALUES (@FirstName, @LastName, @Email, @Phone, @Faculty, @YearOfStudy)">
                <SelectParameters>
                    <asp:ControlParameter Name="Faculty" ControlID="DropDownList1" PropertyName="SelectedValue" Type="String" ConvertEmptyStringToNull="false" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="FirstName" Type="String" /><asp:Parameter Name="LastName" Type="String" /><asp:Parameter Name="Email" Type="String" /><asp:Parameter Name="Phone" Type="String" /><asp:Parameter Name="Faculty" Type="String" /><asp:Parameter Name="YearOfStudy" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            
            <asp:SqlDataSource ID="SqlDataSourceFaculty" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT Faculty FROM Students"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>