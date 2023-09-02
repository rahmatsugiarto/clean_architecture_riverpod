import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/network/providers/dio_network_service_provider.dart';
import '../../data/datasources/remote/remote_datasource.dart';
import '../../data/repositories/repository_impl.dart';
import '../repositories/repository.dart';

final datasourceProvider = Provider.family<RemoteDataSource, Dio>(
  (_, dio) => RemoteDataSourceImpl(dio: dio),
);

final repositoryProvider = Provider<Repository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final remoteDatasource = ref.watch(datasourceProvider(networkService));
  final respository = RepositoryImpl(remoteDataSource: remoteDatasource);

  return respository;
});
