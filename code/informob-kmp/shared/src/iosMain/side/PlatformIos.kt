// Copyright 2022 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.side

import platform.UIKit.UIDevice

import org.informob.pure.domain.*

actual fun platformOsStats(): OsStats =
    UIDevice.currentDevice.systemVersion.let { version ->
        OsKnown.values().find {
            it.value.family == OsFamily.iOS &&
            it.value.version == version
        }?.value ?: OsStats(
            family = OsFamily.iOS,
            version = version
        )
    }
