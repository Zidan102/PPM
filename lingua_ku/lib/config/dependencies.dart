import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/repositories/materi_bahasa_repository.dart';
import '../data/repositories/target_harian_repository.dart';
import '../data/repositories/tips_budaya_repository.dart';
import '../data/services/linguaku_service.dart';

List<SingleChildWidget> get appProviders {
  return [
    Provider<LinguakuService>(
      create: (_) => LinguakuService(),
    ),
    Provider<MateriBahasaRepository>(
      create: (context) => MateriBahasaRepository(
        context.read<LinguakuService>(),
      ),
    ),
    ChangeNotifierProvider<TargetHarianRepository>(
      create: (context) => TargetHarianRepository(
        context.read<LinguakuService>(),
      ),
    ),
    Provider<TipsBudayaRepository>(
      create: (context) => TipsBudayaRepository(
        context.read<LinguakuService>(),
      ),
    ),
  ];
}