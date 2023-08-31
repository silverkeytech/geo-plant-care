CREATE MIGRATION m16h5f6m4nev2c36iei63slnitdyqyokunqoou56idhtpqx3rd544q
    ONTO m1thxeqi7grdy4f27slbanqsfswmrr2d4jrndgutk2hdm7fmccktaa
{
  CREATE SCALAR TYPE default::Recommendation EXTENDING enum<Recommended, NotRecommended>;
  CREATE SCALAR TYPE default::SunExposure EXTENDING enum<FullSun, PartialSun, FullShade>;
  CREATE SCALAR TYPE default::Toxicity EXTENDING enum<ToxicToAnimals, ToxicToHumans, NonToxic>;
  CREATE SCALAR TYPE default::WateringSchedule EXTENDING enum<Daily, OnceAWeek, TwiceAWeek, OnceAMonth>;
  CREATE TYPE default::PlantLabel {
      CREATE PROPERTY autumn_watering: default::WateringSchedule;
      CREATE PROPERTY recommendation: default::Recommendation;
      CREATE PROPERTY spring_watering: default::WateringSchedule;
      CREATE PROPERTY summer_watering: default::WateringSchedule;
      CREATE PROPERTY sun_exposure: default::SunExposure;
      CREATE PROPERTY toxicity: default::Toxicity;
      CREATE PROPERTY winter_watering: default::WateringSchedule;
  };
  ALTER TYPE default::Plant {
      CREATE LINK labels: default::PlantLabel;
  };
};
