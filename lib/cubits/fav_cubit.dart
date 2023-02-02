import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motor_scheme/models/vehicle_model.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavInitial> {
  FavCubit() : super(FavInitial([]));

  Future<void> addFavorites(VehicleModel vehicle) async {
    state.vehicleData!.add(vehicle);
    emit(FavInitial(state.vehicleData));
  }
}
