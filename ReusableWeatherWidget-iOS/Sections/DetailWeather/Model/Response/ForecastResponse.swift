//
//  ForecastResponse.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import Foundation

struct ForecastResponse: Decodable {
    let properties: ForecastPropertiesResponse
}

struct ForecastPropertiesResponse: Decodable {
    let periods: [PeriodResponse]
}

struct PeriodResponse: Decodable {
    let number: Int
    let name: String
    let startTime: String
    let endTime: String
    let isDaytime: Bool
    let temperature: Int
    let temperatureUnit: String
    let temperatureTrend: String?
    let probabilityOfPrecipitation: ProbabilityResponse
    let windSpeed: String
    let windDirection: String
    let icon: URL
    let shortForecast: String
    let detailedForecast: String
}

struct ProbabilityResponse: Decodable {
    let unitCode: String
    let value: Int?
}

extension PeriodResponse {

    static func getMock(
        number: Int = 1,
        name: String = "Monday",
        startTime: String = "2025-07-23T06:00:00-05:00",
        endTime: String = "2025-07-23T18:00:00-05:00",
        isDaytime: Bool = true,
        temperature: Int = 30,
        temperatureUnit: String = "C",
        temperatureTrend: String? = nil,
        probabilityOfPrecipitation: ProbabilityResponse = .init(unitCode: "wmoUnit:percent", value: 50),
        windSpeed: String = "10 km/h",
        windDirection: String = "NW",
        icon: URL = URL(string: "https://icon.url")!,
        shortForecast: String = "Sunny",
        detailedForecast: String = "Clear sky"
    ) -> PeriodResponse {
        .init(
            number: number,
            name: name,
            startTime: startTime,
            endTime: endTime,
            isDaytime: isDaytime,
            temperature: temperature,
            temperatureUnit: temperatureUnit,
            temperatureTrend: temperatureTrend,
            probabilityOfPrecipitation: probabilityOfPrecipitation,
            windSpeed: windSpeed,
            windDirection: windDirection,
            icon: icon,
            shortForecast: shortForecast,
            detailedForecast: detailedForecast
        )
    }
}
