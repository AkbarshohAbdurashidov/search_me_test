package com.example.search_me_test

import android.app.Application

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity(){
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        MapKitFactory.setApiKey("fa56eabe-fd5b-4269-ac5a-da0de01a002a")
        super.configureFlutterEngine(flutterEngine)
    }
}
