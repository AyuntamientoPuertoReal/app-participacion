
import 'package:appparticipacion/src/bloc/noticias_bloc.dart';
import 'package:appparticipacion/src/bloc/puntos_interes_bloc.dart';
import 'package:appparticipacion/src/bloc/seguimiento_ticket_bloc.dart';
import 'package:appparticipacion/src/bloc/ticket_bloc.dart';
import 'package:appparticipacion/src/bloc/tipo_incidencia_bloc.dart';
import 'package:flutter/cupertino.dart';

class Provider extends InheritedWidget{

final _ticketBloc = new TicketBloc();
final _noticiaBloc = new NoticiaBloc();
final _puntosInteresBloc = new PuntoInteresBloc();
final _tipoIncidenciaBloc = new TipoIncidenciaBloc();
final _seguimientoTicketBloc = new SeguimientoTicketBloc();



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


    static TicketBloc ticketbloc ( BuildContext context ) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._ticketBloc;
    }

    static NoticiaBloc noticiaBloc ( BuildContext context ) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._noticiaBloc;
    }

    static PuntoInteresBloc puntoInteresBloc ( BuildContext context ) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._puntosInteresBloc;
    }

    static TipoIncidenciaBloc tipoIncidenciaBloc ( BuildContext context ) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._tipoIncidenciaBloc;
    }

    static SeguimientoTicketBloc seguimientoTicketBloc ( BuildContext context ) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._seguimientoTicketBloc;
    }
    

}