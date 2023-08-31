module default {
    
    scalar type UserType extending enum<Admin,Regular>;
    # User Entity
    type User {
        required property username -> str;
        property password -> str; 
        property userType -> UserType;
        link location -> Location;
        multi link plants -> Plant;
    };

    # Location Entity
    type Location {
        required property name -> str;
        property latitude -> float64;
        property longitude -> float64;
        property climate -> str;
        multi link plants -> Plant;
    };

    # Temperature Category Enumeration
    scalar type TemperatureCategory extending enum<BelowTemperature, WithinRange, AboveTemperature>;

    # Plant Entity
    type Plant {
        required property common_name -> str;
        property botanical_name -> str;
        property description -> str;
        property bloom_time -> str;
        property native_area -> str;
        multi link care_guides -> PlantCareGuide;
        multi link photos -> PlantPhotoGallery;
        link labels -> PlantLabel;
    };

    # Plant Care Entity
    type PlantCareGuide {
        required property temperature_category -> TemperatureCategory;
        property light -> str;
        property water_schedule -> str;
        property water_amount -> str;
        property water_approach -> str;
        property soil_type -> str;
        property fertilizers -> str;
        property toxicity -> str;
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

    scalar type SunExposure extending enum<FullSun, PartialSun, FullShade>;

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
        property toxicity -> Toxicity;
    };

};
