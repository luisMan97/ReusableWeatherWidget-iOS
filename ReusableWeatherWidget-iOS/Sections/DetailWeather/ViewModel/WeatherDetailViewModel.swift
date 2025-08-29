//
//  WeatherDetailViewModel.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import Foundation
import Observation
import RequestManager

enum ProductsViewState: Equatable {
    case loading
    case error(String)
    case loaded(WeatherDetailItem?)
}

@Observable
class WeatherDetailViewModel {

    let apiManager: APIManagerProtocol
    var viewState: ProductsViewState = .loading

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }

    @MainActor
    func getWeather() async {
        do {
            let weather: WeatherResponse = try await apiManager.request(service: .weather)
            try await getForecastDetail(weather: weather)
        } catch {
            viewState = .error(error.localizedDescription)
            ServiceLogger.debugError(error)
        }
    }
}

private extension WeatherDetailViewModel {

    @MainActor
    func getForecastDetail(weather: WeatherResponse) async throws {
        let forecast: ForecastResponse = try await apiManager.request(service: .customURL(weather.properties.forecast))
        viewState = .loaded(
            getForecastIem(
                weather: weather,
                forecast: forecast
            )
        )
    }

    func getForecastIem(
        weather: WeatherResponse,
        forecast: ForecastResponse
    ) -> WeatherDetailItem? {
        guard let period = forecast.properties.periods.first else { return nil }

        return .init(
            name: "\(weather.properties.relativeLocation.properties.city), \(weather.properties.relativeLocation.properties.state)",
            timeLabel: period.name,
            temperature: "\(period.temperature)",
            temperatureUnit: period.temperatureUnit,
            shortDescription: period.shortForecast,
            description: period.detailedForecast,
            wind: period.windSpeed,
            windDirection: period.windDirection,
            rain: "\(Int(period.probabilityOfPrecipitation.value ?? 0))% rain",
            iconURL: period.icon
        )
    }
}
