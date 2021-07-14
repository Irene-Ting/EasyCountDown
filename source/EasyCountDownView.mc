import Toybox.WatchUi;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class EasyCountDownView extends WatchUi.View {
    const MAX_ACTIVITY = 3;
    const WEEK = 7;
    const SECOND_OF_DAY = 86400;
    const APP_ICON_WIDTH = 50;
    const SADFACE_ICON_WIDTH = 100;

    private var activityNames = new [MAX_ACTIVITY];
    private var activityDateUnixs = new [MAX_ACTIVITY];
    private var numOfActivity;
    private var appIcon;
    private var sadFaceIcon;
    private var dcWidth;
    private var dcHeight;
    private var timeZoneOffset;
    private var todayMoment;

    function initialize() {
        View.initialize();
        timeZoneOffset = System.getClockTime().timeZoneOffset;
        todayMoment = new Time.Moment(Time.today().value());
        numOfActivity = loadActivityFromSetting();
        sortActivityByTime();
        App.getApp().setProperty("totalPages", numOfActivity);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        appIcon = App.loadResource(Rez.Drawables.CalendarIcon);
        sadFaceIcon = App.loadResource(Rez.Drawables.SadFace);
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

        drawAppIcon(dc);
        drawPageArc(dc);

        if(numOfActivity==0) {
            drawEmptyMsg(dc);
        } else {
            for(var i = 0; i < numOfActivity; i++) {
                drawActivity(dc, i);
            }
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function loadActivityFromSetting() {
        var index = 0;
        for(var i = 1; i <= MAX_ACTIVITY; i++) {
            var activityName = getApp().getProperty("activityName"+i.toString());
            var activityDateUnix = getApp().getProperty("activityDate"+i.toString());
            if(activityName.length() != 0) {
                activityNames[index] = activityName;
                activityDateUnixs[index] = activityDateUnix;
                index += 1;
            }
        }
        return index;
    }

    function sortActivityByTime() {
        for(var i = 0; i < numOfActivity; i++) {
            for(var j = i; j < numOfActivity; j++) {
                if(activityDateUnixs[i] > activityDateUnixs[j]) {
                    var tmp = activityDateUnixs[i];
                    activityDateUnixs[i] = activityDateUnixs[j];
                    activityDateUnixs[j] = tmp;

                    tmp = activityNames[i];
                    activityNames[i] = activityNames[j];
                    activityNames[j] = tmp;
                }
            }
        }
    }

    function drawAppIcon(dc) {
        dc.drawBitmap(
            dcWidth / 2 - APP_ICON_WIDTH / 2,
            0,
            appIcon
        );
    }

    function drawPageArc(dc) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(10);
        dc.drawArc(
            dcWidth / 2,
            dcHeight / 2,
            dcHeight / 2,
            Gfx.ARC_COUNTER_CLOCKWISE,
            20,
            40
        );
    }

    function drawEmptyMsg(dc) {
        dc.drawBitmap(
            dcWidth / 2 - SADFACE_ICON_WIDTH / 2,
            dcHeight / 2 - SADFACE_ICON_WIDTH / 2,
            sadFaceIcon
        );
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(
	    	dcWidth / 2, 
	    	dcHeight * 0.75, 
	    	Gfx.FONT_XTINY, 
	    	"go to setting and\nadd your 1st activity", 
	    	Gfx.TEXT_JUSTIFY_CENTER
	    );
    }

    function drawActivity(dc, idx) {
        var days = calculateDays(idx);
        var color = getColor(days);
        var position = 0.1 + 0.9 * (idx+1)/(numOfActivity+1);
        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(5);
        dc.drawPoint(
            dcWidth * 0.2,
            dcHeight * position
        );
        dc.drawText(
	    	dcWidth * 0.25, 
	    	dcHeight * position, 
	    	Gfx.FONT_SMALL, 
	    	activityNames[idx], 
	    	Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER
	    );
        dc.drawText(
	    	dcWidth * 0.75, 
	    	dcHeight * position, 
	    	Gfx.FONT_SMALL, 
	    	days, 
	    	Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER
	    );
    }

    function calculateDays(idx) {
        var activityDateString = transferUnixToString(activityDateUnixs[idx]);
        var activityDateMoment = new Time.Moment(activityDateUnixs[idx]-timeZoneOffset);
        var interval = todayMoment.subtract(activityDateMoment);
        return interval.value() / SECOND_OF_DAY;
    }

    function transferUnixToString(unix) {
        // format: 2021/7/13
        var moment = new Time.Moment(unix);
        var lang = Gregorian.info(moment, Time.FORMAT_SHORT);
		return lang.format("$1$/$2$/$3$", [lang.year, lang.month, lang.day]);
    }

    function getColor(days) {
        if(days > WEEK * 12) {
            return Gfx.COLOR_PURPLE;
        } else if(days > WEEK * 4) {
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
