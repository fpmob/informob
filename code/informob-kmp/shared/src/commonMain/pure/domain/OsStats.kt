// Copyright 2022 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.pure.domain

enum class OsCategory { Unknown, Open, Proprietary }

enum class OsFamily { Unknown, Android, iOS }

enum class OsMaker { Unknown, Apple, Google }

data class OsStats(
    val category: OsCategory = OsCategory.Unknown,
    val family: OsFamily = OsFamily.Unknown,
    val maker: OsMaker = OsMaker.Unknown,
    val apiLevel: Int = 0,
    val nickname: String = "",
    val version: String = ""
)
