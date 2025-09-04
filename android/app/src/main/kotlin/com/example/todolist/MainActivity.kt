package com.example.todolist

import android.app.AlarmManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "alarm_permission"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "canScheduleExactAlarms") {
                val alarmManager = getSystemService(ALARM_SERVICE) as AlarmManager
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    result.success(alarmManager.canScheduleExactAlarms())
                } else {
                    result.success(true) // Android 11 ve altı zaten izin istemiyor
                }
            } else {
                result.notImplemented()
            }
        }
    }
}