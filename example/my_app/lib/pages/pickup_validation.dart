import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:my_app/models/pickup.dart';
import 'package:my_app/pages/pickup_detail.dart';
import 'package:my_app/services/onrest.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PickUpValidation extends StatefulWidget {
  final PackageInfo packageInfo;

  const PickUpValidation({
    required this.packageInfo,
    Key? key,
  }) : super(key: key);

  @override
  PickupValidationState createState() => PickupValidationState();
}

class PickupValidationState extends State<PickUpValidation> {
  TextEditingController inputController = TextEditingController();
  FormGroup buildForm() => fb.group(<String, Object>{
        'destination_id': [
          widget.packageInfo.destinationId,
          Validators.required
        ],
        'service_id': [widget.packageInfo.serviceId, Validators.required],
        'sender_name': [widget.packageInfo.senderName, Validators.required],
        'sender_phone': [widget.packageInfo.senderPhone, Validators.required],
        'sender_address': [
          widget.packageInfo.senderAddress,
          Validators.required
        ],
        'receiver_name': [widget.packageInfo.receiverName, Validators.required],
        'receiver_phone': [
          widget.packageInfo.receiverPhone,
          Validators.required
        ],
        'receiver_address': [
          widget.packageInfo.receiverAddress,
          Validators.required
        ],
        'goods_id': [widget.packageInfo.goodsId, Validators.required],
        'goods_desc': [widget.packageInfo.goodsDesc],
        'goods_weight': FormControl<int>(
            value: widget.packageInfo.goodsWeight,
            validators: [Validators.required, Validators.max(10000000)]),
        'length': [
          widget.packageInfo.length,
        ],
        'width': [widget.packageInfo.width],
        'height': [widget.packageInfo.height],
        'notes': [widget.packageInfo.notes],
        'insurance_exist': [
          widget.packageInfo.insuranceExist,
          Validators.required
        ],
        'goods_value': [widget.packageInfo.goodsValue],
        'estimate_price': [
          widget.packageInfo.estimatePrice,
          Validators.required
        ],
        'fixed_price': [widget.packageInfo.fixedPrice, Validators.required],
      });

