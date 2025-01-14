// Copyright © 2022 - 2024 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI
import Charts // iOS 16
import infsha

let colorBackPerf   = Color(red: 0.7, green: 0.7, blue: 0.6)
let colorBackRend   = Color(red: 0.6, green: 0.7, blue: 0.7)
let colorBackRandom = Color(red: 0.6, green: 0.7, blue: 0.6)
let colorBackStress = Color(red: 0.7, green: 0.6, blue: 0.6)

struct AppView: View {
    @ObservedObject var perfStats: PerfStats
    @ObservedObject var rendStats: RendStats
    @State private var hasPerfs  = false
    @State private var hasRends  = false
    @State private var hasRandom = false
    @State private var hasStress = false
    let spacing = 16.0
    let buttonx = 80.0
    var body: some View {
        ZStack {
            Color.black
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    OsStatsView()
                    VStack(spacing: spacing) {
                        Button { hasPerfs.toggle()
                        } label: { ButtonViewText(
                            background: colorBackPerf,
                            text: "Perfs", x:buttonx, y:spacing) }
                        Button { hasRandom.toggle()
                        } label: { ButtonViewText(
                            background: colorBackRandom,
                            text: "Random", x:buttonx, y:spacing) }
                    }.padding()
                    //.border(Color.yellow, width: 1)
                    VStack(spacing: spacing) {
                        Button { hasRends.toggle()
                        } label: { ButtonViewText(
                            background: colorBackRend,
                            text: "Rends", x:buttonx, y:spacing) }
                        Button { hasStress.toggle()
                        } label: { ButtonViewText(
                            background: colorBackStress,
                            text: "Stress", x:buttonx, y:spacing) }
                    }.padding([.bottom, .top, .trailing], nil)
                    //.border(Color.yellow, width: 1)
                }//.border(Color.yellow, width: 1)
                HStack(spacing: 0) {
                    if hasPerfs {
                        PerfView(perfStats: perfStats,
                                 rendStats: rendStats)
                            .border(Color.orange, width: 4)
                    }
                    if hasRends {
                        RendView(rendStats: rendStats)
                            .border(Color.blue,   width: 4)
                    }
                }//.border(Color.yellow, width: 1)
                HStack(spacing: 0) {
                    if hasRandom {
                        RandomView(rendStats: rendStats)
                            .border(Color.green, width: 4)
                    }
                    if hasStress {
                        StressView(rendStats: rendStats)
                            .border(Color.red,   width: 4)
                    }
                }//.border(Color.yellow, width: 1)
                Spacer()
            }
        }
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
    var background: Color
    var text:       String
    var x, y:       CGFloat
    var body: some View { Text(text)
        .bold()
        .frame(width: x, height: y)
        .padding()
        .background(background)
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
            .background(colorBackPerf)
            .onAppear {
                rendStats.update(
                    id: "PerfView",
                    changes: "(unknown)"
                        // TODO: ### AppView._printChanges()
                )
            }
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorBackPerf }
        }
    }
}

struct RendView: View {
    @ObservedObject var rendStats: RendStats
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
            .background(colorBackRend)
            .onAppear {
                rendStats.update(
                    id: "RendView",
                    changes: "(unknown)"
                        // TODO: ### AppView._printChanges()
                )
            }
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorBackRend }
        }
    }
}

struct RandomView: View {
    @ObservedObject var rendStats: RendStats
    let osStats = OsStatsPresentKt.osStatsPresent(
        model: PlatformIosKt.platformOsStats())
    var body: some View {
        ZStack { colorBackRandom }
        //.border(Color.yellow, width: 1)
        .onAppear {
            rendStats.update(
                id: "RandomView",
                changes: "(unknown)"
                        // TODO: ### AppView._printChanges()
            )
        }
    }
}

struct StressView: View {
    @ObservedObject var rendStats: RendStats
    let osStats = OsStatsPresentKt.osStatsPresent(
        model: PlatformIosKt.platformOsStats())
    var body: some View {
        ZStack { colorBackStress }
        //.border(Color.yellow, width: 1)
        .onAppear {
            rendStats.update(
                id: "StressView",
                changes: "(unknown)"
                        // TODO: ### AppView._printChanges()
            )
        }
    }
}
