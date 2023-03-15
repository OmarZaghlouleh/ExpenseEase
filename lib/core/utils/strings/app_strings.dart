class AppStrings {
  static const String appName = " ExpenseEase ";

  static const String dollarSympol = '\$';
  static const String emptyString = "";
  static const String spaceString = " ";

  static const String syrianPound = "SYP";
  static const String add = "Add";
  static const String value = "Value";

  static const String creatingPlanErrorMessage =
      "Error while creating the plan, please try again";

  static const String withCapitalText = "With";
  static const String intro1 = "you can easily track your income and expenses.";
  static const String intro2 =
      "Set and monitor budgets, and gain valuable insights into your spending habits.";
  static const String intro3 =
      "Our intuitive interface and powerful features make it easy to stay on top of your finances, so you can achieve your financial goals faster.";
  static const String intro4 =
      "Whether you're saving up for a down payment on a house, paying off debt, or just looking to take control of your money, ExpenseEase has everything you need to succeed. Start your journey to financial freedom today!";

  static const String swipeUpToSkip = "Swipe up to skip";
  static const String gettingStarted = "Getting started";
  static const String selectYourPlan = "Select your plan";
  static const String employeePlan = "Employee plan";
  static const String employeePlanDescription =
      "In this plan you can set your monthly salary and keep tracking it.";
  static const String businessPlan = "Business plan";
  static const String businessKey = "business";
  static const String employeeKey = "employee";

  static const String businessPlanDescription =
      "In this plan you can manage your income and expenses.";
  static const String colon = ":";
  static const String next = "Next";
  static const String invalid = "Invalid";
  static const String name = "Name";
  static const String planDetails = "Plan details";
  static const String salary = "Salary";
  static const String currency = "Currency";
  static const String changePlanType = "Change plan type";
  static const String gettingPlanErrorMessage =
      "Something went wrong while getting data.";

  static const String expenses = "Expenses";
  static const String incomes = "Incomes";

  static String getMatchedNameErrorMessage(String name) =>
      "$name already exist";

  static String getCurrentDate() =>
      "${DateTime.now().month}/${DateTime.now().day}";
}
