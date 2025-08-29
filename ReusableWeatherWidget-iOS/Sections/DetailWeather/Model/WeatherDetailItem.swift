//
//  WeatherDetailItem.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import Foundation

struct WeatherDetailItem: Equatable {
    let name: String
    let timeLabel: String
    let temperature: String
    let temperatureUnit: String
    let shortDescription: String
    let description: String
    let wind: String
    let windDirection: String
    let rain: String
    let iconURL: URL?
    
    var temperatureLevel: TemperatureLevel {
        guard let fahrenheit = Double(temperature) else { return .cold }
        return TemperatureLevel.classify(fahrenheit)
    }
}

extension WeatherDetailItem {

    static func getMock(
        name: String = "San Francisco",
        timeLabel: String = "12:00 PM",
        temperature: String = "86",
        temperatureUnit: String = "°F",
        shortDescription: String = "Partly Cloudy",
        description: String = "Partly cloudy skies throughout the day.",
        wind: String = "12 mph",
        windDirection: String = "SW",
        rain: String = "0%",
        iconURL: URL = URL(string: "https://openweathermap.org/img/wn/02d@2x.png")!
    ) -> WeatherDetailItem {
        return .init(
            name: name,
            timeLabel: timeLabel,
            temperature: temperature,
            temperatureUnit: temperatureUnit,
            shortDescription: shortDescription,
            description: description,
            wind: wind,
            windDirection: windDirection,
            rain: rain,
            iconURL: iconURL
        )
    }
}

enum TemperatureLevel: String {
    case cold = "Cold"
    case warm = "Warm"
    case hot = "Hot"

    // Clasificación en Fahrenheit
    static func classify(_ fahrenheit: Double) -> TemperatureLevel {
        switch fahrenheit {
        case ..<68:       // < 20°C
            return .cold
        case 68..<86:     // 20–30°C
            return .warm
        default:          // ≥ 30°C
            return .hot
        }
    }
}
