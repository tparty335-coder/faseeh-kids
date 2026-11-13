# Flutter-specific ProGuard rules
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.app.** { *; }
-dontwarn io.flutter.**

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Hive (local storage for progress data)
-keep class com.hive.** { *; }
-keepclassmembers class * {
    @com.hive.HiveField *;
}

# just_audio and audio_service
-keep class com.google.android.exoplayer2.** { *; }
-dontwarn com.google.android.exoplayer2.**
-keep class com.ryanheise.** { *; }
-dontwarn com.ryanheise.**

# audioplayers
-keep class xyz.luan.audioplayers.** { *; }
-dontwarn xyz.luan.audioplayers.**

# RevenueCat (purchases_flutter / BillingClient)
-keep class com.revenuecat.purchases.** { *; }
-keep class com.revenuecat.purchases_flutter.** { *; }
-keep class com.revenuecat.purchases_ui_flutter.** { *; }
-dontwarn com.revenuecat.purchases.**
-dontwarn com.amazon.**
-keep class com.amazon.** { *; }
-keep class com.android.billingclient.** { *; }
-keep class androidx.lifecycle.DefaultLifecycleObserver
-keep class org.xmlpull.v1.** { *; }

# riverpod
-keep class dev.rrousselgit.riverpod.** { *; }

# Keep all model classes annotated with HiveType
-keepattributes *Annotation*
-keepattributes Signature

# General
-dontnote kotlinx.serialization.AnnotationsKt
-dontwarn kotlin.**
