using System;

namespace StatsLibrary.Models
{
    public interface IReadingModel
    {
        string DeviceId { get; set; }
        int Id { get; set; }
        string MetricId { get; set; }
        DateTime ReadingDateTime { get; set; }
        string ReadingValue { get; set; }
    }
}