// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Inbox extends _Inbox with RealmEntity, RealmObjectBase, RealmObject {
  Inbox(
      String id,
      String title,
      String body,
      DateTime date,
      bool read,
      bool sent,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'body', body);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'read', read);
    RealmObjectBase.set(this, 'sent', sent);
    RealmObjectBase.set(this, 'version', version);
  }

  Inbox._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get body => RealmObjectBase.get<String>(this, 'body') as String;
  @override
  set body(String value) => RealmObjectBase.set(this, 'body', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  bool get read => RealmObjectBase.get<bool>(this, 'read') as bool;
  @override
  set read(bool value) => RealmObjectBase.set(this, 'read', value);

  @override
  bool get sent => RealmObjectBase.get<bool>(this, 'sent') as bool;
  @override
  set sent(bool value) => RealmObjectBase.set(this, 'sent', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<Inbox>> get changes =>
      RealmObjectBase.getChanges<Inbox>(this);

  @override
  Inbox freeze() => RealmObjectBase.freezeObject<Inbox>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Inbox._);
    return const SchemaObject(ObjectType.realmObject, Inbox, 'Inbox', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('body', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('read', RealmPropertyType.bool),
      SchemaProperty('sent', RealmPropertyType.bool),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class ImageFile extends _ImageFile
    with RealmEntity, RealmObjectBase, RealmObject {
  ImageFile({
    Iterable<int> file = const [],
  }) {
    RealmObjectBase.set<RealmList<int>>(this, 'file', RealmList<int>(file));
  }

  ImageFile._();

  @override
  RealmList<int> get file =>
      RealmObjectBase.get<int>(this, 'file') as RealmList<int>;
  @override
  set file(covariant RealmList<int> value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<ImageFile>> get changes =>
      RealmObjectBase.getChanges<ImageFile>(this);

  @override
  ImageFile freeze() => RealmObjectBase.freezeObject<ImageFile>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ImageFile._);
    return const SchemaObject(ObjectType.realmObject, ImageFile, 'ImageFile', [
      SchemaProperty('file', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class Version extends _Version with RealmEntity, RealmObjectBase, RealmObject {
  Version(
      String key,
      int value,
      ) {
    RealmObjectBase.set(this, 'key', key);
    RealmObjectBase.set(this, 'value', value);
  }

  Version._();

  @override
  String get key => RealmObjectBase.get<String>(this, 'key') as String;
  @override
  set key(String value) => RealmObjectBase.set(this, 'key', value);

  @override
  int get value => RealmObjectBase.get<int>(this, 'value') as int;
  @override
  set value(int value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<Version>> get changes =>
      RealmObjectBase.getChanges<Version>(this);

  @override
  Version freeze() => RealmObjectBase.freezeObject<Version>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Version._);
    return const SchemaObject(ObjectType.realmObject, Version, 'Version', [
      SchemaProperty('key', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('value', RealmPropertyType.int),
    ]);
  }
}

class Vendor extends _Vendor with RealmEntity, RealmObjectBase, RealmObject {
  Vendor(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  Vendor._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<Vendor>> get changes =>
      RealmObjectBase.getChanges<Vendor>(this);

  @override
  Vendor freeze() => RealmObjectBase.freezeObject<Vendor>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Vendor._);
    return const SchemaObject(ObjectType.realmObject, Vendor, 'Vendor', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class BaseOffice extends _BaseOffice
    with RealmEntity, RealmObjectBase, RealmObject {
  BaseOffice(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  BaseOffice._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<BaseOffice>> get changes =>
      RealmObjectBase.getChanges<BaseOffice>(this);

  @override
  BaseOffice freeze() => RealmObjectBase.freezeObject<BaseOffice>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(BaseOffice._);
    return const SchemaObject(
        ObjectType.realmObject, BaseOffice, 'BaseOffice', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class ServicePoint extends _ServicePoint
    with RealmEntity, RealmObjectBase, RealmObject {
  ServicePoint(
      String id,
      String vendorId,
      String baseOfficeId,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'vendorId', vendorId);
    RealmObjectBase.set(this, 'baseOfficeId', baseOfficeId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  ServicePoint._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String;
  @override
  set vendorId(String value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  String get baseOfficeId =>
      RealmObjectBase.get<String>(this, 'baseOfficeId') as String;
  @override
  set baseOfficeId(String value) =>
      RealmObjectBase.set(this, 'baseOfficeId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<ServicePoint>> get changes =>
      RealmObjectBase.getChanges<ServicePoint>(this);

  @override
  ServicePoint freeze() => RealmObjectBase.freezeObject<ServicePoint>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ServicePoint._);
    return const SchemaObject(
        ObjectType.realmObject, ServicePoint, 'ServicePoint', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('vendorId', RealmPropertyType.string),
      SchemaProperty('baseOfficeId', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class JobType extends _JobType with RealmEntity, RealmObjectBase, RealmObject {
  JobType(
      String id,
      String vendorId,
      String name,
      String description,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'vendorId', vendorId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'version', version);
  }

  JobType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String;
  @override
  set vendorId(String value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<JobType>> get changes =>
      RealmObjectBase.getChanges<JobType>(this);

  @override
  JobType freeze() => RealmObjectBase.freezeObject<JobType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobType._);
    return const SchemaObject(ObjectType.realmObject, JobType, 'JobType', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('vendorId', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class DocumentStatus extends _DocumentStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  DocumentStatus(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  DocumentStatus._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<DocumentStatus>> get changes =>
      RealmObjectBase.getChanges<DocumentStatus>(this);

  @override
  DocumentStatus freeze() => RealmObjectBase.freezeObject<DocumentStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(DocumentStatus._);
    return const SchemaObject(
        ObjectType.realmObject, DocumentStatus, 'DocumentStatus', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class RequestType extends _RequestType
    with RealmEntity, RealmObjectBase, RealmObject {
  RequestType(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  RequestType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<RequestType>> get changes =>
      RealmObjectBase.getChanges<RequestType>(this);

  @override
  RequestType freeze() => RealmObjectBase.freezeObject<RequestType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RequestType._);
    return const SchemaObject(
        ObjectType.realmObject, RequestType, 'RequestType', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class MmsStatus extends _MmsStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  MmsStatus(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  MmsStatus._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<MmsStatus>> get changes =>
      RealmObjectBase.getChanges<MmsStatus>(this);

  @override
  MmsStatus freeze() => RealmObjectBase.freezeObject<MmsStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MmsStatus._);
    return const SchemaObject(ObjectType.realmObject, MmsStatus, 'MmsStatus', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class Provider extends _Provider
    with RealmEntity, RealmObjectBase, RealmObject {
  Provider(
      String id,
      String vendorId,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'vendorId', vendorId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  Provider._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String;
  @override
  set vendorId(String value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<Provider>> get changes =>
      RealmObjectBase.getChanges<Provider>(this);

  @override
  Provider freeze() => RealmObjectBase.freezeObject<Provider>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Provider._);
    return const SchemaObject(ObjectType.realmObject, Provider, 'Provider', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('vendorId', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class EdcType extends _EdcType with RealmEntity, RealmObjectBase, RealmObject {
  EdcType(
      String id,
      String vendorId,
      String name,
      int version,
      int flag_android,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'vendorId', vendorId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
    RealmObjectBase.set(this, 'flag_android', flag_android);
  }

  EdcType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String;
  @override
  set vendorId(String value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  int get flag_android => RealmObjectBase.get<int>(this, 'flag_android') as int;
  @override
  set flag_android(int value) =>
      RealmObjectBase.set(this, 'flag_android', value);

  @override
  Stream<RealmObjectChanges<EdcType>> get changes =>
      RealmObjectBase.getChanges<EdcType>(this);

  @override
  EdcType freeze() => RealmObjectBase.freezeObject<EdcType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(EdcType._);
    return const SchemaObject(ObjectType.realmObject, EdcType, 'EdcType', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('vendorId', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
      SchemaProperty('flag_android', RealmPropertyType.int),
    ]);
  }
}

class AppVersion extends _AppVersion
    with RealmEntity, RealmObjectBase, RealmObject {
  AppVersion(
      int id_primary,
      int id_versi_aplikasi,
      String versi_aplikasi,
      int id_tipe_dc,
      int android,
      int vendor_id,
      int version,
      ) {
    RealmObjectBase.set(this, 'id_primary', id_primary);
    RealmObjectBase.set(this, 'id_versi_aplikasi', id_versi_aplikasi);
    RealmObjectBase.set(this, 'versi_aplikasi', versi_aplikasi);
    RealmObjectBase.set(this, 'id_tipe_dc', id_tipe_dc);
    RealmObjectBase.set(this, 'android', android);
    RealmObjectBase.set(this, 'vendor_id', vendor_id);
    RealmObjectBase.set(this, 'version', version);
  }

  AppVersion._();
  @override
  int get id_primary => RealmObjectBase.get<int>(this, 'id_primary') as int;
  @override
  set id_primary(int value) => RealmObjectBase.set(this, 'id_primary', value);

  @override
  int get id_versi_aplikasi =>
      RealmObjectBase.get<int>(this, 'id_versi_aplikasi') as int;
  @override
  set id_versi_aplikasi(int value) =>
      RealmObjectBase.set(this, 'id_versi_aplikasi', value);

  @override
  String get versi_aplikasi =>
      RealmObjectBase.get<String>(this, 'versi_aplikasi') as String;
  @override
  set versi_aplikasi(String value) =>
      RealmObjectBase.set(this, 'versi_aplikasi', value);

  @override
  int get id_tipe_dc => RealmObjectBase.get<int>(this, 'id_tipe_dc') as int;
  @override
  set id_tipe_dc(int value) => RealmObjectBase.set(this, 'id_tipe_dc', value);

  @override
  int get android => RealmObjectBase.get<int>(this, 'android') as int;
  @override
  set android(int value) => RealmObjectBase.set(this, 'android', value);

  @override
  int get vendor_id => RealmObjectBase.get<int>(this, 'vendor_id') as int;
  @override
  set vendor_id(int value) => RealmObjectBase.set(this, 'vendor_id', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<AppVersion>> get changes =>
      RealmObjectBase.getChanges<AppVersion>(this);

  @override
  AppVersion freeze() => RealmObjectBase.freezeObject<AppVersion>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(AppVersion._);
    return const SchemaObject(
        ObjectType.realmObject, AppVersion, 'AppVersion', [
      SchemaProperty('id_primary', RealmPropertyType.int,
          primaryKey: true),
      SchemaProperty('id_versi_aplikasi', RealmPropertyType.int),
      SchemaProperty('versi_aplikasi', RealmPropertyType.string),
      SchemaProperty('id_tipe_dc', RealmPropertyType.int),
      SchemaProperty('android', RealmPropertyType.int),
      SchemaProperty('vendor_id', RealmPropertyType.int),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class OsPatch extends _OsPatch with RealmEntity, RealmObjectBase, RealmObject {
  OsPatch(
      int id_os_patch,
      String os_patch_name,
      int id_versi_aplikasi,
      int id_tipe_edc,
      int vendor_id,
      int version,
      ) {
    RealmObjectBase.set(this, 'id_os_patch', id_os_patch);
    RealmObjectBase.set(this, 'os_patch_name', os_patch_name);
    RealmObjectBase.set(this, 'id_versi_aplikasi', id_versi_aplikasi);
    RealmObjectBase.set(this, 'id_tipe_edc', id_tipe_edc);
    RealmObjectBase.set(this, 'vendor_id', vendor_id);
    RealmObjectBase.set(this, 'version', version);
  }

  OsPatch._();

  @override
  int get id_os_patch => RealmObjectBase.get<int>(this, 'id_os_patch') as int;
  @override
  set id_os_patch(int value) => RealmObjectBase.set(this, 'id_os_patch', value);

  @override
  String get os_patch_name =>
      RealmObjectBase.get<String>(this, 'os_patch_name') as String;
  @override
  set os_patch_name(String value) =>
      RealmObjectBase.set(this, 'os_patch_name', value);

  @override
  int get id_versi_aplikasi =>
      RealmObjectBase.get<int>(this, 'id_versi_aplikasi') as int;
  @override
  set id_versi_aplikasi(int value) =>
      RealmObjectBase.set(this, 'id_versi_aplikasi', value);

  @override
  int get id_tipe_edc => RealmObjectBase.get<int>(this, 'id_tipe_edc') as int;
  @override
  set id_tipe_edc(int value) => RealmObjectBase.set(this, 'id_tipe_edc', value);

  @override
  int get vendor_id => RealmObjectBase.get<int>(this, 'vendor_id') as int;
  @override
  set vendor_id(int value) => RealmObjectBase.set(this, 'vendor_id', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<OsPatch>> get changes =>
      RealmObjectBase.getChanges<OsPatch>(this);

  @override
  OsPatch freeze() => RealmObjectBase.freezeObject<OsPatch>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(OsPatch._);
    return const SchemaObject(ObjectType.realmObject, OsPatch, 'OsPatch', [
      SchemaProperty('id_os_patch', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('os_patch_name', RealmPropertyType.string),
      SchemaProperty('id_versi_aplikasi', RealmPropertyType.int),
      SchemaProperty('id_tipe_edc', RealmPropertyType.int),
      SchemaProperty('vendor_id', RealmPropertyType.int),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class StickerBank extends _StickerBank
    with RealmEntity, RealmObjectBase, RealmObject {
  StickerBank(
      int idx,
      String nama_sticker_bank,
      int vendor_id,
      int version,
      ) {
    RealmObjectBase.set(this, 'idx', idx);
    RealmObjectBase.set(this, 'nama_sticker_bank', nama_sticker_bank);
    RealmObjectBase.set(this, 'vendor_id', vendor_id);
    RealmObjectBase.set(this, 'version', version);
  }

  StickerBank._();

  @override
  int get idx => RealmObjectBase.get<int>(this, 'idx') as int;
  @override
  set idx(int value) => RealmObjectBase.set(this, 'idx', value);

  @override
  String get nama_sticker_bank =>
      RealmObjectBase.get<String>(this, 'nama_sticker_bank') as String;
  @override
  set nama_sticker_bank(String value) =>
      RealmObjectBase.set(this, 'nama_sticker_bank', value);

  @override
  int get vendor_id => RealmObjectBase.get<int>(this, 'vendor_id') as int;
  @override
  set vendor_id(int value) => RealmObjectBase.set(this, 'vendor_id', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<StickerBank>> get changes =>
      RealmObjectBase.getChanges<StickerBank>(this);

  @override
  StickerBank freeze() => RealmObjectBase.freezeObject<StickerBank>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(StickerBank._);
    return const SchemaObject(
        ObjectType.realmObject, StickerBank, 'StickerBank', [
      SchemaProperty('idx', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('nama_sticker_bank', RealmPropertyType.string),
      SchemaProperty('vendor_id', RealmPropertyType.int),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class EdcCommunicationType extends _EdcCommunicationType
    with RealmEntity, RealmObjectBase, RealmObject {
  EdcCommunicationType(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  EdcCommunicationType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<EdcCommunicationType>> get changes =>
      RealmObjectBase.getChanges<EdcCommunicationType>(this);

  @override
  EdcCommunicationType freeze() =>
      RealmObjectBase.freezeObject<EdcCommunicationType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(EdcCommunicationType._);
    return const SchemaObject(
        ObjectType.realmObject, EdcCommunicationType, 'EdcCommunicationType', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class ReplacementType extends _ReplacementType
    with RealmEntity, RealmObjectBase, RealmObject {
  ReplacementType(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  ReplacementType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<ReplacementType>> get changes =>
      RealmObjectBase.getChanges<ReplacementType>(this);

  @override
  ReplacementType freeze() =>
      RealmObjectBase.freezeObject<ReplacementType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ReplacementType._);
    return const SchemaObject(
        ObjectType.realmObject, ReplacementType, 'ReplacementType', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class JobStatus extends _JobStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  JobStatus(
      String id,
      String aliasId,
      String vendorId,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'aliasId', aliasId);
    RealmObjectBase.set(this, 'vendorId', vendorId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  JobStatus._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get aliasId => RealmObjectBase.get<String>(this, 'aliasId') as String;
  @override
  set aliasId(String value) => RealmObjectBase.set(this, 'aliasId', value);

  @override
  String get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String;
  @override
  set vendorId(String value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<JobStatus>> get changes =>
      RealmObjectBase.getChanges<JobStatus>(this);

  @override
  JobStatus freeze() => RealmObjectBase.freezeObject<JobStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobStatus._);
    return const SchemaObject(ObjectType.realmObject, JobStatus, 'JobStatus', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('aliasId', RealmPropertyType.string),
      SchemaProperty('vendorId', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class JobStatusCategory extends _JobStatusCategory
    with RealmEntity, RealmObjectBase, RealmObject {
  JobStatusCategory(
      String id,
      String jobStatusId,
      String jobStatusAliasId,
      String vendorId,
      String name,
      int version, {
        String? jobTypeId,
      }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'jobStatusId', jobStatusId);
    RealmObjectBase.set(this, 'jobStatusAliasId', jobStatusAliasId);
    RealmObjectBase.set(this, 'vendorId', vendorId);
    RealmObjectBase.set(this, 'jobTypeId', jobTypeId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  JobStatusCategory._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get jobStatusId =>
      RealmObjectBase.get<String>(this, 'jobStatusId') as String;
  @override
  set jobStatusId(String value) =>
      RealmObjectBase.set(this, 'jobStatusId', value);

  @override
  String get jobStatusAliasId =>
      RealmObjectBase.get<String>(this, 'jobStatusAliasId') as String;
  @override
  set jobStatusAliasId(String value) =>
      RealmObjectBase.set(this, 'jobStatusAliasId', value);

  @override
  String get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String;
  @override
  set vendorId(String value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  String? get jobTypeId =>
      RealmObjectBase.get<String>(this, 'jobTypeId') as String?;
  @override
  set jobTypeId(String? value) => RealmObjectBase.set(this, 'jobTypeId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<JobStatusCategory>> get changes =>
      RealmObjectBase.getChanges<JobStatusCategory>(this);

  @override
  JobStatusCategory freeze() =>
      RealmObjectBase.freezeObject<JobStatusCategory>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobStatusCategory._);
    return const SchemaObject(
        ObjectType.realmObject, JobStatusCategory, 'JobStatusCategory', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('jobStatusId', RealmPropertyType.string),
      SchemaProperty('jobStatusAliasId', RealmPropertyType.string),
      SchemaProperty('vendorId', RealmPropertyType.string),
      SchemaProperty('jobTypeId', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class Note extends _Note with RealmEntity, RealmObjectBase, RealmObject {
  Note(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  Note._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<Note>> get changes =>
      RealmObjectBase.getChanges<Note>(this);

  @override
  Note freeze() => RealmObjectBase.freezeObject<Note>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Note._);
    return const SchemaObject(ObjectType.realmObject, Note, 'Note', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class QrisMenu extends _QrisMenu
    with RealmEntity, RealmObjectBase, RealmObject {
  QrisMenu(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  QrisMenu._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<QrisMenu>> get changes =>
      RealmObjectBase.getChanges<QrisMenu>(this);

  @override
  QrisMenu freeze() => RealmObjectBase.freezeObject<QrisMenu>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(QrisMenu._);
    return const SchemaObject(ObjectType.realmObject, QrisMenu, 'QrisMenu', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class EdcEquipment extends _EdcEquipment
    with RealmEntity, RealmObjectBase, RealmObject {
  EdcEquipment(
      String name,
      String vendorId,
      ) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'vendorId', vendorId);
  }

  EdcEquipment._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String;
  @override
  set vendorId(String value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  Stream<RealmObjectChanges<EdcEquipment>> get changes =>
      RealmObjectBase.getChanges<EdcEquipment>(this);

  @override
  EdcEquipment freeze() => RealmObjectBase.freezeObject<EdcEquipment>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(EdcEquipment._);
    return const SchemaObject(
        ObjectType.realmObject, EdcEquipment, 'EdcEquipment', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('vendorId', RealmPropertyType.string),
    ]);
  }
}

class EdcFeatureTestCase extends _EdcFeatureTestCase
    with RealmEntity, RealmObjectBase, RealmObject {
  EdcFeatureTestCase(
      String id,
      String name,
      String type,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'version', version);
  }

  EdcFeatureTestCase._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<EdcFeatureTestCase>> get changes =>
      RealmObjectBase.getChanges<EdcFeatureTestCase>(this);

  @override
  EdcFeatureTestCase freeze() =>
      RealmObjectBase.freezeObject<EdcFeatureTestCase>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(EdcFeatureTestCase._);
    return const SchemaObject(
        ObjectType.realmObject, EdcFeatureTestCase, 'EdcFeatureTestCase', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('type', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class JobCategory extends _JobCategory
    with RealmEntity, RealmObjectBase, RealmObject {
  JobCategory(
      String id,
      String vendorId,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'vendorId', vendorId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  JobCategory._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String;
  @override
  set vendorId(String value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<JobCategory>> get changes =>
      RealmObjectBase.getChanges<JobCategory>(this);

  @override
  JobCategory freeze() => RealmObjectBase.freezeObject<JobCategory>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobCategory._);
    return const SchemaObject(
        ObjectType.realmObject, JobCategory, 'JobCategory', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('vendorId', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class TransactionTestCase extends _TransactionTestCase
    with RealmEntity, RealmObjectBase, RealmObject {
  TransactionTestCase(
      String id,
      String jobTypeId,
      String name,
      String amount,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'jobTypeId', jobTypeId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'version', version);
  }

  TransactionTestCase._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get jobTypeId =>
      RealmObjectBase.get<String>(this, 'jobTypeId') as String;
  @override
  set jobTypeId(String value) => RealmObjectBase.set(this, 'jobTypeId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get amount => RealmObjectBase.get<String>(this, 'amount') as String;
  @override
  set amount(String value) => RealmObjectBase.set(this, 'amount', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<TransactionTestCase>> get changes =>
      RealmObjectBase.getChanges<TransactionTestCase>(this);

  @override
  TransactionTestCase freeze() =>
      RealmObjectBase.freezeObject<TransactionTestCase>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TransactionTestCase._);
    return const SchemaObject(
        ObjectType.realmObject, TransactionTestCase, 'TransactionTestCase', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('jobTypeId', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('amount', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class OtherBankEdc extends _OtherBankEdc
    with RealmEntity, RealmObjectBase, RealmObject {
  OtherBankEdc(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  OtherBankEdc._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<OtherBankEdc>> get changes =>
      RealmObjectBase.getChanges<OtherBankEdc>(this);

  @override
  OtherBankEdc freeze() => RealmObjectBase.freezeObject<OtherBankEdc>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(OtherBankEdc._);
    return const SchemaObject(
        ObjectType.realmObject, OtherBankEdc, 'OtherBankEdc', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class DorMenu extends _DorMenu with RealmEntity, RealmObjectBase, RealmObject {
  DorMenu(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  DorMenu._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<DorMenu>> get changes =>
      RealmObjectBase.getChanges<DorMenu>(this);

  @override
  DorMenu freeze() => RealmObjectBase.freezeObject<DorMenu>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(DorMenu._);
    return const SchemaObject(ObjectType.realmObject, DorMenu, 'DorMenu', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class MarcollUpdateStatus extends _MarcollUpdateStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  MarcollUpdateStatus(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  MarcollUpdateStatus._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<MarcollUpdateStatus>> get changes =>
      RealmObjectBase.getChanges<MarcollUpdateStatus>(this);

  @override
  MarcollUpdateStatus freeze() =>
      RealmObjectBase.freezeObject<MarcollUpdateStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MarcollUpdateStatus._);
    return const SchemaObject(
        ObjectType.realmObject, MarcollUpdateStatus, 'MarcollUpdateStatus', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class EosUpdateStatus extends _EosUpdateStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  EosUpdateStatus(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  EosUpdateStatus._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<EosUpdateStatus>> get changes =>
      RealmObjectBase.getChanges<EosUpdateStatus>(this);

  @override
  EosUpdateStatus freeze() =>
      RealmObjectBase.freezeObject<EosUpdateStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(EosUpdateStatus._);
    return const SchemaObject(
        ObjectType.realmObject, EosUpdateStatus, 'EosUpdateStatus', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class TrainingMaterial extends _TrainingMaterial
    with RealmEntity, RealmObjectBase, RealmObject {
  TrainingMaterial(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  TrainingMaterial._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<TrainingMaterial>> get changes =>
      RealmObjectBase.getChanges<TrainingMaterial>(this);

  @override
  TrainingMaterial freeze() =>
      RealmObjectBase.freezeObject<TrainingMaterial>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TrainingMaterial._);
    return const SchemaObject(
        ObjectType.realmObject, TrainingMaterial, 'TrainingMaterial', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class DamageType extends _DamageType
    with RealmEntity, RealmObjectBase, RealmObject {
  DamageType(
      String id,
      String name,
      int version,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'version', version);
  }

  DamageType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  Stream<RealmObjectChanges<DamageType>> get changes =>
      RealmObjectBase.getChanges<DamageType>(this);

  @override
  DamageType freeze() => RealmObjectBase.freezeObject<DamageType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(DamageType._);
    return const SchemaObject(
        ObjectType.realmObject, DamageType, 'DamageType', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('version', RealmPropertyType.int),
    ]);
  }
}

class SnStock extends _SnStock with RealmEntity, RealmObjectBase, RealmObject {
  SnStock(
      String serialNumber,
      String category,
      String productId,
      String productName,
      String servicePointId,
      String servicePointName,
      bool used,
      ) {
    RealmObjectBase.set(this, 'serialNumber', serialNumber);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'productId', productId);
    RealmObjectBase.set(this, 'productName', productName);
    RealmObjectBase.set(this, 'servicePointId', servicePointId);
    RealmObjectBase.set(this, 'servicePointName', servicePointName);
    RealmObjectBase.set(this, 'used', used);
  }

  SnStock._();

  @override
  String get serialNumber =>
      RealmObjectBase.get<String>(this, 'serialNumber') as String;
  @override
  set serialNumber(String value) =>
      RealmObjectBase.set(this, 'serialNumber', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get productId =>
      RealmObjectBase.get<String>(this, 'productId') as String;
  @override
  set productId(String value) => RealmObjectBase.set(this, 'productId', value);

  @override
  String get productName =>
      RealmObjectBase.get<String>(this, 'productName') as String;
  @override
  set productName(String value) =>
      RealmObjectBase.set(this, 'productName', value);

  @override
  String get servicePointId =>
      RealmObjectBase.get<String>(this, 'servicePointId') as String;
  @override
  set servicePointId(String value) =>
      RealmObjectBase.set(this, 'servicePointId', value);

  @override
  String get servicePointName =>
      RealmObjectBase.get<String>(this, 'servicePointName') as String;
  @override
  set servicePointName(String value) =>
      RealmObjectBase.set(this, 'servicePointName', value);

  @override
  bool get used => RealmObjectBase.get<bool>(this, 'used') as bool;
  @override
  set used(bool value) => RealmObjectBase.set(this, 'used', value);

  @override
  Stream<RealmObjectChanges<SnStock>> get changes =>
      RealmObjectBase.getChanges<SnStock>(this);

  @override
  SnStock freeze() => RealmObjectBase.freezeObject<SnStock>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SnStock._);
    return const SchemaObject(ObjectType.realmObject, SnStock, 'SnStock', [
      SchemaProperty('serialNumber', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('productId', RealmPropertyType.string),
      SchemaProperty('productName', RealmPropertyType.string),
      SchemaProperty('servicePointId', RealmPropertyType.string),
      SchemaProperty('servicePointName', RealmPropertyType.string),
      SchemaProperty('used', RealmPropertyType.bool),
    ]);
  }
}

class NonSnStock extends _NonSnStock
    with RealmEntity, RealmObjectBase, RealmObject {
  NonSnStock(
      String id,
      String servicePointId,
      String servicePointName,
      String category,
      String productName,
      int quantity,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'servicePointId', servicePointId);
    RealmObjectBase.set(this, 'servicePointName', servicePointName);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'productName', productName);
    RealmObjectBase.set(this, 'quantity', quantity);
  }

  NonSnStock._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get servicePointId =>
      RealmObjectBase.get<String>(this, 'servicePointId') as String;
  @override
  set servicePointId(String value) =>
      RealmObjectBase.set(this, 'servicePointId', value);

  @override
  String get servicePointName =>
      RealmObjectBase.get<String>(this, 'servicePointName') as String;
  @override
  set servicePointName(String value) =>
      RealmObjectBase.set(this, 'servicePointName', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get productName =>
      RealmObjectBase.get<String>(this, 'productName') as String;
  @override
  set productName(String value) =>
      RealmObjectBase.set(this, 'productName', value);

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  Stream<RealmObjectChanges<NonSnStock>> get changes =>
      RealmObjectBase.getChanges<NonSnStock>(this);

  @override
  NonSnStock freeze() => RealmObjectBase.freezeObject<NonSnStock>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(NonSnStock._);
    return const SchemaObject(
        ObjectType.realmObject, NonSnStock, 'NonSnStock', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('servicePointId', RealmPropertyType.string),
      SchemaProperty('servicePointName', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('productName', RealmPropertyType.string),
      SchemaProperty('quantity', RealmPropertyType.int),
    ]);
  }
}

class JobOrderDocumentStatus extends _JobOrderDocumentStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderDocumentStatus(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderDocumentStatus._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderDocumentStatus>> get changes =>
      RealmObjectBase.getChanges<JobOrderDocumentStatus>(this);

  @override
  JobOrderDocumentStatus freeze() =>
      RealmObjectBase.freezeObject<JobOrderDocumentStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderDocumentStatus._);
    return const SchemaObject(ObjectType.realmObject, JobOrderDocumentStatus,
        'JobOrderDocumentStatus', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('name', RealmPropertyType.string),
        ]);
  }
}

class JobOrderDamageType extends _JobOrderDamageType
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderDamageType(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderDamageType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderDamageType>> get changes =>
      RealmObjectBase.getChanges<JobOrderDamageType>(this);

  @override
  JobOrderDamageType freeze() =>
      RealmObjectBase.freezeObject<JobOrderDamageType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderDamageType._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderDamageType, 'JobOrderDamageType', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderBaseOffice extends _JobOrderBaseOffice
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderBaseOffice(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderBaseOffice._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderBaseOffice>> get changes =>
      RealmObjectBase.getChanges<JobOrderBaseOffice>(this);

  @override
  JobOrderBaseOffice freeze() =>
      RealmObjectBase.freezeObject<JobOrderBaseOffice>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderBaseOffice._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderBaseOffice, 'JobOrderBaseOffice', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderServicePoint extends _JobOrderServicePoint
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderServicePoint(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderServicePoint._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderServicePoint>> get changes =>
      RealmObjectBase.getChanges<JobOrderServicePoint>(this);

  @override
  JobOrderServicePoint freeze() =>
      RealmObjectBase.freezeObject<JobOrderServicePoint>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderServicePoint._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderServicePoint, 'JobOrderServicePoint', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderJobType extends _JobOrderJobType
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderJobType(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderJobType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderJobType>> get changes =>
      RealmObjectBase.getChanges<JobOrderJobType>(this);

  @override
  JobOrderJobType freeze() =>
      RealmObjectBase.freezeObject<JobOrderJobType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderJobType._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderJobType, 'JobOrderJobType', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderTiming extends _JobOrderTiming
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderTiming({
    DateTime? departure,
    String? departureCoordinate,
    DateTime? visit,
    String? visitCoordinate,
    DateTime? start,
    String? startCoordinate,
    DateTime? pause,
    String? pauseCoordinate,
    DateTime? finish,
    String? finishCoordinate,
  }) {
    RealmObjectBase.set(this, 'departure', departure);
    RealmObjectBase.set(this, 'departureCoordinate', departureCoordinate);
    RealmObjectBase.set(this, 'visit', visit);
    RealmObjectBase.set(this, 'visitCoordinate', visitCoordinate);
    RealmObjectBase.set(this, 'start', start);
    RealmObjectBase.set(this, 'startCoordinate', startCoordinate);
    RealmObjectBase.set(this, 'pause', pause);
    RealmObjectBase.set(this, 'pauseCoordinate', pauseCoordinate);
    RealmObjectBase.set(this, 'finish', finish);
    RealmObjectBase.set(this, 'finishCoordinate', finishCoordinate);
  }

  JobOrderTiming._();

  @override
  DateTime? get departure =>
      RealmObjectBase.get<DateTime>(this, 'departure') as DateTime?;
  @override
  set departure(DateTime? value) =>
      RealmObjectBase.set(this, 'departure', value);

  @override
  String? get departureCoordinate =>
      RealmObjectBase.get<String>(this, 'departureCoordinate') as String?;
  @override
  set departureCoordinate(String? value) =>
      RealmObjectBase.set(this, 'departureCoordinate', value);

  @override
  DateTime? get visit =>
      RealmObjectBase.get<DateTime>(this, 'visit') as DateTime?;
  @override
  set visit(DateTime? value) => RealmObjectBase.set(this, 'visit', value);

  @override
  String? get visitCoordinate =>
      RealmObjectBase.get<String>(this, 'visitCoordinate') as String?;
  @override
  set visitCoordinate(String? value) =>
      RealmObjectBase.set(this, 'visitCoordinate', value);

  @override
  DateTime? get start =>
      RealmObjectBase.get<DateTime>(this, 'start') as DateTime?;
  @override
  set start(DateTime? value) => RealmObjectBase.set(this, 'start', value);

  @override
  String? get startCoordinate =>
      RealmObjectBase.get<String>(this, 'startCoordinate') as String?;
  @override
  set startCoordinate(String? value) =>
      RealmObjectBase.set(this, 'startCoordinate', value);

  @override
  DateTime? get pause =>
      RealmObjectBase.get<DateTime>(this, 'pause') as DateTime?;
  @override
  set pause(DateTime? value) => RealmObjectBase.set(this, 'pause', value);

  @override
  String? get pauseCoordinate =>
      RealmObjectBase.get<String>(this, 'pauseCoordinate') as String?;
  @override
  set pauseCoordinate(String? value) =>
      RealmObjectBase.set(this, 'pauseCoordinate', value);

  @override
  DateTime? get finish =>
      RealmObjectBase.get<DateTime>(this, 'finish') as DateTime?;
  @override
  set finish(DateTime? value) => RealmObjectBase.set(this, 'finish', value);

  @override
  String? get finishCoordinate =>
      RealmObjectBase.get<String>(this, 'finishCoordinate') as String?;
  @override
  set finishCoordinate(String? value) =>
      RealmObjectBase.set(this, 'finishCoordinate', value);

  @override
  Stream<RealmObjectChanges<JobOrderTiming>> get changes =>
      RealmObjectBase.getChanges<JobOrderTiming>(this);

  @override
  JobOrderTiming freeze() => RealmObjectBase.freezeObject<JobOrderTiming>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderTiming._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderTiming, 'JobOrderTiming', [
      SchemaProperty('departure', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('departureCoordinate', RealmPropertyType.string,
          optional: true),
      SchemaProperty('visit', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('visitCoordinate', RealmPropertyType.string,
          optional: true),
      SchemaProperty('start', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('startCoordinate', RealmPropertyType.string,
          optional: true),
      SchemaProperty('pause', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('pauseCoordinate', RealmPropertyType.string,
          optional: true),
      SchemaProperty('finish', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('finishCoordinate', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class JobOrderStatus extends _JobOrderStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderStatus({
    String? id,
    String? name,
    String? categoryId,
    String? categoryName,
    DateTime? newVisitDate,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'categoryId', categoryId);
    RealmObjectBase.set(this, 'categoryName', categoryName);
    RealmObjectBase.set(this, 'newVisitDate', newVisitDate);
  }

  JobOrderStatus._();

  @override
  String? get id => RealmObjectBase.get<String>(this, 'id') as String?;
  @override
  set id(String? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get categoryId =>
      RealmObjectBase.get<String>(this, 'categoryId') as String?;
  @override
  set categoryId(String? value) =>
      RealmObjectBase.set(this, 'categoryId', value);

  @override
  String? get categoryName =>
      RealmObjectBase.get<String>(this, 'categoryName') as String?;
  @override
  set categoryName(String? value) =>
      RealmObjectBase.set(this, 'categoryName', value);

  @override
  DateTime? get newVisitDate =>
      RealmObjectBase.get<DateTime>(this, 'newVisitDate') as DateTime?;
  @override
  set newVisitDate(DateTime? value) =>
      RealmObjectBase.set(this, 'newVisitDate', value);

  @override
  Stream<RealmObjectChanges<JobOrderStatus>> get changes =>
      RealmObjectBase.getChanges<JobOrderStatus>(this);

  @override
  JobOrderStatus freeze() => RealmObjectBase.freezeObject<JobOrderStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderStatus._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderStatus, 'JobOrderStatus', [
      SchemaProperty('id', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('categoryId', RealmPropertyType.string, optional: true),
      SchemaProperty('categoryName', RealmPropertyType.string, optional: true),
      SchemaProperty('newVisitDate', RealmPropertyType.timestamp,
          optional: true),
    ]);
  }
}

class JobOrderRequestType extends _JobOrderRequestType
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderRequestType(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderRequestType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderRequestType>> get changes =>
      RealmObjectBase.getChanges<JobOrderRequestType>(this);

  @override
  JobOrderRequestType freeze() =>
      RealmObjectBase.freezeObject<JobOrderRequestType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderRequestType._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderRequestType, 'JobOrderRequestType', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderMerchant extends _JobOrderMerchant
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderMerchant(
      String id,
      String name,
      String shortName,
      String city,
      String address,
      String phoneNumber,
      String assignedPicName,
      int invoiceCount, {
        String? picName,
        String? picPhoneNumber,
        String? note,
        ImageFile? signature,
        Iterable<ImageFile> images = const [],
      }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'shortName', shortName);
    RealmObjectBase.set(this, 'city', city);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'phoneNumber', phoneNumber);
    RealmObjectBase.set(this, 'assignedPicName', assignedPicName);
    RealmObjectBase.set(this, 'picName', picName);
    RealmObjectBase.set(this, 'picPhoneNumber', picPhoneNumber);
    RealmObjectBase.set(this, 'invoiceCount', invoiceCount);
    RealmObjectBase.set(this, 'note', note);
    RealmObjectBase.set(this, 'signature', signature);
    RealmObjectBase.set<RealmList<ImageFile>>(
        this, 'images', RealmList<ImageFile>(images));
  }

  JobOrderMerchant._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get shortName =>
      RealmObjectBase.get<String>(this, 'shortName') as String;
  @override
  set shortName(String value) => RealmObjectBase.set(this, 'shortName', value);

  @override
  String get city => RealmObjectBase.get<String>(this, 'city') as String;
  @override
  set city(String value) => RealmObjectBase.set(this, 'city', value);

  @override
  String get address => RealmObjectBase.get<String>(this, 'address') as String;
  @override
  set address(String value) => RealmObjectBase.set(this, 'address', value);

  @override
  String get phoneNumber =>
      RealmObjectBase.get<String>(this, 'phoneNumber') as String;
  @override
  set phoneNumber(String value) =>
      RealmObjectBase.set(this, 'phoneNumber', value);

  @override
  String get assignedPicName =>
      RealmObjectBase.get<String>(this, 'assignedPicName') as String;
  @override
  set assignedPicName(String value) =>
      RealmObjectBase.set(this, 'assignedPicName', value);

  @override
  String? get picName =>
      RealmObjectBase.get<String>(this, 'picName') as String?;
  @override
  set picName(String? value) => RealmObjectBase.set(this, 'picName', value);

  @override
  String? get picPhoneNumber =>
      RealmObjectBase.get<String>(this, 'picPhoneNumber') as String?;
  @override
  set picPhoneNumber(String? value) =>
      RealmObjectBase.set(this, 'picPhoneNumber', value);

  @override
  int get invoiceCount => RealmObjectBase.get<int>(this, 'invoiceCount') as int;
  @override
  set invoiceCount(int value) =>
      RealmObjectBase.set(this, 'invoiceCount', value);

  @override
  String? get note => RealmObjectBase.get<String>(this, 'note') as String?;
  @override
  set note(String? value) => RealmObjectBase.set(this, 'note', value);

  @override
  ImageFile? get signature =>
      RealmObjectBase.get<ImageFile>(this, 'signature') as ImageFile?;
  @override
  set signature(covariant ImageFile? value) =>
      RealmObjectBase.set(this, 'signature', value);

  @override
  RealmList<ImageFile> get images =>
      RealmObjectBase.get<ImageFile>(this, 'images') as RealmList<ImageFile>;
  @override
  set images(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<JobOrderMerchant>> get changes =>
      RealmObjectBase.getChanges<JobOrderMerchant>(this);

  @override
  JobOrderMerchant freeze() =>
      RealmObjectBase.freezeObject<JobOrderMerchant>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderMerchant._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderMerchant, 'JobOrderMerchant', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('shortName', RealmPropertyType.string),
      SchemaProperty('city', RealmPropertyType.string),
      SchemaProperty('address', RealmPropertyType.string),
      SchemaProperty('phoneNumber', RealmPropertyType.string),
      SchemaProperty('assignedPicName', RealmPropertyType.string),
      SchemaProperty('picName', RealmPropertyType.string, optional: true),
      SchemaProperty('picPhoneNumber', RealmPropertyType.string,
          optional: true),
      SchemaProperty('invoiceCount', RealmPropertyType.int),
      SchemaProperty('note', RealmPropertyType.string, optional: true),
      SchemaProperty('signature', RealmPropertyType.object,
          optional: true, linkTarget: 'ImageFile'),
      SchemaProperty('images', RealmPropertyType.object,
          linkTarget: 'ImageFile', collectionType: RealmCollectionType.list),
    ]);
  }
}

class JobOrderProvider extends _JobOrderProvider
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderProvider(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderProvider._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderProvider>> get changes =>
      RealmObjectBase.getChanges<JobOrderProvider>(this);

  @override
  JobOrderProvider freeze() =>
      RealmObjectBase.freezeObject<JobOrderProvider>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderProvider._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderProvider, 'JobOrderProvider', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderEdcType extends _JobOrderEdcType
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderEdcType(
      String id,
      String name,
      String flag_android,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'flag_android', flag_android);
  }

  JobOrderEdcType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get flag_android =>
      RealmObjectBase.get<String>(this, 'flag_android') as String;
  @override
  set flag_android(String value) =>
      RealmObjectBase.set(this, 'name', flag_android);

  @override
  Stream<RealmObjectChanges<JobOrderEdcType>> get changes =>
      RealmObjectBase.getChanges<JobOrderEdcType>(this);

  @override
  JobOrderEdcType freeze() =>
      RealmObjectBase.freezeObject<JobOrderEdcType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderEdcType._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderEdcType, 'JobOrderEdcType', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('flag_android', RealmPropertyType.string),
    ]);
  }
}

class JobOrderEdcCommunicationType extends _JobOrderEdcCommunicationType
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderEdcCommunicationType(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderEdcCommunicationType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderEdcCommunicationType>> get changes =>
      RealmObjectBase.getChanges<JobOrderEdcCommunicationType>(this);

  @override
  JobOrderEdcCommunicationType freeze() =>
      RealmObjectBase.freezeObject<JobOrderEdcCommunicationType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderEdcCommunicationType._);
    return const SchemaObject(ObjectType.realmObject,
        JobOrderEdcCommunicationType, 'JobOrderEdcCommunicationType', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('name', RealmPropertyType.string),
        ]);
  }
}

class JobOrderMachineAndCard extends _JobOrderMachineAndCard
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderMachineAndCard({
    String? simCard,
    JobOrderProvider? provider,
    String? sam,
    String? sam2,
    String? sam3,
    String? sam4,
    String? sam5,
    String? sam6,
    String? sam7,
    JobOrderEdcType? edcType,
    JobOrderEdcCommunicationType? edcCommunicationType,
    Iterable<ImageFile> images = const [],
    Iterable<ImageFile> serialNumberPhotos = const [],
    Iterable<ImageFile> picMerchantImages = const [],
    Iterable<ImageFile> rollSalesDraftImages = const [],
    Iterable<ImageFile> trainingStatementLetterImages = const [],
    Iterable<ImageFile> edcAppImages = const [],
    Iterable<ImageFile> otherImages = const [],
  }) {
    RealmObjectBase.set(this, 'simCard', simCard);
    RealmObjectBase.set(this, 'provider', provider);
    RealmObjectBase.set(this, 'sam', sam);
    RealmObjectBase.set(this, 'sam2', sam2);
    RealmObjectBase.set(this, 'sam3', sam3);
    RealmObjectBase.set(this, 'sam4', sam4);
    RealmObjectBase.set(this, 'sam5', sam5);
    RealmObjectBase.set(this, 'sam6', sam6);
    RealmObjectBase.set(this, 'sam7', sam7);
    RealmObjectBase.set(this, 'edcType', edcType);
    RealmObjectBase.set(this, 'edcCommunicationType', edcCommunicationType);
    RealmObjectBase.set<RealmList<ImageFile>>(
      this, 'images', RealmList<ImageFile>(images),
    );
    RealmObjectBase.set<RealmList<ImageFile>>(
      this, 'serialNumberPhotos', RealmList<ImageFile>(serialNumberPhotos),
    );
    RealmObjectBase.set<RealmList<ImageFile>>(
      this, 'picMerchantImages', RealmList<ImageFile>(picMerchantImages),
    );
    RealmObjectBase.set<RealmList<ImageFile>>(
      this, 'rollSalesDraftImages', RealmList<ImageFile>(rollSalesDraftImages),
    );
    RealmObjectBase.set<RealmList<ImageFile>>(
      this, 'trainingStatementLetterImages', RealmList<ImageFile>(trainingStatementLetterImages),
    );
    RealmObjectBase.set<RealmList<ImageFile>>(
      this, 'edcAppImages', RealmList<ImageFile>(edcAppImages),
    );
    RealmObjectBase.set<RealmList<ImageFile>>(
      this, 'otherImages', RealmList<ImageFile>(otherImages),
    );
  }

  JobOrderMachineAndCard._();

  @override
  String? get simCard =>
      RealmObjectBase.get<String>(this, 'simCard') as String?;
  @override
  set simCard(String? value) => RealmObjectBase.set(this, 'simCard', value);

  @override
  JobOrderProvider? get provider =>
      RealmObjectBase.get<JobOrderProvider>(this, 'provider')
      as JobOrderProvider?;
  @override
  set provider(covariant JobOrderProvider? value) =>
      RealmObjectBase.set(this, 'provider', value);

  @override
  String? get sam => RealmObjectBase.get<String>(this, 'sam') as String?;
  @override
  set sam(String? value) => RealmObjectBase.set(this, 'sam', value);

  @override
  String? get sam2 => RealmObjectBase.get<String>(this, 'sam2') as String?;
  @override
  set sam2(String? value) => RealmObjectBase.set(this, 'sam2', value);

  @override
  String? get sam3 => RealmObjectBase.get<String>(this, 'sam3') as String?;
  @override
  set sam3(String? value) => RealmObjectBase.set(this, 'sam3', value);

  @override
  String? get sam4 => RealmObjectBase.get<String>(this, 'sam4') as String?;
  @override
  set sam4(String? value) => RealmObjectBase.set(this, 'sam4', value);

  @override
  String? get sam5 => RealmObjectBase.get<String>(this, 'sam5') as String?;
  @override
  set sam5(String? value) => RealmObjectBase.set(this, 'sam5', value);

  @override
  String? get sam6 => RealmObjectBase.get<String>(this, 'sam6') as String?;
  @override
  set sam6(String? value) => RealmObjectBase.set(this, 'sam6', value);

  @override
  String? get sam7 => RealmObjectBase.get<String>(this, 'sam7') as String?;
  @override
  set sam7(String? value) => RealmObjectBase.set(this, 'sam7', value);

  @override
  JobOrderEdcType? get edcType =>
      RealmObjectBase.get<JobOrderEdcType>(this, 'edcType') as JobOrderEdcType?;
  @override
  set edcType(covariant JobOrderEdcType? value) =>
      RealmObjectBase.set(this, 'edcType', value);

  @override
  JobOrderEdcCommunicationType? get edcCommunicationType =>
      RealmObjectBase.get<JobOrderEdcCommunicationType>(
          this, 'edcCommunicationType') as JobOrderEdcCommunicationType?;
  @override
  set edcCommunicationType(covariant JobOrderEdcCommunicationType? value) =>
      RealmObjectBase.set(this, 'edcCommunicationType', value);

  @override
  RealmList<ImageFile> get images =>
      RealmObjectBase.get<ImageFile>(this, 'images') as RealmList<ImageFile>;
  @override
  set images(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get serialNumberPhotos =>
      RealmObjectBase.get<ImageFile>(this, 'serialNumberPhotos')
      as RealmList<ImageFile>;
  @override
  set serialNumberPhotos(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get picMerchantImages =>
      RealmObjectBase.get<ImageFile>(this, 'picMerchantImages') as RealmList<ImageFile>;
  @override
  set picMerchantImages(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get rollSalesDraftImages =>
      RealmObjectBase.get<ImageFile>(this, 'rollSalesDraftImages') as RealmList<ImageFile>;
  @override
  set rollSalesDraftImages(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get trainingStatementLetterImages =>
      RealmObjectBase.get<ImageFile>(this, 'trainingStatementLetterImages') as RealmList<ImageFile>;
  @override
  set trainingStatementLetterImages(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get edcAppImages =>
      RealmObjectBase.get<ImageFile>(this, 'edcAppImages') as RealmList<ImageFile>;
  @override
  set edcAppImages(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get otherImages =>
      RealmObjectBase.get<ImageFile>(this, 'otherImages') as RealmList<ImageFile>;
  @override
  set otherImages(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<JobOrderMachineAndCard>> get changes =>
      RealmObjectBase.getChanges<JobOrderMachineAndCard>(this);

  @override
  JobOrderMachineAndCard freeze() =>
      RealmObjectBase.freezeObject<JobOrderMachineAndCard>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderMachineAndCard._);
    return const SchemaObject(ObjectType.realmObject, JobOrderMachineAndCard,
        'JobOrderMachineAndCard', [
          SchemaProperty('simCard', RealmPropertyType.string, optional: true),
          SchemaProperty('provider', RealmPropertyType.object,
              optional: true, linkTarget: 'JobOrderProvider'),
          SchemaProperty('sam', RealmPropertyType.string, optional: true),
          SchemaProperty('sam2', RealmPropertyType.string, optional: true),
          SchemaProperty('sam3', RealmPropertyType.string, optional: true),
          SchemaProperty('sam4', RealmPropertyType.string, optional: true),
          SchemaProperty('sam5', RealmPropertyType.string, optional: true),
          SchemaProperty('sam6', RealmPropertyType.string, optional: true),
          SchemaProperty('sam7', RealmPropertyType.string, optional: true),
          SchemaProperty('edcType', RealmPropertyType.object,
            optional: true,
            linkTarget: 'JobOrderEdcType',
          ),
          SchemaProperty(
            'edcCommunicationType',
            RealmPropertyType.object,
            optional: true,
            linkTarget: 'JobOrderEdcCommunicationType',
          ),
          SchemaProperty(
            'images',
            RealmPropertyType.object,
            linkTarget: 'ImageFile',
            collectionType: RealmCollectionType.list,
          ),
          SchemaProperty(
            'serialNumberPhotos',
            RealmPropertyType.object,
            linkTarget: 'ImageFile',
            collectionType: RealmCollectionType.list,
          ),
          SchemaProperty('picMerchantImages', RealmPropertyType.object,
            linkTarget: 'ImageFile', collectionType: RealmCollectionType.list,),
          SchemaProperty('rollSalesDraftImages', RealmPropertyType.object,
            linkTarget: 'ImageFile', collectionType: RealmCollectionType.list,),
          SchemaProperty('trainingStatementLetterImages', RealmPropertyType.object,
            linkTarget: 'ImageFile', collectionType: RealmCollectionType.list,),
          SchemaProperty('edcAppImages', RealmPropertyType.object,
            linkTarget: 'ImageFile', collectionType: RealmCollectionType.list,),
          SchemaProperty('otherImages', RealmPropertyType.object,
            linkTarget: 'ImageFile', collectionType: RealmCollectionType.list,),
        ]);
  }
}

class JobOrderReplacementType extends _JobOrderReplacementType
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderReplacementType(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderReplacementType._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderReplacementType>> get changes =>
      RealmObjectBase.getChanges<JobOrderReplacementType>(this);

  @override
  JobOrderReplacementType freeze() =>
      RealmObjectBase.freezeObject<JobOrderReplacementType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderReplacementType._);
    return const SchemaObject(ObjectType.realmObject, JobOrderReplacementType,
        'JobOrderReplacementType', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('name', RealmPropertyType.string),
        ]);
  }
}

class JobOrderReplacement extends _JobOrderReplacement
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderReplacement(
      String category,
      String productId,
      String name,
      String oldSerialNumber,
      String newSerialNumber,
      int quantity,
      String reason, {
        JobOrderReplacementType? type,
      }) {
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'productId', productId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'oldSerialNumber', oldSerialNumber);
    RealmObjectBase.set(this, 'newSerialNumber', newSerialNumber);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'reason', reason);
  }

  JobOrderReplacement._();

  @override
  JobOrderReplacementType? get type =>
      RealmObjectBase.get<JobOrderReplacementType>(this, 'type')
      as JobOrderReplacementType?;
  @override
  set type(covariant JobOrderReplacementType? value) =>
      RealmObjectBase.set(this, 'type', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get productId =>
      RealmObjectBase.get<String>(this, 'productId') as String;
  @override
  set productId(String value) => RealmObjectBase.set(this, 'productId', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get oldSerialNumber =>
      RealmObjectBase.get<String>(this, 'oldSerialNumber') as String;
  @override
  set oldSerialNumber(String value) =>
      RealmObjectBase.set(this, 'oldSerialNumber', value);

  @override
  String get newSerialNumber =>
      RealmObjectBase.get<String>(this, 'newSerialNumber') as String;
  @override
  set newSerialNumber(String value) =>
      RealmObjectBase.set(this, 'newSerialNumber', value);

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  String get reason => RealmObjectBase.get<String>(this, 'reason') as String;
  @override
  set reason(String value) => RealmObjectBase.set(this, 'reason', value);

  @override
  Stream<RealmObjectChanges<JobOrderReplacement>> get changes =>
      RealmObjectBase.getChanges<JobOrderReplacement>(this);

  @override
  JobOrderReplacement freeze() =>
      RealmObjectBase.freezeObject<JobOrderReplacement>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderReplacement._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderReplacement, 'JobOrderReplacement', [
      SchemaProperty('type', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderReplacementType'),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('productId', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('oldSerialNumber', RealmPropertyType.string),
      SchemaProperty('newSerialNumber', RealmPropertyType.string),
      SchemaProperty('quantity', RealmPropertyType.int),
      SchemaProperty('reason', RealmPropertyType.string),
    ]);
  }
}

class JobOrderInputPeripheral extends _JobOrderInputPeripheral
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderInputPeripheral(
      String id,
      String servicePoint,
      String category,
      String productName,
      int quantity,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'servicePoint', servicePoint);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'productName', productName);
    RealmObjectBase.set(this, 'quantity', quantity);
  }

  JobOrderInputPeripheral._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get servicePoint =>
      RealmObjectBase.get<String>(this, 'servicePoint') as String;
  @override
  set servicePoint(String value) =>
      RealmObjectBase.set(this, 'servicePoint', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get productName =>
      RealmObjectBase.get<String>(this, 'productName') as String;
  @override
  set productName(String value) =>
      RealmObjectBase.set(this, 'productName', value);

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  Stream<RealmObjectChanges<JobOrderInputPeripheral>> get changes =>
      RealmObjectBase.getChanges<JobOrderInputPeripheral>(this);

  @override
  JobOrderInputPeripheral freeze() =>
      RealmObjectBase.freezeObject<JobOrderInputPeripheral>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderInputPeripheral._);
    return const SchemaObject(ObjectType.realmObject, JobOrderInputPeripheral,
        'JobOrderInputPeripheral', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('servicePoint', RealmPropertyType.string),
          SchemaProperty('category', RealmPropertyType.string),
          SchemaProperty('productName', RealmPropertyType.string),
          SchemaProperty('quantity', RealmPropertyType.int),
        ]);
  }
}

class JobOrderNote extends _JobOrderNote
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderNote(
      String id,
      String name,
      bool value,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'value', value);
  }

  JobOrderNote._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  bool get value => RealmObjectBase.get<bool>(this, 'value') as bool;
  @override
  set value(bool value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<JobOrderNote>> get changes =>
      RealmObjectBase.getChanges<JobOrderNote>(this);

  @override
  JobOrderNote freeze() => RealmObjectBase.freezeObject<JobOrderNote>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderNote._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderNote, 'JobOrderNote', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('value', RealmPropertyType.bool),
    ]);
  }
}

class JobOrderQrisMenu extends _JobOrderQrisMenu
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderQrisMenu(
      String id,
      String name,
      bool value,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'value', value);
  }

  JobOrderQrisMenu._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  bool get value => RealmObjectBase.get<bool>(this, 'value') as bool;
  @override
  set value(bool value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<JobOrderQrisMenu>> get changes =>
      RealmObjectBase.getChanges<JobOrderQrisMenu>(this);

  @override
  JobOrderQrisMenu freeze() =>
      RealmObjectBase.freezeObject<JobOrderQrisMenu>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderQrisMenu._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderQrisMenu, 'JobOrderQrisMenu', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('value', RealmPropertyType.bool),
    ]);
  }
}

class JobOrderQris extends _JobOrderQris
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderQris(
      bool exist,
      bool testResult, {
        Iterable<JobOrderQrisMenu> menus = const [],
        Iterable<ImageFile> qrisReceiptImages = const [],
        Iterable<ImageFile> brizziInstallmentReceiptImages = const [],
      }) {
    RealmObjectBase.set(this, 'exist', exist);
    RealmObjectBase.set(this, 'testResult', testResult);
    RealmObjectBase.set<RealmList<JobOrderQrisMenu>>(
        this, 'menus', RealmList<JobOrderQrisMenu>(menus));
    RealmObjectBase.set<RealmList<ImageFile>>(
        this, 'qrisReceiptImages', RealmList<ImageFile>(qrisReceiptImages));
    RealmObjectBase.set<RealmList<ImageFile>>(
        this,
        'brizziInstallmentReceiptImages',
        RealmList<ImageFile>(brizziInstallmentReceiptImages));
  }

  JobOrderQris._();

  @override
  bool get exist => RealmObjectBase.get<bool>(this, 'exist') as bool;
  @override
  set exist(bool value) => RealmObjectBase.set(this, 'exist', value);

  @override
  bool get testResult => RealmObjectBase.get<bool>(this, 'testResult') as bool;
  @override
  set testResult(bool value) => RealmObjectBase.set(this, 'testResult', value);

  @override
  RealmList<JobOrderQrisMenu> get menus =>
      RealmObjectBase.get<JobOrderQrisMenu>(this, 'menus')
      as RealmList<JobOrderQrisMenu>;
  @override
  set menus(covariant RealmList<JobOrderQrisMenu> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get qrisReceiptImages =>
      RealmObjectBase.get<ImageFile>(this, 'qrisReceiptImages')
      as RealmList<ImageFile>;
  @override
  set qrisReceiptImages(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get brizziInstallmentReceiptImages =>
      RealmObjectBase.get<ImageFile>(this, 'brizziInstallmentReceiptImages')
      as RealmList<ImageFile>;
  @override
  set brizziInstallmentReceiptImages(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<JobOrderQris>> get changes =>
      RealmObjectBase.getChanges<JobOrderQris>(this);

  @override
  JobOrderQris freeze() => RealmObjectBase.freezeObject<JobOrderQris>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderQris._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderQris, 'JobOrderQris', [
      SchemaProperty('exist', RealmPropertyType.bool),
      SchemaProperty('testResult', RealmPropertyType.bool),
      SchemaProperty('menus', RealmPropertyType.object,
          linkTarget: 'JobOrderQrisMenu',
          collectionType: RealmCollectionType.list),
      SchemaProperty('qrisReceiptImages', RealmPropertyType.object,
          linkTarget: 'ImageFile', collectionType: RealmCollectionType.list),
      SchemaProperty('brizziInstallmentReceiptImages', RealmPropertyType.object,
          linkTarget: 'ImageFile', collectionType: RealmCollectionType.list),
    ]);
  }
}

class JobOrderEdcEquipment extends _JobOrderEdcEquipment
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderEdcEquipment(
      String name,
      int quantity,
      ) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'quantity', quantity);
  }

  JobOrderEdcEquipment._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  Stream<RealmObjectChanges<JobOrderEdcEquipment>> get changes =>
      RealmObjectBase.getChanges<JobOrderEdcEquipment>(this);

  @override
  JobOrderEdcEquipment freeze() =>
      RealmObjectBase.freezeObject<JobOrderEdcEquipment>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderEdcEquipment._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderEdcEquipment, 'JobOrderEdcEquipment', [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('quantity', RealmPropertyType.int),
    ]);
  }
}

class JobOrderEdcFeatureTestCase extends _JobOrderEdcFeatureTestCase
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderEdcFeatureTestCase(
      String id,
      String name,
      bool value, {
        String? type,
      }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'value', value);
  }

  JobOrderEdcFeatureTestCase._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get type => RealmObjectBase.get<String>(this, 'type') as String?;
  @override
  set type(String? value) => RealmObjectBase.set(this, 'type', value);

  @override
  bool get value => RealmObjectBase.get<bool>(this, 'value') as bool;
  @override
  set value(bool value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<JobOrderEdcFeatureTestCase>> get changes =>
      RealmObjectBase.getChanges<JobOrderEdcFeatureTestCase>(this);

  @override
  JobOrderEdcFeatureTestCase freeze() =>
      RealmObjectBase.freezeObject<JobOrderEdcFeatureTestCase>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderEdcFeatureTestCase._);
    return const SchemaObject(ObjectType.realmObject,
        JobOrderEdcFeatureTestCase, 'JobOrderEdcFeatureTestCase', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('name', RealmPropertyType.string),
          SchemaProperty('type', RealmPropertyType.string, optional: true),
          SchemaProperty('value', RealmPropertyType.bool),
        ]);
  }
}

class JobOrderJobCategory extends _JobOrderJobCategory
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderJobCategory(
      String id,
      String name,
      bool value,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'value', value);
  }

  JobOrderJobCategory._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  bool get value => RealmObjectBase.get<bool>(this, 'value') as bool;
  @override
  set value(bool value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<JobOrderJobCategory>> get changes =>
      RealmObjectBase.getChanges<JobOrderJobCategory>(this);

  @override
  JobOrderJobCategory freeze() =>
      RealmObjectBase.freezeObject<JobOrderJobCategory>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderJobCategory._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderJobCategory, 'JobOrderJobCategory', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('value', RealmPropertyType.bool),
    ]);
  }
}

class JobOrderTransactionTestCase extends _JobOrderTransactionTestCase
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderTransactionTestCase(
      String id,
      String name,
      String amount,
      bool value,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'value', value);
  }

  JobOrderTransactionTestCase._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get amount => RealmObjectBase.get<String>(this, 'amount') as String;
  @override
  set amount(String value) => RealmObjectBase.set(this, 'amount', value);

  @override
  bool get value => RealmObjectBase.get<bool>(this, 'value') as bool;
  @override
  set value(bool value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<JobOrderTransactionTestCase>> get changes =>
      RealmObjectBase.getChanges<JobOrderTransactionTestCase>(this);

  @override
  JobOrderTransactionTestCase freeze() =>
      RealmObjectBase.freezeObject<JobOrderTransactionTestCase>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderTransactionTestCase._);
    return const SchemaObject(ObjectType.realmObject,
        JobOrderTransactionTestCase, 'JobOrderTransactionTestCase', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('name', RealmPropertyType.string),
          SchemaProperty('amount', RealmPropertyType.string),
          SchemaProperty('value', RealmPropertyType.bool),
        ]);
  }
}

class JobOrderTransactionTest extends _JobOrderTransactionTest
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderTransactionTest({
    DateTime? date,
    Iterable<JobOrderTransactionTestCase> cases = const [],
    Iterable<ImageFile> images = const [],
  }) {
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set<RealmList<JobOrderTransactionTestCase>>(
        this, 'cases', RealmList<JobOrderTransactionTestCase>(cases));
    RealmObjectBase.set<RealmList<ImageFile>>(
        this, 'images', RealmList<ImageFile>(images));
  }

  JobOrderTransactionTest._();

  @override
  DateTime? get date =>
      RealmObjectBase.get<DateTime>(this, 'date') as DateTime?;
  @override
  set date(DateTime? value) => RealmObjectBase.set(this, 'date', value);

  @override
  RealmList<JobOrderTransactionTestCase> get cases =>
      RealmObjectBase.get<JobOrderTransactionTestCase>(this, 'cases')
      as RealmList<JobOrderTransactionTestCase>;
  @override
  set cases(covariant RealmList<JobOrderTransactionTestCase> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<ImageFile> get images =>
      RealmObjectBase.get<ImageFile>(this, 'images') as RealmList<ImageFile>;
  @override
  set images(covariant RealmList<ImageFile> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<JobOrderTransactionTest>> get changes =>
      RealmObjectBase.getChanges<JobOrderTransactionTest>(this);

  @override
  JobOrderTransactionTest freeze() =>
      RealmObjectBase.freezeObject<JobOrderTransactionTest>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderTransactionTest._);
    return const SchemaObject(ObjectType.realmObject, JobOrderTransactionTest,
        'JobOrderTransactionTest', [
          SchemaProperty('date', RealmPropertyType.timestamp, optional: true),
          SchemaProperty('cases', RealmPropertyType.object,
              linkTarget: 'JobOrderTransactionTestCase',
              collectionType: RealmCollectionType.list),
          SchemaProperty('images', RealmPropertyType.object,
              linkTarget: 'ImageFile', collectionType: RealmCollectionType.list),
        ]);
  }
}

class JobOrderOtherBankEdc extends _JobOrderOtherBankEdc
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderOtherBankEdc(
      String id,
      String name,
      bool value,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'value', value);
  }

  JobOrderOtherBankEdc._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  bool get value => RealmObjectBase.get<bool>(this, 'value') as bool;
  @override
  set value(bool value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<JobOrderOtherBankEdc>> get changes =>
      RealmObjectBase.getChanges<JobOrderOtherBankEdc>(this);

  @override
  JobOrderOtherBankEdc freeze() =>
      RealmObjectBase.freezeObject<JobOrderOtherBankEdc>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderOtherBankEdc._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderOtherBankEdc, 'JobOrderOtherBankEdc', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('value', RealmPropertyType.bool),
    ]);
  }
}

class JobOrderDorMenu extends _JobOrderDorMenu
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderDorMenu(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderDorMenu._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderDorMenu>> get changes =>
      RealmObjectBase.getChanges<JobOrderDorMenu>(this);

  @override
  JobOrderDorMenu freeze() =>
      RealmObjectBase.freezeObject<JobOrderDorMenu>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderDorMenu._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderDorMenu, 'JobOrderDorMenu', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderMarcollUpdateStatus extends _JobOrderMarcollUpdateStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderMarcollUpdateStatus(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderMarcollUpdateStatus._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderMarcollUpdateStatus>> get changes =>
      RealmObjectBase.getChanges<JobOrderMarcollUpdateStatus>(this);

  @override
  JobOrderMarcollUpdateStatus freeze() =>
      RealmObjectBase.freezeObject<JobOrderMarcollUpdateStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderMarcollUpdateStatus._);
    return const SchemaObject(ObjectType.realmObject,
        JobOrderMarcollUpdateStatus, 'JobOrderMarcollUpdateStatus', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('name', RealmPropertyType.string),
        ]);
  }
}

class JobOrderEosUpdateStatus extends _JobOrderEosUpdateStatus
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderEosUpdateStatus(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderEosUpdateStatus._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderEosUpdateStatus>> get changes =>
      RealmObjectBase.getChanges<JobOrderEosUpdateStatus>(this);

  @override
  JobOrderEosUpdateStatus freeze() =>
      RealmObjectBase.freezeObject<JobOrderEosUpdateStatus>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderEosUpdateStatus._);
    return const SchemaObject(ObjectType.realmObject, JobOrderEosUpdateStatus,
        'JobOrderEosUpdateStatus', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('name', RealmPropertyType.string),
        ]);
  }
}

class JobOrderAppVersion extends _JobOrderAppVersion
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderAppVersion(
      String id,
      String name,
      String id_tipe_edc,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'id_tipe_edc', id_tipe_edc);
  }

  JobOrderAppVersion._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get id_tipe_edc =>
      RealmObjectBase.get<String>(this, 'id_tipe_edc') as String;
  @override
  set id_tipe_edc(String value) =>
      RealmObjectBase.set(this, 'id_tipe_edc', value);

  @override
  Stream<RealmObjectChanges<JobOrderAppVersion>> get changes =>
      RealmObjectBase.getChanges<JobOrderAppVersion>(this);

  @override
  JobOrderAppVersion freeze() =>
      RealmObjectBase.freezeObject<JobOrderAppVersion>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderAppVersion._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderAppVersion, 'JobOrderAppVersion', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('id_tipe_edc', RealmPropertyType.string),
    ]);
  }
}

class JobOrderOsPatch extends _JobOrderOsPatch
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderOsPatch(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderOsPatch._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderOsPatch>> get changes =>
      RealmObjectBase.getChanges<JobOrderOsPatch>(this);

  @override
  JobOrderOsPatch freeze() =>
      RealmObjectBase.freezeObject<JobOrderOsPatch>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderOsPatch._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderOsPatch, 'JobOrderOsPatch', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderStickerBank extends _JobOrderStickerBank
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderStickerBank(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderStickerBank._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderStickerBank>> get changes =>
      RealmObjectBase.getChanges<JobOrderStickerBank>(this);

  @override
  JobOrderStickerBank freeze() =>
      RealmObjectBase.freezeObject<JobOrderStickerBank>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderStickerBank._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderStickerBank, 'JobOrderStickerBank', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderCleaningEdc extends _JobOrderCleaningEdc
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderCleaningEdc(
      String id,
      String name,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  JobOrderCleaningEdc._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<JobOrderCleaningEdc>> get changes =>
      RealmObjectBase.getChanges<JobOrderCleaningEdc>(this);

  @override
  JobOrderCleaningEdc freeze() =>
      RealmObjectBase.freezeObject<JobOrderCleaningEdc>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderCleaningEdc._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderCleaningEdc, 'JobOrderCleaningEdc', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }
}

class JobOrderEdcUpdate extends _JobOrderEdcUpdate
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderEdcUpdate({
    JobOrderDorMenu? dorMenu,
    JobOrderMarcollUpdateStatus? marcollUpdateStatus,
    JobOrderEosUpdateStatus? eosUpdateStatus,
    JobOrderAppVersion? appVersion,
    JobOrderOsPatch? osPatch,
    JobOrderStickerBank? stickerBank,
    JobOrderCleaningEdc? cleaningEdc,
  }) {
    RealmObjectBase.set(this, 'dorMenu', dorMenu);
    RealmObjectBase.set(this, 'marcollUpdateStatus', marcollUpdateStatus);
    RealmObjectBase.set(this, 'eosUpdateStatus', eosUpdateStatus);
    RealmObjectBase.set(this, 'appVersion', appVersion);
    RealmObjectBase.set(this, 'osPatch', osPatch);
    RealmObjectBase.set(this, 'stickerBank', stickerBank);
    RealmObjectBase.set(this, 'cleaningEdc', cleaningEdc);
  }

  JobOrderEdcUpdate._();

  @override
  JobOrderDorMenu? get dorMenu =>
      RealmObjectBase.get<JobOrderDorMenu>(this, 'dorMenu') as JobOrderDorMenu?;
  @override
  set dorMenu(covariant JobOrderDorMenu? value) =>
      RealmObjectBase.set(this, 'dorMenu', value);

  @override
  JobOrderMarcollUpdateStatus? get marcollUpdateStatus =>
      RealmObjectBase.get<JobOrderMarcollUpdateStatus>(
          this, 'marcollUpdateStatus') as JobOrderMarcollUpdateStatus?;
  @override
  set marcollUpdateStatus(covariant JobOrderMarcollUpdateStatus? value) =>
      RealmObjectBase.set(this, 'marcollUpdateStatus', value);

  @override
  JobOrderEosUpdateStatus? get eosUpdateStatus =>
      RealmObjectBase.get<JobOrderEosUpdateStatus>(this, 'eosUpdateStatus')
      as JobOrderEosUpdateStatus?;
  @override
  set eosUpdateStatus(covariant JobOrderEosUpdateStatus? value) =>
      RealmObjectBase.set(this, 'eosUpdateStatus', value);

  @override
  JobOrderAppVersion? get appVersion =>
      RealmObjectBase.get<JobOrderAppVersion>(this, 'appVersion')
      as JobOrderAppVersion?;
  @override
  set appVersion(covariant JobOrderAppVersion? value) =>
      RealmObjectBase.set(this, 'appVersion', value);

  @override
  JobOrderOsPatch? get osPatch =>
      RealmObjectBase.get<JobOrderOsPatch>(this, 'osPatch') as JobOrderOsPatch?;
  @override
  set osPatch(covariant JobOrderOsPatch? value) =>
      RealmObjectBase.set(this, 'osPatch', value);

  @override
  JobOrderStickerBank? get stickerBank =>
      RealmObjectBase.get<JobOrderStickerBank>(this, 'stickerBank')
      as JobOrderStickerBank?;
  @override
  set stickerBank(covariant JobOrderStickerBank? value) =>
      RealmObjectBase.set(this, 'stickerBank', value);

  @override
  JobOrderCleaningEdc? get cleaningEdc =>
      RealmObjectBase.get<JobOrderCleaningEdc>(this, 'cleaningEdc')
      as JobOrderCleaningEdc?;
  @override
  set cleaningEdc(covariant JobOrderCleaningEdc? value) =>
      RealmObjectBase.set(this, 'cleaningEdc', value);

  @override
  Stream<RealmObjectChanges<JobOrderEdcUpdate>> get changes =>
      RealmObjectBase.getChanges<JobOrderEdcUpdate>(this);

  @override
  JobOrderEdcUpdate freeze() =>
      RealmObjectBase.freezeObject<JobOrderEdcUpdate>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderEdcUpdate._);
    return const SchemaObject(
        ObjectType.realmObject, JobOrderEdcUpdate, 'JobOrderEdcUpdate', [
      SchemaProperty('dorMenu', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderDorMenu'),
      SchemaProperty('marcollUpdateStatus', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderMarcollUpdateStatus'),
      SchemaProperty('eosUpdateStatus', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderEosUpdateStatus'),
      SchemaProperty('appVersion', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderAppVersion'),
      SchemaProperty('osPatch', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderOsPatch'),
      SchemaProperty('stickerBank', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderStickerBank'),
      SchemaProperty('cleaningEdc', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderCleaningEdc'),
    ]);
  }
}

class JobOrderTrainingMaterial extends _JobOrderTrainingMaterial
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrderTrainingMaterial(
      String id,
      String name,
      bool value,
      ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'value', value);
  }

  JobOrderTrainingMaterial._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  bool get value => RealmObjectBase.get<bool>(this, 'value') as bool;
  @override
  set value(bool value) => RealmObjectBase.set(this, 'value', value);

  @override
  Stream<RealmObjectChanges<JobOrderTrainingMaterial>> get changes =>
      RealmObjectBase.getChanges<JobOrderTrainingMaterial>(this);

  @override
  JobOrderTrainingMaterial freeze() =>
      RealmObjectBase.freezeObject<JobOrderTrainingMaterial>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrderTrainingMaterial._);
    return const SchemaObject(ObjectType.realmObject, JobOrderTrainingMaterial,
        'JobOrderTrainingMaterial', [
          SchemaProperty('id', RealmPropertyType.string),
          SchemaProperty('name', RealmPropertyType.string),
          SchemaProperty('value', RealmPropertyType.bool),
        ]);
  }
}

class JobOrder extends _JobOrder
    with RealmEntity, RealmObjectBase, RealmObject {
  JobOrder(
      String id,
      int version,
      String serialNumberMaxDigit,
      bool synced,
      bool machineConditionNormal,
      String serialNumberMandatoryType,
      String serialNumberValidationType,
      String imageMandatoryType,
      String? latitude,
      String? longitude,
      String? jamBukaToko,
      String? jamTutupToko,
      int? edcCount,
      bool sent, {
        JobOrderTransactionTest? transactionTest,
        String? parentId,
        String? vendorId,
        String? caseId,
        String? mid,
        String? tid,
        String? poi,
        String? iccid,
        String? msisdn,
        String? provider,
        String? simCard,
        JobOrderBaseOffice? baseOffice,
        JobOrderStatus? status,
        JobOrderMerchant? merchant,
        String? serialNumber,
        DateTime? receivedDate,
        JobOrderEdcUpdate? edcUpdate,
        DateTime? visitDate,
        JobOrderTiming? timing,
        JobOrderRequestType? requestType,
        String? scannedSerialNumber,
        JobOrderMachineAndCard? machineAndCard,
        JobOrderQris? qris,
        DateTime? uploadDate,
        String? sam,
        DateTime? endSla,
        String? sam2,
        String? description,
        String? requiredThermalCount,
        String? sam3,
        String? sam4,
        String? sam5,
        String? sam6,
        JobOrderDocumentStatus? documentStatus,
        JobOrderDamageType? damageType,
        String? sam7,
        JobOrderServicePoint? servicePoint,
        String? cmRemark,
        JobOrderJobType? jobType,
        Iterable<JobOrderNote> notes = const [],
        Iterable<JobOrderEdcEquipment> edcEquipments = const [],
        Iterable<JobOrderOtherBankEdc> otherBankEdcs = const [],
        Iterable<JobOrderTrainingMaterial> trainingMaterials = const [],
        Iterable<JobOrderInputPeripheral> inputPeripherals = const [],
        Iterable<JobOrderEdcFeatureTestCase> edcFeatureTestCases = const [],
        Iterable<JobOrderReplacement> replacements = const [],
        Iterable<JobOrderJobCategory> jobCategories = const [],
        // New values
        String? edcCleaning,
        String? edcProblem,
        String? comLine,
        String? settlement,
        String? signalBar,
        String? priorityEdc,
        String? merchantComment,
        String? mostUsedEdc,
        String? otherEdc,
        String? merchantRequest,
        String? promoMaterial,
        String? position,
      }) {
    RealmObjectBase.set(this, 'transactionTest', transactionTest);
    RealmObjectBase.set(this, 'parentId', parentId);
    RealmObjectBase.set(this, 'vendorId', vendorId);
    RealmObjectBase.set(this, 'caseId', caseId);
    RealmObjectBase.set(this, 'mid', mid);
    RealmObjectBase.set(this, 'tid', tid);
    RealmObjectBase.set(this, 'poi', poi);
    RealmObjectBase.set(this, 'iccid', iccid);
    RealmObjectBase.set(this, 'msisdn', msisdn);
    RealmObjectBase.set(this, 'provider', provider);
    RealmObjectBase.set(this, 'simCard', simCard);
    RealmObjectBase.set(this, 'baseOffice', baseOffice);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'merchant', merchant);
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'serialNumber', serialNumber);
    RealmObjectBase.set(this, 'receivedDate', receivedDate);
    RealmObjectBase.set(this, 'edcUpdate', edcUpdate);
    RealmObjectBase.set(this, 'visitDate', visitDate);
    RealmObjectBase.set(this, 'version', version);
    RealmObjectBase.set(this, 'timing', timing);
    RealmObjectBase.set(this, 'requestType', requestType);
    RealmObjectBase.set(this, 'scannedSerialNumber', scannedSerialNumber);
    RealmObjectBase.set(this, 'machineAndCard', machineAndCard);
    RealmObjectBase.set(this, 'qris', qris);
    RealmObjectBase.set(this, 'serialNumberMaxDigit', serialNumberMaxDigit);
    RealmObjectBase.set(this, 'synced', synced);
    RealmObjectBase.set(this, 'uploadDate', uploadDate);
    RealmObjectBase.set(this, 'sam', sam);
    RealmObjectBase.set(this, 'endSla', endSla);
    RealmObjectBase.set(this, 'sam2', sam2);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'requiredThermalCount', requiredThermalCount);
    RealmObjectBase.set(this, 'sam3', sam3);
    RealmObjectBase.set(this, 'machineConditionNormal', machineConditionNormal);
    RealmObjectBase.set(this, 'sam4', sam4);
    RealmObjectBase.set(
        this, 'serialNumberMandatoryType', serialNumberMandatoryType);
    RealmObjectBase.set(
        this, 'serialNumberValidationType', serialNumberValidationType);
    RealmObjectBase.set(this, 'sam5', sam5);
    RealmObjectBase.set(this, 'imageMandatoryType', imageMandatoryType);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'jamBukaToko', jamBukaToko);
    RealmObjectBase.set(this, 'jamTutupToko', jamTutupToko);
    RealmObjectBase.set(this, 'edcCount', edcCount);

    RealmObjectBase.set(this, 'sam6', sam6);
    RealmObjectBase.set(this, 'documentStatus', documentStatus);
    RealmObjectBase.set(this, 'sent', sent);
    RealmObjectBase.set(this, 'damageType', damageType);
    RealmObjectBase.set(this, 'sam7', sam7);
    RealmObjectBase.set(this, 'servicePoint', servicePoint);
    RealmObjectBase.set(this, 'cmRemark', cmRemark);
    RealmObjectBase.set(this, 'jobType', jobType);
    RealmObjectBase.set<RealmList<JobOrderNote>>(
        this, 'notes', RealmList<JobOrderNote>(notes));
    RealmObjectBase.set<RealmList<JobOrderEdcEquipment>>(
        this, 'edcEquipments', RealmList<JobOrderEdcEquipment>(edcEquipments));
    RealmObjectBase.set<RealmList<JobOrderOtherBankEdc>>(
        this, 'otherBankEdcs', RealmList<JobOrderOtherBankEdc>(otherBankEdcs));
    RealmObjectBase.set<RealmList<JobOrderTrainingMaterial>>(
        this,
        'trainingMaterials',
        RealmList<JobOrderTrainingMaterial>(trainingMaterials));
    RealmObjectBase.set<RealmList<JobOrderInputPeripheral>>(
        this,
        'inputPeripherals',
        RealmList<JobOrderInputPeripheral>(inputPeripherals));
    RealmObjectBase.set<RealmList<JobOrderEdcFeatureTestCase>>(
        this,
        'edcFeatureTestCases',
        RealmList<JobOrderEdcFeatureTestCase>(edcFeatureTestCases));
    RealmObjectBase.set<RealmList<JobOrderReplacement>>(
        this, 'replacements', RealmList<JobOrderReplacement>(replacements));
    RealmObjectBase.set<RealmList<JobOrderJobCategory>>(
        this, 'jobCategories', RealmList<JobOrderJobCategory>(jobCategories));
    // New values
    RealmObjectBase.set(this, 'edcCleaning', edcCleaning);
    RealmObjectBase.set(this, 'edcProblem', edcProblem);
    RealmObjectBase.set(this, 'comLine', comLine);
    RealmObjectBase.set(this, 'settlement', settlement);
    RealmObjectBase.set(this, 'signalBar', signalBar);
    RealmObjectBase.set(this, 'priorityEdc', priorityEdc);
    RealmObjectBase.set(this, 'merchantComment', merchantComment);
    RealmObjectBase.set(this, 'mostUsedEdc', mostUsedEdc);
    RealmObjectBase.set(this, 'otherEdc', otherEdc);
    RealmObjectBase.set(this, 'merchantRequest', merchantRequest);
    RealmObjectBase.set(this, 'promoMaterial', promoMaterial);
    RealmObjectBase.set(this, 'position', position);
  }

  JobOrder._();

  @override
  JobOrderTransactionTest? get transactionTest =>
      RealmObjectBase.get<JobOrderTransactionTest>(this, 'transactionTest')
      as JobOrderTransactionTest?;

  @override
  set transactionTest(covariant JobOrderTransactionTest? value) =>
      RealmObjectBase.set(this, 'transactionTest', value);

  @override
  String? get parentId =>
      RealmObjectBase.get<String>(this, 'parentId') as String?;
  @override
  set parentId(String? value) => RealmObjectBase.set(this, 'parentId', value);

  @override
  String? get latitude =>
      RealmObjectBase.get<String>(this, 'latitude') as String?;
  @override
  set latitude(String? value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  String? get longitude =>
      RealmObjectBase.get<String>(this, 'longitude') as String?;
  @override
  set longitude(String? value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  String? get jamBukaToko =>
      RealmObjectBase.get<String>(this, 'jamBukaToko') as String?;
  @override
  set jamBukaToko(String? value) =>
      RealmObjectBase.set(this, 'jamBukaToko', value);

  @override
  String? get jamTutupToko =>
      RealmObjectBase.get<String>(this, 'jamTutupToko') as String?;
  @override
  set jamTutupToko(String? value) =>
      RealmObjectBase.set(this, 'jamTutupToko', value);

  @override
  int? get edcCount => RealmObjectBase.get<int>(this, 'edcCount') as int?;
  @override
  set edcCount(int? value) => RealmObjectBase.set(this, 'edcCount', value);

  @override
  String? get vendorId =>
      RealmObjectBase.get<String>(this, 'vendorId') as String?;
  @override
  set vendorId(String? value) => RealmObjectBase.set(this, 'vendorId', value);

  @override
  String? get caseId => RealmObjectBase.get<String>(this, 'caseId') as String?;
  @override
  set caseId(String? value) => RealmObjectBase.set(this, 'caseId', value);

  @override
  String? get mid => RealmObjectBase.get<String>(this, 'mid') as String?;
  @override
  set mid(String? value) => RealmObjectBase.set(this, 'mid', value);

  @override
  String? get tid => RealmObjectBase.get<String>(this, 'tid') as String?;
  @override
  set tid(String? value) => RealmObjectBase.set(this, 'tid', value);

  @override
  String? get poi => RealmObjectBase.get<String>(this, 'poi') as String?;
  @override
  set poi(String? value) => RealmObjectBase.set(this, 'poi', value);

  @override
  String? get iccid => RealmObjectBase.get<String>(this, 'iccid') as String?;
  @override
  set iccid(String? value) => RealmObjectBase.set(this, 'iccid', value);

  @override
  String? get msisdn => RealmObjectBase.get<String>(this, 'msisdn') as String?;
  @override
  set msisdn(String? value) => RealmObjectBase.set(this, 'msisdn', value);

  @override
  String? get provider =>
      RealmObjectBase.get<String>(this, 'provider') as String?;
  @override
  set provider(String? value) => RealmObjectBase.set(this, 'provider', value);

  @override
  String? get simCard =>
      RealmObjectBase.get<String>(this, 'simCard') as String?;
  @override
  set simCard(String? value) => RealmObjectBase.set(this, 'simCard', value);

  @override
  JobOrderBaseOffice? get baseOffice =>
      RealmObjectBase.get<JobOrderBaseOffice>(this, 'baseOffice')
      as JobOrderBaseOffice?;
  @override
  set baseOffice(covariant JobOrderBaseOffice? value) =>
      RealmObjectBase.set(this, 'baseOffice', value);

  @override
  JobOrderStatus? get status =>
      RealmObjectBase.get<JobOrderStatus>(this, 'status') as JobOrderStatus?;
  @override
  set status(covariant JobOrderStatus? value) =>
      RealmObjectBase.set(this, 'status', value);

  @override
  JobOrderMerchant? get merchant =>
      RealmObjectBase.get<JobOrderMerchant>(this, 'merchant')
      as JobOrderMerchant?;
  @override
  set merchant(covariant JobOrderMerchant? value) =>
      RealmObjectBase.set(this, 'merchant', value);

  @override
  RealmList<JobOrderNote> get notes =>
      RealmObjectBase.get<JobOrderNote>(this, 'notes')
      as RealmList<JobOrderNote>;
  @override
  set notes(covariant RealmList<JobOrderNote> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<JobOrderEdcEquipment> get edcEquipments =>
      RealmObjectBase.get<JobOrderEdcEquipment>(this, 'edcEquipments')
      as RealmList<JobOrderEdcEquipment>;
  @override
  set edcEquipments(covariant RealmList<JobOrderEdcEquipment> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<JobOrderOtherBankEdc> get otherBankEdcs =>
      RealmObjectBase.get<JobOrderOtherBankEdc>(this, 'otherBankEdcs')
      as RealmList<JobOrderOtherBankEdc>;
  @override
  set otherBankEdcs(covariant RealmList<JobOrderOtherBankEdc> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<JobOrderTrainingMaterial> get trainingMaterials =>
      RealmObjectBase.get<JobOrderTrainingMaterial>(this, 'trainingMaterials')
      as RealmList<JobOrderTrainingMaterial>;
  @override
  set trainingMaterials(covariant RealmList<JobOrderTrainingMaterial> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get serialNumber =>
      RealmObjectBase.get<String>(this, 'serialNumber') as String?;
  @override
  set serialNumber(String? value) =>
      RealmObjectBase.set(this, 'serialNumber', value);

  @override
  DateTime? get receivedDate =>
      RealmObjectBase.get<DateTime>(this, 'receivedDate') as DateTime?;
  @override
  set receivedDate(DateTime? value) =>
      RealmObjectBase.set(this, 'receivedDate', value);

  @override
  JobOrderEdcUpdate? get edcUpdate =>
      RealmObjectBase.get<JobOrderEdcUpdate>(this, 'edcUpdate')
      as JobOrderEdcUpdate?;
  @override
  set edcUpdate(covariant JobOrderEdcUpdate? value) =>
      RealmObjectBase.set(this, 'edcUpdate', value);

  @override
  DateTime? get visitDate =>
      RealmObjectBase.get<DateTime>(this, 'visitDate') as DateTime?;
  @override
  set visitDate(DateTime? value) =>
      RealmObjectBase.set(this, 'visitDate', value);

  @override
  int get version => RealmObjectBase.get<int>(this, 'version') as int;
  @override
  set version(int value) => RealmObjectBase.set(this, 'version', value);

  @override
  JobOrderTiming? get timing =>
      RealmObjectBase.get<JobOrderTiming>(this, 'timing') as JobOrderTiming?;
  @override
  set timing(covariant JobOrderTiming? value) =>
      RealmObjectBase.set(this, 'timing', value);

  @override
  JobOrderRequestType? get requestType =>
      RealmObjectBase.get<JobOrderRequestType>(this, 'requestType')
      as JobOrderRequestType?;
  @override
  set requestType(covariant JobOrderRequestType? value) =>
      RealmObjectBase.set(this, 'requestType', value);

  @override
  String? get scannedSerialNumber =>
      RealmObjectBase.get<String>(this, 'scannedSerialNumber') as String?;
  @override
  set scannedSerialNumber(String? value) =>
      RealmObjectBase.set(this, 'scannedSerialNumber', value);

  @override
  JobOrderMachineAndCard? get machineAndCard =>
      RealmObjectBase.get<JobOrderMachineAndCard>(this, 'machineAndCard')
      as JobOrderMachineAndCard?;
  @override
  set machineAndCard(covariant JobOrderMachineAndCard? value) =>
      RealmObjectBase.set(this, 'machineAndCard', value);

  @override
  RealmList<JobOrderInputPeripheral> get inputPeripherals =>
      RealmObjectBase.get<JobOrderInputPeripheral>(this, 'inputPeripherals')
      as RealmList<JobOrderInputPeripheral>;
  @override
  set inputPeripherals(covariant RealmList<JobOrderInputPeripheral> value) =>
      throw RealmUnsupportedSetError();

  @override
  JobOrderQris? get qris =>
      RealmObjectBase.get<JobOrderQris>(this, 'qris') as JobOrderQris?;
  @override
  set qris(covariant JobOrderQris? value) =>
      RealmObjectBase.set(this, 'qris', value);

  @override
  String get serialNumberMaxDigit =>
      RealmObjectBase.get<String>(this, 'serialNumberMaxDigit') as String;
  @override
  set serialNumberMaxDigit(String value) =>
      RealmObjectBase.set(this, 'serialNumberMaxDigit', value);

  @override
  RealmList<JobOrderEdcFeatureTestCase> get edcFeatureTestCases =>
      RealmObjectBase.get<JobOrderEdcFeatureTestCase>(
          this, 'edcFeatureTestCases') as RealmList<JobOrderEdcFeatureTestCase>;
  @override
  set edcFeatureTestCases(
      covariant RealmList<JobOrderEdcFeatureTestCase> value) =>
      throw RealmUnsupportedSetError();

  @override
  bool get synced => RealmObjectBase.get<bool>(this, 'synced') as bool;
  @override
  set synced(bool value) => RealmObjectBase.set(this, 'synced', value);

  @override
  DateTime? get uploadDate =>
      RealmObjectBase.get<DateTime>(this, 'uploadDate') as DateTime?;
  @override
  set uploadDate(DateTime? value) =>
      RealmObjectBase.set(this, 'uploadDate', value);

  @override
  String? get sam => RealmObjectBase.get<String>(this, 'sam') as String?;
  @override
  set sam(String? value) => RealmObjectBase.set(this, 'sam', value);

  @override
  DateTime? get endSla =>
      RealmObjectBase.get<DateTime>(this, 'endSla') as DateTime?;
  @override
  set endSla(DateTime? value) => RealmObjectBase.set(this, 'endSla', value);

  @override
  String? get sam2 => RealmObjectBase.get<String>(this, 'sam2') as String?;
  @override
  set sam2(String? value) => RealmObjectBase.set(this, 'sam2', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  RealmList<JobOrderReplacement> get replacements =>
      RealmObjectBase.get<JobOrderReplacement>(this, 'replacements')
      as RealmList<JobOrderReplacement>;
  @override
  set replacements(covariant RealmList<JobOrderReplacement> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get requiredThermalCount =>
      RealmObjectBase.get<String>(this, 'requiredThermalCount') as String?;
  @override
  set requiredThermalCount(String? value) =>
      RealmObjectBase.set(this, 'requiredThermalCount', value);

  @override
  String? get sam3 => RealmObjectBase.get<String>(this, 'sam3') as String?;
  @override
  set sam3(String? value) => RealmObjectBase.set(this, 'sam3', value);

  @override
  bool get machineConditionNormal =>
      RealmObjectBase.get<bool>(this, 'machineConditionNormal') as bool;
  @override
  set machineConditionNormal(bool value) =>
      RealmObjectBase.set(this, 'machineConditionNormal', value);

  @override
  String? get sam4 => RealmObjectBase.get<String>(this, 'sam4') as String?;
  @override
  set sam4(String? value) => RealmObjectBase.set(this, 'sam4', value);

  @override
  String get serialNumberMandatoryType =>
      RealmObjectBase.get<String>(this, 'serialNumberMandatoryType') as String;
  @override
  set serialNumberMandatoryType(String value) =>
      RealmObjectBase.set(this, 'serialNumberMandatoryType', value);

  @override
  RealmList<JobOrderJobCategory> get jobCategories =>
      RealmObjectBase.get<JobOrderJobCategory>(this, 'jobCategories')
      as RealmList<JobOrderJobCategory>;
  @override
  set jobCategories(covariant RealmList<JobOrderJobCategory> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get serialNumberValidationType =>
      RealmObjectBase.get<String>(this, 'serialNumberValidationType') as String;
  @override
  set serialNumberValidationType(String value) =>
      RealmObjectBase.set(this, 'serialNumberValidationType', value);

  @override
  String? get sam5 => RealmObjectBase.get<String>(this, 'sam5') as String?;
  @override
  set sam5(String? value) => RealmObjectBase.set(this, 'sam5', value);

  @override
  String get imageMandatoryType =>
      RealmObjectBase.get<String>(this, 'imageMandatoryType') as String;
  @override
  set imageMandatoryType(String value) =>
      RealmObjectBase.set(this, 'imageMandatoryType', value);

  @override
  String? get sam6 => RealmObjectBase.get<String>(this, 'sam6') as String?;
  @override
  set sam6(String? value) => RealmObjectBase.set(this, 'sam6', value);

  @override
  JobOrderDocumentStatus? get documentStatus =>
      RealmObjectBase.get<JobOrderDocumentStatus>(this, 'documentStatus')
      as JobOrderDocumentStatus?;
  @override
  set documentStatus(covariant JobOrderDocumentStatus? value) =>
      RealmObjectBase.set(this, 'documentStatus', value);

  @override
  bool get sent => RealmObjectBase.get<bool>(this, 'sent') as bool;
  @override
  set sent(bool value) => RealmObjectBase.set(this, 'sent', value);

  @override
  JobOrderDamageType? get damageType =>
      RealmObjectBase.get<JobOrderDamageType>(this, 'damageType')
      as JobOrderDamageType?;
  @override
  set damageType(covariant JobOrderDamageType? value) =>
      RealmObjectBase.set(this, 'damageType', value);

  @override
  String? get sam7 => RealmObjectBase.get<String>(this, 'sam7') as String?;
  @override
  set sam7(String? value) => RealmObjectBase.set(this, 'sam7', value);

  @override
  JobOrderServicePoint? get servicePoint =>
      RealmObjectBase.get<JobOrderServicePoint>(this, 'servicePoint')
      as JobOrderServicePoint?;
  @override
  set servicePoint(covariant JobOrderServicePoint? value) =>
      RealmObjectBase.set(this, 'servicePoint', value);

  @override
  String? get cmRemark =>
      RealmObjectBase.get<String>(this, 'cmRemark') as String?;
  @override
  set cmRemark(String? value) => RealmObjectBase.set(this, 'cmRemark', value);

  @override
  JobOrderJobType? get jobType =>
      RealmObjectBase.get<JobOrderJobType>(this, 'jobType') as JobOrderJobType?;
  @override
  set jobType(covariant JobOrderJobType? value) =>
      RealmObjectBase.set(this, 'jobType', value);

  @override
  Stream<RealmObjectChanges<JobOrder>> get changes =>
      RealmObjectBase.getChanges<JobOrder>(this);

  // New value
  @override
  String? get edcCleaning => RealmObjectBase.get<String>(this, 'edcCleaning') as String?;
  @override
  set edcCleaning(String? value) => RealmObjectBase.set(this, 'edcCleaning', value);
  @override
  String? get edcProblem => RealmObjectBase.get<String>(this, 'edcProblem') as String?;
  @override
  set edcProblem(String? value) => RealmObjectBase.set(this, 'edcProblem', value);
  @override
  String? get comLine => RealmObjectBase.get<String>(this, 'comLine') as String?;
  @override
  set comLine(String? value) => RealmObjectBase.set(this, 'comLine', value);
  @override
  String? get settlement => RealmObjectBase.get<String>(this, 'settlement') as String?;
  @override
  set settlement(String? value) => RealmObjectBase.set(this, 'settlement', value);
  @override
  String? get signalBar => RealmObjectBase.get<String>(this, 'signalBar') as String?;
  @override
  set signalBar(String? value) => RealmObjectBase.set(this, 'signalBar', value);
  @override
  String? get priorityEdc => RealmObjectBase.get<String>(this, 'priorityEdc') as String?;
  @override
  set priorityEdc(String? value) => RealmObjectBase.set(this, 'priorityEdc', value);
  @override
  String? get merchantComment => RealmObjectBase.get<String>(this, 'merchantComment') as String?;
  @override
  set merchantComment(String? value) => RealmObjectBase.set(this, 'merchantComment', value);
  @override
  String? get mostUsedEdc => RealmObjectBase.get<String>(this, 'mostUsedEdc') as String?;
  @override
  set mostUsedEdc(String? value) => RealmObjectBase.set(this, 'mostUsedEdc', value);
  @override
  String? get otherEdc => RealmObjectBase.get<String>(this, 'otherEdc') as String?;
  @override
  set otherEdc(String? value) => RealmObjectBase.set(this, 'otherEdc', value);
  @override
  String? get merchantRequest => RealmObjectBase.get<String>(this, 'merchantRequest') as String?;
  @override
  set merchantRequest(String? value) => RealmObjectBase.set(this, 'merchantRequest', value);
  @override
  String? get promoMaterial => RealmObjectBase.get<String>(this, 'promoMaterial') as String?;
  @override
  set promoMaterial(String? value) => RealmObjectBase.set(this, 'promoMaterial', value);
  @override
  String? get position => RealmObjectBase.get<String>(this, 'position') as String?;
  @override
  set position(String? value) => RealmObjectBase.set(this, 'position', value);

  @override
  JobOrder freeze() => RealmObjectBase.freezeObject<JobOrder>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(JobOrder._);
    return const SchemaObject(ObjectType.realmObject, JobOrder, 'JobOrder', [
      SchemaProperty('transactionTest', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderTransactionTest'),
      SchemaProperty('parentId', RealmPropertyType.string, optional: true),
      SchemaProperty('vendorId', RealmPropertyType.string, optional: true),
      SchemaProperty('caseId', RealmPropertyType.string, optional: true),
      SchemaProperty('mid', RealmPropertyType.string, optional: true),
      SchemaProperty('tid', RealmPropertyType.string, optional: true),
      SchemaProperty('poi', RealmPropertyType.string, optional: true),
      SchemaProperty('iccid', RealmPropertyType.string, optional: true),
      SchemaProperty('msisdn', RealmPropertyType.string, optional: true),
      SchemaProperty('provider', RealmPropertyType.string, optional: true),
      SchemaProperty('simCard', RealmPropertyType.string, optional: true),
      SchemaProperty('baseOffice', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderBaseOffice'),
      SchemaProperty('status', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderStatus'),
      SchemaProperty('merchant', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderMerchant'),
      SchemaProperty('notes', RealmPropertyType.object,
          linkTarget: 'JobOrderNote', collectionType: RealmCollectionType.list),
      SchemaProperty('edcEquipments', RealmPropertyType.object,
          linkTarget: 'JobOrderEdcEquipment',
          collectionType: RealmCollectionType.list),
      SchemaProperty('otherBankEdcs', RealmPropertyType.object,
          linkTarget: 'JobOrderOtherBankEdc',
          collectionType: RealmCollectionType.list),
      SchemaProperty('trainingMaterials', RealmPropertyType.object,
          linkTarget: 'JobOrderTrainingMaterial',
          collectionType: RealmCollectionType.list),
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('serialNumber', RealmPropertyType.string, optional: true),
      SchemaProperty('receivedDate', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('edcUpdate', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderEdcUpdate'),
      SchemaProperty('visitDate', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('version', RealmPropertyType.int),
      SchemaProperty('timing', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderTiming'),
      SchemaProperty('requestType', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderRequestType'),
      SchemaProperty('scannedSerialNumber', RealmPropertyType.string,
          optional: true),
      SchemaProperty('machineAndCard', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderMachineAndCard'),
      SchemaProperty('inputPeripherals', RealmPropertyType.object,
          linkTarget: 'JobOrderInputPeripheral',
          collectionType: RealmCollectionType.list),
      SchemaProperty('qris', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderQris'),
      SchemaProperty('serialNumberMaxDigit', RealmPropertyType.string),
      SchemaProperty('edcFeatureTestCases', RealmPropertyType.object,
          linkTarget: 'JobOrderEdcFeatureTestCase',
          collectionType: RealmCollectionType.list),
      SchemaProperty('synced', RealmPropertyType.bool),
      SchemaProperty('uploadDate', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('sam', RealmPropertyType.string, optional: true),
      SchemaProperty('endSla', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('sam2', RealmPropertyType.string, optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('replacements', RealmPropertyType.object,
          linkTarget: 'JobOrderReplacement',
          collectionType: RealmCollectionType.list),
      SchemaProperty('requiredThermalCount', RealmPropertyType.string,
          optional: true),
      SchemaProperty('sam3', RealmPropertyType.string, optional: true),
      SchemaProperty('machineConditionNormal', RealmPropertyType.bool),
      SchemaProperty('sam4', RealmPropertyType.string, optional: true),
      SchemaProperty('serialNumberMandatoryType', RealmPropertyType.string),
      SchemaProperty('jobCategories', RealmPropertyType.object,
          linkTarget: 'JobOrderJobCategory',
          collectionType: RealmCollectionType.list),
      SchemaProperty('serialNumberValidationType', RealmPropertyType.string),
      SchemaProperty('sam5', RealmPropertyType.string, optional: true),
      SchemaProperty('imageMandatoryType', RealmPropertyType.string),
      SchemaProperty('latitude', RealmPropertyType.string, optional: true),
      SchemaProperty('longitude', RealmPropertyType.string, optional: true),
      SchemaProperty('jamBukaToko', RealmPropertyType.string, optional: true),
      SchemaProperty('jamTutupToko', RealmPropertyType.string, optional: true),
      SchemaProperty('edcCount', RealmPropertyType.int, optional: true),
      SchemaProperty('sam6', RealmPropertyType.string, optional: true),
      SchemaProperty('documentStatus', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderDocumentStatus'),
      SchemaProperty('sent', RealmPropertyType.bool),
      SchemaProperty('damageType', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderDamageType'),
      SchemaProperty('sam7', RealmPropertyType.string, optional: true),
      SchemaProperty('servicePoint', RealmPropertyType.object,
          optional: true, linkTarget: 'JobOrderServicePoint'),
      SchemaProperty('cmRemark', RealmPropertyType.string, optional: true),
      SchemaProperty('jobType', RealmPropertyType.object,
        optional: true, linkTarget: 'JobOrderJobType',),
      // New Value
      SchemaProperty('edcCleaning', RealmPropertyType.string, optional: true),
      SchemaProperty('edcProblem', RealmPropertyType.string, optional: true),
      SchemaProperty('comLine', RealmPropertyType.string, optional: true),
      SchemaProperty('settlement', RealmPropertyType.string, optional: true),
      SchemaProperty('signalBar', RealmPropertyType.string, optional: true),
      SchemaProperty('priorityEdc', RealmPropertyType.string, optional: true),
      SchemaProperty('merchantComment', RealmPropertyType.string, optional: true),
      SchemaProperty('mostUsedEdc', RealmPropertyType.string, optional: true),
      SchemaProperty('otherEdc', RealmPropertyType.string, optional: true),
      SchemaProperty('merchantRequest', RealmPropertyType.string, optional: true),
      SchemaProperty('promoMaterial', RealmPropertyType.string, optional: true),
      SchemaProperty('position', RealmPropertyType.string, optional: true),
    ]);
  }
}
