package com.example.snry_remote

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.SystemClock
import android.provider.MediaStore
import android.provider.Settings.ACTION_SETTINGS
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress
import android.view.MotionEvent;
import android.view.KeyEvent


class MainActivity : AppCompatActivity() {



    val REQUEST_CODE = 200

    fun capturePhoto() {

        val cameraIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        startActivityForResult(cameraIntent, REQUEST_CODE)
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK && requestCode == REQUEST_CODE && data != null){

        }
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        Log.d("TAG", "12312313123")
        return super.onKeyDown(keyCode, event)
    }

    override fun onGenericMotionEvent(event: MotionEvent?): Boolean {
        Log.d("TAG", "1233")
        return super.onGenericMotionEvent(event)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(findViewById(R.id.toolbar))

        Log.d("TAG", "message")



        val rootView = window.decorView.rootView

        val s = DatagramSocket()

        startActivity(Intent(ACTION_SETTINGS))

        startActivity(Intent(ACTION_SETTINGS))

        //Create amd send a tap event at the current target loctaion to the PhotoView
        //From testing (on an original Google Pixel) a tap event needs an ACTION_DOWN followed shortly afterwards by
        //an ACTION_UP, so send both events
        //First, create amd send the ACTION_DOWN MotionEvent
        var originalDownTime: Long = SystemClock.uptimeMillis()
        var eventTime: Long = SystemClock.uptimeMillis() + 100
        var x = 300.0f
        var y = 1000.0f
        var metaState = 0
        var motionEvent = MotionEvent.obtain(
            originalDownTime,
            eventTime,
            MotionEvent.ACTION_DOWN,
            x,
            y,
            metaState
        )
        var returnVal = rootView.dispatchTouchEvent(motionEvent)
          Log.d("MSG","rteurnVal: " + returnVal)

        //Create amd send the ACTION_UP MotionEvent
        eventTime= SystemClock.uptimeMillis() + 100
        motionEvent = MotionEvent.obtain(
            originalDownTime,
            eventTime,
            MotionEvent.ACTION_UP,
            x,
            y,
            metaState
        )
        returnVal = rootView.dispatchTouchEvent(motionEvent)
        Log.d("MSG","rteurnVal: " + returnVal)

        rootView.dispatchTouchEvent(motionEvent)

        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener { view ->
            Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                    .setAction("Action", null).show()



            val m = "33468!"
            val p = DatagramPacket(m.toByteArray(), m.length,
                    InetAddress.getByName("192.168.1.103"), 8900)

            val t = Thread(Runnable {
                s.send(p)
            })
            t.start()



        }


    }





    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.

        return when (item.itemId) {
            R.id.action_settings -> true
            else -> super.onOptionsItemSelected(item)
        }
    }
}