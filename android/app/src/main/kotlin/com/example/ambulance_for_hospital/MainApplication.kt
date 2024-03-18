package com.example.ambulance_for_hospital

import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
//        MapKitFactory.setLocale("ru") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("fc8b36d3-c7c1-48be-9150-e53ac6f07438") // Your generated API key
    }
}