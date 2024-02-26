import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinepedia/infrastructure/dataSources/isar_datasource.dart';
import 'package:cinepedia/infrastructure/repositories/localstorage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl( IsarDatasource());
});