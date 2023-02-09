//
//  Reducer+.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import ComposableArchitecture

private struct EmptyReducer<State, Action>: ReducerProtocol {
    init() {}

    func reduce(into _: inout State, action _: Action) -> EffectTask<Action> {
        .none
    }
}

extension ReducerProtocol where Self == AppReducer {
    static var empty: some ReducerProtocol<State, Action> { EmptyReducer() }
}
extension ReducerProtocol where Self == SidebarReducer {
    static var empty: some ReducerProtocol<State, Action> { EmptyReducer() }
}
extension ReducerProtocol where Self == ContentReducer {
    static var empty: some ReducerProtocol<State, Action> { EmptyReducer() }
}
extension ReducerProtocol where Self == DetailReducer {
    static var empty: some ReducerProtocol<State, Action> { EmptyReducer() }
}

