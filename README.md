![](https://repository-images.githubusercontent.com/707907202/3d1ffff9-f435-42e9-b482-547cc5d9a848)

## Hiking Difficulty

This is a data field for Garmin watches that calculates your real time [Shenandoah's Hiking Difficulty](https://www.nps.gov/shen/planyourvisit/how-to-determine-hiking-difficulty.htm). The hike difficulty is based on current distance and elevation gained, and given as a score. 

Based on the score, hikes may be categorized as:
 - Easiest (0–49)
 - Moderate (50–99)
 - Moderately Strenuous (100–149)
 - Strenuous (150–199)
 - Very Strenuous (200–249)
 - Challenging (250–499)
 - Bomber (500+)

The calculated difficulty is written into activity and viewable with Garmin Connect as a hike difficulty and as a chart. This metric is handy when you compare your two hikes, challenge yourself or track your progress.

[<img src="https://developer.garmin.com/static/available-badge-9e49ebfb7336ce47f8df66dfe45d28ae.svg" width="250">](https://apps.garmin.com/apps/97b297da-429d-4fee-abcd-9f86f8d840d4)

---

## Changelog

#### Version [1.8.1](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/1.7.0)

- Changed: Garmin connect also displays difficulty value as an integer.

#### Version [1.8.0](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/1.7.0)

- Fixed: the field on some watches will always display 0, even if correct data is written into FIT / Garmin Connect.
- Changed: the difficulty field is now stored as integer in FIT file, twice reducing the data size needed to store it.
- Changed: recompiling the data field with 8.4.1 Connect IQ SDK

#### Version [1.7.0](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/1.7.0)

- Added: support for fēnix® 8 Pro, Instinct® Crossover AMOLED and Venu® 4.

#### Version [1.6.0](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/1.6.0)

- Added: support for Forerunner® 570 and Forerunner® 970.

#### Version [1.5.0](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/1.5.0)

- Changed: difficulty is stored and displayed in Garmin Connect as a float number. The realtime data field still shows difficulty as an integer for simplicity.

#### Version [1.2.0](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/1.2.0)

- Changed: Field name was shortened from "Hiking Difficulty" to "Difficulty" to better fit multifields data screen
- Added: storing current difficulty once per second making a chart possible

#### Version [1.1.0](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/1.1.0)

- Added: support for Descent™ MK3, Enduro™ 3, fēnix® 7 Pro, fēnix® 8, fēnix® E, Instinct® 3, Instinct® E
- Fixed: compilation fixes for newer Connect IQ SDK

#### Version [1.0.0](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/1.0.0)

- Release for all current devices with barometer to measure elevation gain during the hike
- Moving strings into resources

#### Version [0.2.0](https://github.com/AlexBarinov/GarminHikeDifficulty/releases/tag/0.2.0)

- Beta release for epix 2 / epix 2 Pro models only
