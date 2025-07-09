// Ignore Spelling: Auth
// Title: AuthService
// Author: Ahmed Ibrahim
// Date: 2025-07-09
// Description: Handles user authentication logic against the Users table

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VMS.Data;

namespace VMS.Services
{
    public static class AuthService
    {
        public static bool Authenticate(string username, string password, out string role)
        {
            role = null;

            string query = @"SELECT Role FROM Users 
                             WHERE Username = @Username AND PasswordHash = @Password AND IsActive = 1";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@Username", username),
                new SqlParameter("@Password", password)
            };

            DataTable result = DbHelper.ExecuteQuery(query, parameters);

            if (result.Rows.Count == 1)
            {
                role = result.Rows[0]["Role"].ToString();
                return true;
            }

            return false;
        }
    }
}
