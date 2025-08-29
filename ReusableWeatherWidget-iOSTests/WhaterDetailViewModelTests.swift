//
//  WhaterDetailViewModelTests.swift
//  ReusableWeatherWidget-iOSTests
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import Testing
@testable import ReusableWeatherWidget_iOS
import Foundation

struct WhaterDetailViewModelTests {

    @Test func testGetWeatherSuccess() async throws {
        // Given
        let apiManagerMock = APIManagerMock()
        await apiManagerMock.storage.setPeriodResponse(.getMock())
        let viewModel = WeatherDetailViewModel(apiManager: apiManagerMock)
        // When
        await viewModel.getWeather()
        // Then
        if case let .loaded(item?) = viewModel.viewState {
            #expect(item.temperature == "30")
        }
    }

    @Test func testGetWeatherSuccessWithoutPeriods() async throws {
        // Given
        let apiManagerMock = APIManagerMock()
        await apiManagerMock.storage.setPeriodResponse(nil)
        let viewModel = WeatherDetailViewModel(apiManager: apiManagerMock)
        // When
        await viewModel.getWeather()
        // Then
        if case let .loaded(item) = viewModel.viewState {
            #expect(item == nil)
        }
    }

    @Test func testGetWeatherError() async throws {
        // Given
        let apiManagerMock = APIManagerMock()
        await apiManagerMock.storage.setShouldFail(true)
        let viewModel = WeatherDetailViewModel(apiManager: apiManagerMock)
        // When
        await viewModel.getWeather()
        // Then
        if case let .error(message) = viewModel.viewState {
            #expect(message.contains("The operation couldn’t be completed."))
        }
    }
}
