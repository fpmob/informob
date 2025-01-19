// Copyright © 2022 - 2025 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.side

import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.*
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.*
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.*
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.*

import org.informob.pure.present.*
import org.informob.ui.theme.jpcThemeInf

fun andPresentMainScreen(appMutant: AppMutant): AppMutant = appMutant.apply {
    ((platformBlobRef as? AndPlatformBlob)?.activity)?.run {
        setContent { // !!! will not work outside of Activity class
            jpcThemeInf { jpcViewMain() }
        }
    }
}

val colorBackDraw   = Color(red=0.7f,green=0.6f,blue=0.6f)
val colorBackOs     = Color(red=0.2f,green=0.2f,blue=0.2f)
val colorBackPerf   = Color(red=0.7f,green=0.7f,blue=0.6f)
val colorBackRandom = Color(red=0.6f,green=0.7f,blue=0.6f)
val colorBackStress = Color(red=0.6f,green=0.7f,blue=0.7f)
val colorBordDebug  = Color(red=1.0f,green=1.0f,blue=0.0f) // .yellow
val colorBordDraw   = Color(red=0.6f,green=0.0f,blue=0.0f)
val colorBordPerf   = Color(red=0.6f,green=0.4f,blue=0.0f)
val colorBordRandom = Color(red=0.0f,green=0.5f,blue=0.0f)
val colorBordStress = Color(red=0.0f,green=0.2f,blue=0.7f)
val colorForeDraw   = Color(red=0.6f,green=0.3f,blue=0.3f)
val colorForeOs     = Color(red=0.7f,green=0.7f,blue=0.7f)
val colorForePerf   = Color(red=0.6f,green=0.4f,blue=0.2f)
val colorForeRandom = Color(red=0.6f,green=0.7f,blue=0.6f)
val colorForeStress = Color(red=0.4f,green=0.4f,blue=0.8f)

val paddingCommon   = 16
val paddingOsStats  = 8
val widthBordPanel  = 4.0

@Composable
fun jpcViewMain()
  = Column(
        horizontalAlignment = Alignment.Start,
        verticalArrangement = Arrangement.Top,
        modifier = Modifier.fillMaxSize().background(Color.Black)
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Column(modifier = Modifier.weight(0.36f)
                   .padding(all = paddingCommon.dp)) {
                jpcViewOsStats(osStatsPresent(platformOsStats()))
            }
            Column(modifier = Modifier.weight(0.32f)
                    .padding(top = paddingCommon.dp,
                             end = paddingCommon.dp,
                          bottom = paddingCommon.dp)) {
                jpcButtonPanel("Draws",  colorBackDraw    ) { }
                jpcButtonPanel("Random", colorBackRandom) { }
            }
            Column(modifier = Modifier.weight(0.32f)
                    .padding(top = paddingCommon.dp,
                             end = paddingCommon.dp,
                          bottom = paddingCommon.dp)) {
                jpcButtonPanel("Perfs",  colorBackPerf  ) { }
                jpcButtonPanel("Stress", colorBackStress) { }
            }
        }
    }

@Preview(showBackground = true)
@Composable
fun jpcViewMainPreview()
  = jpcThemeInf {}

@Composable
fun jpcButtonPanel(
    label: String,
    color: Color,
    action: () -> Unit
) =
    Button({ action },
        shape = (2f * paddingCommon).let { RoundedCornerShape(it, it, it, it) },
        colors = ButtonDefaults.buttonColors(backgroundColor = color),
        modifier = Modifier.fillMaxWidth()
    ) {
        Text(text = label,
            letterSpacing = 0.sp,
            overflow = TextOverflow.Clip,
            style = MaterialTheme.typography.button)
    }

@Composable
fun jpcViewOsStats(model: OsStatsPresent)
  = Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier
            .background(colorBackOs)
            .padding(all = paddingOsStats.dp)
    ) {
        Text(
            text      = model.name,
            color     = colorForeOs,
            textAlign = TextAlign.Center,
            style     = MaterialTheme.typography.subtitle2)
        Text(
            text      = model.version,
            color     = colorForeOs,
            textAlign = TextAlign.Center,
            style     = MaterialTheme.typography.subtitle1)
    }