package com.zj.play

import android.graphics.Color
import android.os.Build
import android.view.View
import android.view.Window
import android.view.WindowManager
import androidx.annotation.RequiresApi

/**
 * 版权：渤海新能 版权所有
 * @author zhujiang
 * 版本：1.5
 * 创建日期：2020/4/2
 * 描述：android
 *
 */
//隐藏状态栏
@RequiresApi(Build.VERSION_CODES.LOLLIPOP)
fun transparentStatusBar(window: Window) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        try {
            val decorViewClazz = Class.forName("com.android.internal.policy.DecorView")
            val field = decorViewClazz.getDeclaredField("mSemiTransparentStatusBarColor")
            field.isAccessible = true
            field.setInt(window.decorView, Color.TRANSPARENT) //改为透明
        } catch (ignored: Exception) {
        }
    }
    window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
    val option = View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        val vis = window.decorView.systemUiVisibility and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
        window.decorView.systemUiVisibility = option or vis
    } else {
        window.decorView.systemUiVisibility = option
    }
    window.statusBarColor = Color.TRANSPARENT
}