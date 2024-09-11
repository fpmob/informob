// Copyright © 2022 - 2024 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI
import infsha

struct AppView: View {
    let osStats = OsStatsPresentKt.osStatsPresent(
        model: PlatformIosKt.platformOsStats())

    var body: some View {
        VStack {
            VStack {
                Text(osStats.name)
                    .font(.largeTitle)
                Text(osStats.version)
                    .font(.title)
            }
            .padding()
        }
        .background(Color.gray)
    }
}

struct AppView_Previews: PreviewProvider {
	static var previews: some View { AppView() }
}
