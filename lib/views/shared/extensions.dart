extension StringExtension on String {
  String trimAll() {
    return this == null ? null : this.trim().replaceAll("  ", "");
  }

  double toDouble() {
    if(this == null) return null;
    return double.tryParse(this.replaceAll(".", "").replaceAll("-", ""));
  }

  String toCpfFormated() =>
      this.substring(0, 3) +
      '.' +
      this.substring(3, 6) +
      '.' +
      this.substring(6, 9) +
      '-' +
      this.substring(9);

  String removeDotsAndTraces() => this.replaceAll(".", "").replaceAll("-", "");

  String removeUnderscore() => this.replaceAll("_", " ");

  String removeStoreNumber() => this.split(",").first.trim();


  String removeAccents(String s) {

    var textResult;
    
    textResult = this.replaceAll(new RegExp("[ÁÀÂÃ]"), 'a');
    textResult = textResult.replaceAll(new RegExp('[ÉÈÊ]'), 'e');
    textResult = textResult.replaceAll(new RegExp('[ÍÌÎ]'), 'i');
    textResult = textResult.replaceAll(new RegExp('[ÓÒÔÕ]'), 'o');
    textResult = textResult.replaceAll(new RegExp('[ÚÙÛ]'), 'u');
    textResult = textResult.replaceAll(new RegExp('[Ç]'), 'c');
    textResult = textResult.toLowerCase();

    return textResult;
  }

}

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndex<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }

  void forEachIndex(void f(E e, int i)) {
    var i = 0;
    this.forEach((e) => f(e, i++));
  }
}

extension FutureExtension<T> on Future<T> {
  /// Transform the future value into other type after complete future
  /// Useful to transform list to ObservableList in requests
  Future<E> map<E>(Future<E> Function(Future<T>) transform) => transform(this);
}