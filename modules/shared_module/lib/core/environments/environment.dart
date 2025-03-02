enum Flavor {
  dev,
  qa,
  prod,
}

extension FlavorExtension on Flavor {
  String get prefix {
    switch (this) {
      case Flavor.dev:
        return 'DEV';
      case Flavor.qa:
        return 'QA';
      case Flavor.prod:
        return 'PROD';
    }
  }
}

class Environment {
  static late String title;
  static late Flavor _environment;

  static Flavor get environment => _environment;

  static void setUpEnv(Flavor env) {
    _environment = env;

    switch (env) {
      case Flavor.dev:
        {
          title = 'Asd dev Flavor';
          break;
        }
      case Flavor.qa:
        {
          title = 'Asd qa Flavor';
          break;
        }
      case Flavor.prod:
        {
          title = 'Asd prod Flavor';
          break;
        }
    }
  }
}
