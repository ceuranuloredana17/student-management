<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="WebApplication2.Search" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard Analitic Voluntari</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f7f6; padding: 30px; }
        .search-container { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 1100px; margin: auto; }
        .header { color: #507CD1; border-bottom: 2px solid #507CD1; margin-bottom: 20px; padding-bottom: 10px; text-align: center; }
        .search-controls { margin-bottom: 20px; display: flex; justify-content: center; align-items: center; gap: 15px; background: #fafafa; padding: 15px; border-radius: 8px; }
        .stats-panel { display: flex; justify-content: space-around; background-color: #eef2fa; padding: 15px; border-radius: 6px; margin-bottom: 20px; border-left: 5px solid #507CD1; }
        .content-layout { display: flex; gap: 20px; flex-wrap: wrap; justify-content: center; }
        .grid-style { flex: 1; min-width: 450px; border-collapse: collapse; background: white; }
        .grid-style th { background-color: #507CD1; color: white; padding: 10px; }
        .grid-style td { padding: 10px; border-bottom: 1px solid #ddd; }
        .chart-box { flex: 0 0 420px; background: #fff; border: 1px solid #eee; padding: 15px; border-radius: 8px; text-align: center; }
        .text-input { padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .btn-search { padding: 8px 25px; background-color: #507CD1; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .error-msg { color: #d9534f; font-weight: bold; display: block; margin-bottom: 10px; text-align: center; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <script runat="server">
            protected void Page_Load(object sender, EventArgs e) {
                this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            }
        </script>

        <div class="search-container">
            <h2 class="header">📊 Monitorizare și Analiză Participări</h2>
            
            <asp:Label ID="lblError" runat="server" CssClass="error-msg" Text=""></asp:Label>

            <div class="search-controls">
                <span>Nume Student:</span>
                <asp:TextBox ID="txtSearchName" runat="server" CssClass="text-input" placeholder="Ex: Popescu"></asp:TextBox>
                
                <span>Tip Vizualizare:</span>
                <asp:DropDownList ID="ddlChartType" runat="server" CssClass="text-input" AutoPostBack="true" OnSelectedIndexChanged="ddlChartType_SelectedIndexChanged">
                    <asp:ListItem Text="Coloane (Bars)" Value="Column" />
                    <asp:ListItem Text="Linii (Line)" Value="Line" />
                    <asp:ListItem Text="Plăcintă (Pie)" Value="Pie" />
                </asp:DropDownList>

                <asp:Button ID="btnSearch" runat="server" Text="Generează Raport" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <div class="stats-panel">
                <div><strong>Participări Totale:</strong> <asp:Label ID="lblTotalCount" runat="server" Text="0" Font-Bold="true" ForeColor="#507CD1"></asp:Label></div>
                <div><strong>Status Voluntar:</strong> <asp:Label ID="lblRank" runat="server" Text="-" Font-Bold="true" ForeColor="#28a745"></asp:Label></div>
            </div>

            <div class="content-layout">
                <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="False" CssClass="grid-style" EmptyDataText="Nu s-au găsit date pentru acest student.">
                    <Columns>
                        <asp:TemplateField HeaderText="Voluntar">
                            <ItemTemplate><%# Eval("FirstName") %> <%# Eval("LastName") %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="EventName" HeaderText="Eveniment" />
                        <asp:BoundField DataField="EventDate" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Location" HeaderText="Locație" />
                    </Columns>
                </asp:GridView>

                <div class="chart-box">
                    <h4 style="margin-top:0;">Analiză Distribuție Locații</h4>
                    <asp:Chart ID="ChartLocatii" runat="server" Width="380px" Height="300px">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="Location" YValueMembers="NrEvenimente" 
                                IsValueShownAsLabel="true" Font="Bold, 10px"></asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" Inclination="15" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Bottom"></asp:Legend>
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
        </div>
    </form>
</body>
</html>