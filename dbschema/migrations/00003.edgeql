CREATE MIGRATION m13ne7xclq2zexajmtnuaojqkwpgsr2smhqvudz4rnvscxbu4farwa
    ONTO m1obkijuzi56m55urrcqyus7bkkoguejguxryjophep7a3a2i343yq
{
  ALTER TYPE default::PlantCareGuide {
      ALTER PROPERTY light {
          RENAME TO sun_exposure;
      };
  };
};
