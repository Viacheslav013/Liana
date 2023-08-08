extension IterableExtensions<T> on Iterable<T> {
  Iterable<E> mapIndexed<E>(E Function(T, int) mapper) {
    var index = 0;
    final result = [
      for (T element in this) mapper(element, index++),
    ];

    return result;
  }
}
