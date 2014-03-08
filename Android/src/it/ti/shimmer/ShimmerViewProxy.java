package it.ti.shimmer;

import android.app.Activity;

import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiContext;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.view.TiUIView;

@Kroll.proxy(creatableInModule=ShimmerModule.class, propertyAccessors = {})
public class ShimmerViewProxy extends TiViewProxy {

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
    public String getApiName() {
        return "it.ti.shimmer.ShimmerView";
    }

}
