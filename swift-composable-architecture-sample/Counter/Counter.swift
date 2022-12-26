//
//  Counter.swift
//  swift-composable-architecture-sample
//
//  Created by Kou Yamamoto on 2022/12/26.
//

import Foundation
import ComposableArchitecture

struct Counter: ReducerProtocol {

    struct State: Equatable {
        var count = 0
        var numberFactAlert: String?
    }

    enum Action: Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(TaskResult<String>)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .factAlertDismissed:
            state.numberFactAlert = nil
            return .none
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        case .numberFactButtonTapped:
            return .task { [count = state.count] in
                let result = await TaskResult {
                    if count % 2 == 0 {
                        throw NSError(domain: "OptionalError", code: 111, userInfo: nil)
                    } else {
                       return "2の倍数です"
                    }
                }
                return .numberFactResponse(result)
            }
        case let .numberFactResponse(.success(fact)):
            state.numberFactAlert = fact
            return .none
        case .numberFactResponse(.failure):
            state.numberFactAlert = "Could not load a number fact :("
            return .none
        }
    }
}
