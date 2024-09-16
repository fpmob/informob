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
    @State private var hasSwiftUi = false
    @State private var hasUinota  = false
    let spacing = 16.0
    let buttonx = 80.0
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                OsStatsView()
                Spacer()
                VStack(spacing: spacing) {
                    Button {
                        hasSwiftUi = !hasSwiftUi
                    } label: { ButtonViewText(
                        text: "Swift UI", x:buttonx, y:spacing) }
                    Button {
                        hasUinota = !hasUinota
                    } label: { ButtonViewText(
                        text: "Uinota"  , x:buttonx, y:spacing) }
                }.padding()
                //.border(Color.yellow, width: 1)
                Spacer()
            }//.border(Color.yellow, width: 1)
            if hasSwiftUi {
                PerfView().border(Color.blue,  width: 4)
            } else { Spacer() }
            if hasUinota {
                PerfView().border(Color.green, width: 4)
            } else { Spacer() }
        }
        .background(Color.black)
        //.border(Color.yellow, width: 1)
    }
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View { AppView() }
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
    let stats = mockPerfStats()
    let colorBack = Color(red: 0.5, green: 0.6, blue: 0.6)
    let colorBar  = Color(red: 0.6, green: 0.2, blue: 0.2)
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart(stats) {
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
        } else {
            // TODO: ### CUSTOM CHART FOR iOS < 16
            ZStack { colorBack }
        }
    }
}

struct PerfStat: Identifiable {
    let id:      String
    let max:     Int
    let value:   Int
    var percent: Double {
        if max > 0 { Double(value)/Double(max) * 100.0 } else { 0.0 }
    }
}

func mockPerfStats() -> [PerfStat] { [
    .init(id: "cores",   max:  64, value:  8),
    .init(id: "threads", max: 100, value: 50),
    .init(id: "tasks",   max: 100, value: 30),
    .init(id: "awaits",  max: 100, value: 20),
] }
