import 'package:davidocs/domain/entities/download.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_state.freezed.dart';

@freezed
abstract class DownloadState with _$DownloadState {
  /// Data is present state
  const factory DownloadState.data({required DownloadEntity downloadEntity}) =
      _Data;

  /// Initial/default state
  const factory DownloadState.initial() = _Initial;

  /// Data is loading state
  const factory DownloadState.loading() = _Loading;

  /// Error when loading data state
  const factory DownloadState.error([String? message]) = _Error;
}
