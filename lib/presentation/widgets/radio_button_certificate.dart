
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesis_firmonec/infrastructure/entities/entities.dart';
import 'package:tesis_firmonec/presentation/providers/providers.dart';

class RadioButtonCertificate extends ConsumerStatefulWidget{

  final CertificateEntity certificate;

  const RadioButtonCertificate(this.certificate, {super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RadioButtonCertificateState();
  
  }



  class _RadioButtonCertificateState extends ConsumerState<RadioButtonCertificate> {
    
    @override
    Widget build(BuildContext context) {

      final selectedCertId = ref.watch(
        documentSelectedProvider.select(
          (state) => state.certificate?.id
        )
      );
      
      return Radio<String>(
        value: widget.certificate.id,
        groupValue: selectedCertId,
        onChanged: (value) {
          ref.read(documentSelectedProvider.notifier).updateCertificate(widget.certificate);
        },
      );
    }
  }