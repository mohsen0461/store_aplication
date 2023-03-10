import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_aplication/common/exception.dart';
import 'package:store_aplication/data/banner.dart';
import 'package:store_aplication/data/product.dart';
import 'package:store_aplication/data/repo/baner_repository.dart';
import 'package:store_aplication/data/repo/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  HomeBloc({required this.bannerRepository, required this.productRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());

          Future.delayed(const Duration(seconds: 1));

          final banners = await bannerRepository.getAllBanner();
          final latestProducts =
              await productRepository.getAll(ProductSort.latest);
          final popularProducts =
              await productRepository.getAll(ProductSort.popular);
          emit(HomeSuccess(
              banners: banners,
              latestProducts: latestProducts,
              popularProducts: popularProducts));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
