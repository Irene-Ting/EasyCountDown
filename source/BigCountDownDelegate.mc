import Toybox.System;
using Toybox.WatchUi;
using Toybox.Application as App;

class BigCountDownDelegate extends WatchUi.BehaviorDelegate {
    private var totalPages;
    private var curPage;

    function initialize() {
        BehaviorDelegate.initialize();
        totalPages = 5;
        curPage = App.getApp().getProperty("curPage");
    }
    function onKey(keyEvent) {
        System.println(keyEvent.getKey());         // e.g. KEY_MENU = 7
        // var view = new BigCountDownView("testing", "1000");
        // var delegate;
        // // menu.setTitle("My Menu");
        // // menu.addItem("Item One", :one);
        // // menu.addItem("Item Two", :two);
        // delegate = new EasyCountDownDelegate(); // a WatchUi.MenuInputDelegate
        // WatchUi.pushView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
        // return true;
    }
    function onNextPage() {
        curPage = (curPage + 1) % totalPages;
        App.getApp().setProperty("curPage", curPage);
        System.println(curPage);
        var view = new BigCountDownView("next", curPage*86400);
        var delegate = new BigCountDownDelegate(); // a WatchUi.MenuInputDelegate
        WatchUi.switchToView(view, delegate, WatchUi.SLIDE_DOWN);
        return true;
    }
    function onPreviousPage() {
        curPage = (curPage + 4) % totalPages;
        App.getApp().setProperty("curPage", curPage);
        System.println(curPage);
        var view = new BigCountDownView("prev", curPage*86400);
        var delegate = new BigCountDownDelegate(); // a WatchUi.MenuInputDelegate
        WatchUi.switchToView(view, delegate, WatchUi.SLIDE_UP);
        return true;
    }
    // function onSelect() {
    //     System.println("onSelect");
    //     System.println(keyEvent.getKey());         // e.g. KEY_MENU = 7
    //     var view = new BigCountDownView("testing", "1000");
    //     var delegate;
    //     delegate = new EasyCountDownDelegate(); // a WatchUi.MenuInputDelegate
    //     WatchUi.pushView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
    //     return true;
    // }
    function onMenu() {
        // var menu = new WatchUi.Menu();
        // var delegate;
        // menu.setTitle("My Menu");
        // menu.addItem("Item One", :one);
        // menu.addItem("Item Two", :two);
        // delegate = new EasyCountDownDelegate(); // a WatchUi.MenuInputDelegate
        // WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}