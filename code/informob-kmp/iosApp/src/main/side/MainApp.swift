import SwiftUI
import shared

@main
struct MainApp: App {
    var body: some Scene { WindowGroup { ContentView() } }
    init() {
        AppFlowKt.enterApp(appMutant: AppMutantKt.appMutant(
            platformBlobRef: PlatformBlob()))
    }
}
