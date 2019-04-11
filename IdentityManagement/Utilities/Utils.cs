using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace IdentityManagement.Utilities
{
    public class Utils
    {
        public static string ConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        }

        public static bool IfUserAuthenticated()
        {
            return HttpContext.Current.User.Identity.IsAuthenticated;
        }

        public static bool IsUserInRole(string roleName)
        {
            if (IfUserAuthenticated())
            {
                return HttpContext.Current.User.IsInRole(roleName);
            }
            return false;
        }

    }
}
