enum Lifestyle {
  SEDENTARY,
  SLIGHTLY_ACTIVE,
  MODERATELY_ACTIVE,
  VERY_ACTIVE,
  EXTREMELY_ACTIVE,
}

enum Gender {
  MALE,
  FEMALE,
  NOT_SPECIFIED,
}

class BMRService {
  //Weight in kilos and height in cm age in years
  double calculateDailyCalorieGoal(double weight, double height, Gender gender,
      double age, Lifestyle lifestyle) {
    double BMR;

    switch (gender) {
      case Gender.MALE:
        BMR = calculateMaleBMR(weight, height, age);
        break;
      case Gender.FEMALE:
        BMR = calculateFemaleBMR(weight, height, age);
        break;
      case Gender.NOT_SPECIFIED:
        BMR = (calculateFemaleBMR(weight, height, age) +
                calculateMaleBMR(weight, height, age)) /
            2;
        break;
    }

    switch (lifestyle) {
      case Lifestyle.SEDENTARY:
        BMR *= 1.2;
        break;
      case Lifestyle.SLIGHTLY_ACTIVE:
        BMR *= 1.375;
        break;
      case Lifestyle.MODERATELY_ACTIVE:
        BMR *= 1.55;
        break;
      case Lifestyle.VERY_ACTIVE:
        BMR *= 1.725;
        break;
      case Lifestyle.EXTREMELY_ACTIVE:
        BMR *= 1.9;
        break;
    }

    return BMR;
  }

  //Weight in kilos and height in cm age in years
  double calculateMaleBMR(double weight, double height, double age) {
    return (10 * weight) + (6.25 * height) - (5 * age) + 5;
  }

  //Weight in kilos and height in cm age in years
  double calculateFemaleBMR(double weight, double height, double age) {
    return (10 * weight) + (6.25 * height) - (5 * age) - 161;
  }
}
