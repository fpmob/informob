// Copyright © 2022 - 2025 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI
import Charts // iOS 16
import infsha

let colorBackDraw   = Color(red: 0.7, green: 0.6, blue: 0.6)
let colorBackOs     = Color(red: 0.2, green: 0.2, blue: 0.2)
let colorBackPerf   = Color(red: 0.7, green: 0.7, blue: 0.6)
let colorBackRandom = Color(red: 0.6, green: 0.7, blue: 0.6)
let colorBackStress = Color(red: 0.6, green: 0.7, blue: 0.7)
let colorBordDebug  = Color.yellow
let colorBordDraw   = Color(red: 0.6, green: 0.0, blue: 0.0)
let colorBordPerf   = Color(red: 0.6, green: 0.4, blue: 0.0)
let colorBordRandom = Color(red: 0.0, green: 0.5, blue: 0.0)
let colorBordStress = Color(red: 0.0, green: 0.2, blue: 0.7)
let colorForeDraw   = Color(red: 0.6, green: 0.3, blue: 0.3)
let colorForeOs     = Color(red: 0.7, green: 0.7, blue: 0.7)
let colorForePerf   = Color(red: 0.6, green: 0.4, blue: 0.2)
let colorForeRandom = Color(red: 0.6, green: 0.7, blue: 0.6)
let colorForeStress = Color(red: 0.4, green: 0.4, blue: 0.8)
let widthBordPanel  = 4.0

struct ViewApp: View {
    @ObservedObject var statsDraw: StatsDraw
    @ObservedObject var statsPerf: StatsPerf

    private var procIncDraws: (String) -> ()
    @State private var hasDraws  = false
    @State private var hasPerfs  = false
    @State private var hasRandom = false
    @State private var hasStress = false
    let spacing = 16.0
    let buttonx = 80.0

    var body: some View {
        // TODO: ### REDRAW CYCLE
        //let _ = procIncDraws("ViewApp")
        ZStack {
            Color.black
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ViewOsStats()
                    VStack(spacing: spacing) {
                        Button { hasDraws.toggle()
                        } label: { ViewButtonText(
                            background: colorBackDraw,
                            text: "Draws", x:buttonx, y:spacing) }
                        Button { hasRandom.toggle()
                        } label: { ViewButtonText(
                            background: colorBackRandom,
                            text: "Random", x:buttonx, y:spacing) }
                    }.padding()
                    //.border(colorBordDebug, width: 1)
                    VStack(spacing: spacing) {
                        Button { hasPerfs.toggle()
                        } label: { ViewButtonText(
                            background: colorBackPerf,
                            text: "Perfs", x:buttonx, y:spacing) }
                        Button { hasStress.toggle()
                        } label: { ViewButtonText(
                            background: colorBackStress,
                            text: "Stress", x:buttonx, y:spacing) }
                    }.padding([.bottom, .top, .trailing], nil)
                    //.border(colorBordDebug, width: 1)
                }//.border(colorBordDebug, width: 1)
                HStack(spacing: 0) {
                    if hasDraws {
                        ViewDraws(
                            procIncDraws: procIncDraws,
                            statsDraw: statsDraw)
                        .border(colorBordDraw, width: widthBordPanel)
                    }
                    if hasPerfs {
                        ViewPerfs(
                            procIncDraws: procIncDraws,
                            statsPerf: statsPerf)
                        .border(colorBordPerf, width: widthBordPanel)
                    }
                }//.border(colorBordDebug, width: 1)
                HStack(spacing: 0) {
                    if hasRandom {
                        ViewRandom(
                            procIncDraws: procIncDraws)
                        .border(colorBordRandom, width: widthBordPanel)
                    }
                    if hasStress {
                        ViewStress(
                            procIncDraws: procIncDraws)
                        .border(colorBordStress, width: widthBordPanel)
                    }
                }//.border(colorBordDebug, width: 1)
                Spacer()
            }
        }
        //.border(colorBordDebug, width: 1)
    }
    init(
        statsDraw: StatsDraw,
        statsPerf: StatsPerf
    ) {
        self.statsDraw = statsDraw
        self.statsPerf = statsPerf
        self.procIncDraws = { name in
            Task { await MainActor.run {
                statsDraw.update(
                    id: name,
                    changes: "(unknown)"
                    // TODO: ### ViewApp._printChanges()
                )
            }}
        }
    }
}

