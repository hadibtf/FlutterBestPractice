package com.android.thisisyou;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Point;
import android.os.Bundle;
import android.util.Log;
import android.view.Display;

public class LauncherActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        init();
    }

    private void init() {
        setContentView(R.layout.activity_launcher);

        Display display = getWindowManager(). getDefaultDisplay();
        Point size = new Point();
        display. getSize(size);
        int width = size.x;
        int height = size.y;
        Log.e("---Width", "" + width);
        Log.e("---Height", "" + height);
    }
}
