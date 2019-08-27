using System;

namespace StatsLibrary.Models
{
    public class ReadingModel : IReadingModel
    {

        public int Id { get; set; }
        public string DeviceId { get; set; }
        public string MetricId { get; set; }
        public string ReadingValue { get; set; }
        public DateTime ReadingDateTime { get; set; } = System.DateTime.Now;


    }
}
