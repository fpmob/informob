// Copyright © 2022 - 2025 Christopher Augustus
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.side

import androidx.activity.compose.setContent
import androidx.compose.foundation.*
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.*
import androidx.compose.material.*
import androidx.compose.runtime.*
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

fun colorFrom(c: ColorPalette)
  = c.value.let { Color(red = it.r, green = it.g, blue = it.b, alpha = it.a) }

val paddingCommon   = 16
val paddingOsStats  = 8
val widthBordPanel  = 4

@Composable
fun jpcViewMain()
  = Column(
        horizontalAlignment = Alignment.Start,
        verticalArrangement = Arrangement.Top,
        modifier = Modifier
            .background(Color.Black)
            .fillMaxSize()
    ) {
        var hasDraws  by remember { mutableStateOf(false) }
        var hasPerfs  by remember { mutableStateOf(false) }
        var hasRandom by remember { mutableStateOf(false) }
        var hasStress by remember { mutableStateOf(false) }
        Row(verticalAlignment = Alignment.CenterVertically) {
            Column(modifier = Modifier
                    .weight(0.36f)
                    .padding(all = paddingCommon.dp)) {
                jpcViewOsStats(osStatsPresent(platformOsStats()))
            }
            Column(modifier = Modifier.weight(0.32f)
                    .padding(top = paddingCommon.dp,
                             end = paddingCommon.dp,
                          bottom = paddingCommon.dp)) {
                jpcButtonPanel("Draws",  ColorPalette.BackDraw  ) { hasDraws  = !hasDraws }
                jpcButtonPanel("Random", ColorPalette.BackRandom) { hasRandom = !hasRandom}
            }
            Column(modifier = Modifier.weight(0.32f)
                    .padding(top = paddingCommon.dp,
                             end = paddingCommon.dp,
                          bottom = paddingCommon.dp)) {
                jpcButtonPanel("Perfs",  ColorPalette.BackPerf  ) { hasPerfs  = !hasPerfs }
                jpcButtonPanel("Stress", ColorPalette.BackStress) { hasStress = !hasStress }
            }
        }
        if (hasDraws || hasPerfs)
            Row(modifier = Modifier.weight(1.0f)) {
                if (hasDraws)  jpcViewDraws()
                if (hasPerfs)  jpcViewPerfs()
            }
        if (hasRandom || hasStress)
            Row(modifier = Modifier.weight(1.0f)) {
                if (hasRandom) jpcViewRandom()
                if (hasStress) jpcViewStress()
            }
    }

@Preview(showBackground = true)
@Composable
fun jpcViewMainPreview()
  = jpcThemeInf {}

@Composable
fun jpcButtonPanel(
    label:      String,
    colorBack:  ColorPalette,
    action:     () -> Unit
) =
    Button({ action() },
        shape = (2f * paddingCommon).let { RoundedCornerShape(it, it, it, it) },
        colors = ButtonDefaults.buttonColors(backgroundColor = colorFrom(colorBack)),
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
            .background(colorFrom(ColorPalette.BackOs))
            .padding(all = paddingOsStats.dp)
    ) {
        Text(
            text      = model.name,
            color     = colorFrom(ColorPalette.ForeOs),
            textAlign = TextAlign.Center,
            style     = MaterialTheme.typography.subtitle2)
        Text(
            text      = model.version,
            color     = colorFrom(ColorPalette.ForeOs),
            textAlign = TextAlign.Center,
            style     = MaterialTheme.typography.subtitle1)
    }

@Composable
fun RowScope.jpcViewPanel(colorBack: ColorPalette, colorBord: ColorPalette)
  = Box(modifier = Modifier
        .background(colorFrom(colorBack))
        .border(widthBordPanel.dp, colorFrom(colorBord))
        .fillMaxHeight()
        .weight(1.0f)
) {}

@Composable
fun RowScope.jpcViewDraws()
  = jpcViewPanel(ColorPalette.BackDraw,   ColorPalette.BordDraw)

@Composable
fun RowScope.jpcViewPerfs()
  = jpcViewPanel(ColorPalette.BackPerf,   ColorPalette.BordPerf)

@Composable
fun RowScope.jpcViewRandom()
  = jpcViewPanel(ColorPalette.BackRandom, ColorPalette.BordRandom)

@Composable
fun RowScope.jpcViewStress()
  = jpcViewPanel(ColorPalette.BackStress, ColorPalette.BordStress)
