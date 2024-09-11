// Copyright © 2022 - 2024 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI
import infsha

struct AppView: View {
    @State private var hasSwiftUi = false
    @State private var hasUinota  = false
    let spacing = 16.0
    let buttonx = 80.0
    var body: some View {
        VStack {
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
                ZStack { Color.blue  }.border(Color.orange, width: 4)
            } else { Spacer() }
            if hasUinota {
                ZStack { Color.green }.border(Color.orange, width: 4)
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
