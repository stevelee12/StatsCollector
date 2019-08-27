using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using StatsApi.Models;
using StatsLibrary.BusinessLogic;
using StatsLibrary.Models;

namespace StatsAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReadingController : ControllerBase
    {

        private IConfiguration config;

        /// <summary>
        /// Controller used to persist readings taken. Get and Get all used for Debug Only
        /// </summary>
        /// <param name="configuration"></param>
        public ReadingController(IConfiguration configuration)
        {
            config = configuration;
        }

        
        /// <summary>
        /// Get all readings - Debug purposes only
        /// </summary>
        /// <returns></returns>
        // GET: api/values
        [HttpGet]
        public List<ReadingModel> Get()
        {
            return ReadingProcessor.LoadAllReadings(config);
        }

        /// <summary>
        /// Get by Id - Debug purposes only
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        // GET: api/values/5
        [HttpGet("{id}", Name = "Get")]
        public List<ReadingModel> Get(int id)
        {
            return ReadingProcessor.LoadReading(config, id);
        }

        /// <summary>
        /// Persist a recording to datastore
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        // POST api/values
        [HttpPost]
        public ActionResult<string> Post(ReadingModelInput data)
        {
            int iRowsAffected = ReadingProcessor.CreateReading(config, data.DeviceId, data.MetricId, data.ReadingValue, data.ReadingDateTime);
            return Ok($"Rows affected: {iRowsAffected}");
        }

    }
}