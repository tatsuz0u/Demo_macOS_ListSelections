//
//  Store+.swift
//  Demo_macOS_ListSelections
//
//  Created by 荒木辰造 on R 5/02/09.
//

import Foundation
import ComposableArchitecture

extension Store: ObservableObject where State == AppReducer.State, Action == AppReducer.Action {}
