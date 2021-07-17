import Toybox.WatchUi;
import Toybox.System;
import Toybox.Time;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian;
using Toybox.Application as App;

class BigCountDownView extends WatchUi.View {
    private var activityName;
    private var activityDate;
    private var activityDays;
    private var dcWidth;
    private var dcHeight;
    const WEEK = 7;

    function initialize(curPage) {
        View.initialize();
        var activityData = App.Storage.getValue("activityData");
        activityName = activityData[curPage][0];
        activityDays = activityData[curPage][1];
        activityDate = activityData[curPage][2];
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        dcWidth = dc.getWidth();
        dcHeight = dc.getHeight();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        drawActivityName(dc, activityName);
        drawActivityDate(dc, activityDate);
        drawCountDays(dc, activityDays);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function drawActivityName(dc, name) {
        var color = getColor(activityDays);
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
	    	dcWidth / 2, 
	    	dcHeight * 0.15, 
	    	Gfx.FONT_TINY, 
	    	name, 
	    	Gfx.TEXT_JUSTIFY_CENTER
	    );
    }

    function drawActivityDate(dc, date) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
	    	dcWidth / 2, 
	    	dcHeight * 0.25, 
	    	Gfx.FONT_TINY, 
	    	date, 
	    	Gfx.TEXT_JUSTIFY_CENTER
	    );
    }

    function drawCountDays(dc, days) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
	    	dcWidth / 2, 
	    	dcHeight * 0.6, 
	    	Gfx.FONT_LARGE, 
	    	days, 
	    	Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER
	    );

        var color = getColor(days);
        dc.setPenWidth(5);
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawCircle(
            dcWidth / 2,
            dcHeight * 0.6,
            dcWidth * 0.2
        );
    }

    function getColor(days) {
        if(days > WEEK * 12) {
            return Gfx.COLOR_PURPLE;
        } else if(days > WEEK *4) {
            return Gfx.COLOR_BLUE;
        } else if(days > WEEK) {
            return Gfx.COLOR_GREEN;
        } else if(days > 3) {
            return Gfx.COLOR_ORANGE;
        } else {
            return Gfx.COLOR_RED;
        }
    }
}
