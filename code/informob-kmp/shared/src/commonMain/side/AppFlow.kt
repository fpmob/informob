package org.informob.side

import org.informob.pure.*

expect fun viewApp(appMutant: AppMutant): Boolean

fun enterApp(appMutant: AppMutant): AppMutant =
    appMutant.copy(appState = AppState(entered = viewApp(appMutant)))

fun leaveApp(appMutant: AppMutant): AppMutant =
    appMutant.copy(appState = AppState(entered = true))
