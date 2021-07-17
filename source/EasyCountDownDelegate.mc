import Toybox.System;
using Toybox.WatchUi;
using Toybox.Application as App;
class EasyCountDownDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        var totalPages = App.Storage.getValue("totalPages");
        if(totalPages == 0) {
            return;
        }
        App.Storage.setValue("curPage", 0);
        var view = new BigCountDownView(0);
        var delegate = new BigCountDownDelegate();
        WatchUi.pushView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onMenu() {
        return true;
    }
}