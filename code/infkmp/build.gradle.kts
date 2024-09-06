plugins {
    val versionAgp = "8.1.1"
    id("com.android.application")   .version(versionAgp).apply(false)
    id("com.android.library")       .version(versionAgp).apply(false)
    //val versionKotlin = "1.7.10" // !!! required for compose 1.3.1 WHICH CAUSES UI TESTS TO FAIL
    //val versionKotlin = "1.8.0"  // !!! required for compose compiler 1.4.0
    //val versionKotlin = "1.8.10" // !!! required for compose compiler 1.4.4
    //val versionKotlin = "1.8.20" // !!! required for compose compiler 1.4.5
    //val versionKotlin = "1.9.10" // !!! required for iOS 17
    val versionKotlin = "1.9.20"   // !!! matches KMP plugin 0.8.1
    kotlin("android")               .version(versionKotlin).apply(false)
    kotlin("multiplatform")         .version(versionKotlin).apply(false)
/* TODO: @@@ ONLY NEEDED FOR compose-multiplatform
    id("org.jetbrains.compose").version("1.4.0").apply(false)
 */
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}