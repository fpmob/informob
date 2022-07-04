// Copyright 2022 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.pure.domain

enum class OsKnown(val value: OsStats) {
    ANDROID_5(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 21,
        nickname = "Lollipop",
        version = "5"
    )),
    ANDROID_5_1(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 22,
        nickname = "Lollipop MR1",
        version = "5.1"
    )),
    ANDROID_6(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 23,
        nickname = "Marshmallow",
        version = "6"
    )),
    ANDROID_7(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 24,
        nickname = "Nougat",
        version = "7"
    )),
    ANDROID_7_1(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 25,
        nickname = "Nougat MR1",
        version = "7.1"
    )),
    ANDROID_8(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 26,
        nickname = "Oreo",
        version = "8"
    )),
    ANDROID_8_1(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 27,
        nickname = "Oreo",
        version = "8.1"
    )),
    ANDROID_9(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 28,
        nickname = "Pie",
        version = "9"
    )),
    ANDROID_10(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 29,
        nickname = "Quince Tart",
        version = "10"
    )),
    ANDROID_11(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 30,
        nickname = "Red Velvet Cake",
        version = "11"
    )),
    ANDROID_12(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 31,
        nickname = "Snow Cone",
        version = "12"
    )),
    ANDROID_12_1(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 32,
        nickname = "Snow Cone v2",
        version = "12.1"
    )),
    ANDROID_13(OsStats(
        category = OsCategory.Open,
        family = OsFamily.Android,
        maker = OsMaker.Google,
        apiLevel = 33,
        nickname = "Tiramisu",
        version = "13"
    )),
}
