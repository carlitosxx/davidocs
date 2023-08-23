part of '../injects_provider.dart';

class DocumentTypeNotifier extends StateNotifier<DocumentTypeState> {
  DocumentTypeNotifier({
    DocumentTypeState? initialState,
    required GetListDocumentsTypeUC getListDocumentsTypeUC,
  })  : _getListDocumentsTypeUC = getListDocumentsTypeUC,
        super(initialState ?? const DocumentTypeState.initial());
  final GetListDocumentsTypeUC _getListDocumentsTypeUC;

  void reset() => state = const DocumentTypeState.initial();

  Future<void> getListDocumentType(String codigoempresa) async {
    state = const DocumentTypeState.loading();
    final result = await _getListDocumentsTypeUC(codigoempresa);

    result.when(
      left: (error) =>
          state = DocumentTypeState.error(mapFailureToString(error)),
      right: (listDocumentType) => state = DocumentTypeState.data(
        responseListDocumentTypeEntity: listDocumentType,
      ),
    );
  }
}
