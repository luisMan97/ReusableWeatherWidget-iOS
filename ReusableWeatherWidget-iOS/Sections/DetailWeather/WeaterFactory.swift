//
//  WeatherFactory.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import Foundation
import RequestManager

enum WeatherFactory {

    @MainActor static func getWeatherView() -> WeatherDetailView {
        let apiManager = APIManager()
        let viewModel = WeatherDetailViewModel(apiManager: apiManager)
        return .init(viewModel: viewModel)
    }
}
