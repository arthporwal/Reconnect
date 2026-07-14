allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

subprojects {
    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = JavaVersion.VERSION_11.toString()
        targetCompatibility = JavaVersion.VERSION_11.toString()
    }

    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
        }
    }
}

subprojects {
    plugins.withId("com.android.library") {
        extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
            compileSdk = 36

            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_11
                targetCompatibility = JavaVersion.VERSION_11
            }

            if (namespace == null) {
                val manifestFile = project.file("src/main/AndroidManifest.xml")
                val manifestPackage =
                    if (manifestFile.exists()) {
                        Regex("""package="([^"]+)"""")
                            .find(manifestFile.readText())
                            ?.groupValues
                            ?.get(1)
                    } else {
                        null
                    }

                if (manifestPackage != null) {
                    namespace = manifestPackage
                }
            }

            buildFeatures.buildConfig = true
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
