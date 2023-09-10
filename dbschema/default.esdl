module default {
    
    scalar type UserType extending enum<Admin, Regular>;

    # User Entity
    type User {
        required property username -> str;
        property password -> str; 
        property user_type -> UserType;
        property email -> str {constraint exclusive};
        multi link plants -> Plant;
    };

    # # Location Entity
    # type Location {
    #     required property name -> str;
    #     property latitude -> float64;
    #     property longitude -> float64;
    #     property climate_temp_celsius -> int16; 
    #     multi link plants -> Plant;
    # };

    # Enumerated types for bloom time, soil type, and native area
    scalar type BloomTime extending enum<Summer, Spring, Winter, Autumn>;
    scalar type SoilType extending enum<WellDrained, Moist, Rich, Sand, Clay, Loam, Chalky, Silt, Peat>;
    scalar type NativeArea extending enum<Europe, Asia, SouthAfrica, SouthAmerica, Australia>;

    # Temperature Category Enumeration
    scalar type TemperatureCategory extending enum<BelowTemperature, WithinRange, AboveTemperature>;

    # water frequency Enumeration
    scalar type WaterFrequency extending enum<Daily, TwiceAweek, OnceAWeek, TwiceAMonth, OnceAMonth>;

    # Plant Entity
    type Plant {
        required property common_name -> str;
        property botanical_name -> str;
        property description -> str;
        property bloom_time -> BloomTime;
        property native_area -> array<NativeArea>;
        multi link care_guides -> PlantCareGuide;
        property min_temperature -> int16;
        property max_temperature -> int16;
        property toxicity -> array<Toxicity>;
        multi link photos -> PlantPhotoGallery;
        link labels -> PlantLabel;
    };

    # Plant Care Entity
    type PlantCareGuide {
        required property temperature_category -> TemperatureCategory;
        property sun_exposure_ideal -> SunExposure;
        property sun_exposure_tolerance -> SunExposure;
        property water_frequnecy -> WaterFrequency;
        property water_approach -> str;
        property soil_type -> array<SoilType>;
        property fertilizers -> str;
        
    };

    # Plant Photo Gallery Entity
    type PlantPhotoGallery {
        required property url -> str;
        property description -> str;
    };

    # Change History Entity
    type ChangeHistory {
        required property update_date -> datetime;
        link updated_by -> User;
        link plant -> Plant;
        property change_description -> str;
    };

    # Enumerated types for labels
    scalar type WateringSchedule extending enum<Daily, OnceAWeek, TwiceAWeek, OnceAMonth>;
    scalar type SunExposure extending enum<FullSunIdeal, PartialSunIdeal, FullShadeIdeal, FullSunTolerance, PartialSunTolerance, FullShadeTolerance>;
    scalar type Recommendation extending enum<Recommended, NotRecommended>;
    scalar type Toxicity extending enum<ToxicToAnimals, ToxicToHumans, NonToxic>;

    # Plant Label Entity
    type PlantLabel {
        property winter_watering -> WateringSchedule;
        property summer_watering -> WateringSchedule;
        property spring_watering -> WateringSchedule;
        property autumn_watering -> WateringSchedule;
        
        property sun_exposure -> SunExposure;
        property recommendation -> Recommendation;
        property toxicity -> array<Toxicity>;
    };
};
