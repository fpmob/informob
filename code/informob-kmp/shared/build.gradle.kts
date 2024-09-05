val compose_version = "1.5.4"

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
            isStatic = true
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
                // TODO: @@@ not yet actually required
                //implementation("androidx.core:core-ktx:1.7.0")
                //implementation("androidx.compose.ui:ui:$compose_version")
                implementation("androidx.compose.material:material:$compose_version")
                implementation("androidx.compose.ui:ui-tooling-preview:$compose_version")
                // TODO: @@@ not yet actually required
                //implementation("androidx.lifecycle:lifecycle-runtime-ktx:0.3.1")
                implementation("androidx.activity:activity-compose:1.6.1")
                // TODO: @@@ not yet actually required
                //testImplementation("junit:junit:4.13.2")
                //androidTestImplementation("androidx.test.ext:junit:1.1.3")
                //androidTestImplementation("androidx.test.espresso:espresso-core:3.4.0")
                //androidTestImplementation("androidx.compose.ui:ui-test-junit4:$compose_version")
                //debugImplementation("androidx.compose.ui:ui-tooling:$compose_version")
                //debugImplementation("androidx.compose.ui:ui-test-manifest:$compose_version")
            }
        }
        //val androidTest by getting { kotlin.srcDir("src/androidTest") }
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

/* TODO: ### DISABLED UNTIL WE FIGURE OUT IF WE STILL NEED THIS
// !!! from https://github.com/cl3m/multiplatform-compose/blob/develop/multiplatform-compose/build.gradle.kts
// https://youtrack.jetbrains.com/issue/KT-38694
//workaround (https://github.com/arunkumar9t2/compose_mpp_workaround/tree/patch-1):
configurations {
    create("composeCompiler") {
        isCanBeConsumed = true
    }
}
dependencies {
    "composeCompiler"("androidx.compose.compiler:compiler:${compose_version}")
}
*/

android {
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    compileSdk = 34
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    defaultConfig {
        minSdk = 21
        targetSdk = 34
    }
/* TODO: ### DISABLED UNTIL WE FIGURE OUT IF WE STILL NEED THIS
    // !!! from https://github.com/cl3m/multiplatform-compose/blob/develop/multiplatform-compose/build.gradle.kts
    afterEvaluate {
        val composeCompilerJar =
            configurations["composeCompiler"]
                .resolve()
                .singleOrNull()
                ?: error("Please add \"androidx.compose:compose-compiler\" (and only that) as a \"composeCompiler\" dependency")
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile> {
            kotlinOptions.freeCompilerArgs += listOf("-Xuse-ir", "-Xplugin=$composeCompilerJar")
        }
    }
*/
    buildFeatures {
        compose = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = compose_version
    }
    namespace = "org.informob"
}
