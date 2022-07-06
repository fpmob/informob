// Copyright 2022 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.side

import org.informob.pure.*

expect fun viewApp(appMutant: AppMutant): AppMutant

fun enterApp(appMutant: AppMutant): AppMutant =
    viewApp(appMutant.copy(appState = AppState(entered = true)))

fun leaveApp(appMutant: AppMutant): AppMutant =
    appMutant.copy(appState = AppState(entered = false))
