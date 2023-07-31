using Microsoft.EntityFrameworkCore;

namespace EC2BenchmarkingAspnet7
{
    public class WeatherContext : DbContext
    {
        public DbSet<WeatherForecast> WeatherForecasts { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
            => options.UseInMemoryDatabase("forecastdb");
    }
}
