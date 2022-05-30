plugins {
    kotlin("multiplatform")
    id("com.android.library")
}

kotlin {
    android()
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
        }
    }

    sourceSets {
        val commonMain by getting { kotlin.srcDir("src/commonMain") }
        val commonTest by getting { kotlin.srcDir("src/commonTest")
            dependencies {
                implementation(kotlin("test"))
            }
        }
        val androidMain by getting { kotlin.srcDir("src/androidMain")
            dependencies {
                implementation("com.google.android.material:material:1.4.0")
                implementation("androidx.appcompat:appcompat:1.3.1")
                implementation("androidx.constraintlayout:constraintlayout:2.1.0")
            }
        }
        val androidTest by getting { kotlin.srcDir("src/androidTest") }
        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating { kotlin.srcDir("src/iosMain")
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)
        }
        val iosX64Test by getting
        val iosArm64Test by getting
        val iosSimulatorArm64Test by getting
        val iosTest by creating { kotlin.srcDir("src/iosTest")
            dependsOn(commonTest)
            iosX64Test.dependsOn(this)
            iosArm64Test.dependsOn(this)
            iosSimulatorArm64Test.dependsOn(this)
        }
    }
}

android {
    compileSdk = 32
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    defaultConfig {
        minSdk = 21
        targetSdk = 32
    }
}
