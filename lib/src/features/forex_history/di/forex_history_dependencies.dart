import 'package:fxtm_trader/src/core/network/network_client.dart';
import 'package:fxtm_trader/src/features/forex_history/data/datasource/local/candle_local_datasource.dart';
import 'package:fxtm_trader/src/features/forex_history/data/datasource/remote/candle_remote_datasource.dart';
import 'package:fxtm_trader/src/features/forex_history/data/repository/candle_repository_impl.dart';
import 'package:fxtm_trader/src/features/forex_history/domain/repository/candle_repository.dart';
import 'package:fxtm_trader/src/features/forex_history/domain/usecase/get_candle_data_usecase.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/bloc/forex_history_bloc.dart';
import 'package:fxtm_trader/src/features/forex_history/presentation/mapper/forex_history_display_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupForexHistoryDependencies() {

  // CandleRemoteDatasource
  getIt.registerFactory<CandleRemoteDatasource>(() => CandleRemoteDatasourceImpl(networkClient: getIt<NetworkClient>()));

  // CandleLocalDataSource
  getIt.registerFactory<CandleLocalDataSource>(() => CandleLocalDataSourceImpl(jsonFilePath: 'assets/candle_data.json'));

  // CandleRepository
  getIt.registerFactory<CandleRepository>(() =>
    CandleRepositoryImpl(
      remoteDataSource: getIt<CandleRemoteDatasource>(),
      localDataSource: getIt<CandleLocalDataSource>()
  ));

  // GetCandleDataUseCase
  getIt.registerFactory<GetCandleDataUseCase>(() => 
    GetCandleDataUseCaseImpl(getIt<CandleRepository>())
  );

  // ForexHistoryDisplayMapper
  getIt.registerFactory<ForexHistoryDisplayMapper>(() => ForexHistoryDisplayMapperImpl());

  // ForexHistoryBloc
  getIt.registerFactory<ForexHistoryBloc>(() => ForexHistoryBloc(
      getIt<GetCandleDataUseCase>(),
      getIt<ForexHistoryDisplayMapper>()
    )
  );
}
