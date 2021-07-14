import Toybox.System;
using Toybox.WatchUi;
using Toybox.Application as App;

class BigCountDownDelegate extends WatchUi.BehaviorDelegate {
    private var totalPages;
    private var curPage;

    function initialize() {
        BehaviorDelegate.initialize();
        totalPages = App.getApp().getProperty("totalPages");
        curPage = App.getApp().getProperty("curPage");
    }

    function onNextPage() {
        curPage = (curPage + 1) % totalPages;
        App.getApp().setProperty("curPage", curPage);
        var view = new BigCountDownView(curPage);
        var delegate = new BigCountDownDelegate();
        WatchUi.switchToView(view, delegate, WatchUi.SLIDE_DOWN);
        return true;
    }

    function onPreviousPage() {
        curPage = (curPage + (totalPages-1)) % totalPages;
        App.getApp().setProperty("curPage", curPage);
        var view = new BigCountDownView(curPage);
        var delegate = new BigCountDownDelegate();
        WatchUi.switchToView(view, delegate, WatchUi.SLIDE_UP);
        return true;
    }
    
    function onMenu() {
        return true;
    }
}