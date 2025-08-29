//
//  WeatherResponse.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let properties: PropertiesResponse
}

struct PropertiesResponse: Decodable {
    let forecast: URL
    let relativeLocation: RelativeLocationResponse
}

struct RelativeLocationResponse: Decodable {
    let properties: PropertiesRelativeLocationResponse
}

struct PropertiesRelativeLocationResponse: Decodable {
    let city: String
    let state: String
}
