package it.ti.shimmer;

import android.animation.Animator;
import android.animation.ObjectAnimator;
import android.animation.ValueAnimator;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Shader;
import android.util.AttributeSet;

import org.appcelerator.titanium.TiC;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.util.TiConvert;
import org.appcelerator.titanium.view.TiCompositeLayout;
import org.appcelerator.titanium.view.TiUIView;

public class ShimmerView extends TiUIView {

    protected TiCompositeLayout view;
    protected ObjectAnimator maskAnimator;
    protected ObjectAnimator introAnimator;

    protected float maskX = 0.0f;
    protected float maskFactor = 0.0f;

    protected long shimmeringBeginFadeDuration = 300;
    protected long shimmeringSpeed = 2000;
    protected float shimmeringRelativeSize = 0.2f;

    protected int fullOpacity = 0xFF;
    protected int dimOpacity = 0x70;
    protected int shimOpacity = 0xFF;

    protected boolean shimming = false;

    public static final String TAG = "Shimmer";

    public ShimmerView(final TiViewProxy proxy) {
        super(proxy);

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

        maskAnimator = ObjectAnimator.ofFloat(this, "maskX", 0.0f, 1.0f);
        maskAnimator.setDuration(shimmeringSpeed);
        maskAnimator.setRepeatCount(ValueAnimator.INFINITE);
        maskAnimator.addListener(new Animator.AnimatorListener() {

            @Override
            public void onAnimationStart(Animator animator) {
                shimming = true;
            }

            @Override
            public void onAnimationEnd(Animator animator) {
                shimming = false;
            }

            @Override
            public void onAnimationCancel(Animator animator) {
                //
            }

            @Override
            public void onAnimationRepeat(Animator animator) {
                //
            }
        });

        introAnimator = ObjectAnimator.ofFloat(this, "maskFactor", 1.0f);
        introAnimator.setDuration(shimmeringBeginFadeDuration);
        introAnimator.setRepeatCount(0);
        introAnimator.addListener(new Animator.AnimatorListener() {

            @Override
            public void onAnimationStart(Animator animator) {
                if (!shimming) {
                    maskAnimator.start();
                }
            }

            @Override
            public void onAnimationEnd(Animator animator) {
                if (maskFactor == 0) {
                    maskAnimator.end();
                }
            }

            @Override
            public void onAnimationCancel(Animator animator) {
                //
            }

            @Override
            public void onAnimationRepeat(Animator animator) {
                //
            }
        });

        setNativeView(view);
    }

    public void startShimming() {
        introAnimator.setFloatValues(1.0f);
        introAnimator.start();
    }

    public void endShimming() {
        introAnimator.setFloatValues(0.0f);
        introAnimator.start();
    }

    public void setMaskFactor(float maskFactor) {
        this.maskFactor = maskFactor;
        view.invalidate();
    }

    public void setMaskX(float maskX) {
        this.maskX = maskX;
        view.invalidate();
    }

    public float getMaskFactor() {
        return maskFactor;
    }

    public float getMaskX() {
        return maskX;
    }

    protected class ShimmerCompositeLayout extends TiCompositeLayout {

        public ShimmerCompositeLayout(Context context) {
            super(context);
        }

        public ShimmerCompositeLayout(
                Context context, TiCompositeLayout.LayoutArrangement arrangement) {
            super(context, arrangement);
        }

        public ShimmerCompositeLayout(Context context, AttributeSet set) {
            super(context, set);
        }

        public ShimmerCompositeLayout(Context context, TiViewProxy proxy) {
            super(context, proxy);
        }

        public ShimmerCompositeLayout(
                Context context, TiCompositeLayout.LayoutArrangement arrangement,
                TiViewProxy proxy) {
            super(context, arrangement, proxy);
        }

        @Override
        public void dispatchDraw(Canvas canvas) {
            if (maskFactor > 0) {
                int width = canvas.getWidth();
                int height = canvas.getHeight();

                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                Canvas buffer = new Canvas(bitmap);

                Paint paint = new Paint();

                paint.setFilterBitmap(false);

                int highColor =
                    Color.argb(clamp(fullOpacity, shimOpacity, maskFactor), 255, 255, 255);
                int lowColor =
                    Color.argb(clamp(fullOpacity, dimOpacity, maskFactor), 255, 255, 255);

                float shimSize = width * shimmeringRelativeSize;
                float gradientSize = width * 2 + shimSize;

                float x0 = (0 - width - shimSize) * (1 - maskX);
                float x1 = x0 + gradientSize;

                float shimInitialPosition = width / gradientSize;
                float shimFinalPosition = 1 - shimInitialPosition;

                Shader shader = new LinearGradient(
                    x0, 0, x1, 0,
                    new int[] { lowColor, lowColor, highColor, lowColor, lowColor },
                    new float[] { 0, shimInitialPosition, 0.5f, shimFinalPosition, 1 },
                    Shader.TileMode.CLAMP);

                paint.setShader(shader);
                paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.DST_IN));

                super.dispatchDraw(buffer);

                buffer.drawPaint(paint);

                canvas.drawBitmap(bitmap, 0, 0, null);
            }
            else {
                super.dispatchDraw(canvas);
            }
        }

        public int clamp(int from, int to, float factor) {
            return Math.round(from * (1 - factor) + to * factor);
        }
    }
}
