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
    stokUnitTerkecil,
    unitTerkecil,
    hargaItem,
    createdAt,
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
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
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
  final DateTime createdAt;
  const Item({
    required this.id,
    required this.namaItem,
    required this.stokUnitTerkecil,
    required this.unitTerkecil,
    required this.hargaItem,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_item'] = Variable<String>(namaItem);
    map['stok_unit_terkecil'] = Variable<int>(stokUnitTerkecil);
    map['unit_terkecil'] = Variable<String>(unitTerkecil);
    map['harga_item'] = Variable<int>(hargaItem);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      namaItem: Value(namaItem),
      stokUnitTerkecil: Value(stokUnitTerkecil),
      unitTerkecil: Value(unitTerkecil),
      hargaItem: Value(hargaItem),
      createdAt: Value(createdAt),
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
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
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
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Item copyWith({
    int? id,
    String? namaItem,
    int? stokUnitTerkecil,
    String? unitTerkecil,
    int? hargaItem,
    DateTime? createdAt,
  }) => Item(
    id: id ?? this.id,
    namaItem: namaItem ?? this.namaItem,
    stokUnitTerkecil: stokUnitTerkecil ?? this.stokUnitTerkecil,
    unitTerkecil: unitTerkecil ?? this.unitTerkecil,
    hargaItem: hargaItem ?? this.hargaItem,
    createdAt: createdAt ?? this.createdAt,
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
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
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
          ..write('createdAt: $createdAt')
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
    createdAt,
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
          other.createdAt == this.createdAt);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> namaItem;
  final Value<int> stokUnitTerkecil;
  final Value<String> unitTerkecil;
  final Value<int> hargaItem;
  final Value<DateTime> createdAt;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.namaItem = const Value.absent(),
    this.stokUnitTerkecil = const Value.absent(),
    this.unitTerkecil = const Value.absent(),
    this.hargaItem = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String namaItem,
    required int stokUnitTerkecil,
    required String unitTerkecil,
    required int hargaItem,
    this.createdAt = const Value.absent(),
  }) : namaItem = Value(namaItem),
       stokUnitTerkecil = Value(stokUnitTerkecil),
       unitTerkecil = Value(unitTerkecil),
       hargaItem = Value(hargaItem);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? namaItem,
    Expression<int>? stokUnitTerkecil,
    Expression<String>? unitTerkecil,
    Expression<int>? hargaItem,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaItem != null) 'nama_item': namaItem,
      if (stokUnitTerkecil != null) 'stok_unit_terkecil': stokUnitTerkecil,
      if (unitTerkecil != null) 'unit_terkecil': unitTerkecil,
      if (hargaItem != null) 'harga_item': hargaItem,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? namaItem,
    Value<int>? stokUnitTerkecil,
    Value<String>? unitTerkecil,
    Value<int>? hargaItem,
    Value<DateTime>? createdAt,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      namaItem: namaItem ?? this.namaItem,
      stokUnitTerkecil: stokUnitTerkecil ?? this.stokUnitTerkecil,
      unitTerkecil: unitTerkecil ?? this.unitTerkecil,
      hargaItem: hargaItem ?? this.hargaItem,
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
    if (stokUnitTerkecil.present) {
      map['stok_unit_terkecil'] = Variable<int>(stokUnitTerkecil.value);
    }
    if (unitTerkecil.present) {
      map['unit_terkecil'] = Variable<String>(unitTerkecil.value);
    }
    if (hargaItem.present) {
      map['harga_item'] = Variable<int>(hargaItem.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UnitConversionsTable extends UnitConversions
    with TableInfo<$UnitConversionsTable, UnitConversion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitConversionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _namaUnitMeta = const VerificationMeta(
    'namaUnit',
  );
  @override
  late final GeneratedColumn<String> namaUnit = GeneratedColumn<String>(
    'nama_unit',
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
    itemId,
    namaUnit,
    multiplier,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unit_conversions';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnitConversion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('nama_unit')) {
      context.handle(
        _namaUnitMeta,
        namaUnit.isAcceptableOrUnknown(data['nama_unit']!, _namaUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_namaUnitMeta);
    }
    if (data.containsKey('multiplier')) {
      context.handle(
        _multiplierMeta,
        multiplier.isAcceptableOrUnknown(data['multiplier']!, _multiplierMeta),
      );
    } else if (isInserting) {
      context.missing(_multiplierMeta);
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
  UnitConversion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitConversion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      namaUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_unit'],
      )!,
      multiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}multiplier'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UnitConversionsTable createAlias(String alias) {
    return $UnitConversionsTable(attachedDatabase, alias);
  }
}

