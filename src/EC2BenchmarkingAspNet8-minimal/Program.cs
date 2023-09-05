// ASP.NET Core (on .NET 7) used for performance testing under load
using EC2BenchmarkingAspnet7;
using Microsoft.Extensions.Primitives;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

var app = WebApplication.Create(args);
var platform = new StringValues(string.Format(
    "{0} on {1}",
    Environment.Version.ToString(),
    RuntimeInformation.ProcessArchitecture.ToString()));

//create 100 weather forecasts and persist to in-memory EFCore db
var summaries = new[] { "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching" };
var rng = new Random();

var weatherArray = Enumerable.Range(1, 100).Select(index =>
    new WeatherForecast(
        DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
        rng.Next(-20, 55),
        summaries[rng.Next(summaries.Length)]
    ));

using (var context = new WeatherContext())
{
    context.WeatherForecasts.AddRange(weatherArray);
    context.SaveChanges();
}


app.MapGet("/weatherforecast", (int? count, HttpResponse response) =>
{
    List<WeatherForecast> forecasts;

    using (var context = new WeatherContext())
    {
        forecasts = context.WeatherForecasts.Take(count ?? 100).ToList();
    }

    UnicodeEncoding ByteConverter = new();

    using (RSACryptoServiceProvider RSA = new())
    {
        Parallel.ForEach(forecasts, x => x.EncryptedSummary = Encryptor.RSAEncrypt(ByteConverter.GetBytes(x.Summary), RSA.ExportParameters(false), false));
    }

    response.Headers.Add("Platform", platform);
    return forecasts;
});

app.MapGet("/jsonserialize", async (int? count, HttpResponse response) =>
{
    List<WeatherForecast> forecasts;
    List<string> jsons = new(count ?? 100);

    using (var context = new WeatherContext())
    {
        forecasts = context.WeatherForecasts.Take(count ?? 100).ToList();
    }

    await Task.Delay(3);
    Parallel.ForEach(forecasts, x => jsons.Add(JsonSerializer.Serialize(x)));

    response.Headers.Add("Platform", platform);
    return jsons;
});

app.Run();

