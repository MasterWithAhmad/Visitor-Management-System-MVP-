// Ignore Spelling: Auth

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using VMS.Services;

namespace VMS.Forms.Auth
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (AuthService.Authenticate(username, password, out string role))
            {
                MessageBox.Show($"Welcome, {username}! Your role is {role}.");
                // Open MainForm or Dashboard here
            }
            else
            {
                MessageBox.Show("Invalid credentials or inactive user.", "Login Failed", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }
    }
}
