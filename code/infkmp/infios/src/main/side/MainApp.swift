// Copyright © 2022 - 2024 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import SwiftUI

import infsha

@main
struct MainApp: App {
    // TODO: @@@ REFACTOR COMPOSE UI CODE TO iosAppPlatformFunctions.presentMainScreen(...)
    var body: some Scene { WindowGroup { AppView() } }
    var appMutant = AppMutantKt.appMutant()
    init() {
        var appMutant = AppMutantKt.appMutant(
            platformFunctions: iosAppPlatformFunctions()
            )(IosPlatformBlob(
                // TODO: @@@ FIGURE OUT WHAT WE NEED A REFERENCE TO
            ))
        appMutant = AppFlowKt.enterApp(appMutant: appMutant)
    }
}
