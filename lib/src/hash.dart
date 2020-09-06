/// Hash functions stolen from Quiver

/// Generates a hash code for multiple [objects].
int hashObjects(Iterable<dynamic> objects) =>
    _finish(objects.fold(0, (h, dynamic i) => _combine(h, i.hashCode)));

/// Generates a hash code for two objects.
int hash2(dynamic a, dynamic b) =>
    _finish(_combine(_combine(0, a.hashCode), b.hashCode));

/// Generates a hash code for three objects.
int hash3(dynamic a, dynamic b, dynamic c) => _finish(
    _combine(_combine(_combine(0, a.hashCode), b.hashCode), c.hashCode));

/// Generates a hash code for four objects.
int hash4(dynamic a, dynamic b, dynamic c, Object d) => _finish(_combine(
    _combine(_combine(_combine(0, a.hashCode), b.hashCode), c.hashCode),
    d.hashCode));

// Jenkins hash functions

int _combine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _finish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}
