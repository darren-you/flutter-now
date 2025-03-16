package cn.darrenyou.flutternow

import android.content.ClipboardManager
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import top.canyie.pine.Pine
import top.canyie.pine.callback.MethodHook
import java.lang.reflect.Method

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 初始化 Pine
        Pine.ensureInitialized()

        // Hook ClipboardManager.getPrimaryClipDescription
        hookClipboardMethod()

        Log.d("PineHook", "初始化完成✅")
    }

    private fun hookClipboardMethod() {
        try {
            // 获取 ClipboardManager 类
            val clipboardClass = Class.forName("android.content.ClipboardManager")

            // 获取 getPrimaryClipDescription 方法
            val method: Method = clipboardClass.getDeclaredMethod("getPrimaryClipDescription")

            // 使用 Pine Hook 方法
            Pine.hook(method, object : MethodHook() {
                override fun beforeCall(callFrame: Pine.CallFrame) {
                    // Log before the method call
                    Log.d("PineHook", "调用 getPrimaryClipDescription() 🙅")
                }

                override fun afterCall(callFrame: Pine.CallFrame) {
                    // Preserve original method behavior
                    callFrame.result
                }
            })
        } catch (e: Exception) {
            Log.e("PineHook", "Hook failed ❌", e)
        }
    }
}
