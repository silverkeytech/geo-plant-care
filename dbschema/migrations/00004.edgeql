CREATE MIGRATION m1cz3cjpqj5uqbpr6wuxklcdu7fvznq66ph5rkeqjfv67g6xb6te6q
    ONTO m13ne7xclq2zexajmtnuaojqkwpgsr2smhqvudz4rnvscxbu4farwa
{
  ALTER TYPE default::Plant {
      ALTER PROPERTY native_area {
          SET TYPE array<default::NativeArea> USING ([.native_area]);
      };
  };
  ALTER TYPE default::PlantCareGuide {
      ALTER PROPERTY soil_type {
          SET TYPE array<default::SoilType> USING ([.soil_type]);
      };
  };
    ALTER TYPE default::PlantLabel {
      ALTER PROPERTY toxicity {
          SET TYPE array<default::Toxicity> USING ([.toxicity]);
      };
  };
  ALTER TYPE default::Plant {
      CREATE PROPERTY toxicity: array<default::Toxicity>;
      CREATE PROPERTY max_temperature: std::int16;
      CREATE PROPERTY min_temperature: std::int16;
  };
  ALTER TYPE default::Location {
      DROP LINK plants;
      DROP PROPERTY climate_temp_celsius;
      DROP PROPERTY latitude;
      DROP PROPERTY longitude;
      DROP PROPERTY name;
  };
  ALTER TYPE default::User {
      DROP LINK location;
  };
  DROP TYPE default::Location;
  ALTER TYPE default::PlantCareGuide {
      ALTER PROPERTY sun_exposure {
          RENAME TO sun_exposure_ideal;
      };
  };
  ALTER TYPE default::PlantCareGuide {
      CREATE PROPERTY sun_exposure_tolerance: default::SunExposure;
  };
  ALTER TYPE default::PlantCareGuide {
      DROP PROPERTY toxicity;
  };
  ALTER TYPE default::User {
      CREATE PROPERTY email: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
  };

  INSERT User {
      username := 'admin',
      password := 'adminpassword',
      email := 'admin@example.com',
      user_type := default::UserType.Admin,
  };
  
  INSERT User {
      username := 'regular_user',
      password := 'regularpassword',
      email := 'regular_user@example.com',
      user_type := default::UserType.Regular,
  };

    INSERT Plant {
        common_name := 'garden tulip',
        botanical_name := 'tulipa gesneriana',
        description := 'Garden tulip (Tulipa gesneriana) is an ornamental bulbous plant native to southwest Asia. Ottomans brought it to Europe in the 16th century, and it almost instantly became popular, especially amongst Dutchmen. Garden tulip’s showy flowers are usually red or orange, but there are also varieties with purple, pink or yellow flowers.',
        bloom_time := default::BloomTime.Spring,
        native_area := [default::NativeArea.Europe, default::NativeArea.Asia],
        min_temperature := -10,
        max_temperature := 35,
        toxicity := [default::Toxicity.ToxicToAnimals, default::Toxicity.ToxicToHumans],
        care_guides := {
            (INSERT PlantCareGuide {
                temperature_category := default::TemperatureCategory.WithinRange,
                sun_exposure_ideal := default::SunExposure.FullSunIdeal,
                sun_exposure_tolerance := default::SunExposure.PartialSunTolerance,
                water_frequnecy := default::WaterFrequency.OnceAWeek,
                water_approach := 'Detailed watering approaches including from the soil, from the bottom, and water bath.',
                soil_type := [default::SoilType.Sand, default::SoilType.Loam, default::SoilType.Clay], 
                fertilizers := 'The garden tulip should be fertilized with a well-balanced fertilizer upon planting. A slow-release fertilizer with a 10-10-10 nitrogen, phosphorous, and potassium formulation is appropriate and will not damage the bulbs during planting. If the plants are perennials, fertilizer is necessary for optimal growth. If the bulbs are annuals, fertilizer is not necessary.',
                 
            })
        },
        labels := (INSERT PlantLabel {
            winter_watering := default::WateringSchedule.OnceAMonth,
            summer_watering := default::WateringSchedule.TwiceAWeek,
            spring_watering := default::WateringSchedule.OnceAWeek,
            autumn_watering := default::WateringSchedule.OnceAWeek,
            sun_exposure := default::SunExposure.FullSunIdeal,
            recommendation := default::Recommendation.Recommended,
            toxicity := [default::Toxicity.ToxicToAnimals, default::Toxicity.ToxicToHumans] 
        })
  };
};
