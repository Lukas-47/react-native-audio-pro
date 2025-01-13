package dev.rnap

import com.facebook.react.TurboReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider
import com.facebook.react.module.annotations.ReactModule

@ReactModule(name = AudioProModule.NAME)
class AudioProPackage : TurboReactPackage() {
    override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? {
        return if (name == AudioProModule.NAME) {
            AudioProModule(reactContext)
        } else {
            null
        }
    }

    override fun getReactModuleInfoProvider(): ReactModuleInfoProvider {
        return ReactModuleInfoProvider {
            mapOf(
                AudioProModule.NAME to ReactModuleInfo(
                    AudioProModule.NAME,
                    AudioProModule::class.java.name,
                    false, // canOverrideExistingModule
                    false, // needsEagerInit
                    true,  // hasConstants
                    false, // isCxxModule
                    true   // supportsTurboModule
                )
            )
        }
    }
}
