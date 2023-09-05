CREATE MIGRATION m1obkijuzi56m55urrcqyus7bkkoguejguxryjophep7a3a2i343yq
    ONTO m1k3qlpha7eddoqrzi4cijdoa6sxvjebuuqxglhex5bifnytuiyrgq
{
  ALTER TYPE default::Location {
      DROP PROPERTY climate;
  };
  ALTER TYPE default::Location {
      CREATE PROPERTY climate_temp_celsius: std::float64;
  };
  CREATE SCALAR TYPE default::BloomTime EXTENDING enum<Summer, Spring, Winter, Autumn>;
  ALTER TYPE default::Plant {
      ALTER PROPERTY bloom_time {
          SET TYPE default::BloomTime;
      };
  };
  CREATE SCALAR TYPE default::NativeArea EXTENDING enum<Europe, Asia, SouthAfrica, SouthAmerica, Australia>;
  ALTER TYPE default::Plant {
      ALTER PROPERTY native_area {
          SET TYPE default::NativeArea;
      };
  };
  ALTER TYPE default::PlantCareGuide {
      ALTER PROPERTY light {
          SET TYPE default::SunExposure;
      };
  };
  CREATE SCALAR TYPE default::SoilType EXTENDING enum<WellDrained, Moist, Rich, Sand, Clay, Loam, Chalky, Silt, Peat>;
  ALTER TYPE default::PlantCareGuide {
      ALTER PROPERTY soil_type {
          SET TYPE default::SoilType;
      };
  };
  ALTER TYPE default::PlantCareGuide {
      DROP PROPERTY water_amount;
  };
  CREATE SCALAR TYPE default::WaterFrequency EXTENDING enum<Daily, TwiceAweek, OnceAWeek, TwiceAMonth, OnceAMonth>;
  ALTER TYPE default::PlantCareGuide {
      CREATE PROPERTY water_frequnecy: default::WaterFrequency;
  };
  ALTER TYPE default::PlantCareGuide {
      DROP PROPERTY water_schedule;
  };
  ALTER TYPE default::User {
      ALTER PROPERTY userType {
          RENAME TO user_type;
      };
  };
  ALTER SCALAR TYPE default::SunExposure EXTENDING enum<FullSunIdeal, PartialSunIdeal, FullShadeIdeal, FullSunTolerance, PartialSunTolerance, FullShadeTolerance>;
};
