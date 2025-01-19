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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

import org.informob.pure.present.*
import org.informob.ui.theme.InformobTheme

fun andPresentMainScreen(appMutant: AppMutant): AppMutant = appMutant.apply {
    ((platformBlobRef as? AndPlatformBlob)?.activity as? ComponentActivity)?.run {
        setContent { // !!! will not work outside of Activity class
            InformobTheme { appScreen() }
        }
    }
}

@Composable
fun appScreen() {
    Column(
        horizontalAlignment = Alignment.Start,
        verticalArrangement = Arrangement.Top,
        modifier = Modifier.fillMaxSize().background(Color.Black)
    ) {
        osStatsView(osStatsPresent(platformOsStats()))
    }
}

@Composable
fun osStatsView(model: OsStatsPresent) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier
            .background(Color(160, 80, 160)) // purple
            .padding(all = 12.dp)
    ) {
        Text(
            text = model.name,
            color = Color.White,
            style = MaterialTheme.typography.subtitle2)
        Text(
            text = model.version,
            color = Color.White,
            style = MaterialTheme.typography.subtitle1)
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    InformobTheme {
    }
}
