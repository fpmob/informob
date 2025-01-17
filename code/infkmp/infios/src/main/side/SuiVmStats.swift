// Copyright © 2022 - 2025 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

struct StatDraw: Identifiable {
    let id:      String
    let changes: String
    let updates: Int
    let seconds: Double
}

class StatsDraw: ObservableObject {
    @Published var dict: [String:StatDraw] = [:]

    init() {}

    func reset() { dict = [:] }

    func sortedArray() -> [StatDraw] {
        return dict.sorted { $0.0 < $1.0 } .map { $0.1 }
    }

    func update(id: String, changes: String) {
        let stat = dict[id]
        dict[id] = StatDraw(
            id:      id,
            changes: changes,
            updates: 1 + (stat?.updates ?? 0),
            seconds: stat?.seconds ?? 0.0)
    }
}

struct StatPerf: Identifiable {
    let id:      String
    let max:     Int
    let value:   Int
    var percent: Double {
        if max > 0 { Double(value)/Double(max) * 100.0 } else { 0.0 }
    }
}

class StatsPerf: ObservableObject {
    @Published var array: [StatPerf] = statsPerfMock()
    init() {}
}

func statsPerfMock() -> [StatPerf] { [
    .init(id: "cores",   max:  64, value:  8),
    .init(id: "threads", max: 100, value: 30),
    .init(id: "queues",  max: 100, value: 60),
] }
