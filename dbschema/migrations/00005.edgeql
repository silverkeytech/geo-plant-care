CREATE MIGRATION m1zqipg7r4xrewi3yvlppb47bkrqhwskb7nqhhhzehjauhnfcrj6ca
    ONTO m1cz3cjpqj5uqbpr6wuxklcdu7fvznq66ph5rkeqjfv67g6xb6te6q
{
  ALTER TYPE default::PlantPhotoGallery {
    DROP PROPERTY url;
  };

   ALTER TYPE default::PlantPhotoGallery {
    CREATE PROPERTY url -> array<std::str>;
  };
};
