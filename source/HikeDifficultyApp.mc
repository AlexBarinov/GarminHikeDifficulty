import Toybox.Application;
import Toybox.WatchUi;

class HikeDifficultyApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new HikeDifficultyView() ];
    }

}