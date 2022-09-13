// Copyright © 2022 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.side

import org.informob.pure.*

data class AppMutant(
    val appState: AppState = AppState(),
    val platformFunctions: AppPlatformFunctions = AppPlatformFunctions(),
    val platformBlobRef: Any? = null
)

fun appMutant() = AppMutant() // !!! because Kotlin -> ObjC/Swift doesn't support default args

fun appMutant(platformFunctions: AppPlatformFunctions): (Any) -> AppMutant =
    { platformBlobRef: Any ->
        AppMutant(AppState(), platformFunctions, platformBlobRef)
    }
