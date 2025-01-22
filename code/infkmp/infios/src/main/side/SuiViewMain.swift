// Copyright © 2022 - 2025 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI
import Charts // iOS 16
import infsha

let widthBordPanel  = 4.0

struct SuiViewMain: View {
    @ObservedObject var statsDraw: ObsStatsDraw
    @ObservedObject var statsPerf: ObsStatsPerf

    private var procIncDraws: (String) -> ()
    @State private var hasDraws  = false
    @State private var hasPerfs  = false
    @State private var hasRandom = false
    @State private var hasStress = false
    let spacing = 16.0
    let buttonx = 80.0

    var body: some View {
        // TODO: ### REDRAW CYCLE
        //let _ = procIncDraws("SuiViewMain")
        ZStack {
            Color.black
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    SuiViewOsStats()
                    VStack(spacing: spacing) {
                        Button {
                            hasDraws.toggle()
                            if (!hasDraws) { statsDraw.reset() }
                        } label: { SuiViewButtonText(
                            background: colorFrom(ColorPalette.backdraw),
                            text: "Draws", x:buttonx, y:spacing) }
                        Button { hasRandom.toggle()
                        } label: { SuiViewButtonText(
                            background: colorFrom(ColorPalette.backrandom),
                            text: "Random", x:buttonx, y:spacing) }
                    }.padding()
                    //.border(colorFrom(ColorPalette.borddebug), width: 1)
                    VStack(spacing: spacing) {
                        Button { hasPerfs.toggle()
                        } label: { SuiViewButtonText(
                            background: colorFrom(ColorPalette.backperf),
                            text: "Perfs", x:buttonx, y:spacing) }
                        Button { hasStress.toggle()
                        } label: { SuiViewButtonText(
                            background: colorFrom(ColorPalette.backstress),
                            text: "Stress", x:buttonx, y:spacing) }
                    }.padding([.bottom, .top, .trailing], nil)
                    //.border(colorFrom(ColorPalette.borddebug), width: 1)
                }//.border(colorFrom(ColorPalette.borddebug), width: 1)
                HStack(spacing: 0) {
                    if hasDraws {
                        SuiViewDraws(
                            procIncDraws: procIncDraws,
                            statsDraw: statsDraw)
                        .border(colorFrom(ColorPalette.borddraw), width: widthBordPanel)
                    }
                    if hasPerfs {
                        SuiViewPerfs(
                            procIncDraws: procIncDraws,
                            statsPerf: statsPerf)
                        .border(colorFrom(ColorPalette.bordperf), width: widthBordPanel)
                    }
                }//.border(colorFrom(ColorPalette.borddebug), width: 1)
                HStack(spacing: 0) {
                    if hasRandom {
                        SuiViewRandom(
                            procIncDraws: procIncDraws)
                        .border(colorFrom(ColorPalette.bordrandom), width: widthBordPanel)
                    }
                    if hasStress {
                        SuiViewStress(
                            procIncDraws: procIncDraws)
                        .border(colorFrom(ColorPalette.bordstress), width: widthBordPanel)
                    }
                }//.border(colorFrom(ColorPalette.borddebug), width: 1)
                Spacer()
            }
        }
        //.border(colorFrom(ColorPalette.borddebug), width: 1)
    }
    init(
        statsDraw: ObsStatsDraw,
        statsPerf: ObsStatsPerf
    ) {
        self.statsDraw = statsDraw
        self.statsPerf = statsPerf
        self.procIncDraws = { name in
            Task { await MainActor.run {
                statsDraw.update(
                    id: name,
                    changes: "(unknown)"
                    // TODO: ### SuiViewMain._printChanges()
                )
            }}
        }
    }
}

struct SuiViewMain_Previews: PreviewProvider {
    static var previews: some View {
        SuiViewMain(statsDraw: ObsStatsDraw(),
                statsPerf: ObsStatsPerf()) }
}

struct SuiViewButtonText: View {
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
        //.border(colorFrom(ColorPalette.borddebug), width: 1)
    }
}

struct SuiViewOsStats: View {
    let osStats = OsStatsPresentKt.osStatsPresent(
        model: PlatformIosKt.platformOsStats())
    var body: some View {
        VStack {
            Text(osStats.name   ).font(.largeTitle)
            Text(osStats.version).font(.title)
        }
        .padding()
        .background(     colorFrom(ColorPalette.backos))
        .foregroundColor(colorFrom(ColorPalette.foreos))
        //.border(colorFrom(ColorPalette.borddebug), width: 1)
    }
}

