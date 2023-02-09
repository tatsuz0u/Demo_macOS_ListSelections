//
//  ContentReducer.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import Foundation
import ComposableArchitecture

struct ContentReducer: ReducerProtocol {
    enum Status: String, Equatable, CaseIterable {
        case a, b, c
    }
    enum Category: String, Equatable, CaseIterable {
        case x, y, z
    }

    enum Selection: Equatable, Hashable {
        case status(Status)
        case category(Category)
    }

    struct State: Equatable, Identifiable {
        let id: UUID
        var selections: Set<Selection> {
            .init(
                [
                    selectedStatus.map(Selection.status),
                    selectedCategory.map(Selection.category)
                ]
                .compactMap({ $0 })
            )
        }

        var selectedStatus: Status?
        var selectedCategory: Category?

        init(id: UUID) {
            self.id = id
        }
    }

    enum Action: Equatable {
        case setSelections(Set<Selection>)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .setSelections(let selections):
                if let status = selections
                    .compactMap((/Selection.status).extract)
                    .first(where: { $0 != state.selectedStatus })
                {
                    state.selectedStatus = status
                }
                if let category = selections
                    .compactMap((/Selection.category).extract)
                    .first(where: { $0 != state.selectedCategory })
                {
                    state.selectedCategory = category
                }
                return .none
            }
        }
    }
}
