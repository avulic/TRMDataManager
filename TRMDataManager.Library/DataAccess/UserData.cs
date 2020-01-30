using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TRMDataManager.Library.Internal.DataAccess;
using TRMDataManager.Library.Models;

namespace TRMDataManager.Library.DataAccess
{
    public class UserData
    {
        public List<UserModel> GetUserById(string Id)
        {
            SqlDataAcceess sql = new SqlDataAcceess();

            var p = new { Id = Id };

            var output = sql.LoadData<UserModel, dynamic>("dbo.apUserLookup", p, "TRMData");

            return output;
        }
    }
}
