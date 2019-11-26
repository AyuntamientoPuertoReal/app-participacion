import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget retornarIframe(BuildContext context, String latitud, String longitud){
  double width=MediaQuery.of(context).size.width * 0.95;

 return Container(
    height: 305,
    child: WebView(
      initialUrl: Uri.dataFromString('<html><body><iframe width="$width" height="300" id="gmap_canvas" src="https://maps.google.com/maps?q=$latitud,$longitud&t=&z=16&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe></body></html>', mimeType: 'text/html').toString(),
      javaScriptMode: JavaScriptMode.unrestricted,
    ),
  );
}