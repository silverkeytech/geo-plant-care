// using System.Net.Http;
// using System.Text.Json;
// using System.Threading.Tasks;
// using Microsoft.AspNetCore.Mvc;
// using Microsoft.AspNetCore.Mvc.RazorPages;
// using Microsoft.Extensions.Configuration;

// public class LayoutModel : PageModel
// {
//     private readonly IHttpClientFactory _clientFactory;
//     private readonly IConfiguration _configuration;

//     public LayoutModel(IHttpClientFactory clientFactory, IConfiguration configuration)
//     {
//         _clientFactory = clientFactory;
//         _configuration = configuration;
//     }

//     public void OnGet()
//     {
//     }

//     public async Task<IActionResult> OnGetUserLocation(double lat, double lng)
//     {
//         var googleApiKey = _configuration["Google:ApiKey"];
//         var client = _clientFactory.CreateClient();
//         var response = await client.GetStringAsync($"https://maps.googleapis.com/maps/api/geocode/json?latlng={lat},{lng}&key={googleApiKey}");
//         var data = JsonSerializer.Deserialize<object>(response);
//         return new JsonResult(data);
//     }

//     public async Task<IActionResult> OnGetWeatherData(double lat, double lng)
//     {
//         var openWeatherApiKey = _configuration["OpenWeather:ApiKey"];
//         var client = _clientFactory.CreateClient();
//         var response = await client.GetStringAsync($"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lng}&appid={openWeatherApiKey}&units=metric");
//         var data = JsonSerializer.Deserialize<object>(response);
//         return new JsonResult(data);
//     }
// }
