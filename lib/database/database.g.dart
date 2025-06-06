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
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 99),
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
  final DateTime? createdAt;
  const Item({
    required this.id,
    required this.namaItem,
    required this.stokUnitTerkecil,
    required this.unitTerkecil,
    required this.hargaItem,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_item'] = Variable<String>(namaItem);
    map['stok_unit_terkecil'] = Variable<int>(stokUnitTerkecil);
    map['unit_terkecil'] = Variable<String>(unitTerkecil);
    map['harga_item'] = Variable<int>(hargaItem);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
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
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
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
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
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
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  Item copyWith({
    int? id,
    String? namaItem,
    int? stokUnitTerkecil,
    String? unitTerkecil,
    int? hargaItem,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => Item(
    id: id ?? this.id,
    namaItem: namaItem ?? this.namaItem,
    stokUnitTerkecil: stokUnitTerkecil ?? this.stokUnitTerkecil,
    unitTerkecil: unitTerkecil ?? this.unitTerkecil,
    hargaItem: hargaItem ?? this.hargaItem,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
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
  final Value<DateTime?> createdAt;
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
    Value<DateTime?>? createdAt,
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
  @override
  List<GeneratedColumn> get $columns => [id, itemId, namaUnit, multiplier];
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
  const UnitConversion({
    required this.id,
    required this.itemId,
    required this.namaUnit,
    required this.multiplier,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['nama_unit'] = Variable<String>(namaUnit);
    map['multiplier'] = Variable<int>(multiplier);
    return map;
  }

  UnitConversionsCompanion toCompanion(bool nullToAbsent) {
    return UnitConversionsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      namaUnit: Value(namaUnit),
      multiplier: Value(multiplier),
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
    };
  }

  UnitConversion copyWith({
    int? id,
    int? itemId,
    String? namaUnit,
    int? multiplier,
  }) => UnitConversion(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    namaUnit: namaUnit ?? this.namaUnit,
    multiplier: multiplier ?? this.multiplier,
  );
  UnitConversion copyWithCompanion(UnitConversionsCompanion data) {
    return UnitConversion(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      namaUnit: data.namaUnit.present ? data.namaUnit.value : this.namaUnit,
      multiplier: data.multiplier.present
          ? data.multiplier.value
          : this.multiplier,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitConversion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('namaUnit: $namaUnit, ')
          ..write('multiplier: $multiplier')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemId, namaUnit, multiplier);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitConversion &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.namaUnit == this.namaUnit &&
          other.multiplier == this.multiplier);
}

class UnitConversionsCompanion extends UpdateCompanion<UnitConversion> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<String> namaUnit;
  final Value<int> multiplier;
  const UnitConversionsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.namaUnit = const Value.absent(),
    this.multiplier = const Value.absent(),
  });
  UnitConversionsCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    required String namaUnit,
    required int multiplier,
  }) : itemId = Value(itemId),
       namaUnit = Value(namaUnit),
       multiplier = Value(multiplier);
  static Insertable<UnitConversion> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<String>? namaUnit,
    Expression<int>? multiplier,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (namaUnit != null) 'nama_unit': namaUnit,
      if (multiplier != null) 'multiplier': multiplier,
    });
  }

  UnitConversionsCompanion copyWith({
    Value<int>? id,
    Value<int>? itemId,
    Value<String>? namaUnit,
    Value<int>? multiplier,
  }) {
    return UnitConversionsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      namaUnit: namaUnit ?? this.namaUnit,
      multiplier: multiplier ?? this.multiplier,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitConversionsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('namaUnit: $namaUnit, ')
          ..write('multiplier: $multiplier')
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
  late final ItemsDao itemsDao = ItemsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [items, unitConversions];
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
  ]);
}

typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      required String namaItem,
      required int stokUnitTerkecil,
      required String unitTerkecil,
      required int hargaItem,
      Value<DateTime?> createdAt,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      Value<String> namaItem,
      Value<int> stokUnitTerkecil,
      Value<String> unitTerkecil,
      Value<int> hargaItem,
      Value<DateTime?> createdAt,
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
          PrefetchHooks Function({bool unitConversionsRefs})
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
                Value<DateTime?> createdAt = const Value.absent(),
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
                Value<DateTime?> createdAt = const Value.absent(),
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
          prefetchHooksCallback: ({unitConversionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (unitConversionsRefs) db.unitConversions,
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
                      managerFromTypedResult: (p0) => $$ItemsTableReferences(
                        db,
                        table,
                        p0,
                      ).unitConversionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.itemId == item.id),
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
      PrefetchHooks Function({bool unitConversionsRefs})
    >;
typedef $$UnitConversionsTableCreateCompanionBuilder =
    UnitConversionsCompanion Function({
      Value<int> id,
      required int itemId,
      required String namaUnit,
      required int multiplier,
    });
typedef $$UnitConversionsTableUpdateCompanionBuilder =
    UnitConversionsCompanion Function({
      Value<int> id,
      Value<int> itemId,
      Value<String> namaUnit,
      Value<int> multiplier,
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
              }) => UnitConversionsCompanion(
                id: id,
                itemId: itemId,
                namaUnit: namaUnit,
                multiplier: multiplier,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itemId,
                required String namaUnit,
                required int multiplier,
              }) => UnitConversionsCompanion.insert(
                id: id,
                itemId: itemId,
                namaUnit: namaUnit,
                multiplier: multiplier,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$UnitConversionsTableTableManager get unitConversions =>
      $$UnitConversionsTableTableManager(_db, _db.unitConversions);
}
