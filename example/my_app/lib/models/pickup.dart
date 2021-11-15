import 'package:image_picker/image_picker.dart';

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
    required this.status,
    required this.type,
    required this.address,
    required this.user,
    required this.phoneNumber,
    required this.level,
    required this.timestamp,
    required this.bookingId,
  });
  late final List<PackageInfo> packageInfo;
  late final String status;
  late final String type;
  late final Address address;
  late final String user;
  late final String phoneNumber;
  late final String level;
  late final String timestamp;
  late final String bookingId;

  BookingDetail.fromJson(Map<String, dynamic> json) {
    packageInfo = List.from(json['package_info'])
        .map((e) => PackageInfo.fromJson(e))
        .toList();
    status = json['status'];
    type = json['type'];
    address = Address.fromJson(json['address']);
    user = json['user'];
    phoneNumber = json['phone_number'];
    level = json['level'];
    timestamp = json['timestamp'];
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['package_info'] = packageInfo.map((e) => e.toJson()).toList();
    _data['status'] = status;
    _data['type'] = type;
    _data['address'] = address.toJson();
    _data['user'] = user;
    _data['phone_number'] = phoneNumber;
    _data['level'] = level;
    _data['timestamp'] = timestamp;
    _data['booking_id'] = bookingId;
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
    required this.estimatePrice,
    this.status = false,
    this.fixedPrice = 0,
    this.image,
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
  late final int estimatePrice;
  late final bool status;
  late final int fixedPrice;
  late final XFile? image;

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
    status = json['status'] ?? false;
    estimatePrice = json['estimate_price'];
    fixedPrice = json['fixed_price'] ?? json['estimate_price'];
    image = json['image'];
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
    _data['status'] = status;
    _data['estimate_price'] = estimatePrice;
    _data['fixed_price'] = fixedPrice;
    _data['image'] = image;
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

class CheckPriceBody {
  CheckPriceBody({
    required this.weight,
    required this.length,
    required this.width,
    required this.height,
    required this.serviceId,
    required this.destinationId,
  });
  late final int weight;
  late final int length;
  late final int width;
  late final int height;
  late final int serviceId;
  late final int destinationId;

  CheckPriceBody.fromJson(Map<String, dynamic> json) {
    weight = json['goods_weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    serviceId = json['service_id'];
    destinationId = json['destination_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['weight'] = weight;
    _data['length'] = length;
    _data['width'] = width;
    _data['height'] = height;
    _data['service_id'] = 1;
    _data['destination_id'] = 25030;
    return _data;
  }
}

class CheckPriceRespone {
  CheckPriceRespone({
    required this.realWeight,
    required this.serviceCost,
    required this.estTime,
    required this.minKg,
    required this.cod,
    required this.originalCost,
    required this.gocengActive,
  });
  late final int realWeight;
  late final int serviceCost;
  late final int estTime;
  late final int minKg;
  late final bool cod;
  late final int originalCost;
  late final bool gocengActive;

  CheckPriceRespone.fromJson(Map<String, dynamic> json) {
    realWeight = json['real_weight'];
    serviceCost = json['service_cost'];
    estTime = json['est_time'];
    minKg = json['min_kg'];
    cod = json['cod'];
    originalCost = json['original_cost'];
    gocengActive = json['goceng_active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['real_weight'] = realWeight;
    _data['service_cost'] = serviceCost;
    _data['est_time'] = estTime;
    _data['min_kg'] = minKg;
    _data['cod'] = cod;
    _data['original_cost'] = originalCost;
    _data['goceng_active'] = gocengActive;
    return _data;
  }
}

class ContentList {
  ContentList({
    required this.id,
    required this.name,
    required this.pcpContentTypeId,
    required this.status,
  });
  late final int id;
  late final String name;
  late final int pcpContentTypeId;
  late final bool status;

  ContentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pcpContentTypeId = json['pcp_content_type_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['pcp_content_type_id'] = pcpContentTypeId;
    _data['status'] = status;
    return _data;
  }
}

class CheckOutDriverBody {
  CheckOutDriverBody({
    required this.amount,
    required this.service,
    required this.source,
    required this.client,
  });
  late final int amount;
  late final String service;
  late final String source;
  late final String client;

  CheckOutDriverBody.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    service = json['service'];
    source = json['source'];
    client = json['client'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['amount'] = amount;
    _data['service'] = service;
    _data['source'] = source;
    _data['client'] = client;
    return _data;
  }
}

class CheckOutDriverRespone {
  CheckOutDriverRespone({
    required this.invoice,
    this.paymentUrl,
  });
  late final String invoice;
  late final String? paymentUrl;

  CheckOutDriverRespone.fromJson(Map<String, dynamic> json) {
    invoice = json['invoice'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['invoice'] = invoice;
    _data['payment_url'] = paymentUrl;
    return _data;
  }
}

class WaybillCreateBody {
  WaybillCreateBody({
    required this.destinationId,
    required this.serviceId,
    required this.senderName,
    required this.senderAddress,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.goodsId,
    required this.goodsDesc,
    required this.goodsValue,
    required this.goodsWeight,
    required this.length,
    required this.width,
    required this.height,
    required this.notesInstructions,
    this.senderLat,
    this.senderLong,
    this.receiverLat,
    this.receiverLong,
    required this.driverId,
    required this.paymentType,
  });
  late final int destinationId;
  late final int serviceId;
  late final String senderName;
  late final String senderAddress;
  late final String senderPhone;
  late final String receiverName;
  late final String receiverPhone;
  late final String receiverAddress;
  late final int goodsId;
  late final String goodsDesc;
  late final int goodsValue;
  late final int goodsWeight;
  late final int length;
  late final int width;
  late final int height;
  late final String notesInstructions;
  late final double? senderLat;
  late final double? senderLong;
  late final double? receiverLat;
  late final double? receiverLong;
  late final String driverId;
  late final String paymentType;

  WaybillCreateBody.fromJson(Map<String, dynamic> json) {
    destinationId = json['destination_id'];
    serviceId = json['service_id'];
    senderName = json['sender_name'];
    senderAddress = json['sender_address'];
    senderPhone = json['sender_phone'];
    receiverName = json['receiver_name'];
    receiverPhone = json['receiver_phone'];
    receiverAddress = json['receiver_address'];
    goodsId = json['goods_id'];
    goodsDesc = json['goods_desc'];
    goodsValue = json['goods_value'];
    goodsWeight = json['goods_weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    notesInstructions = json['notes'];
    senderLat = json['sender_lat'] ?? 0;
    senderLong = json['sender_long'] ?? 0;
    receiverLat = json['receiver_lat'] ?? 0;
    receiverLong = json['receiver_long'] ?? 0;
    driverId = json['driver_id'];
    paymentType = json['payment_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['destination_id'] = destinationId;
    _data['service_id'] = serviceId;
    _data['sender_name'] = senderName;
    _data['sender_address'] = senderAddress;
    _data['sender_phone'] = senderPhone;
    _data['receiver_name'] = receiverName;
    _data['receiver_phone'] = receiverPhone;
    _data['receiver_address'] = receiverAddress;
    _data['goods_id'] = goodsId;
    _data['goods_desc'] = goodsDesc;
    _data['goods_value'] = goodsValue;
    _data['goods_weight'] = goodsWeight;
    _data['length'] = length;
    _data['width'] = width;
    _data['height'] = height;
    _data['notes_instructions'] = notesInstructions;
    _data['sender_lat'] = senderLat;
    _data['sender_long'] = senderLong;
    _data['receiver_lat'] = receiverLat;
    _data['receiver_long'] = receiverLong;
    _data['driver_id'] = driverId;
    _data['payment_type'] = paymentType;
    return _data;
  }
}

class WaybilCreateRespone {
  WaybilCreateRespone({
    required this.waybillNumber,
    required this.message,
  });
  late final String waybillNumber;
  late final String message;

  WaybilCreateRespone.fromJson(Map<String, dynamic> json) {
    waybillNumber = json['waybill_number'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['waybill_number'] = waybillNumber;
    _data['message'] = message;
    return _data;
  }
}
