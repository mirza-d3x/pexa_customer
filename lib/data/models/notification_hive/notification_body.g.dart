// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_body.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationBodyAdapter extends TypeAdapter<NotificationBody> {
  @override
  final int typeId = 1;

  @override
  NotificationBody read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationBody(
      notificationType: fields[0] as NotificationType?,
      orderId: fields[2] as String?,
      orderDocId: fields[1] as String?,
      serviceName: fields[3] as String?,
      serviceType: fields[4] as MainCategory?,
      happyCode: fields[5] as String?,
      productName: fields[6] as String?,
    )
      ..serviceTypeString = fields[7] as String?
      ..notificationTypeString = fields[8] as String?;
  }

  @override
  void write(BinaryWriter writer, NotificationBody obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.notificationType)
      ..writeByte(1)
      ..write(obj.orderDocId)
      ..writeByte(2)
      ..write(obj.orderId)
      ..writeByte(3)
      ..write(obj.serviceName)
      ..writeByte(4)
      ..write(obj.serviceType)
      ..writeByte(5)
      ..write(obj.happyCode)
      ..writeByte(6)
      ..write(obj.productName)
      ..writeByte(7)
      ..write(obj.serviceTypeString)
      ..writeByte(8)
      ..write(obj.notificationTypeString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationBodyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
