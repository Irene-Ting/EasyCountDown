import Toybox.System;
using Toybox.WatchUi;
using Toybox.Application as App;
class EasyCountDownDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }
    // function onKey(keyEvent) {
        // System.println(keyEvent.getKey());         // e.g. KEY_MENU = 7
        // var view = new BigCountDownView("testing", "1000");
        // var delegate;
        // // menu.setTitle("My Menu");
        // // menu.addItem("Item One", :one);
        // // menu.addItem("Item Two", :two);
        // delegate = new EasyCountDownDelegate(); // a WatchUi.MenuInputDelegate
        // WatchUi.pushView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
        // return true;
    // }
    function onSelect() {
        System.println("onSelect");  
        App.getApp().setProperty("curPage", 0);
        var view = new BigCountDownView("testing", 1000);
        var delegate;
        delegate = new BigCountDownDelegate(); // a WatchUi.MenuInputDelegate
        WatchUi.pushView(view, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
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