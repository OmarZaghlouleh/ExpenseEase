import 'package:hive/hive.dart';

T? getHiveMapValue<T>({required String key, required Box box}) {
  try {
    return box
        .toMap()
        .entries
        .firstWhere((element) => element.key.toString() == key)
        .value as T;
  } catch (e) {
    return null;
  }
}
