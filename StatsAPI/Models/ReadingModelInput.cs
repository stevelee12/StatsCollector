using System;

namespace StatsApi.Models
{
    /// <summary>
    /// This class is used to accept input via the API and turn it into a ReadingModel for the datastore
    /// </summary>
    public class ReadingModelInput
    {

        /// <summary>
        /// This is the GUID of the device we're collecting information on i.e. motherboard, fan, hdd etc. 
        /// This is unique per individual device regardless of the type of device
        /// </summary>
        public string DeviceId { get; set; }

        /// <summary>
        /// This is the GUID of the metric we're measuring, used to identify what the reading is about i.e. temperature, free disk space etc.
        /// </summary>
        public string MetricId { get; set; }

        /// <summary>
        /// This is the actual reading i.e. temperature recorded, Mb's free etc.
        /// </summary>
        public string ReadingValue { get; set; }
        
        /// <summary>
        /// This is the datetime the recording was taken
        /// </summary>
        public DateTime ReadingDateTime { get; set; } = System.DateTime.Now;

    }
}
