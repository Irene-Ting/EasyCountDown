import Toybox.System;
using Toybox.WatchUi;
using Toybox.Application as App;
class EasyCountDownDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        var totalPages = App.getApp().getProperty("totalPages");
        if(totalPages == 0) {
            return;
        }
        App.getApp().setProperty("curPage", 0);
        var view = new BigCountDownView(0);
        var delegate = new BigCountDownDelegate();
        WatchUi.pushView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onMenu() {
        return true;
    }
}