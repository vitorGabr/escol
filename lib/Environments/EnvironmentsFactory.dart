class EnvironmentFactory {
  static EnvironmentFactory _instance;
  factory EnvironmentFactory() {
    _instance ??= EnvironmentFactory._internalConstructor();

    return _instance;
  }

  const EnvironmentFactory._internalConstructor();

  static const String getEndPointFacebookApi = 'https://graph.facebook.com/me?fields=';



}