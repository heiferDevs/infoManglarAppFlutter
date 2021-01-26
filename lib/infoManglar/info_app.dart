import 'package:flutter/material.dart';
import '../shared/info/widgets/info.dart';

class InfoApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Info(
        title: 'Diseño InfoManglar',
        info: Text('El Ministerio del Ambiente, con apoyo de la Universidad Técnica Particular de Loja (UTPL) y la Fundación Heifer diseñaron esta herramienta de gobierno electrónico llamada InfoManglar, una aplicación para teléfonos móviles iOS y Android que permitirá mejorar los procesos de organización, procesamiento y sistematización de la información sobre los manglares bajo custodia; de tal manera que, sirva como insumo para la toma de decisiones por parte de las entidades estatales, las mismas organizaciones con Acuerdos y donantes o colaboradores.'),
    );
  }
}
