package com.example.snry_remote

import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Bundle
import android.os.SystemClock
import android.util.Log
import android.view.KeyEvent
import android.view.Menu
import android.view.MenuItem
import android.view.MotionEvent
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress



class MainActivity : AppCompatActivity() {

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


        Log.d("TAG", "message")


        val rootView = window.decorView.rootView

        val s = DatagramSocket()

//        startActivity(Intent(ACTION_SETTINGS))

        //Create amd send a tap event at the current target loctaion to the PhotoView
        //From testing (on an original Google Pixel) a tap event needs an ACTION_DOWN followed shortly afterwards by
        //an ACTION_UP, so send both events
        //First, create amd send the ACTION_DOWN MotionEvent
        var originalDownTime: Long = SystemClock.uptimeMillis()
        var eventTime: Long = SystemClock.uptimeMillis() + 100
        var x = 100.0f
        var y = 100.0f
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
        Log.d("MSG", "rteurnVal: " + returnVal)

        //Create amd send the ACTION_UP MotionEvent
        eventTime = SystemClock.uptimeMillis() + 100
        motionEvent = MotionEvent.obtain(
                originalDownTime,
                eventTime,
                MotionEvent.ACTION_UP,
                x,
                y,
                metaState
        )
        returnVal = rootView.dispatchTouchEvent(motionEvent)
        Log.d("MSG", "rteurnVal: " + returnVal)

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


        val t2 = Thread(Runnable {
            for (item in arrayListOf(1, 2, 12)) {
                Log.d("TAG2", item.toString())
            }
            val bufferSize = AudioRecord.getMinBufferSize(44100,
                    AudioFormat.CHANNEL_IN_MONO,
                    AudioFormat.ENCODING_PCM_16BIT)
            val record = AudioRecord(MediaRecorder.AudioSource.DEFAULT,
                    44100,
                    AudioFormat.CHANNEL_IN_MONO,
                    AudioFormat.ENCODING_PCM_16BIT,
                    bufferSize)

        })

        t2.start()


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