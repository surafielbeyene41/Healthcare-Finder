plugins {
    id("com.android.application")
    id("com.google.gms.google-services") version "4.3.15" apply true  // Ensure this is applied
    id("com.google.firebase.crashlytics") version "2.9.2" apply true  // Ensure this is applied if you are using crashlytics
}

android {
    namespace = "com.example.healthcare_finder" // Set the correct namespace here
    compileSdk = 33

    defaultConfig {
        applicationId = "com.example.healthcare_finder"
        minSdk = 21
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

repositories {
    google()  // Ensure this is defined
    mavenCentral()
}

dependencies {
    implementation("com.google.firebase:firebase-bom:32.3.1")
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.gms:google-services:4.3.15")  // Make sure this dependency is included in the app module
}
