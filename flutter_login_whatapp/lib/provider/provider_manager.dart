import 'package:flutter_login_whatapp/models/shop/product.dart';
import 'package:flutter_login_whatapp/provider/shop_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalController = StateNotifierProvider<CounterNotifier,int>((ref) => CounterNotifier());

final counterController = StateNotifierProvider<CounterNotifier,int>((ref){
  final counter = ref.watch(totalController.notifier);
  return counter;
});

