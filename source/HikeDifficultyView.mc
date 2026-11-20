import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.FitContributor;
import Toybox.Math;

class HikeDifficultyView extends WatchUi.SimpleDataField {

    private var hikeDifficultyField as FitContributor.Field?;
    private var hikeDifficultyTimeField as FitContributor.Field?;
    private var lastDifficulty as Float?;

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();

        lastDifficulty = null;

        var units = WatchUi.loadResource(Rez.Strings.DifficultyUnits) as String;
        hikeDifficultyField = createDifficultyField(
            "hike_difficulty",
            0,
            FitContributor.MESG_TYPE_SESSION,
            units
        );
        hikeDifficultyTimeField = createDifficultyField(
            "hike_difficulty_time",
            1,
            FitContributor.MESG_TYPE_RECORD,
            units
        );

        label = (WatchUi.loadResource(Rez.Strings.DifficultyLabel) as String).toUpper();
    }

    private function createDifficultyField(
        name as String,
        fieldId as Number,
        mesgType as FitContributor.MessageType,
        units as String
    ) as FitContributor.Field? {
        try {
            return createField(
                name,
                fieldId,
                FitContributor.DATA_TYPE_FLOAT,
                {:mesgType => mesgType, :units => units}
            );
        } catch (ex) {
            return null;
        }
    }

    function onTimerReset() as Void {
        lastDifficulty = null;
    }

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        if (Activity has :TIMER_STATE_OFF && info has :timerState) {
            var timerState = info.timerState;
            if (timerState != null && timerState == Activity.TIMER_STATE_OFF) {
                lastDifficulty = null;
                return null;
            }
        }

        var elapsedDistance = info.elapsedDistance;
        var totalAscent = info.totalAscent;
        if (elapsedDistance == null || totalAscent == null) {
            var cachedDifficulty = lastDifficulty;
            return cachedDifficulty != null ? Math.ceil(cachedDifficulty).toNumber() : null;
        }

        //
        // Shenandoah's Hiking Difficulty is determined by a numerical rating
        // using the following formula: 
        //
        // difficulty = sqrt(2 * e * d)
        //
        // where:
        //      e - elevation gain in feet
        //      d - distance in miles
        //
        // Because Garmin provides both distance and elevation gain in meters,
        // the formula is refined as
        //
        // difficulty = sqrt(2 * (e * 3.28084) * (d / 1609.34)) = sqrt(e * d * 0.004077249059)
        //

        var difficultySquared = elapsedDistance * totalAscent.toFloat() * 0.004077249059;
        if (difficultySquared < 0) {
            difficultySquared = 0;
        }

        var difficulty = Math.sqrt(difficultySquared);
        var difficultyFloat = difficulty.toFloat();
        var difficultyInt = Math.ceil(difficulty).toNumber();

        var prevDifficulty = lastDifficulty;
        if (prevDifficulty == null || difficultyFloat != prevDifficulty) {
            lastDifficulty = difficultyFloat;

            var sessionField = hikeDifficultyField;
            if (sessionField != null) {
                sessionField.setData(difficultyFloat);
            }
            var recordField = hikeDifficultyTimeField;
            if (recordField != null) {
                recordField.setData(difficultyFloat);
            }
        }

        return difficultyInt;
    }
}
