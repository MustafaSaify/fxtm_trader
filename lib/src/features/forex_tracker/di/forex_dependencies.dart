import 'package:dio/dio.dart';
import 'package:fxtm_trader/src/core/network/network_client.dart';
import 'package:fxtm_trader/src/core/network/network_client_impl.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/local/price_local_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/price_socket_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/forex_symbols_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/repository/forex_price_socket_repository_impl.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/repository/forex_symbols_repository_impl.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/forex_symbols_repository.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/repository/price_stream_repository.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/get_forex_prices_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/get_forex_symbols_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/mappers/forex_item_display_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupForexDependencies() {
  // Dio
  getIt.registerSingleton<Dio>(Dio());

  // Network Client
  getIt.registerFactory<NetworkClient>(() => NetworkClientImpl());

  // ForexSymbolsRemoteDataSource
  getIt.registerFactory<ForexSymbolsRemoteDataSource>(() =>
      ForexSymbolsRemoteDataSourceImpl(networkClient: getIt<NetworkClient>()));

  // ForexSymbolsRepository
  getIt.registerFactory<ForexSymbolsRepository>(() =>
      ForexSymbolsRepositoryImpl(
          remoteDataSource: getIt<ForexSymbolsRemoteDataSource>()));

  // ForexSymbolsUsecase
  getIt.registerFactory<GetForexSymbolsUsecase>(() =>
      GetForexSymbolsUsecaseImpl(
          symbolsRepository: getIt<ForexSymbolsRepository>()));

  // ForexItesDisplayMapper
  getIt.registerFactory<ForexItemDisplayMapper>(
      () => ForexItemDisplayMapperImpl());

  // ForexListBloc
  getIt.registerFactory<ForexListBloc>(() => ForexListBloc(
      getForexSymbolsUsecase: getIt<GetForexSymbolsUsecase>(),
      getForexPriceUsecase: getIt<GetForexPricesUsecase>(),
      displayMapper: getIt<ForexItemDisplayMapper>()));

  // PriceSocketRemoteDataSource - Singleton
  getIt.registerLazySingleton<PriceSocketRemoteDataSource>(
      () => PriceSocketRemoteDataSourceImpl());

  // PriceLocalDataSource
  getIt.registerFactory<PriceLocalDataSource>(() => PriceLocalDataSourceImpl());

  // ForexPriceSocketRepository - Singleton
  getIt.registerLazySingleton<ForexPriceSocketRepository>(() =>
      ForexPriceSocketRepositoryImpl(
          priceSocketRemoteDataSource: getIt<PriceSocketRemoteDataSource>(),
          priceLocalDataSource: getIt<PriceLocalDataSource>()));

  // ForexPriceUsecase
  getIt.registerFactory<GetForexPricesUsecase>(() => GetForexPricesUsecaseImpl(
      repository: getIt<ForexPriceSocketRepository>()));
}
