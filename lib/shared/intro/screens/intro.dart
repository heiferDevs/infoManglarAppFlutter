import '../widgets/intro_slider.dart';
import '../../../util/utility.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../login/screens/login.dart';
import '../../../util/user.dart';

class Intro extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<Intro> {

  static const int SHOW_DELAY = 3;

  bool _showLogo = true;
  List<Slide> slides = new List();

  @override
  void initState() {

    super.initState();

    slides.add(
      new Slide(
        title: "IMPORTANCIA DEL MANGLAR",
        styleTitle:
        TextStyle(color: Color(Constants.colorTertiary), fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Bookman'),
        description: "El manglar es un ecosistema boscoso que se desarrolla en la transición entre tierra firme y mar abierto, en las zonas tropicales y subtropicales del mundo. Por sus características, es el hábitat de una gran variedad de fauna como aves, peces, moluscos y crustáceos, dentro del cual se encuentran especies de gran valor para la seguridad alimentaria y que son aprovechadas comercialmente como la concha, cangrejo, robalo, lisa, entre otros. Los manglares brindan a su vez servicios ecosistémicos de protección contra la erosión de las costas, ya que atrapan sedimento y hojarasca entre sus raíces ayudando a rellenar y recobrar terreno; protegen al continente de los huracanes, marejadas, tormentas; atenúan los impactos del Fenómeno de El Niño y también protegen las tierras agrícolas de la salinidad del mar, actuando como filtro y manteniendo la calidad del agua.",
        styleDescription:
        TextStyle(color: Color(Constants.colorDark), fontSize: 17.0, fontFamily: 'Bookman'),
        backgroundColor: Color(0xFFFFF),
      ),
    );
    slides.add(
      new Slide(
        title: "ACUERDOS DE USO SOSTENIBLE Y CUSTODIA DEL ECOSISTEMA MANGLAR",
        styleTitle:
        TextStyle(color: Color(Constants.colorTertiary), fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Bookman'),
        description: "El marco legal ecuatoriano contempla una herramienta de gestión del ecosistema manglar llamada Acuerdos de Uso Sustentable y Custodia del Manglar, bajo el cual el MAE entrega en custodia los bosques del manglar a usuarios tradicionales asentados a lo largo del perfil costanero. Es un instrumento jurídico que garantiza a los custodios el acceso exclusivo a las áreas de manglar con el derecho de aprovechar sustentablemente los recursos bioacuáticos, pero a su vez tienen la obligación de custodiar el manglar y denunciar cualquier daño ambiental a la autoridad ambiental.",
        styleDescription:
        TextStyle(color: Color(Constants.colorDark), fontSize: 17.0, fontFamily: 'Bookman'),
        backgroundColor: Color(0xFFFFF),
      ),
    );
    slides.add(
      new Slide(
        title: "¿CUANDO SE DEBE USAR EL NÚMERO 911?",
        styleTitle:
        TextStyle(color: Color(Constants.colorTertiary), fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Bookman'),
        description:
        "Solo en casos de emergencia. Una emergencia es cualquier situación que perturba el funcionamiento de la comunidad o sociedad con afectación a las personas, la salud, los bienes o al medio ambiente. Una emergencia puede ser generada por eventos naturales o propios de la actividad humana, ya sea de forma repentina o como resultado de un proceso.",
        styleDescription:
        TextStyle(color: Color(Constants.colorDark), fontSize: 17.0, fontFamily: 'Bookman'),
        backgroundColor: Color(0xFFFFF),
      ),
    );
    Future.delayed(
      const Duration(seconds: SHOW_DELAY),
      () => Utility.navTo(context, Login()),
    );
  }

  hideLogo(){
    setState(() {
      _showLogo = false;
    });
  }

  void onDonePress() {
    Utility.navTo(context, Login());
  }

  void onSkipPress() {
    Utility.navTo(context, Login());
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(Constants.colorPrimary),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(Constants.colorPrimary),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(Constants.colorPrimary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _showLogo ? _logo() : _introSlider();
  }

  Widget _introSlider(){
    return IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      onSkipPress: this.onSkipPress,
      colorSkipBtn: Color(0xFFFFF),
      highlightColorSkipBtn: Color(Constants.colorDark),

      // Next, Done button
      onDonePress: this.onDonePress,
      renderNextBtn: this.renderNextBtn(),
      renderDoneBtn: this.renderDoneBtn(),
      colorDoneBtn: Color(0xFFFFF),
      highlightColorDoneBtn: Color(Constants.colorDark),

      // Dot indicator
      colorDot: Color(Constants.colorSecondary),
      colorActiveDot: Color(Constants.colorPrimary),
      sizeDot: 13.0,
    );
  }

  Widget _logo() {

    final double cWidth = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          User.getImagePath('logo_suia_small.png'),
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
          width: cWidth,
        ),
      ),
    );
  }

}
