import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

///O in most cases is List<I>
///I is input single object which has a db box of Box<I>
mixin StreamListener<I> on GetxController {
  late BehaviorSubject<List<I>> _streamListener;

  final Duration _throttleTime = const Duration(milliseconds: 500);
  final RxList<I> items = RxList<I>.empty();
  void _init() {
    _streamListener = BehaviorSubject<List<I>>();
    _streamListener
        .throttleTime(_throttleTime, leading: false, trailing: true)
        .map<List<I>>(streamFilter)
        .listen((rawData) {
      updateData(rawData);
    });
    setupSubscriptions();
  }

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  ///loads if on first run data is empty
  Future<void> onStartEmpty() async {
    return;
  }

  List<Box<I>?> boxesToListenTo();

  Future<void> setupSubscriptions() async {
    Box<I>? originalDataBox;
    for (final box in boxesToListenTo()) {
      if (box is Box<I>) {
        originalDataBox = box;
        _streamListener.add(box.values.toList());
      }
      box?.listenable().addListener(() {
        if (_streamListener.isClosed) {
          return;
        }
        if (box is Box<I>) {
          _streamListener.add(box.values.toList());
        } else {
          if (originalDataBox != null) {
            _streamListener.add(originalDataBox.values.toList());
          }
        }
      });
    }

    if (_streamListener.hasValue) {
      await onStartEmpty();
    }
  }

  Future<void> _dispose() async {
    await _streamListener.drain<List<I>>();
    await _streamListener.close();
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }

  void addToStream(I newItem) {
    _streamListener.add(_streamListener.value.toList()..add(newItem));
  }

  List<I> streamFilter(List<I> event) {
    return event;
  }

  void updateData(List<I> rawData) {
    final equals = const DeepCollectionEquality().equals(items, rawData);
    if (!equals) {
      items.assignAll(rawData);
    }

    return;
  }
}
