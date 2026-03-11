using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using System.Linq;

namespace WebApplication2
{
    public partial class Search : System.Web.UI.Page
    {
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblError.Text = ""; 
            ActualizeazaDateSiGrafic();
        }

        protected void ddlChartType_SelectedIndexChanged(object sender, EventArgs e)
        {
            ActualizeazaDateSiGrafic();
        }

        private void ActualizeazaDateSiGrafic()
        {
            string searchTerm = txtSearchName.Text.Trim();

           
            if (string.IsNullOrEmpty(searchTerm))
            {
                lblError.Text = "⚠️ Te rugăm să introduci un nume pentru căutare.";
                return;
            }
            if (searchTerm.Any(char.IsDigit))
            {
                lblError.Text = "⚠️ Numele nu poate conține cifre!";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connString))
            {
                
                SqlCommand cmd = new SqlCommand("GetEventsByStudentNameWithCount", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchTerm", searchTerm);

                // Parametrul OUTPUT 
                SqlParameter outParam = new SqlParameter("@TotalEvents", SqlDbType.Int);
                outParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(outParam);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                try
                {
                    con.Open();
                    da.Fill(ds);

                    if (ds.Tables.Count > 0)
                    {
                       
                        string selectedType = ddlChartType.SelectedValue;
                        ChartLocatii.Series["Series1"].ChartType = (SeriesChartType)Enum.Parse(typeof(SeriesChartType), selectedType);

                        ChartLocatii.DataSource = ds.Tables[0];  //ds legat de table[0]
                        ChartLocatii.DataBind();

                        // --- 3. DATA BINDING GRIDVIEW 
                        gvResults.DataSource = ds.Tables[1]; 
                        gvResults.DataBind();

                        // PARAMETRU OUT ȘI APEL FUNCȚIE SCALARĂ 
                        int total = (outParam.Value != DBNull.Value) ? Convert.ToInt32(outParam.Value) : 0;
                        lblTotalCount.Text = total.ToString();

                        // fct sclara rank
                        lblRank.Text = GetRankFromDatabase(total, con);
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Eroare la baza de date: " + ex.Message;
                }
            }
        }

       
        private string GetRankFromDatabase(int total, SqlConnection con)
        {
            
            if (con.State != ConnectionState.Open) con.Open();

           
            SqlCommand cmdRank = new SqlCommand("SELECT dbo.GetStudentRank(@Total)", con);
            cmdRank.Parameters.AddWithValue("@Total", total);

            object result = cmdRank.ExecuteScalar();
            return result != null ? result.ToString() : "N/A";
        }
    }
}