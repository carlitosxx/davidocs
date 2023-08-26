part of '../injects_provider.dart';

class DownloadNotifier extends StateNotifier<DownloadState> {
  DownloadNotifier({
    DownloadState? initialState,
    required GetDownloadFileUC getDownloadFileUC,
  })  : _getDownloadFileUC = getDownloadFileUC,
        super(initialState ?? const DownloadState.initial());
  final GetDownloadFileUC _getDownloadFileUC;
  Future<void> getDownloadFile(String codigodocumento) async {
    state = const DownloadState.loading();
    final result = await _getDownloadFileUC(codigodocumento);

    result.when(
      left: (error) => state = DownloadState.error(mapFailureToString(error)),
      right: (downloadEntity) => state = DownloadState.data(
        downloadEntity: downloadEntity,
      ),
    );
  }
}
