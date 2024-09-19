// Copyright © 2022 - 2024 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI
import Charts // iOS 16
import infsha

struct AppView: View {
    @ObservedObject var perfStats: PerfStats
    @ObservedObject var rendStats: RendStats
    @State private var hasPerfs = false
    @State private var hasRends = false
    let spacing = 16.0
    let buttonx = 80.0
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                OsStatsView()
                Spacer()
                VStack(spacing: spacing) {
                    Button { hasPerfs.toggle()
                    } label: { ButtonViewText(
                        text: "Perfs", x:buttonx, y:spacing) }
                    Button { hasRends.toggle()
                    } label: { ButtonViewText(
                        text: "Rends", x:buttonx, y:spacing) }
                }.padding()
                //.border(Color.yellow, width: 1)
            }//.border(Color.yellow, width: 1)
            if hasPerfs {
                PerfView(perfStats: perfStats,
                         rendStats: rendStats)
                    .border(Color.orange, width: 4)
            } else { Spacer() }
            if hasRends {
                RendView(rendStats: rendStats)
                    .border(Color.blue,   width: 4)
            } else { Spacer() }
        }
        .background(Color.black)
        //.border(Color.yellow, width: 1)
        .onAppear {
            rendStats.update(
                id: "AppView",
                changes: "(unknown)"
                    // TODO: ### AppView._printChanges()
            )
        }
    }
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View {
        AppView(perfStats: PerfStats(),
                rendStats: RendStats()) }
}

struct ButtonViewText: View {
    var text: String
    var x, y: CGFloat
    var body: some View { Text(text)
        .bold()
        .frame(width: x, height: y)
        .padding()
        .background(     Color.orange)
        .foregroundColor(Color.black)
        .cornerRadius(y)
        //.border(Color.yellow, width: 1)
    }
}

struct OsStatsView: View {
    let osStats = OsStatsPresentKt.osStatsPresent(
        model: PlatformIosKt.platformOsStats())
    var body: some View {
        VStack {
            Text(osStats.name   ).font(.largeTitle)
            Text(osStats.version).font(.title)
        }
        .padding()
        .background(Color.purple)
        .foregroundColor(Color.white)
        //.border(Color.yellow, width: 1)
    }
}

struct PerfView: View {
    @ObservedObject var perfStats: PerfStats
    @ObservedObject var rendStats: RendStats
    let colorBack = Color(red: 0.7, green: 0.7, blue: 0.6)
    let colorBar  = Color(red: 0.7, green: 0.3, blue: 0.3)
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart(perfStats.array) {
                BarMark(
                    x: .value("%", $0.percent),
                    y: .value("?", "    \($0.value) of \($0.max) \($0.id)")
                )
                .foregroundStyle(colorBar
                    .blendMode(.difference))
                    //.blendMode(.destinationOver))
                //.opacity(0.5)
                //.zIndex(-1) // !!! iOS 17
            }
            .chartXAxis(.hidden)
            .chartXScale(domain: 0...100)
            .chartYAxis {
                AxisMarks(preset: .inset) {
                    AxisValueLabel(centered: true)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(colorBar)
                }
            }
            .background(colorBack)
            .onAppear {
                rendStats.update(
                    id: "PerfView",
                    changes: "(unknown)"
                        // TODO: ### AppView._printChanges()
                )
            }
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorBack }
        }
    }
}

struct RendView: View {
    @ObservedObject var rendStats: RendStats
    let colorBack = Color(red: 0.6, green: 0.7, blue: 0.7)
    let colorBar  = Color(red: 0.4, green: 0.4, blue: 0.8)
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart(rendStats.sortedArray()) {
                BarMark(
                    x: .value("up", $0.updates),
                    y: .value("id", "    \($0.id) \($0.updates)")
                )
                .foregroundStyle(colorBar
                    .blendMode(.difference))
                    //.blendMode(.destinationOver))
                //.opacity(0.5)
                //.zIndex(-1) // !!! iOS 17
            }
            .chartXAxis(.hidden)
            .chartXScale(domain: 0...100)
            .chartYAxis {
                AxisMarks(preset: .inset) {
                    AxisValueLabel(centered: true)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(colorBar)
                }
            }
            .background(colorBack)
            .onAppear {
                rendStats.update(
                    id: "RendView",
                    changes: "(unknown)"
                        // TODO: ### AppView._printChanges()
                )
            }
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorBack }
        }
    }
}
