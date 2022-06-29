package org.informob.side

import org.informob.pure.*

data class AppMutant(
    val appState: AppState = AppState(),
    val platformBlobRef: Any
)

fun appMutant(platformBlobRef: Any): AppMutant =
    AppMutant(platformBlobRef = platformBlobRef)