struct SuiViewPerfs: View {
    let procIncDraws: (String) -> ()
    @ObservedObject var statsPerf: ObsStatsPerf
    var body: some View {
        let _ = procIncDraws("SuiViewPerfs")
        if #available(iOS 16.0, *) {
            Chart(statsPerf.array) {
                BarMark(
                    x: .value("%", $0.percent),
                    y: .value("?", "    \($0.value) of \($0.max) \($0.id)")
                )
                .foregroundStyle(colorFrom(ColorPalette.foreperf)
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
                    .foregroundStyle(colorFrom(ColorPalette.foreperf))
                }
            }
            .background(colorFrom(ColorPalette.backperf))
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorFrom(ColorPalette.backperf) }
        }
    }
}

struct SuiViewDraws: View {
    let procIncDraws: (String) -> ()
    @ObservedObject var statsDraw: ObsStatsDraw
    var body: some View {
        // TODO: ### REDRAW CYCLE
        //let _ = procIncDraws("SuiViewDraws")
        if #available(iOS 16.0, *) {
            Chart(statsDraw.sortedArray()) {
                BarMark(
                    x: .value("up", $0.updates),
                    y: .value("id", "    \($0.id) \($0.updates)")
                )
                .foregroundStyle(colorFrom(ColorPalette.foredraw)
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
                    .foregroundStyle(colorFrom(ColorPalette.foredraw))
                }
            }
            .background(colorFrom(ColorPalette.backdraw))
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorFrom(ColorPalette.backdraw) }
        }
    }
}

struct SuiViewRandom: View {
    let procIncDraws: (String) -> ()
    @State private var countPressed = 0
    @State private var countRandomized = 0
    var body: some View {
        let _ = procIncDraws("SuiViewRandom")
        ScrollView([.horizontal, .vertical]) {
            SuiViewRandomized(depth: 3,
                procIncDraws: procIncDraws,
                countPressed: $countPressed,
                countRandomized: $countRandomized)
        }
        .background(colorFrom(ColorPalette.backrandom))
        //.defaultScrollAnchor(.center) !!! iOS 17
    }
}

struct SuiViewRandomized: View {
    let depth: Int
    let procIncDraws: (String) -> ()
    @Binding var countPressed: Int
    @Binding var countRandomized: Int
    var body: some View {
        let _ = procIncDraws("random \(depth) depth")
        if (depth <= 0) {
            Button { countPressed += 1 }
            label: {
                let _ = procIncDraws("random Button P")
                Text("\(countPressed)")
                .padding(12)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(48)
            }
            Button { countRandomized += 1 }
            label: {
                let _ = procIncDraws("random Button R")
                Text("\(countRandomized)")
                .padding(12)
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(48)
            }
        } else if countRandomized >= 0 { // !!! trigger redraws
            let recurse = {
                SuiViewRandomized(
                    depth: depth - 1,
                    procIncDraws: procIncDraws,
                    countPressed: $countPressed,
                    countRandomized: $countRandomized)
            }
            let count = Int.random(in: 1...3)
            switch Int.random(in: 1...2) {
                case 1 :
                    let _ = procIncDraws("random HStack")
                    HStack {
                        ForEach(1...count, id: \.self)
                            { _ in recurse() }
                    }.padding(8).border(Color.red, width: 4)
                case 2 :
                    let _ = procIncDraws("random VStack")
                    VStack {
                        ForEach(1...count, id: \.self)
                            { _ in recurse() }
                    }.padding(8).border(Color.blue, width: 4)
                default : ZStack { Color.red }
                        // !!! should never occur
            }
        }
    }
}

struct SuiViewStress: View {
    let procIncDraws: (String) -> ()
    var body: some View {
        let _ = procIncDraws("SuiViewStress")
        ZStack { colorFrom(ColorPalette.backstress) }
        //.border(colorFrom(ColorPalette.borddebug), width: 1)
    }
}

func colorFrom(_ c: ColorPalette) -> Color {
    return Color(red: Double(c.value.r),
               green: Double(c.value.g),
                blue: Double(c.value.b))
               // TODO: ### alpha not supported
               //alpha: Double(v.a))
}
