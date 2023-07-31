namespace EC2BenchmarkingAspnet7
{
    public record WeatherForecast(DateOnly Date, int TemperatureC, string Summary)
    {
        public Guid WeatherForecastId { get; set; } = Guid.NewGuid();

        public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);

        public byte[]? EncryptedSummary { get; set; }
    }
}
