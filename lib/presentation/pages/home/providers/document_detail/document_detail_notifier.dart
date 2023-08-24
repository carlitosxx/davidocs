part of '../injects_provider.dart';

class DocumentDetailNotifier extends StateNotifier<DocumentDetailState> {
  DocumentDetailNotifier({
    DocumentDetailState? initialState,
    required GetDocumentDetailUC getDocumentDetailUC,
  })  : _getDocumentDetailUC = getDocumentDetailUC,
        super(initialState ?? const DocumentDetailState.initial());
  final GetDocumentDetailUC _getDocumentDetailUC;

  void reset() => state = const DocumentDetailState.initial();

  Future<void> getDocumentDetailUC(
    String codigodocumento,
  ) async {
    state = const DocumentDetailState.loading();
    final result = await _getDocumentDetailUC(codigodocumento);

    result.when(
      left: (error) =>
          state = DocumentDetailState.error(mapFailureToString(error)),
      right: (documentDetailEntity) => state = DocumentDetailState.data(
        documentDetailEntity: documentDetailEntity,
      ),
    );
  }
}
