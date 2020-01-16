
import 'package:appparticipacion/src/bloc/news_bloc.dart';
import 'package:appparticipacion/src/bloc/phone_identifier_bloc.dart';
import 'package:appparticipacion/src/bloc/interest_points_bloc.dart';
import 'package:appparticipacion/src/bloc/incidence_trackings_bloc.dart';
import 'package:appparticipacion/src/bloc/incidence_bloc.dart';
import 'package:appparticipacion/src/bloc/incidence_types_bloc.dart';
import 'package:flutter/cupertino.dart';

class Provider extends InheritedWidget{

  final _incidenceBloc = new IncidencesBloc();
  final _newsBloc = new NewsBloc();
  final _interestPointsBloc = new InterestPointsBloc();
  final _incidenceTypesBloc = new IncidenceTypesBloc();
  final _incidenceTrackingsBloc = new IncidenceTrackingsBloc();
  final _phoneIdentifierBloc = new PhoneIdentifierBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}){

    if (_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
     : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

    static IncidencesBloc incidenciaBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._incidenceBloc;
    }

    static NewsBloc noticiaBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._newsBloc;
    }

    static InterestPointsBloc puntoInteresBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._interestPointsBloc;
    }

    static IncidenceTypesBloc tipoIncidenciaBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._incidenceTypesBloc;
    }

    static IncidenceTrackingsBloc seguimientoTicketBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._incidenceTrackingsBloc;
    }
    static PhoneIdentifierBloc phoneIdentifierBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._phoneIdentifierBloc;
    }
}