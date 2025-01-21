//  Copyright © 2022 - 2025 Christopher Augustus
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

package org.informob.pure.present

data class ColorRgba(
    val r: Float, val g: Float, val b: Float, val a: Float = 1f)

enum class ColorPalette(val value: ColorRgba) {
   BackDraw   ( ColorRgba( 0.7f, 0.6f, 0.6f ) ),
   BackOs     ( ColorRgba( 0.2f, 0.2f, 0.2f ) ),
   BackPerf   ( ColorRgba( 0.7f, 0.7f, 0.6f ) ),
   BackRandom ( ColorRgba( 0.6f, 0.7f, 0.6f ) ),
   BackStress ( ColorRgba( 0.6f, 0.7f, 0.7f ) ),
   BordDebug  ( ColorRgba( 1.0f, 1.0f, 0.0f ) ),
   BordDraw   ( ColorRgba( 0.6f, 0.0f, 0.0f ) ),
   BordPerf   ( ColorRgba( 0.6f, 0.4f, 0.0f ) ),
   BordRandom ( ColorRgba( 0.0f, 0.5f, 0.0f ) ),
   BordStress ( ColorRgba( 0.0f, 0.2f, 0.7f ) ),
   ForeDraw   ( ColorRgba( 0.6f, 0.3f, 0.3f ) ),
   ForeOs     ( ColorRgba( 0.7f, 0.7f, 0.7f ) ),
   ForePerf   ( ColorRgba( 0.6f, 0.4f, 0.2f ) ),
   ForeRandom ( ColorRgba( 0.6f, 0.7f, 0.6f ) ),
   ForeStress ( ColorRgba( 0.4f, 0.4f, 0.8f ) ),
}
