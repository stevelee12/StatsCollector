using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;
using StatsLibrary.Models;

namespace StatsLibrary.BusinessLogic
{
    /// <summary>
    /// Middle layer to de-couple DB activity from front end. This class is called by the Controller
    /// </summary>
    public static class ReadingProcessor
    {

        /// <summary>
        /// Save new reading
        /// </summary>
        /// <param name="config"></param>
        /// <param name="deviceId"></param>
        /// <param name="metricId"></param>
        /// <param name="readingValue"></param>
        /// <param name="readingDateTime"></param>
        /// <returns></returns>
        public static int CreateReading(IConfiguration config, string deviceId, string metricId, string readingValue, DateTime readingDateTime)
        {
            string sql = @"EXEC usp_SaveReading @DeviceId, @MetricId, @ReadingValue, @ReadingDateTime";

            ReadingModel data = new ReadingModel()
            {
                DeviceId = deviceId,
                MetricId = metricId,
                ReadingValue = readingValue,
                ReadingDateTime = readingDateTime
            };

            return DataAccess.SqlDataAccess.SaveData<ReadingModel>(config, sql, data);
        }

        /// <summary>
        /// Load all readings. Debug only, should never make it to Production!
        /// </summary>
        /// <param name="config"></param>
        /// <returns></returns>
        public static List<ReadingModel> LoadAllReadings(IConfiguration config)
        {
            string sql = @"EXEC usp_LoadAllReadings";

            return DataAccess.SqlDataAccess.LoadData<ReadingModel>(config, sql);
        }

        /// <summary>
        /// Load 1 reading. Debug only, should never make it to Production!
        /// </summary>
        /// <param name="config"></param>
        /// <param name="readingId"></param>
        /// <returns></returns>
        public static List<ReadingModel> LoadReading(IConfiguration config, int readingId)
        {
            string sql = $@"EXEC usp_LoadReading @ReadingId='{readingId}'";

            return DataAccess.SqlDataAccess.LoadData<ReadingModel>(config, sql);
        }
    }
}
