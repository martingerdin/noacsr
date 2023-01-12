# create_injury_dataset_for_ais_coding generates correct data

    Code
      create_injury_dataset_for_ais_coding(data = list(test1 = injury.test.data,
        test2 = injury.test.data), injury.columns = list(test1 = c("einj1", "ctinj1"),
      test2 = c("einj2", "ctinj2")))
    Output
                                                              injury_description
      1                                                                      999
      2                                    Abrasion on back (0.5 x 0.1 x 0.1 mm)
      3                             CLW over right side of nose 1 x 0.5 x 0.2 cm
      4                                                          CLW ON FOREHEAD
      5                                                         not coded injury
      6                                                RIGHT TEMPO OCCIPITAL EDH
      7  SWELLING OVER RIGHT PARIETAL REGION 2 X 1 CM WITH ABRASION 0.5 X 0.5 CM
      8                                                    Cut injury over nose.
      9                                                  Pain in Rt thigh & knee
      10                          ABRASION IN LT SIDE OF THE FACE BELOW  LT  EYE
         head_and_neck face chest abdomen extremity external
      1             NA   NA    NA      NA        NA       NA
      2             NA   NA    NA      NA        NA       NA
      3             NA   NA    NA      NA        NA       NA
      4             NA   NA    NA      NA        NA       NA
      5             NA   NA    NA      NA        NA       NA
      6             NA   NA    NA      NA        NA       NA
      7             NA   NA    NA      NA        NA       NA
      8             NA   NA    NA      NA        NA       NA
      9             NA   NA    NA      NA        NA       NA
      10            NA   NA    NA      NA        NA       NA

