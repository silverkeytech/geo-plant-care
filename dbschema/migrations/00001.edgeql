CREATE MIGRATION m1k3qlpha7eddoqrzi4cijdoa6sxvjebuuqxglhex5bifnytuiyrgq
    ONTO initial
{
  CREATE SCALAR TYPE default::TemperatureCategory EXTENDING enum<BelowTemperature, WithinRange, AboveTemperature>;
  CREATE TYPE default::PlantCareGuide {
      CREATE PROPERTY fertilizers: std::str;
      CREATE PROPERTY light: std::str;
      CREATE PROPERTY soil_type: std::str;
      CREATE REQUIRED PROPERTY temperature_category: default::TemperatureCategory;
      CREATE PROPERTY toxicity: std::str;
      CREATE PROPERTY water_amount: std::str;
      CREATE PROPERTY water_approach: std::str;
      CREATE PROPERTY water_schedule: std::str;
  };
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
  CREATE TYPE default::PlantPhotoGallery {
      CREATE PROPERTY description: std::str;
      CREATE REQUIRED PROPERTY url: std::str;
  };
  CREATE TYPE default::Plant {
      CREATE MULTI LINK care_guides: default::PlantCareGuide;
      CREATE LINK labels: default::PlantLabel;
      CREATE MULTI LINK photos: default::PlantPhotoGallery;
      CREATE PROPERTY bloom_time: std::str;
      CREATE PROPERTY botanical_name: std::str;
      CREATE REQUIRED PROPERTY common_name: std::str;
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY native_area: std::str;
  };
  CREATE TYPE default::Location {
      CREATE MULTI LINK plants: default::Plant;
      CREATE PROPERTY climate: std::str;
      CREATE PROPERTY latitude: std::float64;
      CREATE PROPERTY longitude: std::float64;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE SCALAR TYPE default::UserType EXTENDING enum<Admin, Regular>;
  CREATE TYPE default::User {
      CREATE LINK location: default::Location;
      CREATE MULTI LINK plants: default::Plant;
      CREATE PROPERTY password: std::str;
      CREATE PROPERTY userType: default::UserType;
      CREATE REQUIRED PROPERTY username: std::str;
  };
  CREATE TYPE default::ChangeHistory {
      CREATE LINK plant: default::Plant;
      CREATE LINK updated_by: default::User;
      CREATE PROPERTY change_description: std::str;
      CREATE REQUIRED PROPERTY update_date: std::datetime;
  };
};
