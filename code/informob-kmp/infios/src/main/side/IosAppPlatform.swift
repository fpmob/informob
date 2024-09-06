// Copyright © 2022 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import infsha

public func iosAppPlatformFunctions() -> AppPlatformFunctions {
    AppPlatformFunctions(
        presentMainScreen: { (appMutant: AppMutant) -> AppMutant in
            // TODO: @@@ REFACTOR MainApp.body COMPOSE UI CODE TO HERE
            return appMutant
        }
    )
}
