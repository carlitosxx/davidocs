part of '../injects_provider.dart';

class DocumentNotifier extends StateNotifier<DocumentState> {
  DocumentNotifier({
    DocumentState? initialState,
    required GetListDocumentsUC getListDocumentsUC,
  })  : _getListDocumentsUC = getListDocumentsUC,
        super(initialState ?? const DocumentState.initial());
  final GetListDocumentsUC _getListDocumentsUC;

  void reset() => state = const DocumentState.initial();

  Future<void> getListDocumentsUC(
      String codigoempresa, String codigotipodocumento) async {
    state = const DocumentState.loading();
    final result =
        await _getListDocumentsUC(codigoempresa, codigotipodocumento);

    result.when(
      left: (error) => state = DocumentState.error(mapFailureToString(error)),
      right: (listDocuments) => state = DocumentState.data(
        responseListDocumentsEntity: listDocuments,
      ),
    );
  }
}
