import 'package:davidocs/core/utils/either.util.dart';
import 'package:davidocs/domain/repositories/documents/documents.repository.dart';

abstract class IGpsDataSource {
  ServiceAndPermissionOrFailure validateGps();
}

class GpsDataSourceImpl implements IGpsDataSource {
  @override
  ServiceAndPermissionOrFailure validateGps() async {
    return Either.right(true);
  }
}
