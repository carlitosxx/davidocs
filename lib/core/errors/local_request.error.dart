import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_request.error.freezed.dart';

@freezed
class LocalRequestFailure with _$LocalRequestFailure {
  factory LocalRequestFailure.available() = _Available;
  factory LocalRequestFailure.gpsNotEnabled() = _GpsNotEnabled;
  factory LocalRequestFailure.gpsNotPermission() = _GpsNotPermission;
  factory LocalRequestFailure.failureUnknown() = _FailureUnknown;
  // factory LocalRequestFailure.
  // factory LocalRequestFailure.notFound() = _NotFound;
  // factory LocalRequestFailure.server() = _Server;
  // factory LocalRequestFailure.unauthorized() = _Unauthorized;
  // factory LocalRequestFailure.badRequest(BadRequestModel dataError) =
  //     _BadRequest;
  // factory HttpRequestFailure.local() = _Local;
}
