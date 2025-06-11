// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaItemMeta = const VerificationMeta(
    'namaItem',
  );
  @override
  late final GeneratedColumn<String> namaItem = GeneratedColumn<String>(
    'nama_item',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _stokUnitTerkecilMeta = const VerificationMeta(
    'stokUnitTerkecil',
  );
  @override
  late final GeneratedColumn<int> stokUnitTerkecil = GeneratedColumn<int>(
    'stok_unit_terkecil',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitTerkecilMeta = const VerificationMeta(
    'unitTerkecil',
  );
  @override
  late final GeneratedColumn<String> unitTerkecil = GeneratedColumn<String>(
    'unit_terkecil',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hargaItemMeta = const VerificationMeta(
    'hargaItem',
  );
  @override
  late final GeneratedColumn<int> hargaItem = GeneratedColumn<int>(
    'harga_item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _konversiMeta = const VerificationMeta(
    'konversi',
  );
  @override
  late final GeneratedColumn<String> konversi = GeneratedColumn<String>(
    'konversi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    namaItem,
    stokUnitTerkecil,
    unitTerkecil,
    hargaItem,
    konversi,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_item')) {
      context.handle(
        _namaItemMeta,
        namaItem.isAcceptableOrUnknown(data['nama_item']!, _namaItemMeta),
      );
    } else if (isInserting) {
      context.missing(_namaItemMeta);
    }
    if (data.containsKey('stok_unit_terkecil')) {
      context.handle(
        _stokUnitTerkecilMeta,
        stokUnitTerkecil.isAcceptableOrUnknown(
          data['stok_unit_terkecil']!,
          _stokUnitTerkecilMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stokUnitTerkecilMeta);
    }
    if (data.containsKey('unit_terkecil')) {
      context.handle(
        _unitTerkecilMeta,
        unitTerkecil.isAcceptableOrUnknown(
          data['unit_terkecil']!,
          _unitTerkecilMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitTerkecilMeta);
    }
    if (data.containsKey('harga_item')) {
      context.handle(
        _hargaItemMeta,
        hargaItem.isAcceptableOrUnknown(data['harga_item']!, _hargaItemMeta),
      );
    } else if (isInserting) {
      context.missing(_hargaItemMeta);
    }
    if (data.containsKey('konversi')) {
      context.handle(
        _konversiMeta,
        konversi.isAcceptableOrUnknown(data['konversi']!, _konversiMeta),
      );
    } else if (isInserting) {
      context.missing(_konversiMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      namaItem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_item'],
      )!,
      stokUnitTerkecil: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stok_unit_terkecil'],
      )!,
      unitTerkecil: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_terkecil'],
      )!,
      hargaItem: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga_item'],
      )!,
      konversi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}konversi'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String namaItem;
  final int stokUnitTerkecil;
  final String unitTerkecil;
  final int hargaItem;
  final String konversi;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Item({
    required this.id,
    required this.namaItem,
    required this.stokUnitTerkecil,
    required this.unitTerkecil,
    required this.hargaItem,
    required this.konversi,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_item'] = Variable<String>(namaItem);
    map['stok_unit_terkecil'] = Variable<int>(stokUnitTerkecil);
    map['unit_terkecil'] = Variable<String>(unitTerkecil);
    map['harga_item'] = Variable<int>(hargaItem);
    map['konversi'] = Variable<String>(konversi);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      namaItem: Value(namaItem),
      stokUnitTerkecil: Value(stokUnitTerkecil),
      unitTerkecil: Value(unitTerkecil),
      hargaItem: Value(hargaItem),
      konversi: Value(konversi),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      namaItem: serializer.fromJson<String>(json['namaItem']),
      stokUnitTerkecil: serializer.fromJson<int>(json['stokUnitTerkecil']),
      unitTerkecil: serializer.fromJson<String>(json['unitTerkecil']),
      hargaItem: serializer.fromJson<int>(json['hargaItem']),
      konversi: serializer.fromJson<String>(json['konversi']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaItem': serializer.toJson<String>(namaItem),
      'stokUnitTerkecil': serializer.toJson<int>(stokUnitTerkecil),
      'unitTerkecil': serializer.toJson<String>(unitTerkecil),
      'hargaItem': serializer.toJson<int>(hargaItem),
      'konversi': serializer.toJson<String>(konversi),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Item copyWith({
    int? id,
    String? namaItem,
    int? stokUnitTerkecil,
    String? unitTerkecil,
    int? hargaItem,
    String? konversi,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Item(
    id: id ?? this.id,
    namaItem: namaItem ?? this.namaItem,
    stokUnitTerkecil: stokUnitTerkecil ?? this.stokUnitTerkecil,
    unitTerkecil: unitTerkecil ?? this.unitTerkecil,
    hargaItem: hargaItem ?? this.hargaItem,
    konversi: konversi ?? this.konversi,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      namaItem: data.namaItem.present ? data.namaItem.value : this.namaItem,
      stokUnitTerkecil: data.stokUnitTerkecil.present
          ? data.stokUnitTerkecil.value
          : this.stokUnitTerkecil,
      unitTerkecil: data.unitTerkecil.present
          ? data.unitTerkecil.value
          : this.unitTerkecil,
      hargaItem: data.hargaItem.present ? data.hargaItem.value : this.hargaItem,
      konversi: data.konversi.present ? data.konversi.value : this.konversi,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('namaItem: $namaItem, ')
          ..write('stokUnitTerkecil: $stokUnitTerkecil, ')
          ..write('unitTerkecil: $unitTerkecil, ')
          ..write('hargaItem: $hargaItem, ')
          ..write('konversi: $konversi, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    namaItem,
    stokUnitTerkecil,
    unitTerkecil,
    hargaItem,
    konversi,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.namaItem == this.namaItem &&
          other.stokUnitTerkecil == this.stokUnitTerkecil &&
          other.unitTerkecil == this.unitTerkecil &&
          other.hargaItem == this.hargaItem &&
          other.konversi == this.konversi &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> namaItem;
  final Value<int> stokUnitTerkecil;
  final Value<String> unitTerkecil;
  final Value<int> hargaItem;
  final Value<String> konversi;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.namaItem = const Value.absent(),
    this.stokUnitTerkecil = const Value.absent(),
    this.unitTerkecil = const Value.absent(),
    this.hargaItem = const Value.absent(),
    this.konversi = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String namaItem,
    required int stokUnitTerkecil,
    required String unitTerkecil,
    required int hargaItem,
    required String konversi,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : namaItem = Value(namaItem),
       stokUnitTerkecil = Value(stokUnitTerkecil),
       unitTerkecil = Value(unitTerkecil),
       hargaItem = Value(hargaItem),
       konversi = Value(konversi);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? namaItem,
    Expression<int>? stokUnitTerkecil,
    Expression<String>? unitTerkecil,
    Expression<int>? hargaItem,
    Expression<String>? konversi,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaItem != null) 'nama_item': namaItem,
      if (stokUnitTerkecil != null) 'stok_unit_terkecil': stokUnitTerkecil,
      if (unitTerkecil != null) 'unit_terkecil': unitTerkecil,
      if (hargaItem != null) 'harga_item': hargaItem,
      if (konversi != null) 'konversi': konversi,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? namaItem,
    Value<int>? stokUnitTerkecil,
    Value<String>? unitTerkecil,
    Value<int>? hargaItem,
    Value<String>? konversi,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      namaItem: namaItem ?? this.namaItem,
      stokUnitTerkecil: stokUnitTerkecil ?? this.stokUnitTerkecil,
      unitTerkecil: unitTerkecil ?? this.unitTerkecil,
      hargaItem: hargaItem ?? this.hargaItem,
      konversi: konversi ?? this.konversi,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaItem.present) {
      map['nama_item'] = Variable<String>(namaItem.value);
    }
    if (stokUnitTerkecil.present) {
      map['stok_unit_terkecil'] = Variable<int>(stokUnitTerkecil.value);
    }
    if (unitTerkecil.present) {
      map['unit_terkecil'] = Variable<String>(unitTerkecil.value);
    }
    if (hargaItem.present) {
      map['harga_item'] = Variable<int>(hargaItem.value);
    }
    if (konversi.present) {
      map['konversi'] = Variable<String>(konversi.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('namaItem: $namaItem, ')
          ..write('stokUnitTerkecil: $stokUnitTerkecil, ')
          ..write('unitTerkecil: $unitTerkecil, ')
          ..write('hargaItem: $hargaItem, ')
          ..write('konversi: $konversi, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaPenjualanMeta = const VerificationMeta(
    'namaPenjualan',
  );
  @override
  late final GeneratedColumn<String> namaPenjualan = GeneratedColumn<String>(
    'nama_penjualan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _namaInstansiMeta = const VerificationMeta(
    'namaInstansi',
  );
  @override
  late final GeneratedColumn<String> namaInstansi = GeneratedColumn<String>(
    'nama_instansi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipePenjualanMeta = const VerificationMeta(
    'tipePenjualan',
  );
  @override
  late final GeneratedColumn<String> tipePenjualan = GeneratedColumn<String>(
    'tipe_penjualan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant('KREDIT'),
  );
  static const VerificationMeta _identifiersMeta = const VerificationMeta(
    'identifiers',
  );
  @override
  late final GeneratedColumn<String> identifiers = GeneratedColumn<String>(
    'identifiers',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sudahDibayarMeta = const VerificationMeta(
    'sudahDibayar',
  );
  @override
  late final GeneratedColumn<bool> sudahDibayar = GeneratedColumn<bool>(
    'sudah_dibayar',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sudah_dibayar" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _tanggalPenjualanMeta = const VerificationMeta(
    'tanggalPenjualan',
  );
  @override
  late final GeneratedColumn<DateTime> tanggalPenjualan =
      GeneratedColumn<DateTime>(
        'tanggal_penjualan',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _tenggatWaktuMeta = const VerificationMeta(
    'tenggatWaktu',
  );
  @override
  late final GeneratedColumn<DateTime> tenggatWaktu = GeneratedColumn<DateTime>(
    'tenggat_waktu',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    namaPenjualan,
    namaInstansi,
    tipePenjualan,
    identifiers,
    sudahDibayar,
    tanggalPenjualan,
    tenggatWaktu,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_penjualan')) {
      context.handle(
        _namaPenjualanMeta,
        namaPenjualan.isAcceptableOrUnknown(
          data['nama_penjualan']!,
          _namaPenjualanMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_namaPenjualanMeta);
    }
    if (data.containsKey('nama_instansi')) {
      context.handle(
        _namaInstansiMeta,
        namaInstansi.isAcceptableOrUnknown(
          data['nama_instansi']!,
          _namaInstansiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_namaInstansiMeta);
    }
    if (data.containsKey('tipe_penjualan')) {
      context.handle(
        _tipePenjualanMeta,
        tipePenjualan.isAcceptableOrUnknown(
          data['tipe_penjualan']!,
          _tipePenjualanMeta,
        ),
      );
    }
    if (data.containsKey('identifiers')) {
      context.handle(
        _identifiersMeta,
        identifiers.isAcceptableOrUnknown(
          data['identifiers']!,
          _identifiersMeta,
        ),
      );
    }
    if (data.containsKey('sudah_dibayar')) {
      context.handle(
        _sudahDibayarMeta,
        sudahDibayar.isAcceptableOrUnknown(
          data['sudah_dibayar']!,
          _sudahDibayarMeta,
        ),
      );
    }
    if (data.containsKey('tanggal_penjualan')) {
      context.handle(
        _tanggalPenjualanMeta,
        tanggalPenjualan.isAcceptableOrUnknown(
          data['tanggal_penjualan']!,
          _tanggalPenjualanMeta,
        ),
      );
    }
    if (data.containsKey('tenggat_waktu')) {
      context.handle(
        _tenggatWaktuMeta,
        tenggatWaktu.isAcceptableOrUnknown(
          data['tenggat_waktu']!,
          _tenggatWaktuMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      namaPenjualan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_penjualan'],
      )!,
      namaInstansi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_instansi'],
      )!,
      tipePenjualan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipe_penjualan'],
      )!,
      identifiers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identifiers'],
      ),
      sudahDibayar: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sudah_dibayar'],
      )!,
      tanggalPenjualan: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal_penjualan'],
      ),
      tenggatWaktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tenggat_waktu'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final int id;
  final String namaPenjualan;
  final String namaInstansi;
  final String tipePenjualan;
  final String? identifiers;
  final bool sudahDibayar;
  final DateTime? tanggalPenjualan;
  final DateTime? tenggatWaktu;
  final DateTime createdAt;
  const Sale({
    required this.id,
    required this.namaPenjualan,
    required this.namaInstansi,
    required this.tipePenjualan,
    this.identifiers,
    required this.sudahDibayar,
    this.tanggalPenjualan,
    this.tenggatWaktu,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_penjualan'] = Variable<String>(namaPenjualan);
    map['nama_instansi'] = Variable<String>(namaInstansi);
    map['tipe_penjualan'] = Variable<String>(tipePenjualan);
    if (!nullToAbsent || identifiers != null) {
      map['identifiers'] = Variable<String>(identifiers);
    }
    map['sudah_dibayar'] = Variable<bool>(sudahDibayar);
    if (!nullToAbsent || tanggalPenjualan != null) {
      map['tanggal_penjualan'] = Variable<DateTime>(tanggalPenjualan);
    }
    if (!nullToAbsent || tenggatWaktu != null) {
      map['tenggat_waktu'] = Variable<DateTime>(tenggatWaktu);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      namaPenjualan: Value(namaPenjualan),
      namaInstansi: Value(namaInstansi),
      tipePenjualan: Value(tipePenjualan),
      identifiers: identifiers == null && nullToAbsent
          ? const Value.absent()
          : Value(identifiers),
      sudahDibayar: Value(sudahDibayar),
      tanggalPenjualan: tanggalPenjualan == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggalPenjualan),
      tenggatWaktu: tenggatWaktu == null && nullToAbsent
          ? const Value.absent()
          : Value(tenggatWaktu),
      createdAt: Value(createdAt),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<int>(json['id']),
      namaPenjualan: serializer.fromJson<String>(json['namaPenjualan']),
      namaInstansi: serializer.fromJson<String>(json['namaInstansi']),
      tipePenjualan: serializer.fromJson<String>(json['tipePenjualan']),
      identifiers: serializer.fromJson<String?>(json['identifiers']),
      sudahDibayar: serializer.fromJson<bool>(json['sudahDibayar']),
      tanggalPenjualan: serializer.fromJson<DateTime?>(
        json['tanggalPenjualan'],
      ),
      tenggatWaktu: serializer.fromJson<DateTime?>(json['tenggatWaktu']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaPenjualan': serializer.toJson<String>(namaPenjualan),
      'namaInstansi': serializer.toJson<String>(namaInstansi),
      'tipePenjualan': serializer.toJson<String>(tipePenjualan),
      'identifiers': serializer.toJson<String?>(identifiers),
      'sudahDibayar': serializer.toJson<bool>(sudahDibayar),
      'tanggalPenjualan': serializer.toJson<DateTime?>(tanggalPenjualan),
      'tenggatWaktu': serializer.toJson<DateTime?>(tenggatWaktu),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Sale copyWith({
    int? id,
    String? namaPenjualan,
    String? namaInstansi,
    String? tipePenjualan,
    Value<String?> identifiers = const Value.absent(),
    bool? sudahDibayar,
    Value<DateTime?> tanggalPenjualan = const Value.absent(),
    Value<DateTime?> tenggatWaktu = const Value.absent(),
    DateTime? createdAt,
  }) => Sale(
    id: id ?? this.id,
    namaPenjualan: namaPenjualan ?? this.namaPenjualan,
    namaInstansi: namaInstansi ?? this.namaInstansi,
    tipePenjualan: tipePenjualan ?? this.tipePenjualan,
    identifiers: identifiers.present ? identifiers.value : this.identifiers,
    sudahDibayar: sudahDibayar ?? this.sudahDibayar,
    tanggalPenjualan: tanggalPenjualan.present
        ? tanggalPenjualan.value
        : this.tanggalPenjualan,
    tenggatWaktu: tenggatWaktu.present ? tenggatWaktu.value : this.tenggatWaktu,
    createdAt: createdAt ?? this.createdAt,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      namaPenjualan: data.namaPenjualan.present
          ? data.namaPenjualan.value
          : this.namaPenjualan,
      namaInstansi: data.namaInstansi.present
          ? data.namaInstansi.value
          : this.namaInstansi,
      tipePenjualan: data.tipePenjualan.present
          ? data.tipePenjualan.value
          : this.tipePenjualan,
      identifiers: data.identifiers.present
          ? data.identifiers.value
          : this.identifiers,
      sudahDibayar: data.sudahDibayar.present
          ? data.sudahDibayar.value
          : this.sudahDibayar,
      tanggalPenjualan: data.tanggalPenjualan.present
          ? data.tanggalPenjualan.value
          : this.tanggalPenjualan,
      tenggatWaktu: data.tenggatWaktu.present
          ? data.tenggatWaktu.value
          : this.tenggatWaktu,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('namaPenjualan: $namaPenjualan, ')
          ..write('namaInstansi: $namaInstansi, ')
          ..write('tipePenjualan: $tipePenjualan, ')
          ..write('identifiers: $identifiers, ')
          ..write('sudahDibayar: $sudahDibayar, ')
          ..write('tanggalPenjualan: $tanggalPenjualan, ')
          ..write('tenggatWaktu: $tenggatWaktu, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    namaPenjualan,
    namaInstansi,
    tipePenjualan,
    identifiers,
    sudahDibayar,
    tanggalPenjualan,
    tenggatWaktu,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.namaPenjualan == this.namaPenjualan &&
          other.namaInstansi == this.namaInstansi &&
          other.tipePenjualan == this.tipePenjualan &&
          other.identifiers == this.identifiers &&
          other.sudahDibayar == this.sudahDibayar &&
          other.tanggalPenjualan == this.tanggalPenjualan &&
          other.tenggatWaktu == this.tenggatWaktu &&
          other.createdAt == this.createdAt);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> id;
  final Value<String> namaPenjualan;
  final Value<String> namaInstansi;
  final Value<String> tipePenjualan;
  final Value<String?> identifiers;
  final Value<bool> sudahDibayar;
  final Value<DateTime?> tanggalPenjualan;
  final Value<DateTime?> tenggatWaktu;
  final Value<DateTime> createdAt;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.namaPenjualan = const Value.absent(),
    this.namaInstansi = const Value.absent(),
    this.tipePenjualan = const Value.absent(),
    this.identifiers = const Value.absent(),
    this.sudahDibayar = const Value.absent(),
    this.tanggalPenjualan = const Value.absent(),
    this.tenggatWaktu = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required String namaPenjualan,
    required String namaInstansi,
    this.tipePenjualan = const Value.absent(),
    this.identifiers = const Value.absent(),
    this.sudahDibayar = const Value.absent(),
    this.tanggalPenjualan = const Value.absent(),
    this.tenggatWaktu = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : namaPenjualan = Value(namaPenjualan),
       namaInstansi = Value(namaInstansi);
  static Insertable<Sale> custom({
    Expression<int>? id,
    Expression<String>? namaPenjualan,
    Expression<String>? namaInstansi,
    Expression<String>? tipePenjualan,
    Expression<String>? identifiers,
    Expression<bool>? sudahDibayar,
    Expression<DateTime>? tanggalPenjualan,
    Expression<DateTime>? tenggatWaktu,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaPenjualan != null) 'nama_penjualan': namaPenjualan,
      if (namaInstansi != null) 'nama_instansi': namaInstansi,
      if (tipePenjualan != null) 'tipe_penjualan': tipePenjualan,
      if (identifiers != null) 'identifiers': identifiers,
      if (sudahDibayar != null) 'sudah_dibayar': sudahDibayar,
      if (tanggalPenjualan != null) 'tanggal_penjualan': tanggalPenjualan,
      if (tenggatWaktu != null) 'tenggat_waktu': tenggatWaktu,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SalesCompanion copyWith({
    Value<int>? id,
    Value<String>? namaPenjualan,
    Value<String>? namaInstansi,
    Value<String>? tipePenjualan,
    Value<String?>? identifiers,
    Value<bool>? sudahDibayar,
    Value<DateTime?>? tanggalPenjualan,
    Value<DateTime?>? tenggatWaktu,
    Value<DateTime>? createdAt,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      namaPenjualan: namaPenjualan ?? this.namaPenjualan,
      namaInstansi: namaInstansi ?? this.namaInstansi,
      tipePenjualan: tipePenjualan ?? this.tipePenjualan,
      identifiers: identifiers ?? this.identifiers,
      sudahDibayar: sudahDibayar ?? this.sudahDibayar,
      tanggalPenjualan: tanggalPenjualan ?? this.tanggalPenjualan,
      tenggatWaktu: tenggatWaktu ?? this.tenggatWaktu,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaPenjualan.present) {
      map['nama_penjualan'] = Variable<String>(namaPenjualan.value);
    }
    if (namaInstansi.present) {
      map['nama_instansi'] = Variable<String>(namaInstansi.value);
    }
    if (tipePenjualan.present) {
      map['tipe_penjualan'] = Variable<String>(tipePenjualan.value);
    }
    if (identifiers.present) {
      map['identifiers'] = Variable<String>(identifiers.value);
    }
    if (sudahDibayar.present) {
      map['sudah_dibayar'] = Variable<bool>(sudahDibayar.value);
    }
    if (tanggalPenjualan.present) {
      map['tanggal_penjualan'] = Variable<DateTime>(tanggalPenjualan.value);
    }
    if (tenggatWaktu.present) {
      map['tenggat_waktu'] = Variable<DateTime>(tenggatWaktu.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('namaPenjualan: $namaPenjualan, ')
          ..write('namaInstansi: $namaInstansi, ')
          ..write('tipePenjualan: $tipePenjualan, ')
          ..write('identifiers: $identifiers, ')
          ..write('sudahDibayar: $sudahDibayar, ')
          ..write('tanggalPenjualan: $tanggalPenjualan, ')
          ..write('tenggatWaktu: $tenggatWaktu, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaItemMeta = const VerificationMeta(
    'namaItem',
  );
  @override
  late final GeneratedColumn<String> namaItem = GeneratedColumn<String>(
    'nama_item',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jumlahMeta = const VerificationMeta('jumlah');
  @override
  late final GeneratedColumn<int> jumlah = GeneratedColumn<int>(
    'jumlah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hargaMeta = const VerificationMeta('harga');
  @override
  late final GeneratedColumn<int> harga = GeneratedColumn<int>(
    'harga',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitTerkecilMeta = const VerificationMeta(
    'unitTerkecil',
  );
  @override
  late final GeneratedColumn<String> unitTerkecil = GeneratedColumn<String>(
    'unit_terkecil',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _multiplierMeta = const VerificationMeta(
    'multiplier',
  );
  @override
  late final GeneratedColumn<int> multiplier = GeneratedColumn<int>(
    'multiplier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    namaItem,
    jumlah,
    harga,
    unitTerkecil,
    unit,
    multiplier,
    saleId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_item')) {
      context.handle(
        _namaItemMeta,
        namaItem.isAcceptableOrUnknown(data['nama_item']!, _namaItemMeta),
      );
    } else if (isInserting) {
      context.missing(_namaItemMeta);
    }
    if (data.containsKey('jumlah')) {
      context.handle(
        _jumlahMeta,
        jumlah.isAcceptableOrUnknown(data['jumlah']!, _jumlahMeta),
      );
    } else if (isInserting) {
      context.missing(_jumlahMeta);
    }
    if (data.containsKey('harga')) {
      context.handle(
        _hargaMeta,
        harga.isAcceptableOrUnknown(data['harga']!, _hargaMeta),
      );
    } else if (isInserting) {
      context.missing(_hargaMeta);
    }
    if (data.containsKey('unit_terkecil')) {
      context.handle(
        _unitTerkecilMeta,
        unitTerkecil.isAcceptableOrUnknown(
          data['unit_terkecil']!,
          _unitTerkecilMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitTerkecilMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('multiplier')) {
      context.handle(
        _multiplierMeta,
        multiplier.isAcceptableOrUnknown(data['multiplier']!, _multiplierMeta),
      );
    } else if (isInserting) {
      context.missing(_multiplierMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      namaItem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_item'],
      )!,
      jumlah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jumlah'],
      )!,
      harga: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga'],
      )!,
      unitTerkecil: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_terkecil'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      multiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}multiplier'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sale_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final int id;
  final String namaItem;
  final int jumlah;
  final int harga;
  final String unitTerkecil;
  final String unit;
  final int multiplier;
  final int saleId;
  final DateTime createdAt;
  const SaleItem({
    required this.id,
    required this.namaItem,
    required this.jumlah,
    required this.harga,
    required this.unitTerkecil,
    required this.unit,
    required this.multiplier,
    required this.saleId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_item'] = Variable<String>(namaItem);
    map['jumlah'] = Variable<int>(jumlah);
    map['harga'] = Variable<int>(harga);
    map['unit_terkecil'] = Variable<String>(unitTerkecil);
    map['unit'] = Variable<String>(unit);
    map['multiplier'] = Variable<int>(multiplier);
    map['sale_id'] = Variable<int>(saleId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      namaItem: Value(namaItem),
      jumlah: Value(jumlah),
      harga: Value(harga),
      unitTerkecil: Value(unitTerkecil),
      unit: Value(unit),
      multiplier: Value(multiplier),
      saleId: Value(saleId),
      createdAt: Value(createdAt),
    );
  }

  factory SaleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<int>(json['id']),
      namaItem: serializer.fromJson<String>(json['namaItem']),
      jumlah: serializer.fromJson<int>(json['jumlah']),
      harga: serializer.fromJson<int>(json['harga']),
      unitTerkecil: serializer.fromJson<String>(json['unitTerkecil']),
      unit: serializer.fromJson<String>(json['unit']),
      multiplier: serializer.fromJson<int>(json['multiplier']),
      saleId: serializer.fromJson<int>(json['saleId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaItem': serializer.toJson<String>(namaItem),
      'jumlah': serializer.toJson<int>(jumlah),
      'harga': serializer.toJson<int>(harga),
      'unitTerkecil': serializer.toJson<String>(unitTerkecil),
      'unit': serializer.toJson<String>(unit),
      'multiplier': serializer.toJson<int>(multiplier),
      'saleId': serializer.toJson<int>(saleId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SaleItem copyWith({
    int? id,
    String? namaItem,
    int? jumlah,
    int? harga,
    String? unitTerkecil,
    String? unit,
    int? multiplier,
    int? saleId,
    DateTime? createdAt,
  }) => SaleItem(
    id: id ?? this.id,
    namaItem: namaItem ?? this.namaItem,
    jumlah: jumlah ?? this.jumlah,
    harga: harga ?? this.harga,
    unitTerkecil: unitTerkecil ?? this.unitTerkecil,
    unit: unit ?? this.unit,
    multiplier: multiplier ?? this.multiplier,
    saleId: saleId ?? this.saleId,
    createdAt: createdAt ?? this.createdAt,
  );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      namaItem: data.namaItem.present ? data.namaItem.value : this.namaItem,
      jumlah: data.jumlah.present ? data.jumlah.value : this.jumlah,
      harga: data.harga.present ? data.harga.value : this.harga,
      unitTerkecil: data.unitTerkecil.present
          ? data.unitTerkecil.value
          : this.unitTerkecil,
      unit: data.unit.present ? data.unit.value : this.unit,
      multiplier: data.multiplier.present
          ? data.multiplier.value
          : this.multiplier,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('namaItem: $namaItem, ')
          ..write('jumlah: $jumlah, ')
          ..write('harga: $harga, ')
          ..write('unitTerkecil: $unitTerkecil, ')
          ..write('unit: $unit, ')
          ..write('multiplier: $multiplier, ')
          ..write('saleId: $saleId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    namaItem,
    jumlah,
    harga,
    unitTerkecil,
    unit,
    multiplier,
    saleId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.namaItem == this.namaItem &&
          other.jumlah == this.jumlah &&
          other.harga == this.harga &&
          other.unitTerkecil == this.unitTerkecil &&
          other.unit == this.unit &&
          other.multiplier == this.multiplier &&
          other.saleId == this.saleId &&
          other.createdAt == this.createdAt);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<int> id;
  final Value<String> namaItem;
  final Value<int> jumlah;
  final Value<int> harga;
  final Value<String> unitTerkecil;
  final Value<String> unit;
  final Value<int> multiplier;
  final Value<int> saleId;
  final Value<DateTime> createdAt;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.namaItem = const Value.absent(),
    this.jumlah = const Value.absent(),
    this.harga = const Value.absent(),
    this.unitTerkecil = const Value.absent(),
    this.unit = const Value.absent(),
    this.multiplier = const Value.absent(),
    this.saleId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    this.id = const Value.absent(),
    required String namaItem,
    required int jumlah,
    required int harga,
    required String unitTerkecil,
    required String unit,
    required int multiplier,
    required int saleId,
    this.createdAt = const Value.absent(),
  }) : namaItem = Value(namaItem),
       jumlah = Value(jumlah),
       harga = Value(harga),
       unitTerkecil = Value(unitTerkecil),
       unit = Value(unit),
       multiplier = Value(multiplier),
       saleId = Value(saleId);
  static Insertable<SaleItem> custom({
    Expression<int>? id,
    Expression<String>? namaItem,
    Expression<int>? jumlah,
    Expression<int>? harga,
    Expression<String>? unitTerkecil,
    Expression<String>? unit,
    Expression<int>? multiplier,
    Expression<int>? saleId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaItem != null) 'nama_item': namaItem,
      if (jumlah != null) 'jumlah': jumlah,
      if (harga != null) 'harga': harga,
      if (unitTerkecil != null) 'unit_terkecil': unitTerkecil,
      if (unit != null) 'unit': unit,
      if (multiplier != null) 'multiplier': multiplier,
      if (saleId != null) 'sale_id': saleId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SaleItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? namaItem,
    Value<int>? jumlah,
    Value<int>? harga,
    Value<String>? unitTerkecil,
    Value<String>? unit,
    Value<int>? multiplier,
    Value<int>? saleId,
    Value<DateTime>? createdAt,
  }) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      namaItem: namaItem ?? this.namaItem,
      jumlah: jumlah ?? this.jumlah,
      harga: harga ?? this.harga,
      unitTerkecil: unitTerkecil ?? this.unitTerkecil,
      unit: unit ?? this.unit,
      multiplier: multiplier ?? this.multiplier,
      saleId: saleId ?? this.saleId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaItem.present) {
      map['nama_item'] = Variable<String>(namaItem.value);
    }
    if (jumlah.present) {
      map['jumlah'] = Variable<int>(jumlah.value);
    }
    if (harga.present) {
      map['harga'] = Variable<int>(harga.value);
    }
    if (unitTerkecil.present) {
      map['unit_terkecil'] = Variable<String>(unitTerkecil.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (multiplier.present) {
      map['multiplier'] = Variable<int>(multiplier.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('namaItem: $namaItem, ')
          ..write('jumlah: $jumlah, ')
          ..write('harga: $harga, ')
          ..write('unitTerkecil: $unitTerkecil, ')
          ..write('unit: $unit, ')
          ..write('multiplier: $multiplier, ')
          ..write('saleId: $saleId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final ItemsDao itemsDao = ItemsDao(this as AppDatabase);
  late final SalesDao salesDao = SalesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [items, sales, saleItems];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sales',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sale_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sales',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sale_items', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      required String namaItem,
      required int stokUnitTerkecil,
      required String unitTerkecil,
      required int hargaItem,
      required String konversi,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      Value<String> namaItem,
      Value<int> stokUnitTerkecil,
      Value<String> unitTerkecil,
      Value<int> hargaItem,
      Value<String> konversi,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaItem => $composableBuilder(
    column: $table.namaItem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stokUnitTerkecil => $composableBuilder(
    column: $table.stokUnitTerkecil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitTerkecil => $composableBuilder(
    column: $table.unitTerkecil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hargaItem => $composableBuilder(
    column: $table.hargaItem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get konversi => $composableBuilder(
    column: $table.konversi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaItem => $composableBuilder(
    column: $table.namaItem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stokUnitTerkecil => $composableBuilder(
    column: $table.stokUnitTerkecil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitTerkecil => $composableBuilder(
    column: $table.unitTerkecil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hargaItem => $composableBuilder(
    column: $table.hargaItem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get konversi => $composableBuilder(
    column: $table.konversi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaItem =>
      $composableBuilder(column: $table.namaItem, builder: (column) => column);

  GeneratedColumn<int> get stokUnitTerkecil => $composableBuilder(
    column: $table.stokUnitTerkecil,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unitTerkecil => $composableBuilder(
    column: $table.unitTerkecil,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hargaItem =>
      $composableBuilder(column: $table.hargaItem, builder: (column) => column);

  GeneratedColumn<String> get konversi =>
      $composableBuilder(column: $table.konversi, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, BaseReferences<_$AppDatabase, $ItemsTable, Item>),
          Item,
          PrefetchHooks Function()
        > {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> namaItem = const Value.absent(),
                Value<int> stokUnitTerkecil = const Value.absent(),
                Value<String> unitTerkecil = const Value.absent(),
                Value<int> hargaItem = const Value.absent(),
                Value<String> konversi = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ItemsCompanion(
                id: id,
                namaItem: namaItem,
                stokUnitTerkecil: stokUnitTerkecil,
                unitTerkecil: unitTerkecil,
                hargaItem: hargaItem,
                konversi: konversi,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String namaItem,
                required int stokUnitTerkecil,
                required String unitTerkecil,
                required int hargaItem,
                required String konversi,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ItemsCompanion.insert(
                id: id,
                namaItem: namaItem,
                stokUnitTerkecil: stokUnitTerkecil,
                unitTerkecil: unitTerkecil,
                hargaItem: hargaItem,
                konversi: konversi,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, BaseReferences<_$AppDatabase, $ItemsTable, Item>),
      Item,
      PrefetchHooks Function()
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      required String namaPenjualan,
      required String namaInstansi,
      Value<String> tipePenjualan,
      Value<String?> identifiers,
      Value<bool> sudahDibayar,
      Value<DateTime?> tanggalPenjualan,
      Value<DateTime?> tenggatWaktu,
      Value<DateTime> createdAt,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      Value<String> namaPenjualan,
      Value<String> namaInstansi,
      Value<String> tipePenjualan,
      Value<String?> identifiers,
      Value<bool> sudahDibayar,
      Value<DateTime?> tanggalPenjualan,
      Value<DateTime?> tenggatWaktu,
      Value<DateTime> createdAt,
    });

final class $$SalesTableReferences
    extends BaseReferences<_$AppDatabase, $SalesTable, Sale> {
  $$SalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: $_aliasNameGenerator(db.sales.id, db.saleItems.saleId),
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaPenjualan => $composableBuilder(
    column: $table.namaPenjualan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaInstansi => $composableBuilder(
    column: $table.namaInstansi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipePenjualan => $composableBuilder(
    column: $table.tipePenjualan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identifiers => $composableBuilder(
    column: $table.identifiers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sudahDibayar => $composableBuilder(
    column: $table.sudahDibayar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggalPenjualan => $composableBuilder(
    column: $table.tanggalPenjualan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tenggatWaktu => $composableBuilder(
    column: $table.tenggatWaktu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaPenjualan => $composableBuilder(
    column: $table.namaPenjualan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaInstansi => $composableBuilder(
    column: $table.namaInstansi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipePenjualan => $composableBuilder(
    column: $table.tipePenjualan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identifiers => $composableBuilder(
    column: $table.identifiers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sudahDibayar => $composableBuilder(
    column: $table.sudahDibayar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggalPenjualan => $composableBuilder(
    column: $table.tanggalPenjualan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tenggatWaktu => $composableBuilder(
    column: $table.tenggatWaktu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaPenjualan => $composableBuilder(
    column: $table.namaPenjualan,
    builder: (column) => column,
  );

  GeneratedColumn<String> get namaInstansi => $composableBuilder(
    column: $table.namaInstansi,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipePenjualan => $composableBuilder(
    column: $table.tipePenjualan,
    builder: (column) => column,
  );

  GeneratedColumn<String> get identifiers => $composableBuilder(
    column: $table.identifiers,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get sudahDibayar => $composableBuilder(
    column: $table.sudahDibayar,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggalPenjualan => $composableBuilder(
    column: $table.tanggalPenjualan,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tenggatWaktu => $composableBuilder(
    column: $table.tenggatWaktu,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, $$SalesTableReferences),
          Sale,
          PrefetchHooks Function({bool saleItemsRefs})
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> namaPenjualan = const Value.absent(),
                Value<String> namaInstansi = const Value.absent(),
                Value<String> tipePenjualan = const Value.absent(),
                Value<String?> identifiers = const Value.absent(),
                Value<bool> sudahDibayar = const Value.absent(),
                Value<DateTime?> tanggalPenjualan = const Value.absent(),
                Value<DateTime?> tenggatWaktu = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                namaPenjualan: namaPenjualan,
                namaInstansi: namaInstansi,
                tipePenjualan: tipePenjualan,
                identifiers: identifiers,
                sudahDibayar: sudahDibayar,
                tanggalPenjualan: tanggalPenjualan,
                tenggatWaktu: tenggatWaktu,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String namaPenjualan,
                required String namaInstansi,
                Value<String> tipePenjualan = const Value.absent(),
                Value<String?> identifiers = const Value.absent(),
                Value<bool> sudahDibayar = const Value.absent(),
                Value<DateTime?> tanggalPenjualan = const Value.absent(),
                Value<DateTime?> tenggatWaktu = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                namaPenjualan: namaPenjualan,
                namaInstansi: namaInstansi,
                tipePenjualan: tipePenjualan,
                identifiers: identifiers,
                sudahDibayar: sudahDibayar,
                tanggalPenjualan: tanggalPenjualan,
                tenggatWaktu: tenggatWaktu,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SalesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({saleItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (saleItemsRefs) db.saleItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (saleItemsRefs)
                    await $_getPrefetchedData<Sale, $SalesTable, SaleItem>(
                      currentTable: table,
                      referencedTable: $$SalesTableReferences
                          ._saleItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SalesTableReferences(db, table, p0).saleItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.saleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, $$SalesTableReferences),
      Sale,
      PrefetchHooks Function({bool saleItemsRefs})
    >;
typedef $$SaleItemsTableCreateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      required String namaItem,
      required int jumlah,
      required int harga,
      required String unitTerkecil,
      required String unit,
      required int multiplier,
      required int saleId,
      Value<DateTime> createdAt,
    });
typedef $$SaleItemsTableUpdateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      Value<String> namaItem,
      Value<int> jumlah,
      Value<int> harga,
      Value<String> unitTerkecil,
      Value<String> unit,
      Value<int> multiplier,
      Value<int> saleId,
      Value<DateTime> createdAt,
    });

final class $$SaleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem> {
  $$SaleItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SalesTable _saleIdTable(_$AppDatabase db) => db.sales.createAlias(
    $_aliasNameGenerator(db.saleItems.saleId, db.sales.id),
  );

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<int>('sale_id')!;

    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaItem => $composableBuilder(
    column: $table.namaItem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jumlah => $composableBuilder(
    column: $table.jumlah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitTerkecil => $composableBuilder(
    column: $table.unitTerkecil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get multiplier => $composableBuilder(
    column: $table.multiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaItem => $composableBuilder(
    column: $table.namaItem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jumlah => $composableBuilder(
    column: $table.jumlah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitTerkecil => $composableBuilder(
    column: $table.unitTerkecil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get multiplier => $composableBuilder(
    column: $table.multiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaItem =>
      $composableBuilder(column: $table.namaItem, builder: (column) => column);

  GeneratedColumn<int> get jumlah =>
      $composableBuilder(column: $table.jumlah, builder: (column) => column);

  GeneratedColumn<int> get harga =>
      $composableBuilder(column: $table.harga, builder: (column) => column);

  GeneratedColumn<String> get unitTerkecil => $composableBuilder(
    column: $table.unitTerkecil,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get multiplier => $composableBuilder(
    column: $table.multiplier,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleItemsTable,
          SaleItem,
          $$SaleItemsTableFilterComposer,
          $$SaleItemsTableOrderingComposer,
          $$SaleItemsTableAnnotationComposer,
          $$SaleItemsTableCreateCompanionBuilder,
          $$SaleItemsTableUpdateCompanionBuilder,
          (SaleItem, $$SaleItemsTableReferences),
          SaleItem,
          PrefetchHooks Function({bool saleId})
        > {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> namaItem = const Value.absent(),
                Value<int> jumlah = const Value.absent(),
                Value<int> harga = const Value.absent(),
                Value<String> unitTerkecil = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> multiplier = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SaleItemsCompanion(
                id: id,
                namaItem: namaItem,
                jumlah: jumlah,
                harga: harga,
                unitTerkecil: unitTerkecil,
                unit: unit,
                multiplier: multiplier,
                saleId: saleId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String namaItem,
                required int jumlah,
                required int harga,
                required String unitTerkecil,
                required String unit,
                required int multiplier,
                required int saleId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => SaleItemsCompanion.insert(
                id: id,
                namaItem: namaItem,
                jumlah: jumlah,
                harga: harga,
                unitTerkecil: unitTerkecil,
                unit: unit,
                multiplier: multiplier,
                saleId: saleId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SaleItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (saleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.saleId,
                                referencedTable: $$SaleItemsTableReferences
                                    ._saleIdTable(db),
                                referencedColumn: $$SaleItemsTableReferences
                                    ._saleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleItemsTable,
      SaleItem,
      $$SaleItemsTableFilterComposer,
      $$SaleItemsTableOrderingComposer,
      $$SaleItemsTableAnnotationComposer,
      $$SaleItemsTableCreateCompanionBuilder,
      $$SaleItemsTableUpdateCompanionBuilder,
      (SaleItem, $$SaleItemsTableReferences),
      SaleItem,
      PrefetchHooks Function({bool saleId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
}
