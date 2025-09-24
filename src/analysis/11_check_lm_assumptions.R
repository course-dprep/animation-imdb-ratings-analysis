# Run checks for your models
check_lm_assumptions(Regression,    "Regression (startYear * animation_dummy)")
check_lm_assumptions(CV_regression, "CV_regression (+ runtimeMinutes + numVotes)")

