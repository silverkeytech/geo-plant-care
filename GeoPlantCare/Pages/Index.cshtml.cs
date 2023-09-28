using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using EdgeDB;

namespace GeoPlantCare.Pages;

public class IndexModel : PageModel
{
    private readonly ILogger<IndexModel> _logger;
    private readonly EdgeDBClient _client;

    public IndexModel(ILogger<IndexModel> logger, EdgeDBClient client)
    {
        _logger = logger;
        _client = client;
    }

    public List<Plant> Plants { get; set; }
    public async Task<IActionResult> OnGetUserRecommendedPlantsAsync(int userTemperature)
    {
        var parameters = new Dictionary<string, object>
        {
            { "userTemperature", (short)userTemperature }
        };
        var plants = await _client.QueryAsync<Plant>(@"
            SELECT Plant {
                id,
                common_name,
                botanical_name,
                photos: {
                    url
                }
            }
            FILTER .min_temperature <= <int16>$userTemperature AND .max_temperature >= <int16>$userTemperature
        ", parameters);

        return new JsonResult(plants);
    }

}




