//
//  swift_composable_architecture_sampleApp.swift
//  swift-composable-architecture-sample
//
//  Created by Kou Yamamoto on 2022/12/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct swift_composable_architecture_sampleApp: App {
    private let store = Store(initialState: Counter.State(), reducer: Counter())

    var body: some Scene {
        WindowGroup {
            CounterView(store: store)
        }
    }
}
