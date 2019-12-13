
import 'package:appparticipacion/src/bloc/news_bloc.dart';
import 'package:appparticipacion/src/bloc/phone_identifier_bloc.dart';
import 'package:appparticipacion/src/bloc/interest_points_bloc.dart';
import 'package:appparticipacion/src/bloc/incidence_trackings_bloc.dart';
import 'package:appparticipacion/src/bloc/incidence_bloc.dart';
import 'package:appparticipacion/src/bloc/incidence_types_bloc.dart';
import 'package:flutter/cupertino.dart';

class Provider extends InheritedWidget{

final _ticketBloc = new IncidenceBloc();
final _noticiaBloc = new NewsBloc();
final _puntosInteresBloc = new InterestPointsBloc();
final _tipoIncidenciaBloc = new TipoIncidenciaBloc();
final _seguimientoTicketBloc = new IncidenceTrackingsBloc();
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


    static IncidenceBloc ticketbloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._ticketBloc;
    }

    static NewsBloc noticiaBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._noticiaBloc;
    }

    static InterestPointsBloc puntoInteresBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._puntosInteresBloc;
    }

    static TipoIncidenciaBloc tipoIncidenciaBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._tipoIncidenciaBloc;
    }

    static IncidenceTrackingsBloc seguimientoTicketBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._seguimientoTicketBloc;
    }
    static PhoneIdentifierBloc phoneIdentifierBloc ( BuildContext context ) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())._phoneIdentifierBloc;
    }
    

}