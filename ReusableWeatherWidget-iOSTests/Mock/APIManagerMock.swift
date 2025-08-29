//
//  APIManagerMock.swift
//  ReusableWeatherWidget-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 24/07/25.
//

import Foundation
import RequestManager
@testable import ReusableWeatherWidget_iOS

final class APIManagerMock: APIManagerProtocol {

    let storage = PeriodStorage()

    func request<T>(service: APIRouter) async throws -> T where T : Decodable {
        if await storage.shouldFail {
            throw URLError(.badServerResponse)
        }

        switch service {
        case .weather:
            let response = WeatherResponse(
                properties: PropertiesResponse(
                    forecast: URL(string: "https://test.com/forecast")!,
                    relativeLocation: .init(
                        properties: .init(
                            city: "Test City",
                            state: "Test State"
                        )
                    )
                )
            )
            return response as! T
        case .customURL:
            let properties = if let periodResponse = await storage.periodResponse {
                ForecastPropertiesResponse(periods: [periodResponse])
            } else {
                ForecastPropertiesResponse(periods: [])
            }
            let forecast = ForecastResponse(
                properties: properties
            )
            return forecast as! T
        }
    }
}

extension APIManagerMock {

    actor PeriodStorage {
        private(set) var periodResponse: PeriodResponse?
        private(set) var shouldFail = false

        func setPeriodResponse(_ response: PeriodResponse?) {
            self.periodResponse = response
        }

        func setShouldFail(_ value: Bool) {
            self.shouldFail = value
        }
    }
}
