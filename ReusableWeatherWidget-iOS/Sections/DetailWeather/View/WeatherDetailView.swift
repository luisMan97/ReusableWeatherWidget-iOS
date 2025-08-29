//
//  WeatherDetailView.swift
//  ReusableWeatherWidget-iOS
//
//  Created by Jorge Luis Rivera Ladino on 23/07/25.
//

import SwiftUI
import CommonUI
import RequestManager

struct WeatherDetailView: View {

    @State var viewModel: WeatherDetailViewModel

    var body: some View {
        switch viewModel.viewState {
        case .loading: loadingView
        case .error(let error): getErrorView(error: error)
        case .loaded(let weather):
            if let item = weather {
                getContentView(weather: item)
            }
        }
    }
}

// MARK: - Private views
private extension WeatherDetailView {
    var loadingView: some View {
        Text(.loading)
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
            .task { await viewModel.getWeather() }
    }

    func getErrorView(error: String) -> some View {
        ContentUnavailableView {
            Label(.noWeatherData, systemImage: .icloudSlash)
        } description: {
            Text("\(.weatherLoadError): \(error)\n\(.tryAgain)")
        } actions: {
            Button(.retry) { viewModel.viewState = .loading }
                .buttonStyle(.borderedProminent)
        }
        .listRowSeparator(.hidden)
    }

    func getContentView(weather: WeatherDetailItem) -> some View {
        return ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    VStack(
                        alignment: .leading,
                        spacing: .titleSpacing
                    ) {
                        Text(weather.name)
                            .bold()
                            .font(.title)

                        Text("\(weather.timeLabel) 🕓")
                            .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                if let iconURL = weather.iconURL {
                                    AsyncImage(url: iconURL) { image in
                                        image
                                            .font(.system(size: 40))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }

                                Text(weather.shortDescription)
                            }
                            .frame(width: 140, alignment: .leading)

                            Spacer()

                            HStack(spacing: .zero) {
                                Text(weather.temperature)
                                    .font(.system(size: 100))
                                    .fontWeight(.bold)
                                    .padding()

                                Text(weather.temperatureUnit)
                                    .font(.system(size: 48))
                                    .baselineOffset(30)
                            }
                        }

                        Spacer()
                            .frame(height:  80)

                        Image(.city)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(.currentWeather)
                                .bold()

                            Text(weather.description)
                        }
                        .padding(.bottom)

                        HStack {
                            WeatherItemView(
                                logo: .thermometer,
                                name: .temperatureLevel,
                                value: weather.temperatureLevel.rawValue,
                                icon: "🌡️"
                            )
                            Spacer()
                            WeatherItemView(
                                logo: "humidity",
                                name: "Rain",
                                value: weather.rain,
                                icon: "☔"
                            )
                        }

                        HStack {
                            WeatherItemView(
                                logo: "location.north.line",
                                name: "Wind direction",
                                value: weather.windDirection,
                                icon: "🧭"
                            )
                            Spacer()
                            WeatherItemView(
                                logo: "wind",
                                name: "Wind speed",
                                value: weather.wind,
                                icon: "🌬️"
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(getColor(temperatureLevel: weather.temperatureLevel))
                    .background(.white)
                    .cornerRadius(20)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(getColor(temperatureLevel: weather.temperatureLevel))
    }
}

// MARK: - L10n Constants
private extension LocalizedStringKey {
    static var noWeatherData: LocalizedStringKey { "no.weather.data" }
    static var loading: LocalizedStringKey {  "loading" }
    static var retry: LocalizedStringKey {  "retry" }
    static var currentWeather: LocalizedStringKey {  "current.weather" }
}

private extension String {
    static let weatherLoadError = String(localized: "weather.load.error")
    static let tryAgain = String(localized: "try.again")
    static let temperatureLevel = String(localized: "temperature.level")
}

// MARK: - System Image Constants
private extension String {
    static let icloudSlash = "icloud.slash"
    static let thermometer = "thermometer"
}

// MARK: - Layout Constants
private extension CGFloat {
    static let titleSpacing: CGFloat = 5
}

// MARK: - Shortcuts
private extension WeatherDetailView {
    func getColor(temperatureLevel: TemperatureLevel) -> Color {
        switch temperatureLevel {
        case .cold: .blueCold
        case .warm: .yellowWarm
        case .hot: .orangeHot
        }
    }
}

#Preview {
    WeatherFactory.getWeatherView()
}

#Preview("WeatherDetailView - cold") {
    @Previewable @State var viewModel = WeatherDetailViewModel(apiManager: APIManager())

    WeatherDetailView(viewModel: viewModel)
        .onChange(of: viewModel.viewState) {
            if case .loaded = viewModel.viewState {
                viewModel.viewState = .loaded(WeatherDetailItem.getMock(temperature: "67"))
            }
        }
}


#Preview("WeatherDetailView - warm") {
    @Previewable @State var viewModel = WeatherDetailViewModel(apiManager: APIManager())

    WeatherDetailView(viewModel: viewModel)
        .onChange(of: viewModel.viewState) {
            if case .loaded = viewModel.viewState {
                viewModel.viewState = .loaded(WeatherDetailItem.getMock(temperature: "68"))
            }
        }
}

#Preview("WeatherDetailView - hot") {
    @Previewable @State var viewModel = WeatherDetailViewModel(apiManager: APIManager())

    WeatherDetailView(viewModel: viewModel)
        .onChange(of: viewModel.viewState) {
            if case .loaded = viewModel.viewState {
                viewModel.viewState = .loaded(WeatherDetailItem.getMock(temperature: "86"))
            }
        }
}

#Preview("WeatherDetailView - error") {
    @Previewable @State var viewModel = WeatherDetailViewModel(apiManager: APIManager())

    WeatherDetailView(viewModel: viewModel)
        .task { viewModel.viewState = .error("") }
}
