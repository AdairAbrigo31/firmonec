
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/domain/repositories/repositories.dart';
import 'package:tesis_firmonec/infrastructure/repositories/repositories.dart';

final repositoryProvider = Provider<RepositoryFirmonec>((ref) => RepositoryFirmonecImplementation());