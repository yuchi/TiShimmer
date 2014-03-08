package it.ti.shimmer;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.TiContext;

@Kroll.module(name="Shimmer",id="it.ti.shimmer")
public class ShimmerModule extends KrollModule {

    public ShimmerModule(TiContext tiContext) {
        super(tiContext);
    }

}
