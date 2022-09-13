// Copyright © 2022 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.side

import org.informob.pure.*

fun enterApp(appMutant: AppMutant): AppMutant =
    appMutant.run { copy(appState = appState.copy(entered = true)) }
    .let { it.platformFunctions.presentMainScreen(it) }

fun leaveApp(appMutant: AppMutant): AppMutant =
    appMutant.copy(appState = AppState(entered = false))