struct ViewApp_Previews: PreviewProvider {
	static var previews: some View {
        ViewApp(statsDraw: StatsDraw(),
                statsPerf: StatsPerf()) }
}

struct ViewButtonText: View {
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
        //.border(colorBordDebug, width: 1)
    }
}

struct ViewOsStats: View {
    let osStats = OsStatsPresentKt.osStatsPresent(
        model: PlatformIosKt.platformOsStats())
    var body: some View {
        VStack {
            Text(osStats.name   ).font(.largeTitle)
            Text(osStats.version).font(.title)
        }
        .padding()
        .background(colorBackOs)
        .foregroundColor(colorForeOs)
        //.border(colorBordDebug, width: 1)
    }
}

struct ViewPerfs: View {
    let procIncDraws: (String) -> ()
    @ObservedObject var statsPerf: StatsPerf
    var body: some View {
        let _ = procIncDraws("ViewPerfs")
        if #available(iOS 16.0, *) {
            Chart(statsPerf.array) {
                BarMark(
                    x: .value("%", $0.percent),
                    y: .value("?", "    \($0.value) of \($0.max) \($0.id)")
                )
                .foregroundStyle(colorForePerf
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
                    .foregroundStyle(colorForePerf)
                }
            }
            .background(colorBackPerf)
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorBackPerf }
        }
    }
}

struct ViewDraws: View {
    let procIncDraws: (String) -> ()
    @ObservedObject var statsDraw: StatsDraw
    var body: some View {
        // TODO: ### REDRAW CYCLE
        //let _ = procIncDraws("ViewDraws")
        if #available(iOS 16.0, *) {
            Chart(statsDraw.sortedArray()) {
                BarMark(
                    x: .value("up", $0.updates),
                    y: .value("id", "    \($0.id) \($0.updates)")
                )
                .foregroundStyle(colorForeDraw
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
                    .foregroundStyle(colorForeDraw)
                }
            }
            .background(colorBackDraw)
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorBackDraw }
        }
    }
}

struct ViewRandom: View {
    let procIncDraws: (String) -> ()
    @State private var countRedrawn = 0
    var body: some View {
        let _ = procIncDraws("ViewRandom")
        ZStack {
            colorBackRandom
            ViewRandomized(depth: 0,
                procIncDraws: procIncDraws,
                countRedrawn: $countRedrawn)
        }
    }
}

struct ViewRandomized: View {
    let depth: Int
    let procIncDraws: (String) -> ()
    @Binding var countRedrawn: Int
    private let count = Int.random(in: 1...3)
    var body: some View {
        let _ = procIncDraws("ViewRandomized")
        if (depth <= 0) {
            let _ = procIncDraws("random Button")
            Button { countRedrawn += 1 }
            label: { Text("\(countRedrawn)")
                .padding(8)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(40)
            }
        } else {
            let recurse = {
                ViewRandomized(
                    depth: depth - 1,
                    procIncDraws: procIncDraws,
                    countRedrawn: $countRedrawn)
            }
            ForEach(1..<count, id: \.self) { _ in
                switch Int.random(in: 1...2) {
                    case 1 :
                        let _ = procIncDraws("random HStack")
                        HStack { recurse()
                        }.border(Color.white)
                    case 2 :
                        let _ = procIncDraws("random VStack")
                        VStack { recurse()
                        }.border(Color.white)
                    default : ZStack { Color.red }
                        // !!! should never occur
                }
            }
        }
    }
}

struct ViewStress: View {
    let procIncDraws: (String) -> ()
    var body: some View {
        let _ = procIncDraws("ViewStress")
        ZStack { colorBackStress }
        //.border(colorBordDebug, width: 1)
    }
}
