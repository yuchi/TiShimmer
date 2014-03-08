package it.ti.shimmer;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.DrawFilter;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.RectF;
import android.graphics.Region;
import android.graphics.Shader;
import android.util.AttributeSet;
import android.widget.LinearLayout;

import org.appcelerator.titanium.TiC;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.util.TiColorHelper;
import org.appcelerator.titanium.util.TiConvert;
import org.appcelerator.titanium.util.TiUIHelper;
import org.appcelerator.titanium.view.TiCompositeLayout;
import org.appcelerator.titanium.view.TiUIView;

public class ShimmerView extends TiUIView {

    private TiCompositeLayout view;

    public static final String TAG = "Shimmer";

    public ShimmerView(final TiViewProxy proxy) {
        super(proxy);

        final ShimmerView that = this;

        TiCompositeLayout.LayoutArrangement arrangement =
            TiCompositeLayout.LayoutArrangement.DEFAULT;

        if (proxy.hasProperty(TiC.PROPERTY_LAYOUT)) {
            String layoutProperty = TiConvert.toString(proxy.getProperty(TiC.PROPERTY_LAYOUT));
            if (layoutProperty.equals(TiC.LAYOUT_HORIZONTAL)) {
                arrangement = TiCompositeLayout.LayoutArrangement.HORIZONTAL;
            } else if (layoutProperty.equals(TiC.LAYOUT_VERTICAL)) {
                arrangement = TiCompositeLayout.LayoutArrangement.VERTICAL;
            }
        }

        view = new ShimmerCompositeLayout(proxy.getActivity(), arrangement, proxy);

        setNativeView(view);
    }

    protected class MyDrawFilter extends DrawFilter {

    }

    protected class ShimmerCompositeLayout extends TiCompositeLayout {

        public ShimmerCompositeLayout(Context context) {
            super(context);
        }

        public ShimmerCompositeLayout(Context context, TiCompositeLayout.LayoutArrangement arrangement) {
            super(context, arrangement);
        }

        public ShimmerCompositeLayout(Context context, AttributeSet set) {
            super(context, set);
        }

        public ShimmerCompositeLayout(Context context, TiViewProxy proxy) {
            super(context, proxy);
        }

        public ShimmerCompositeLayout(Context context, TiCompositeLayout.LayoutArrangement arrangement, TiViewProxy proxy) {
            super(context, arrangement, proxy);
        }

        @Override
        public void dispatchDraw(Canvas canvas) {
            System.out.println("dispatchDraw");

            /*Bitmap temporaryBitmap =
                Bitmap.createBitmap(canvas.getWidth(), canvas.getHeight(), Bitmap.Config.ARGB_8888);

            Canvas temporaryCanvas = new Canvas(temporaryBitmap);

            super.dispatchDraw(temporaryCanvas);*/

            Paint paint = new Paint();

            paint.setFilterBitmap(false);

            Shader shader = new LinearGradient(
                0, 0, canvas.getWidth(), 0, 0x70ffffff, 0x00ffffff,
                Shader.TileMode.REPEAT);

            paint.setShader(shader);
            paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.DST_IN));

            /*canvas.drawBitmap(temporaryBitmap, 0, 0, null);*/

            super.dispatchDraw(canvas);

            canvas.drawPaint(paint);
        }

        @Override
        protected void onDraw(Canvas canvas) {
            System.out.println("onDraw");
            super.onDraw(canvas);
        }

    }

}
