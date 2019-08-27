using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Dapper;
using System.Linq;

namespace StatsLibrary.DataAccess
{
    /// <summary>
    /// Static class used to store data into a SQL Database. Config is passed to each method to specify where data is saved
    /// </summary>
    public static class SqlDataAccess
    {


        /// <summary>
        /// Allows 1 unique place to put the hardcoded connection name rather than in each of load/save data methods
        /// </summary>
        /// <param name="config"></param>
        /// <returns></returns>
        private static string GetConnectionString(IConfiguration config)
        {
            return config.GetConnectionString("connSql");
        }

        /// <summary>
        /// Retrieve data from the DB, maps to a List of Type T passed when calling the method
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="config"></param>
        /// <param name="sql"></param>
        /// <returns></returns>
        public static List<T> LoadData<T>(IConfiguration config, string sql)
        {
            using (IDbConnection cnn = new SqlConnection(GetConnectionString(config)))
            {
                return cnn.Query<T>(sql).ToList();
            }
        }

        /// <summary>
        /// Persist data into the DB by passing the sql command and Type T
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="config"></param>
        /// <param name="sql"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public static int SaveData<T>(IConfiguration config, string sql, T data)
        {
            using (IDbConnection cnn = new SqlConnection(GetConnectionString(config)))
            {
                return cnn.Execute(sql, data);
            }
        }

    }
}