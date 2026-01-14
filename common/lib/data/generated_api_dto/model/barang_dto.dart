//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BarangDto {
  /// Returns a new [BarangDto] instance.
  BarangDto({
    this.id,
    this.kodeBarang,
    this.nama,
    this.kategori,
    this.minStock,
    this.nomorRak,
    this.nomorLaci,
    this.nomorKolom,
    this.stockSekarang,
    this.lastMonthStock,
    this.unitPrice,
    this.uom,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? kodeBarang;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nama;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  KategoriDto? kategori;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? minStock;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? nomorRak;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? nomorLaci;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? nomorKolom;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? stockSekarang;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? lastMonthStock;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? unitPrice;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? uom;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BarangDto &&
    other.id == id &&
    other.kodeBarang == kodeBarang &&
    other.nama == nama &&
    other.kategori == kategori &&
    other.minStock == minStock &&
    other.nomorRak == nomorRak &&
    other.nomorLaci == nomorLaci &&
    other.nomorKolom == nomorKolom &&
    other.stockSekarang == stockSekarang &&
    other.lastMonthStock == lastMonthStock &&
    other.unitPrice == unitPrice &&
    other.uom == uom;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (kodeBarang == null ? 0 : kodeBarang!.hashCode) +
    (nama == null ? 0 : nama!.hashCode) +
    (kategori == null ? 0 : kategori!.hashCode) +
    (minStock == null ? 0 : minStock!.hashCode) +
    (nomorRak == null ? 0 : nomorRak!.hashCode) +
    (nomorLaci == null ? 0 : nomorLaci!.hashCode) +
    (nomorKolom == null ? 0 : nomorKolom!.hashCode) +
    (stockSekarang == null ? 0 : stockSekarang!.hashCode) +
    (lastMonthStock == null ? 0 : lastMonthStock!.hashCode) +
    (unitPrice == null ? 0 : unitPrice!.hashCode) +
    (uom == null ? 0 : uom!.hashCode);

  @override
  String toString() => 'BarangDto[id=$id, kodeBarang=$kodeBarang, nama=$nama, kategori=$kategori, minStock=$minStock, nomorRak=$nomorRak, nomorLaci=$nomorLaci, nomorKolom=$nomorKolom, stockSekarang=$stockSekarang, lastMonthStock=$lastMonthStock, unitPrice=$unitPrice, uom=$uom]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.kodeBarang != null) {
      json[r'kode_barang'] = this.kodeBarang;
    } else {
      json[r'kode_barang'] = null;
    }
    if (this.nama != null) {
      json[r'nama'] = this.nama;
    } else {
      json[r'nama'] = null;
    }
    if (this.kategori != null) {
      json[r'kategori'] = this.kategori;
    } else {
      json[r'kategori'] = null;
    }
    if (this.minStock != null) {
      json[r'min_stock'] = this.minStock;
    } else {
      json[r'min_stock'] = null;
    }
    if (this.nomorRak != null) {
      json[r'nomor_rak'] = this.nomorRak;
    } else {
      json[r'nomor_rak'] = null;
    }
    if (this.nomorLaci != null) {
      json[r'nomor_laci'] = this.nomorLaci;
    } else {
      json[r'nomor_laci'] = null;
    }
    if (this.nomorKolom != null) {
      json[r'nomor_kolom'] = this.nomorKolom;
    } else {
      json[r'nomor_kolom'] = null;
    }
    if (this.stockSekarang != null) {
      json[r'stock_sekarang'] = this.stockSekarang;
    } else {
      json[r'stock_sekarang'] = null;
    }
    if (this.lastMonthStock != null) {
      json[r'last_month_stock'] = this.lastMonthStock;
    } else {
      json[r'last_month_stock'] = null;
    }
    if (this.unitPrice != null) {
      json[r'unit_price'] = this.unitPrice;
    } else {
      json[r'unit_price'] = null;
    }
    if (this.uom != null) {
      json[r'uom'] = this.uom;
    } else {
      json[r'uom'] = null;
    }
    return json;
  }

  /// Returns a new [BarangDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BarangDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BarangDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BarangDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BarangDto(
        id: mapValueOfType<int>(json, r'id'),
        kodeBarang: mapValueOfType<String>(json, r'kode_barang'),
        nama: mapValueOfType<String>(json, r'nama'),
        kategori: KategoriDto.fromJson(json[r'kategori']),
        minStock: mapValueOfType<int>(json, r'min_stock'),
        nomorRak: mapValueOfType<int>(json, r'nomor_rak'),
        nomorLaci: mapValueOfType<int>(json, r'nomor_laci'),
        nomorKolom: mapValueOfType<int>(json, r'nomor_kolom'),
        stockSekarang: mapValueOfType<int>(json, r'stock_sekarang'),
        lastMonthStock: mapValueOfType<int>(json, r'last_month_stock'),
        unitPrice: mapValueOfType<int>(json, r'unit_price'),
        uom: mapValueOfType<String>(json, r'uom'),
      );
    }
    return null;
  }

  static List<BarangDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BarangDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BarangDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BarangDto> mapFromJson(dynamic json) {
    final map = <String, BarangDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BarangDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BarangDto-objects as value to a dart map
  static Map<String, List<BarangDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BarangDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BarangDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

