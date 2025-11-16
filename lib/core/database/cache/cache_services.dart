import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../features/posts/data/models/post_model.dart';

abstract class CacheHelper {
  static const String postsBox = 'postsBox';
  static setUpCache() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ReactionsModelAdapter());
    Hive.registerAdapter(PostModelAdapter());
    await Future.wait([Hive.openBox(postsBox)]);
  }
}

@lazySingleton
class CacheServices {
  T? getDataFromCache<T>({required String boxName, required String key}) {
    return Hive.box(boxName).get(key, defaultValue: null);
  }

  Future<void> storeData<T>({
    required String boxName,
    required String key,
    required T data,
  }) async {
    await Hive.box(boxName).put(key, data);
  }

  Future<void> clear(String boxName) async {
    await Hive.box(boxName).clear();
  }
}
