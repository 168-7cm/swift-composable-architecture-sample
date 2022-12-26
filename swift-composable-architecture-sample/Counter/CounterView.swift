//
//  CounterView.swift
//  swift-composable-architecture-sample
//
//  Created by Kou Yamamoto on 2022/12/26.
//

import SwiftUI
import ComposableArchitecture

struct FactAlert: Identifiable {
    var title: String
    var id: String { title }
}

struct CounterView: View {
    let store: StoreOf<Counter>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                HStack {
                    Button("-") { viewStore.send(.decrementButtonTapped) }
                    Text("\(viewStore.count)")
                    Button("+") { viewStore.send(.incrementButtonTapped) }
                }

                Button("Number fact") { viewStore.send(.numberFactButtonTapped) }
            }
            .alert(
                item: viewStore.binding(
                    get: { $0.numberFactAlert.map(FactAlert.init(title:)) },
                    send: .factAlertDismissed
                ),
                content: { Alert(title: Text($0.title)) }
            )
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: Counter.State(), reducer: Counter())
        CounterView(store: store)
    }
}
