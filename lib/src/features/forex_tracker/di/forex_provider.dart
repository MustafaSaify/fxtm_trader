import 'package:dio/dio.dart';
import 'package:fxtm_trader/src/core/network/network_client.dart';
import 'package:fxtm_trader/src/core/network/network_client_impl.dart';
import 'package:fxtm_trader/src/features/forex_tracker/data/datasource/remote/price_socket_datasource.dart';
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

void setupForex() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerLazySingleton<PriceSocketDataSource>(() => PriceSocketDataSourceImpl());
  getIt.registerFactory<ForexPriceSocketRepository>(
      () => ForexPriceSocketRepositoryImpl(getIt()));
  getIt
      .registerFactory<ForexPriceUsecase>(() => ForexPriceUsecaseImpl(getIt()));
  getIt.registerFactory<ForexPriceBloc>(() => ForexPriceBloc(getIt()));
}

class ForexListProvider {
  ForexListScreenBloc initForexListBloc() {
    return ForexListScreenBloc(
      forexSymbolsUsecase: _getForexSymbolsUsecase(),
      forexItemDisplayMapper: _getForexDisplayMapper()
    );
  }

  ForexSymbolsUsecase _getForexSymbolsUsecase() {
    return ForexSymbolsUsecaseImpl(
        symbolsRepository: _getForexSymbolsRepository());
  }

  ForexSymbolsRepository _getForexSymbolsRepository() {
    return ForexSymbolsRepositoryImpl(
        remoteDataSource: _getForexSymbolsRemoteDataSource());
  }

  ForexSymbolsRemoteDataSource _getForexSymbolsRemoteDataSource() {
    return ForexSymbolsRemoteDataSourceImpl(networkClient: _getNetworkClient());
  }

  NetworkClient _getNetworkClient() {
    return NetworkClientImpl();
  }

  ForexItemDisplayMapper _getForexDisplayMapper() {
    return ForexItemDisplayMapperImpl();
  }
}

// class ForexPriceProvider {
//   ForexPriceBloc initForexPriceBloc() {
//     return ForexPriceBloc(forexPriceUsecase: _getForexPriceUsecase());
//   }

//   ForexPriceUsecase _getForexPriceUsecase() {
//     return ForexPriceUsecaseImpl(repository: _getForexPriceRepository());
//   }

//   ForexPriceSocketRepository _getForexPriceRepository() {
//     return ForexPriceSocketRepositoryImpl(
//         priceSocketDataSource: _getPriceSocketDataSource());
//   }

//   PriceSocketDataSource _getPriceSocketDataSource() {
//     return PriceSocketDataSourceImpl(
//         baseUrl: NetworkConstants.webSocketUrl,
//         token: NetworkConstants.apiToken);
//   }
// }
