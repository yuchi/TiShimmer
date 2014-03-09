package it.ti.shimmer;

import android.app.Activity;
import android.os.Message;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.kroll.common.AsyncResult;
import org.appcelerator.kroll.common.TiMessenger;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.TiContext;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.view.TiUIView;

@Kroll.proxy(creatableInModule=ShimmerModule.class, propertyAccessors = {})
public class ShimmerViewProxy extends TiViewProxy {

    private static final int MSG_FIRST_ID = TiViewProxy.MSG_LAST_ID + 1;
    private static final int MSG_START_SHIMMING = MSG_FIRST_ID + 900;
    private static final int MSG_END_SHIMMING = MSG_FIRST_ID + 901;

    public ShimmerViewProxy() {
        super();
    }

    public ShimmerViewProxy(TiContext tiContext) {
        super();
    }

    @Override
    public TiUIView createView(Activity activity) {
        return new ShimmerView(this);
    }

    @Override
    public boolean handleMessage(Message msg) {
        switch (msg.what) {
            case MSG_START_SHIMMING: {
                AsyncResult result = (AsyncResult)msg.obj;
                handleStartShimming();
                result.setResult(null);
                return true;
            }

            case MSG_END_SHIMMING: {
                AsyncResult result = (AsyncResult)msg.obj;
                handleEndShimming();
                result.setResult(null);
                return true;
            }

            default: {
                return super.handleMessage(msg);
            }
        }
    }

    @Kroll.method
    public void startShimming() {
        if (TiApplication.isUIThread()) {
            handleStartShimming();
        }
        else {
            TiMessenger.sendBlockingMainMessage(getMainHandler().obtainMessage(MSG_START_SHIMMING));
        }
    }

    @Kroll.method
    public void endShimming() {
        if (TiApplication.isUIThread()) {
            handleEndShimming();
        }
        else {
            TiMessenger.sendBlockingMainMessage(getMainHandler().obtainMessage(MSG_END_SHIMMING));
        }
    }

    @Kroll.method
    public void stopShimming() {
        endShimming();
    }

    public void handleStartShimming() {
        TiUIView view = peekView();

        if (view != null) {
            ((ShimmerView)view).startShimming();
        }
    }

    public void handleEndShimming() {
        TiUIView view = peekView();

        if (view != null) {
            ((ShimmerView)view).endShimming();
        }
    }

    @Override
    public String getApiName() {
        return "it.ti.shimmer.ShimmerView";
    }

}
