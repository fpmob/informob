// Copyright 2022 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.side

import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.*
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

import org.informob.pure.present.*
import org.informob.ui.theme.InformobTheme

actual fun viewApp(appMutant: AppMutant): AppMutant = appMutant.also {
    (appMutant.platformBlobRef as? ComponentActivity)?.run {
        setContent { // !!! will not work outside of Activity class
            InformobTheme { appScreen() }
        }
    }
}

@Composable
fun appScreen() {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceAround,
        modifier = Modifier.fillMaxSize()
    ) {
        osStatsView(osStatsPresent(platformOsStats()))
    }
}

@Composable
fun osStatsView(model: OsStatsPresent) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier
            .background(MaterialTheme.colors.secondary)
            .padding(all = 12.dp)
    ) {
        Text(
            text = model.name,
            style = MaterialTheme.typography.h5)
        Text(
            text = model.version,
            style = MaterialTheme.typography.h6)
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    InformobTheme {
    }
}
