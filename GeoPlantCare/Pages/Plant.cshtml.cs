using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using EdgeDB;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System;
using System.Text.Json.Serialization;
using System.Text;


namespace GeoPlantCare.Pages
{
    public class PlantModel : PageModel
    {
        private readonly ILogger<PlantModel> _logger;
        private readonly EdgeDBClient _client;
        public Plant Plantdetails { get; set; }

        public PlantModel(ILogger<PlantModel> logger, EdgeDBClient client)
        {
            _logger = logger;
            _client = client;
        }
        
        public async Task<IActionResult> OnGetPlantByIdAsync([FromQuery] Guid? id)
        {
            if(id == null)
            {
                return BadRequest("Id cannot be null");
            }       
            try
            {
                var plantDetails = await _client.QueryAsync<Plant>(@"
                
                        SELECT Plant {
                            id,
                            common_name,
                            botanical_name,
                            description,
                            bloom_time,
                            native_area,
                            min_temperature,
                            max_temperature,
                            toxicity,
                            care_guides :{
                                temperature_category, 
                                sun_exposure_ideal,
                                sun_exposure_tolerance,
                                water_frequnecy,
                                water_approach,
                                soil_type,
                                fertilizers
                            },
                            photos :{
                                url,
                                description
                            },
                            labels : {
                                winter_watering,
                                summer_watering,
                                spring_watering,
                                autumn_watering,
                                sun_exposure,
                                recommendation,
                                toxicity
                            }
                        }
                        FILTER .id = <uuid>$id
                    ", new Dictionary<string, object?> { { "id", id } });

                if (plantDetails == null || !plantDetails.Any())
                {
                    _logger.LogWarning("No plant found with id: {Id}", id);
                    return NotFound();
                }
                Plantdetails = plantDetails.First(); 
                return Page();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching plant details for id: {Id}", id);
                return StatusCode(500, "Internal server error");
            }
        }

        public string FormatEnum(string enumValue)
        {
            StringBuilder sb = new StringBuilder();
            foreach (char c in enumValue)
            {
                if (char.IsUpper(c) && sb.Length > 0)
                    sb.Append(' ');
                sb.Append(c);
            }
            return sb.ToString();
        }


    }

    
    public class Plant
    {
        public Guid Id { get; set; }
        public string CommonName { get; set; }
        public string BotanicalName { get; set; }
        public string Description { get; set; }
        public BloomTime BloomTime { get; set; }
        public List<NativeArea> NativeArea { get; set; }
        public List<PlantCareGuide> CareGuides { get; set; }
        public int MinTemperature { get; set; }
        public int MaxTemperature { get; set; }
        public List<Toxicity> Toxicity { get; set; }
        public List<PlantPhotoGallery> Photos { get; set; }
        public PlantLabel Labels { get; set; }
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum BloomTime
    {
        Summer,
        Spring,
        Winter,
        Autumn, 
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum NativeArea
    {
        Europe,
        Asia,
        SouthAfrica,
        SouthAmerica,
        Australia
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum TemperatureCategory
    {
        BelowTemperature,
        WithinRange,
        AboveTemperature
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum WaterFrequency
    {
        Daily,
        TwiceAweek,
        OnceAWeek,
        TwiceAMonth,
        OnceAMonth
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum WateringSchedule
    {
        Daily,
        OnceAWeek,
        TwiceAWeek,
        OnceAMonth
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum SunExposure
    {
        FullSunIdeal,
        PartialSunIdeal,
        FullShadeIdeal,
        FullSunTolerance,
        PartialSunTolerance,
        FullShadeTolerance
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum Recommendation
    {
        Recommended,
        NotRecommended
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum Toxicity
    {
        ToxicToAnimals,
        ToxicToHumans,
        NonToxic
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]

    public enum SoilType
    {
        WellDrained,
        Moist,
        Rich,
        Sand,
        Clay,
        Loam,
        Chalky,
        Silt,
        Peat
    }


    public class PlantCareGuide
    {
        public TemperatureCategory TemperatureCategory { get; set; }
        public SunExposure SunExposureIdeal { get; set; }
        public SunExposure SunExposureTolerance { get; set; }
        public WaterFrequency WaterFrequency { get; set; }
        public string WaterApproach { get; set; }
        public List<SoilType> SoilType { get; set; }
        public string Fertilizers { get; set; }
    }

    public class PlantPhotoGallery
    {
        public List<string> Url { get; set; }
        public string Description { get; set; }
    }

    public class PlantLabel
    {
        public WateringSchedule WinterWatering { get; set; }
        public WateringSchedule SummerWatering { get; set; }
        public WateringSchedule SpringWatering { get; set; }
        public WateringSchedule AutumnWatering { get; set; }
        public SunExposure SunExposure { get; set; }
        public Recommendation Recommendation { get; set; }
        public List<Toxicity> Toxicity { get; set; }
    }
}
