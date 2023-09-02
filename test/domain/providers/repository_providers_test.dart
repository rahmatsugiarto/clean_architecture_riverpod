import 'package:clean_architecture_riverpod/common/network/providers/dio_network_service_provider.dart';
import 'package:clean_architecture_riverpod/data/datasources/remote/remote_datasource.dart';
import 'package:clean_architecture_riverpod/domain/providers/repository_providers.dart';
import 'package:clean_architecture_riverpod/domain/repositories/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final providerContainer = ProviderContainer();
  late dynamic networkService;
  late dynamic remoteDataSource;
  late dynamic repository;
  setUpAll(
    () {
      networkService = providerContainer.read(networkServiceProvider);
      remoteDataSource =
          providerContainer.read(datasourceProvider(networkService));
      repository = providerContainer.read(repositoryProvider);
    },
  );
  test('remoteDataSource is a RemoteDataSource', () {
    expect(
      remoteDataSource,
      isA<RemoteDataSource>(),
    );
  });
  test('respository is a Repository', () {
    expect(
      repository,
      isA<Repository>(),
    );
  });
  test('repositoryProvider returns a Repository', () {
    expect(
      providerContainer.read(repositoryProvider),
      isA<Repository>(),
    );
  });
}
