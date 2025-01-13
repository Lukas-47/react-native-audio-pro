package dev.rnap

import android.util.Log
import com.facebook.react.bridge.*
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.modules.core.DeviceEventManagerModule

@ReactModule(name = AudioProModule.NAME)
class AudioProModule(reactContext: ReactApplicationContext) : NativeModule {
    companion object {
        const val NAME = "AudioPro"
    }

    private val reactContext: ReactApplicationContext = reactContext
    private var isLoaded: Boolean = false

    enum class AudioProEvent(val eventName: String) {
        BUFFERING("BUFFERING"),
        PLAYING("PLAYING"),
        PAUSED("PAUSED"),
        FINISHED("FINISHED"),
        ERROR("ERROR");
    }

    override fun getName(): String {
        return NAME
    }

    override fun initialize() {
        Log.d("AudioPro", "Module initialized")
    }

    override fun invalidate() {
        Log.d("AudioPro", "Module invalidated")
        // Add any cleanup code here, if needed
    }

    private fun sendEvent(event: AudioProEvent, params: WritableMap?) {
        if (reactContext.hasActiveCatalystInstance()) {
            Log.d("AudioPro", "Sending event: ${event.eventName}")
            reactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
                ?.emit(event.eventName, params)
        } else {
            Log.w("AudioPro", "React context is not active. Event ${event.eventName} not sent.")
        }
    }

    @ReactMethod
    fun load(mediaFile: ReadableMap, promise: Promise) {
        val url = mediaFile.getString("url")
        val title = mediaFile.getString("title")
        val artist = mediaFile.getString("artist")
        val artwork = mediaFile.getString("artwork")

        if (url == null || title == null || artist == null || artwork == null) {
            promise.reject("E_MISSING_PARAMS", "Missing required parameters")
            return
        }

        isLoaded = true
        Log.d("AudioPro", "Loading media file: $mediaFile")
        val params = Arguments.createMap().apply {
            putString("message", "Loading audio")
        }
        sendEvent(AudioProEvent.BUFFERING, params)
        promise.resolve(true)
    }

    @ReactMethod
    fun play(promise: Promise) {
        if (!isLoaded) {
            promise.reject("E_NOT_LOADED", "Audio not loaded. Call load() first.")
            return
        }

        Log.d("AudioPro", "Playing audio")
        val params = Arguments.createMap().apply {
            putString("message", "Playing audio")
        }
        sendEvent(AudioProEvent.PLAYING, params)
        promise.resolve(true)
    }

    @ReactMethod
    fun pause(promise: Promise) {
        if (!isLoaded) {
            promise.reject("E_NOT_LOADED", "Audio not loaded. Call load() first.")
            return
        }

        Log.d("AudioPro", "Pausing audio")
        val params = Arguments.createMap().apply {
            putString("message", "Pausing audio")
        }
        sendEvent(AudioProEvent.PAUSED, params)
        promise.resolve(true)
    }

    @ReactMethod
    fun stop(promise: Promise) {
        if (!isLoaded) {
            promise.reject("E_NOT_LOADED", "Audio not loaded. Call load() first.")
            return
        }

        isLoaded = false
        Log.d("AudioPro", "Stopping audio")
        val params = Arguments.createMap().apply {
            putString("message", "Stopping and releasing resources")
        }
        sendEvent(AudioProEvent.FINISHED, params)
        promise.resolve(true)
    }
}
