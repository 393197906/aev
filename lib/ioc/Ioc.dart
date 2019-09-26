import 'package:get_it/get_it.dart';

class Ioc {
  static final _container = GetIt.instance;

  static provider<T>(T instance) {
    _container.registerSingleton<T>(instance);
  }

  static providerLazy<T>(FactoryFunc<T> func) {
    _container.registerLazySingleton(func);
  }

  static providerFactory<T>(FactoryFunc<T> func) {
    _container.registerFactory(func);
  }

  static T inject<T>() {
    return _container<T>();
  }
}
