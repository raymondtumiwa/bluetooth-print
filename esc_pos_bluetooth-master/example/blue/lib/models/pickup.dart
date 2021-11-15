class Booking {
  Booking({
    required this.bookingId,
    required this.phoneNumber,
    required this.fullAddress,
    required this.createdAt,
  });
  late final String bookingId;
  late final String phoneNumber;
  late final String fullAddress;
  late final String createdAt;

  Booking.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    phoneNumber = json['phone_number'];
    fullAddress = json['full_address'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['booking_id'] = bookingId;
    _data['phone_number'] = phoneNumber;
    _data['full_address'] = fullAddress;
    _data['created_at'] = createdAt;
    return _data;
  }
}

class StatusDriver {
  StatusDriver({
    required this.bookingId,
  });
  late final String bookingId;

  StatusDriver.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['booking_id'] = bookingId;
    return _data;
  }

  bool checkIfAnyIsNull(jsonDecode) {
    return [bookingId].contains(null);
  }
}

class BookingDetail {
  BookingDetail({
    required this.packageInfo,
    required this.type,
    required this.timestamp,
    required this.status,
    required this.address,
    required this.invoice,
    required this.user,
    required this.phoneNumber,
    required this.level,
  });
  late final List<PackageInfo> packageInfo;
  late final String type;
  late final String timestamp;
  late final String status;
  late final Address address;
  late final String invoice;
  late final String user;
  late final String phoneNumber;
  late final String level;

  BookingDetail.fromJson(Map<String, dynamic> json) {
    packageInfo = List.from(json['package_info'])
        .map((e) => PackageInfo.fromJson(e))
        .toList();
    type = json['type'];
    timestamp = json['timestamp'];
    status = json['status'];
    address = Address.fromJson(json['address']);
    invoice = json['invoice'];
    user = json['user'];
    phoneNumber = json['phone_number'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['package_info'] = packageInfo.map((e) => e.toJson()).toList();
    _data['type'] = type;
    _data['timestamp'] = timestamp;
    _data['status'] = status;
    _data['address'] = address.toJson();
    _data['invoice'] = invoice;
    _data['user'] = user;
    _data['phone_number'] = phoneNumber;
    _data['level'] = level;
    return _data;
  }
}

class PackageInfo {
  PackageInfo({
    required this.destinationId,
    required this.serviceId,
    required this.senderName,
    required this.senderPhone,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.goodsId,
    required this.goodsDesc,
    required this.goodsWeight,
    required this.length,
    required this.width,
    required this.height,
    required this.notes,
    required this.insuranceExist,
    required this.goodsValue,
  });
  late final int destinationId;
  late final int serviceId;
  late final String senderName;
  late final String senderPhone;
  late final String senderAddress;
  late final String receiverName;
  late final String receiverPhone;
  late final String receiverAddress;
  late final int goodsId;
  late final String goodsDesc;
  late final int goodsWeight;
  late final int length;
  late final int width;
  late final int height;
  late final String notes;
  late final bool insuranceExist;
  late final int goodsValue;

  PackageInfo.fromJson(Map<String, dynamic> json) {
    destinationId = json['destination_id'];
    serviceId = json['service_id'];
    senderName = json['sender_name'];
    senderPhone = json['sender_phone'];
    senderAddress = json['sender_address'];
    receiverName = json['receiver_name'];
    receiverPhone = json['receiver_phone'];
    receiverAddress = json['receiver_address'];
    goodsId = json['goods_id'];
    goodsDesc = json['goods_desc'];
    goodsWeight = json['goods_weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    notes = json['notes'];
    insuranceExist = json['insurance_exist'];
    goodsValue = json['goods_value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['destination_id'] = destinationId;
    _data['service_id'] = serviceId;
    _data['sender_name'] = senderName;
    _data['sender_phone'] = senderPhone;
    _data['sender_address'] = senderAddress;
    _data['receiver_name'] = receiverName;
    _data['receiver_phone'] = receiverPhone;
    _data['receiver_address'] = receiverAddress;
    _data['goods_id'] = goodsId;
    _data['goods_desc'] = goodsDesc;
    _data['goods_weight'] = goodsWeight;
    _data['length'] = length;
    _data['width'] = width;
    _data['height'] = height;
    _data['notes'] = notes;
    _data['insurance_exist'] = insuranceExist;
    _data['goods_value'] = goodsValue;
    return _data;
  }
}

class Address {
  Address({
    required this.lat,
    required this.long,
    required this.urbanId,
    required this.subDistrictId,
    required this.cityId,
    required this.fullAddress,
  });
  late final double lat;
  late final double long;
  late final int urbanId;
  late final int subDistrictId;
  late final int cityId;
  late final String fullAddress;

  Address.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    urbanId = json['urban_id'];
    subDistrictId = json['sub_district_id'];
    cityId = json['city_id'];
    fullAddress = json['full_address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['long'] = long;
    _data['urban_id'] = urbanId;
    _data['sub_district_id'] = subDistrictId;
    _data['city_id'] = cityId;
    _data['full_address'] = fullAddress;
    return _data;
  }
}
