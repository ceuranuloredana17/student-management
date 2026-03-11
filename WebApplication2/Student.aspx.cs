using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            if (DropDownList1.SelectedValue == "students")
            {
                GridView1.DataSourceID = "SqlDataSource2";
            }
            else if (DropDownList1.SelectedValue == "events")
            {
                GridView1.DataSourceID = "SqlDataSourceEvents";
            }

           
            GridView1.DataBind();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {

            GridViewRow footerRow = GridView1.FooterRow;
            if (!Page.IsValid) return;

            if (footerRow != null)
            {
                try
                {
                    
                    string fName = ((TextBox)footerRow.FindControl("TextBox7")).Text;
                    string lName = ((TextBox)footerRow.FindControl("TextBox8")).Text;
                    string email = ((TextBox)footerRow.FindControl("TextBox9")).Text;
                    string phone = ((TextBox)footerRow.FindControl("TextBox10")).Text;
                    string faculty = ((TextBox)footerRow.FindControl("TextBox11")).Text;
                    string year = ((DropDownList)footerRow.FindControl("DropDownList2")).SelectedValue;

                    //  Atribuim valorile parametrilor de Insert ai SqlDataSource2
                    SqlDataSource2.InsertParameters["FirstName"].DefaultValue = fName;
                    SqlDataSource2.InsertParameters["LastName"].DefaultValue = lName;
                    SqlDataSource2.InsertParameters["Email"].DefaultValue = email;
                    SqlDataSource2.InsertParameters["Phone"].DefaultValue = phone;
                    SqlDataSource2.InsertParameters["Faculty"].DefaultValue = faculty;
                    SqlDataSource2.InsertParameters["YearOfStudy"].DefaultValue = year;

              
                    SqlDataSource2.Insert();

                    //  noul rând imediat
                    GridView1.DataBind();
                }
                catch (Exception ex)
                {

                    Response.Write("<script>alert('Eroare la adăugare: " + ex.Message + "');</script>");
                }
            }
        }
    }
}