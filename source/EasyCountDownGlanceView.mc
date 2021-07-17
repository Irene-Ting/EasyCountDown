import Toybox.WatchUi;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

(:glance)
class EasyCountDownGlanceView extends WatchUi.GlanceView {
    const SECOND_OF_DAY = 86400;

    private var activityName = "";
    private var activityDateUnix;
    private var appIcon;
    private var timeZoneOffset;
    private var todayMoment;
    private var dcWidth;
    private var dcHeight;

    function initialize() {
        View.initialize();
        System.println("glance");
        timeZoneOffset = System.getClockTime().timeZoneOffset;
        todayMoment = new Time.Moment(Time.today().value());
        
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        dcWidth = dc.getWidth();
        dcHeight = dc.getHeight();
        // appIcon = App.loadResource(Rez.Drawables.CalendarIcon);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var activityName = App.Properties.getValue("activityName1");
        var activityDateUnix = App.Properties.getValue("activityDate1");
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        // drawAppIcon(dc);
        if(activityName.length() != 0) {
            var days = countDaysFromToday(activityDateUnix);
            drawActivity(dc, activityName, days);
        } else {
            System.println("null");
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function drawActivity(dc, activityName, days) {
        var daysString = days.toString();

        var nameMaxLength = 12 - daysString.length();
        if(activityName.length() > nameMaxLength){
            activityName = activityName.substring(0, nameMaxLength);
            activityName = activityName + "...";
        }
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        System.println(activityName+"  "+daysString);
        dc.drawText(
	    	0,
	    	dcHeight / 2, 
	    	Gfx.FONT_SMALL, 
	    	activityName+"  "+daysString, 
	    	Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER
	    );
    }

    function countDaysFromToday(unix) {
        var activityDateMoment = new Time.Moment(unix-timeZoneOffset);
        var interval = todayMoment.subtract(activityDateMoment);
        return interval.value() / SECOND_OF_DAY;
    }
}
