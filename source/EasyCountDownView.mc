import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Time;
using Toybox.Time.Gregorian;

class EasyCountDownView extends WatchUi.View {
    private var activityName;
    private var activityDateUnix;
    private var utc;
    private var width;
    private var height;

    const WEEK = 7;

    function initialize() {
        View.initialize();
        activityName = getApp().getProperty("activityName");
        activityDateUnix = getApp().getProperty("activityDate");
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        width = dc.getWidth();
        height = dc.getHeight();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var activityDateString = transferUnixToString(activityDateUnix);

        var timeZoneOffset = System.getClockTime().timeZoneOffset;
        var activityDateMoment = new Time.Moment(activityDateUnix-timeZoneOffset);
        var todayMoment = new Time.Moment(Time.today().value());
        var interval = todayMoment.subtract(activityDateMoment);
        var days = interval.value() / 86400;

        // System.println(days);
        // System.println(activityDateString);

        // draw
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        drawActivityName(dc);
        drawActivityDate(dc, activityDateString);
        drawCountDays(dc, days);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function transferUnixToString(unix) {
        var moment = new Time.Moment(unix);
        var lang = Gregorian.info(moment, Time.FORMAT_SHORT);
		return lang.format("$1$/$2$/$3$", [lang.year, lang.month, lang.day]);
    }

    function drawActivityName(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
	    	width / 2, 
	    	height * 0.15, 
	    	Graphics.FONT_TINY, 
	    	activityName, 
	    	Graphics.TEXT_JUSTIFY_CENTER
	    );
    }

    function drawActivityDate(dc, activityDateString) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
	    	width / 2, 
	    	height * 0.25, 
	    	Graphics.FONT_TINY, 
	    	activityDateString, 
	    	Graphics.TEXT_JUSTIFY_CENTER
	    );
    }

    function drawCountDays(dc, days) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
	    	width / 2, 
	    	height * 0.6, 
	    	Graphics.FONT_LARGE, 
	    	days, 
	    	Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
	    );

        var color = getColor(days);
        dc.setPenWidth(5);
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.drawCircle(
            width / 2,
            height * 0.6,
            width * 0.2
        );
    }

    function getColor(days) {
        if(days > WEEK * 12) {
            return Graphics.COLOR_PURPLE;
        } else if(days > WEEK *4) {
            return Graphics.COLOR_BLUE;
        } else if(days > WEEK) {
            return Graphics.COLOR_GREEN;
        } else if(days > 3) {
            return Graphics.COLOR_ORANGE;
        } else {
            return Graphics.COLOR_RED;
        }
    }

}
