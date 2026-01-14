//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostBarangDto {
  /// Returns a new [PostBarangDto] instance.
  PostBarangDto({
    this.id,
    required this.nama,
    required this.kodeBarang,
    required this.nomorRak,
    required this.nomorLaci,
    required this.nomorKolom,
    required this.stockSekarang,
    required this.lastMonthStock,
    required this.minStock,
    required this.unitPrice,
    required this.uom,
    required this.kategoriId,
  });

  int? id;

  String nama;

  String kodeBarang;

  /// Minimum value: 1
  /// Maximum value: 6
  int nomorRak;

  /// Minimum value: 1
  /// Maximum value: 30
  int nomorLaci;

  /// Minimum value: 1
  /// Maximum value: 9
  int nomorKolom;

  /// Minimum value: 1
  /// Maximum value: 2147483647
  int stockSekarang;

  /// Minimum value: 1
  /// Maximum value: 2147483647
  int lastMonthStock;

  /// Minimum value: 1
  /// Maximum value: 2147483647
  int minStock;

  /// Minimum value: 1
  /// Maximum value: 2147483647
  int unitPrice;

  String uom;

  /// Minimum value: 1
  /// Maximum value: 2147483647
  int kategoriId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostBarangDto &&
    other.id == id &&
    other.nama == nama &&
    other.kodeBarang == kodeBarang &&
    other.nomorRak == nomorRak &&
    other.nomorLaci == nomorLaci &&
    other.nomorKolom == nomorKolom &&
    other.stockSekarang == stockSekarang &&
    other.lastMonthStock == lastMonthStock &&
    other.minStock == minStock &&
    other.unitPrice == unitPrice &&
    other.uom == uom &&
    other.kategoriId == kategoriId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (nama.hashCode) +
    (kodeBarang.hashCode) +
    (nomorRak.hashCode) +
    (nomorLaci.hashCode) +
    (nomorKolom.hashCode) +
    (stockSekarang.hashCode) +
    (lastMonthStock.hashCode) +
    (minStock.hashCode) +
    (unitPrice.hashCode) +
    (uom.hashCode) +
    (kategoriId.hashCode);

  @override
  String toString() => 'PostBarangDto[id=$id, nama=$nama, kodeBarang=$kodeBarang, nomorRak=$nomorRak, nomorLaci=$nomorLaci, nomorKolom=$nomorKolom, stockSekarang=$stockSekarang, lastMonthStock=$lastMonthStock, minStock=$minStock, unitPrice=$unitPrice, uom=$uom, kategoriId=$kategoriId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
      json[r'nama'] = this.nama;
      json[r'kode_barang'] = this.kodeBarang;
      json[r'nomor_rak'] = this.nomorRak;
      json[r'nomor_laci'] = this.nomorLaci;
      json[r'nomor_kolom'] = this.nomorKolom;
      json[r'stock_sekarang'] = this.stockSekarang;
      json[r'last_month_stock'] = this.lastMonthStock;
      json[r'min_stock'] = this.minStock;
      json[r'unit_price'] = this.unitPrice;
      json[r'uom'] = this.uom;
      json[r'kategori_id'] = this.kategoriId;
    return json;
  }

  /// Returns a new [PostBarangDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostBarangDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostBarangDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostBarangDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostBarangDto(
        id: mapValueOfType<int>(json, r'id'),
        nama: mapValueOfType<String>(json, r'nama')!,
        kodeBarang: mapValueOfType<String>(json, r'kode_barang')!,
        nomorRak: mapValueOfType<int>(json, r'nomor_rak')!,
        nomorLaci: mapValueOfType<int>(json, r'nomor_laci')!,
        nomorKolom: mapValueOfType<int>(json, r'nomor_kolom')!,
        stockSekarang: mapValueOfType<int>(json, r'stock_sekarang')!,
        lastMonthStock: mapValueOfType<int>(json, r'last_month_stock')!,
        minStock: mapValueOfType<int>(json, r'min_stock')!,
        unitPrice: mapValueOfType<int>(json, r'unit_price')!,
        uom: mapValueOfType<String>(json, r'uom')!,
        kategoriId: mapValueOfType<int>(json, r'kategori_id')!,
      );
    }
    return null;
  }

  static List<PostBarangDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostBarangDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostBarangDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostBarangDto> mapFromJson(dynamic json) {
    final map = <String, PostBarangDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostBarangDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostBarangDto-objects as value to a dart map
  static Map<String, List<PostBarangDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostBarangDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostBarangDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'nama',
    'kode_barang',
    'nomor_rak',
    'nomor_laci',
    'nomor_kolom',
    'stock_sekarang',
    'last_month_stock',
    'min_stock',
    'unit_price',
    'uom',
    'kategori_id',
  };
}