  late Timer _debounce = Timer(const Duration(milliseconds: 500), () {});
  bool _isInAsyncCall = true;
  _onSearchChanged(FormGroup form) {
    print("ABCD");
    if (_debounce.isActive) _debounce.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      OnRest.instance
          .checkPrice(CheckPriceBody.fromJson(form.value))
          .then((value) {
        if (counter == 0) {
          setState(() {
            form.control('fixed_price').patchValue(value.serviceCost);
          });
        } else {
          form.control('fixed_price').patchValue(value.serviceCost);
        }
        form.control('fixed_price').updateValueAndValidity();
        form.control('fixed_price').markAllAsTouched();
        form.control('fixed_price').markAsDirty();
        counter++;
      });
    });
  }

  int counter = 0;
  late FormGroup formGroup = buildForm();
  @override
  void initState() {
    super.initState();

    OnRest.instance.contentListType().then((value) {
      setState(() {
        listContent = value
            .map((e) => DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                ))
            .toList();
        _isInAsyncCall = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _debounce.cancel();
  }

  final int _value = 1;
  bool usingVolume = true;
  List<DropdownMenuItem<int>> listContent = [];

  List<Widget> volumetricForm(FormGroup form) {
    validatorsVolumetric(form, true);
    return [
      const Text('Panjang : '),
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: ReactiveTextField<int>(
              formControlName: 'length',
              decoration: InputDecoration(
                hintText: 'Panjang',
                filled: true,
                contentPadding:
                    const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
              validationMessages: (errors) => {
                ValidationMessage.required: 'Panjang tidak boleh kosong',
                ValidationMessage.max:
                    'Panjang yang anda masukkan terlalu banyak'
              },
            )),
      ),
      const Text('Lebar : '),
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: ReactiveTextField<int>(
              formControlName: 'width',
              decoration: InputDecoration(
                hintText: 'Lebar',
                filled: true,
                contentPadding:
                    const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
              validationMessages: (errors) => {
                ValidationMessage.required: 'Lebar tidak boleh kosong',
                ValidationMessage.max:
                    'Panjang yang anda masukkan terlalu banyak'
              },
            )),
      ),
      const Text('Tinggi : '),
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.08,
            child: ReactiveTextField<int>(
              formControlName: 'height',
              decoration: InputDecoration(
                hintText: 'Tinggi',
                filled: true,
                contentPadding:
                    const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
              validationMessages: (errors) => {
                ValidationMessage.required: 'Tinggi tidak boleh kosong',
                ValidationMessage.max:
                    'Panjang yang anda masukkan terlalu banyak'
              },
            )),
      ),
    ];
  }

  late final AsyncMemoizer<dynamic> _memoizer = AsyncMemoizer();

  validatorsVolumetric(FormGroup form, bool isAdd) {
    List<String> list = ["length", 'width', 'height'];
    for (var item in list) {
      if (isAdd) {
        form
            .control(item)
            .setValidators([Validators.required, Validators.max(10000000)]);
      } else {
        form.control(item).clearValidators();
      }
      form.control(item).markAsDirty();
      form.control(item).updateValueAndValidity();
    }
  }

  final ImagePicker _picker = ImagePicker();
  late XFile _imageFile = XFile('');
  dynamic _pickImageError;

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 250,
        maxHeight: 250,
      );
      setState(() {
        _imageFile = pickedFile!;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: const Text("Validasi Informasi"),
        ),
        body: ModalProgressHUD(
          child: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                List<String> watchs = [
                  "goods_weight",
                  "length",
                  'width',
                  'height'
                ];
                // _memoizer.runOnce(() {
                //   for (var item in watchs) {
                //     print(item);
                //     form
                //         .control(item)
                //         .valueChanges
                //         .listen(_onSearchChanged(form));
                //   }
                // });
                for (var item in watchs) {
                  // print(item);
                  form
                      .control(item)
                      .valueChanges
                      .listen(_onSearchChanged(form));
                }
                return SingleChildScrollView(
                  child: Container(
                      color: Colors.grey[200],
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              30.0,
                              30.0,
                              30.0,
                              MediaQuery.of(context).viewInsets.bottom == 0
                                  ? 10.0
                                  : MediaQuery.of(context).viewInsets.bottom),
                          // padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text("Penerima",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Nama : '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child:
                                                      ReactiveTextField<String>(
                                                    formControlName:
                                                        'sender_name',
                                                    decoration: InputDecoration(
                                                      hintText: 'Nama',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Nama tidak boleh kosong',
                                                    },
                                                  )),
                                            ),
                                            const Text('Nomor Telephone: '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child:
                                                      ReactiveTextField<String>(
                                                    formControlName:
                                                        'sender_phone',
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Nomor Telephone',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Nomor Telephone tidak boleh kosong',
                                                    },
                                                  )),
                                            ),
                                            const Text('Alamat : '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child:
                                                      ReactiveTextField<String>(
                                                    formControlName:
                                                        'sender_address',
                                                    decoration: InputDecoration(
                                                      hintText: 'Alamat',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Alamat tidak boleh kosong',
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text("Pengirim",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Nama : '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child:
                                                      ReactiveTextField<String>(
                                                    formControlName:
                                                        'receiver_name',
                                                    decoration: InputDecoration(
                                                      hintText: 'Nama',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Nama tidak boleh kosong',
                                                    },
                                                  )),
                                            ),
                                            const Text('Nomor Telephone: '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child:
                                                      ReactiveTextField<String>(
                                                    formControlName:
                                                        'receiver_phone',
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Nomor Telephone',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Nomor Telephone tidak boleh kosong',
                                                    },
                                                  )),
                                            ),
                                            const Text('Alamat : '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child:
                                                      ReactiveTextField<String>(
                                                    formControlName:
                                                        'receiver_address',
                                                    decoration: InputDecoration(
                                                      hintText: 'Alamat',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Alamat tidak boleh kosong',
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Row(
                                        children: [
                                          const Text("Barang",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold)),
                                          const Spacer(),
                                          const Text("Using Volumetric",
                                              style: TextStyle(
                                                fontSize: 13,
                                              )),
                                          Checkbox(
                                            value: usingVolume,
                                            onChanged: (bool? value) {
                                              if (!value!) {
                                                validatorsVolumetric(
                                                    form, false);
                                              }
                                              setState(() {
                                                usingVolume = value;
                                              });
                                            },
                                          ),
                                        ],
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Berat : '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child: ReactiveTextField<int>(
                                                    formControlName:
                                                        'goods_weight',
                                                    decoration: InputDecoration(
                                                      hintText: 'Berat',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Berat tidak boleh kosong',
                                                      ValidationMessage.max:
                                                          'Berat yang anda masukkan terlalu banyak'
                                                    },
                                                  )),
                                            ),
                                            if (usingVolume)
                                              ...volumetricForm(form),
                                            const Text('Deskripsi : '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child:
                                                      ReactiveTextField<String>(
                                                    formControlName:
                                                        'goods_desc',
                                                    decoration: InputDecoration(
                                                      hintText: 'Deskripsi',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Deskripsi tidak boleh kosong'
                                                    },
                                                  )),
                                            ),
                                            const Text('Content Type : '),
                                            ReactiveDropdownField(
                                                formControlName: 'goods_id',
                                                decoration: InputDecoration(
                                                  hintText: 'Berat',
                                                  filled: true,
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          10.0,
                                                          10.0,
                                                          20.0,
                                                          10.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  fillColor: Colors.white,
                                                ),
                                                items: listContent),
                                            Row(
                                              children: [
                                                ReactiveCheckbox(
                                                    formControlName:
                                                        'insurance_exist'),
                                                const Text("Insurance",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                // validatorsInsurance(form)
                                                ReactiveStatusListenableBuilder(
                                                    formControlName:
                                                        'insurance_exist',
                                                    builder: (context, control,
                                                        child) {
                                                      debugPrint(form.value
                                                          .toString());
                                                      // if (form
                                                      //             .control(
                                                      //                 'insurance_exist')
                                                      //             .value
                                                      //             .toString()
                                                      //             .toLowerCase() ==
                                                      //         'true' &&
                                                      //     form
                                                      //             .control(
                                                      //                 'goods_value')
                                                      //             .value ==
                                                      //         0) {
                                                      //   form
                                                      //       .control(
                                                      //           'goods_value')
                                                      //       .setValidators([
                                                      //     Validators.required
                                                      //   ]);

                                                      //   form
                                                      //       .control(
                                                      //           'goods_value')
                                                      //       .patchValue(0);
                                                      // } else if (form
                                                      //         .control(
                                                      //             'insurance_exist')
                                                      //         .value
                                                      //         .toString()
                                                      //         .toLowerCase() ==
                                                      //     'false') {
                                                      //   form
                                                      //       .control(
                                                      //           'goods_value')
                                                      //       .clearValidators();
                                                      //   form
                                                      //       .control(
                                                      //           'goods_value')
                                                      //       .patchValue(0);
                                                      // }
                                                      // form
                                                      //     .control(
                                                      //         'goods_value')
                                                      //     .markAsDirty();
                                                      // form
                                                      //     .control(
                                                      //         'goods_value')
                                                      //     .updateValueAndValidity();
                                                      return Visibility(
                                                        visible: form
                                                                .control(
                                                                    'insurance_exist')
                                                                .value
                                                                .toString()
                                                                .toLowerCase() ==
                                                            'true',
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                                'Nilai Barang : '),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5,
                                                                      bottom:
                                                                          5),
                                                              child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.53,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.08,
                                                                  child:
                                                                      ReactiveTextField<
                                                                          int>(
                                                                    formControlName:
                                                                        'goods_value',
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'Nilai Barang',
                                                                      filled:
                                                                          true,
                                                                      contentPadding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          10.0,
                                                                          10.0,
                                                                          20.0,
                                                                          10.0),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0)),
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    validationMessages:
                                                                        (errors) =>
                                                                            {
                                                                      ValidationMessage
                                                                              .required:
                                                                          'Nilai Barang tidak boleh kosong',
                                                                    },
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text("Informasi Lainnya :",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Notes : '),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08,
                                                  child:
                                                      ReactiveTextField<String>(
                                                    formControlName: 'notes',
                                                    decoration: InputDecoration(
                                                      hintText: 'Notes',
                                                      filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              10.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      fillColor: Colors.white,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validationMessages:
                                                        (errors) => {
                                                      ValidationMessage
                                                              .required:
                                                          'Notes tidak boleh kosong'
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text("Biaya Lama :",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 5),
                                      child: Text(
                                          "Rp. " +
                                              form
                                                  .control('estimate_price')
                                                  .value
                                                  .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ))),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text("Biaya Baru :",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 5),
                                      child: Text(
                                          "Rp. " +
                                              form
                                                  .control('fixed_price')
                                                  .value
                                                  .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ))),
                                  _imageFile.path != ''
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Semantics(
                                              label:
                                                  'image_picker_example_picked_image',
                                              child: Image.file(
                                                  File(_imageFile.path)),
                                            )
                                          ],
                                        )
                                      : const Text(""),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                          onPressed: () {
                                            _onImageButtonPressed(
                                                ImageSource.camera,
                                                context: context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: <Color>[
                                                    Color(0xFF1254A0),
                                                    Color(0xFF15bae8),
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                                child: Text('Pick Image',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 12))),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              MaterialButton(
                                  onPressed: form.valid
                                      ? () {
                                          print(form.value);
                                          Navigator.of(context).pop(
                                              PackageInfo.fromJson({
                                            ...form.value,
                                            'status': true,
                                            'image': _imageFile
                                          }));
                                        }
                                      : null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: <Color>[
                                            Color(0xFF1254A0),
                                            Color(0xFF15bae8),
                                          ]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                        child: Text('Konfirmasi',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 12))),
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  )),
                            ],
                          ))),
                );
              }),
          inAsyncCall: _isInAsyncCall,
          // demo of some additional parameters
          opacity: 0.5,
          progressIndicator: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator.adaptive(),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading ...'),
              )
            ],
          ),
        ));
  }
}

class TextFormFieldRegular extends StatelessWidget {
  const TextFormFieldRegular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
