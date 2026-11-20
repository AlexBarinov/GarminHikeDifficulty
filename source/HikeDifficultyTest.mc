import Toybox.Lang;
import Toybox.Math;
import Toybox.Test;

(:test)
function testCalculateDifficultyZeroAndNegative(logger as Test.Logger) as Boolean {
    Test.assertEqual(0.0, HikeDifficultyView.calculateDifficulty(0.0, 0.0));
    Test.assertEqual(0.0, HikeDifficultyView.calculateDifficulty(0.0, 500.0));
    Test.assertEqual(0.0, HikeDifficultyView.calculateDifficulty(5000.0, 0.0));
    Test.assertEqual(0.0, HikeDifficultyView.calculateDifficulty(-100.0, 500.0));
    Test.assertEqual(0.0, HikeDifficultyView.calculateDifficulty(5000.0, -50.0));
    Test.assertEqual(0.0, HikeDifficultyView.calculateDifficulty(-100.0, -50.0));
    return true;
}

(:test)
function testCalculateDifficultyBenchmarks(logger as Test.Logger) as Boolean {
    var d1 = HikeDifficultyView.calculateDifficulty(1609.344, 304.8);
    Test.assert(d1 > 44.71 && d1 < 44.73);
    Test.assertEqual(45, Math.ceil(d1).toNumber());

    var d2 = HikeDifficultyView.calculateDifficulty(8046.72, 304.8);
    Test.assert(d2 > 99.99 && d2 < 100.01);
    Test.assertEqual(100, Math.ceil(d2).toNumber());

    var d3 = HikeDifficultyView.calculateDifficulty(16093.44, 609.6);
    Test.assert(d3 > 199.99 && d3 < 200.01);
    Test.assertEqual(200, Math.ceil(d3).toNumber());
    return true;
}

(:test)
function testCalculateDifficultyClampsMaxFloat(logger as Test.Logger) as Boolean {
    var dMax = HikeDifficultyView.calculateDifficulty(1000000000000.0, 1000000000000.0);
    Test.assertEqual(2147483520.0, dMax);
    Test.assertEqual(2147483520, Math.ceil(dMax).toNumber());
    return true;
}