class UnitConversion extends DataClass implements Insertable<UnitConversion> {
  final int id;
  final int itemId;
  final String namaUnit;
  final int multiplier;
  final DateTime createdAt;
  const UnitConversion({
    required this.id,
    required this.itemId,
    required this.namaUnit,
    required this.multiplier,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['nama_unit'] = Variable<String>(namaUnit);
    map['multiplier'] = Variable<int>(multiplier);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UnitConversionsCompanion toCompanion(bool nullToAbsent) {
    return UnitConversionsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      namaUnit: Value(namaUnit),
      multiplier: Value(multiplier),
      createdAt: Value(createdAt),
    );
  }

  factory UnitConversion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitConversion(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      namaUnit: serializer.fromJson<String>(json['namaUnit']),
      multiplier: serializer.fromJson<int>(json['multiplier']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'namaUnit': serializer.toJson<String>(namaUnit),
      'multiplier': serializer.toJson<int>(multiplier),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UnitConversion copyWith({
    int? id,
    int? itemId,
    String? namaUnit,
    int? multiplier,
    DateTime? createdAt,
  }) => UnitConversion(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    namaUnit: namaUnit ?? this.namaUnit,
    multiplier: multiplier ?? this.multiplier,
    createdAt: createdAt ?? this.createdAt,
  );
  UnitConversion copyWithCompanion(UnitConversionsCompanion data) {
    return UnitConversion(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      namaUnit: data.namaUnit.present ? data.namaUnit.value : this.namaUnit,
      multiplier: data.multiplier.present
          ? data.multiplier.value
          : this.multiplier,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitConversion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('namaUnit: $namaUnit, ')
          ..write('multiplier: $multiplier, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemId, namaUnit, multiplier, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitConversion &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.namaUnit == this.namaUnit &&
          other.multiplier == this.multiplier &&
          other.createdAt == this.createdAt);
}

class UnitConversionsCompanion extends UpdateCompanion<UnitConversion> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<String> namaUnit;
  final Value<int> multiplier;
  final Value<DateTime> createdAt;
  const UnitConversionsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.namaUnit = const Value.absent(),
    this.multiplier = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UnitConversionsCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    required String namaUnit,
    required int multiplier,
    this.createdAt = const Value.absent(),
  }) : itemId = Value(itemId),
       namaUnit = Value(namaUnit),
       multiplier = Value(multiplier);
  static Insertable<UnitConversion> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<String>? namaUnit,
    Expression<int>? multiplier,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (namaUnit != null) 'nama_unit': namaUnit,
      if (multiplier != null) 'multiplier': multiplier,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UnitConversionsCompanion copyWith({
    Value<int>? id,
    Value<int>? itemId,
    Value<String>? namaUnit,
    Value<int>? multiplier,
    Value<DateTime>? createdAt,
  }) {
    return UnitConversionsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      namaUnit: namaUnit ?? this.namaUnit,
      multiplier: multiplier ?? this.multiplier,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (namaUnit.present) {
      map['nama_unit'] = Variable<String>(namaUnit.value);
    }
    if (multiplier.present) {
      map['multiplier'] = Variable<int>(multiplier.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitConversionsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('namaUnit: $namaUnit, ')
          ..write('multiplier: $multiplier, ')
          ..write('createdAt: $createdAt')
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
  final String? identifiers;
  final bool sudahDibayar;
  final DateTime? tanggalPenjualan;
  final DateTime? tenggatWaktu;
  final DateTime createdAt;
  const Sale({
    required this.id,
    required this.namaPenjualan,
    required this.namaInstansi,
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
    Value<String?> identifiers = const Value.absent(),
    bool? sudahDibayar,
    Value<DateTime?> tanggalPenjualan = const Value.absent(),
    Value<DateTime?> tenggatWaktu = const Value.absent(),
    DateTime? createdAt,
  }) => Sale(
    id: id ?? this.id,
    namaPenjualan: namaPenjualan ?? this.namaPenjualan,
    namaInstansi: namaInstansi ?? this.namaInstansi,
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
  final Value<String?> identifiers;
  final Value<bool> sudahDibayar;
  final Value<DateTime?> tanggalPenjualan;
  final Value<DateTime?> tenggatWaktu;
  final Value<DateTime> createdAt;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.namaPenjualan = const Value.absent(),
    this.namaInstansi = const Value.absent(),
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
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id) ON UPDATE CASCADE ON DELETE CASCADE',
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
    jumlah,
    harga,
    saleId,
    itemId,
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
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
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
      jumlah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jumlah'],
      )!,
      harga: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sale_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
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
  final int jumlah;
  final int harga;
  final int saleId;
  final int itemId;
  final DateTime createdAt;
  const SaleItem({
    required this.id,
    required this.jumlah,
    required this.harga,
    required this.saleId,
    required this.itemId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['jumlah'] = Variable<int>(jumlah);
    map['harga'] = Variable<int>(harga);
    map['sale_id'] = Variable<int>(saleId);
    map['item_id'] = Variable<int>(itemId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      jumlah: Value(jumlah),
      harga: Value(harga),
      saleId: Value(saleId),
      itemId: Value(itemId),
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
      jumlah: serializer.fromJson<int>(json['jumlah']),
      harga: serializer.fromJson<int>(json['harga']),
      saleId: serializer.fromJson<int>(json['saleId']),
      itemId: serializer.fromJson<int>(json['itemId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jumlah': serializer.toJson<int>(jumlah),
      'harga': serializer.toJson<int>(harga),
      'saleId': serializer.toJson<int>(saleId),
      'itemId': serializer.toJson<int>(itemId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SaleItem copyWith({
    int? id,
    int? jumlah,
    int? harga,
    int? saleId,
    int? itemId,
    DateTime? createdAt,
  }) => SaleItem(
    id: id ?? this.id,
    jumlah: jumlah ?? this.jumlah,
    harga: harga ?? this.harga,
    saleId: saleId ?? this.saleId,
    itemId: itemId ?? this.itemId,
    createdAt: createdAt ?? this.createdAt,
  );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      jumlah: data.jumlah.present ? data.jumlah.value : this.jumlah,
      harga: data.harga.present ? data.harga.value : this.harga,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('jumlah: $jumlah, ')
          ..write('harga: $harga, ')
          ..write('saleId: $saleId, ')
          ..write('itemId: $itemId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jumlah, harga, saleId, itemId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.jumlah == this.jumlah &&
          other.harga == this.harga &&
          other.saleId == this.saleId &&
          other.itemId == this.itemId &&
          other.createdAt == this.createdAt);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<int> id;
  final Value<int> jumlah;
  final Value<int> harga;
  final Value<int> saleId;
  final Value<int> itemId;
  final Value<DateTime> createdAt;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.jumlah = const Value.absent(),
    this.harga = const Value.absent(),
    this.saleId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    this.id = const Value.absent(),
    required int jumlah,
    required int harga,
    required int saleId,
    required int itemId,
    this.createdAt = const Value.absent(),
  }) : jumlah = Value(jumlah),
       harga = Value(harga),
       saleId = Value(saleId),
       itemId = Value(itemId);
  static Insertable<SaleItem> custom({
    Expression<int>? id,
    Expression<int>? jumlah,
    Expression<int>? harga,
    Expression<int>? saleId,
    Expression<int>? itemId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jumlah != null) 'jumlah': jumlah,
      if (harga != null) 'harga': harga,
      if (saleId != null) 'sale_id': saleId,
      if (itemId != null) 'item_id': itemId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SaleItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? jumlah,
    Value<int>? harga,
    Value<int>? saleId,
    Value<int>? itemId,
    Value<DateTime>? createdAt,
  }) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      jumlah: jumlah ?? this.jumlah,
      harga: harga ?? this.harga,
      saleId: saleId ?? this.saleId,
      itemId: itemId ?? this.itemId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jumlah.present) {
      map['jumlah'] = Variable<int>(jumlah.value);
    }
    if (harga.present) {
      map['harga'] = Variable<int>(harga.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
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
          ..write('jumlah: $jumlah, ')
          ..write('harga: $harga, ')
          ..write('saleId: $saleId, ')
          ..write('itemId: $itemId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $UnitConversionsTable unitConversions = $UnitConversionsTable(
    this,
  );
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final ItemsDao itemsDao = ItemsDao(this as AppDatabase);
  late final SalesDao salesDao = SalesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    items,
    unitConversions,
    sales,
    saleItems,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('unit_conversions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'items',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('unit_conversions', kind: UpdateKind.update)],
    ),
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sale_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'items',
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
      Value<DateTime> createdAt,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      Value<String> namaItem,
      Value<int> stokUnitTerkecil,
      Value<String> unitTerkecil,
      Value<int> hargaItem,
      Value<DateTime> createdAt,
    });

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UnitConversionsTable, List<UnitConversion>>
  _unitConversionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.unitConversions,
    aliasName: $_aliasNameGenerator(db.items.id, db.unitConversions.itemId),
  );

  $$UnitConversionsTableProcessedTableManager get unitConversionsRefs {
    final manager = $$UnitConversionsTableTableManager(
      $_db,
      $_db.unitConversions,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _unitConversionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: $_aliasNameGenerator(db.items.id, db.saleItems.itemId),
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> unitConversionsRefs(
    Expression<bool> Function($$UnitConversionsTableFilterComposer f) f,
  ) {
    final $$UnitConversionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.unitConversions,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitConversionsTableFilterComposer(
            $db: $db,
            $table: $db.unitConversions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.itemId,
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> unitConversionsRefs<T extends Object>(
    Expression<T> Function($$UnitConversionsTableAnnotationComposer a) f,
  ) {
    final $$UnitConversionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.unitConversions,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitConversionsTableAnnotationComposer(
            $db: $db,
            $table: $db.unitConversions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.itemId,
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
          (Item, $$ItemsTableReferences),
          Item,
          PrefetchHooks Function({bool unitConversionsRefs, bool saleItemsRefs})
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
                Value<DateTime> createdAt = const Value.absent(),
              }) => ItemsCompanion(
                id: id,
                namaItem: namaItem,
                stokUnitTerkecil: stokUnitTerkecil,
                unitTerkecil: unitTerkecil,
                hargaItem: hargaItem,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String namaItem,
                required int stokUnitTerkecil,
                required String unitTerkecil,
                required int hargaItem,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ItemsCompanion.insert(
                id: id,
                namaItem: namaItem,
                stokUnitTerkecil: stokUnitTerkecil,
                unitTerkecil: unitTerkecil,
                hargaItem: hargaItem,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ItemsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({unitConversionsRefs = false, saleItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (unitConversionsRefs) db.unitConversions,
                    if (saleItemsRefs) db.saleItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (unitConversionsRefs)
                        await $_getPrefetchedData<
                          Item,
                          $ItemsTable,
                          UnitConversion
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._unitConversionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).unitConversionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (saleItemsRefs)
                        await $_getPrefetchedData<Item, $ItemsTable, SaleItem>(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._saleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).saleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
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
      (Item, $$ItemsTableReferences),
      Item,
      PrefetchHooks Function({bool unitConversionsRefs, bool saleItemsRefs})
    >;
typedef $$UnitConversionsTableCreateCompanionBuilder =
    UnitConversionsCompanion Function({
      Value<int> id,
      required int itemId,
      required String namaUnit,
      required int multiplier,
      Value<DateTime> createdAt,
    });
typedef $$UnitConversionsTableUpdateCompanionBuilder =
    UnitConversionsCompanion Function({
      Value<int> id,
      Value<int> itemId,
      Value<String> namaUnit,
      Value<int> multiplier,
      Value<DateTime> createdAt,
    });

final class $$UnitConversionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $UnitConversionsTable, UnitConversion> {
  $$UnitConversionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ItemsTable _itemIdTable(_$AppDatabase db) => db.items.createAlias(
    $_aliasNameGenerator(db.unitConversions.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UnitConversionsTableFilterComposer
    extends Composer<_$AppDatabase, $UnitConversionsTable> {
  $$UnitConversionsTableFilterComposer({
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

  ColumnFilters<String> get namaUnit => $composableBuilder(
    column: $table.namaUnit,
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

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UnitConversionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitConversionsTable> {
  $$UnitConversionsTableOrderingComposer({
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

  ColumnOrderings<String> get namaUnit => $composableBuilder(
    column: $table.namaUnit,
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

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UnitConversionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitConversionsTable> {
  $$UnitConversionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaUnit =>
      $composableBuilder(column: $table.namaUnit, builder: (column) => column);

  GeneratedColumn<int> get multiplier => $composableBuilder(
    column: $table.multiplier,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UnitConversionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnitConversionsTable,
          UnitConversion,
          $$UnitConversionsTableFilterComposer,
          $$UnitConversionsTableOrderingComposer,
          $$UnitConversionsTableAnnotationComposer,
          $$UnitConversionsTableCreateCompanionBuilder,
          $$UnitConversionsTableUpdateCompanionBuilder,
          (UnitConversion, $$UnitConversionsTableReferences),
          UnitConversion,
          PrefetchHooks Function({bool itemId})
        > {
  $$UnitConversionsTableTableManager(
    _$AppDatabase db,
    $UnitConversionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitConversionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitConversionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitConversionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<String> namaUnit = const Value.absent(),
                Value<int> multiplier = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UnitConversionsCompanion(
                id: id,
                itemId: itemId,
                namaUnit: namaUnit,
                multiplier: multiplier,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itemId,
                required String namaUnit,
                required int multiplier,
                Value<DateTime> createdAt = const Value.absent(),
              }) => UnitConversionsCompanion.insert(
                id: id,
                itemId: itemId,
                namaUnit: namaUnit,
                multiplier: multiplier,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UnitConversionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemId = false}) {
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
                    if (itemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.itemId,
                                referencedTable:
                                    $$UnitConversionsTableReferences
                                        ._itemIdTable(db),
                                referencedColumn:
                                    $$UnitConversionsTableReferences
                                        ._itemIdTable(db)
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

typedef $$UnitConversionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnitConversionsTable,
      UnitConversion,
      $$UnitConversionsTableFilterComposer,
      $$UnitConversionsTableOrderingComposer,
      $$UnitConversionsTableAnnotationComposer,
      $$UnitConversionsTableCreateCompanionBuilder,
      $$UnitConversionsTableUpdateCompanionBuilder,
      (UnitConversion, $$UnitConversionsTableReferences),
      UnitConversion,
      PrefetchHooks Function({bool itemId})
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      required String namaPenjualan,
      required String namaInstansi,
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
                Value<String?> identifiers = const Value.absent(),
                Value<bool> sudahDibayar = const Value.absent(),
                Value<DateTime?> tanggalPenjualan = const Value.absent(),
                Value<DateTime?> tenggatWaktu = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                namaPenjualan: namaPenjualan,
                namaInstansi: namaInstansi,
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
                Value<String?> identifiers = const Value.absent(),
                Value<bool> sudahDibayar = const Value.absent(),
                Value<DateTime?> tanggalPenjualan = const Value.absent(),
                Value<DateTime?> tenggatWaktu = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                namaPenjualan: namaPenjualan,
                namaInstansi: namaInstansi,
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
      required int jumlah,
      required int harga,
      required int saleId,
      required int itemId,
      Value<DateTime> createdAt,
    });
typedef $$SaleItemsTableUpdateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      Value<int> jumlah,
      Value<int> harga,
      Value<int> saleId,
      Value<int> itemId,
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

  static $ItemsTable _itemIdTable(_$AppDatabase db) => db.items.createAlias(
    $_aliasNameGenerator(db.saleItems.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
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

  ColumnFilters<int> get jumlah => $composableBuilder(
    column: $table.jumlah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get harga => $composableBuilder(
    column: $table.harga,
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

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
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

  ColumnOrderings<int> get jumlah => $composableBuilder(
    column: $table.jumlah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get harga => $composableBuilder(
    column: $table.harga,
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

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
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

  GeneratedColumn<int> get jumlah =>
      $composableBuilder(column: $table.jumlah, builder: (column) => column);

  GeneratedColumn<int> get harga =>
      $composableBuilder(column: $table.harga, builder: (column) => column);

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

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
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
          PrefetchHooks Function({bool saleId, bool itemId})
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
                Value<int> jumlah = const Value.absent(),
                Value<int> harga = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SaleItemsCompanion(
                id: id,
                jumlah: jumlah,
                harga: harga,
                saleId: saleId,
                itemId: itemId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int jumlah,
                required int harga,
                required int saleId,
                required int itemId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => SaleItemsCompanion.insert(
                id: id,
                jumlah: jumlah,
                harga: harga,
                saleId: saleId,
                itemId: itemId,
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
          prefetchHooksCallback: ({saleId = false, itemId = false}) {
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
                    if (itemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.itemId,
                                referencedTable: $$SaleItemsTableReferences
                                    ._itemIdTable(db),
                                referencedColumn: $$SaleItemsTableReferences
                                    ._itemIdTable(db)
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
      PrefetchHooks Function({bool saleId, bool itemId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$UnitConversionsTableTableManager get unitConversions =>
      $$UnitConversionsTableTableManager(_db, _db.unitConversions);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
}
