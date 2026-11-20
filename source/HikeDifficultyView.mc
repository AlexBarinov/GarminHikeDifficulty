import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.FitContributor;
import Toybox.Math;

class HikeDifficultyView extends WatchUi.SimpleDataField {

    private var hikeDifficultyField as FitContributor.Field?;
    private var hikeDifficultyTimeField as FitContributor.Field?;

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();

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

        var sessionField = hikeDifficultyField;
        if (sessionField != null) {
            sessionField.setData(0.0);
        }
        var recordField = hikeDifficultyTimeField;
        if (recordField != null) {
            recordField.setData(0.0);
        }

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

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        var elapsedDistance = 0.0;
        if (info.elapsedDistance != null) {
            elapsedDistance = info.elapsedDistance;
        }

        var totalAscent = 0.0;
        if (info.totalAscent != null) {
            totalAscent = info.totalAscent;
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

        var difficultySquared = elapsedDistance * totalAscent * 0.004077249059;
        if (difficultySquared < 0) {
            difficultySquared = 0;
        }

        var difficulty = Math.sqrt(difficultySquared);
        var difficultyFloat = difficulty.toFloat();
        var difficultyInt = Math.ceil(difficulty).toNumber();

        var sessionField = hikeDifficultyField;
        if (sessionField != null) {
            sessionField.setData(difficultyFloat);
        }
        var recordField = hikeDifficultyTimeField;
        if (recordField != null) {
            recordField.setData(difficultyFloat);
        }

        return difficultyInt;
    }
}
