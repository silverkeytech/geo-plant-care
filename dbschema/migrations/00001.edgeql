CREATE MIGRATION m1thxeqi7grdy4f27slbanqsfswmrr2d4jrndgutk2hdm7fmccktaa
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
  CREATE TYPE default::PlantPhotoGallery {
      CREATE PROPERTY description: std::str;
      CREATE REQUIRED PROPERTY url: std::str;
  };
  CREATE TYPE default::Plant {
      CREATE MULTI LINK care_guides: default::PlantCareGuide;
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
