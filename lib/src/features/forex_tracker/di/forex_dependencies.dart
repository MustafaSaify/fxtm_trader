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
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_price_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/domain/usecase/forex_symbols_usecase.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/bloc/forex_list_bloc.dart';
import 'package:fxtm_trader/src/features/forex_tracker/presentation/components/price_widget/bloc/forex_price_bloc.dart';
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
  getIt.registerFactory<ForexSymbolsUsecase>(() => ForexSymbolsUsecaseImpl(
      symbolsRepository: getIt<ForexSymbolsRepository>()));

  // ForexItesDisplayMapper
  getIt.registerFactory<ForexItemDisplayMapper>(
      () => ForexItemDisplayMapperImpl());

  // ForexListBloc
  getIt.registerFactory<ForexListBloc>(() => ForexListBloc(
      forexSymbolsUsecase: getIt<ForexSymbolsUsecase>(),
      forexPriceUsecase: getIt<ForexPriceUsecase>(),
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
  getIt.registerFactory<ForexPriceUsecase>(() =>
      ForexPriceUsecaseImpl(repository: getIt<ForexPriceSocketRepository>()));

  // ForexPriceBloc
  getIt.registerFactory<ForexPriceBloc>(
      () => ForexPriceBloc(forexPriceUsecase: getIt<ForexPriceUsecase>()));
}
