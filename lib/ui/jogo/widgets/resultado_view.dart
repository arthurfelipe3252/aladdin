import 'package:flutter/material.dart';

import '../../../domain/models/professor.dart';
import '../../core/app_scaffold.dart';
import '../../core/tema.dart';

class ResultadoView extends StatelessWidget {
  const ResultadoView({
    super.key,
    required this.professor,
    required this.onRecomecar,
    required this.onContinuar,
  });

  final Professor professor;
  final VoidCallback onRecomecar;
  final VoidCallback onContinuar;

  void _acertou(BuildContext context) {
    final primeiroNome = professor.nome.split(' ').first;
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (dialogContext) => _DialogoAladdin(
        titulo: 'Acertei!',
        mensagem: 'Eu sabia que era $primeiroNome!',
        acoes: [
          _BotaoDialogo.primario(
            texto: 'Jogar de novo',
            onTap: () {
              Navigator.of(dialogContext).pop();
              onRecomecar();
            },
          ),
          const SizedBox(height: 6),
          _BotaoDialogo.secundario(
            texto: 'Voltar ao início',
            onTap: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _errei(BuildContext context) {
    final primeiroNome = professor.nome.split(' ').first;
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (dialogContext) => _DialogoAladdin(
        titulo: 'Quase!',
        mensagem: 'Não era $primeiroNome? Posso continuar de onde paramos.',
        acoes: [
          _BotaoDialogo.primario(
            texto: 'Continuar',
            onTap: () {
              Navigator.of(dialogContext).pop();
              onContinuar();
            },
          ),
          const SizedBox(height: 6),
          _BotaoDialogo.secundario(
            texto: 'Recomeçar',
            onTap: () {
              Navigator.of(dialogContext).pop();
              onRecomecar();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final menorLado = media.width < media.height ? media.width : media.height;
    final raioFoto = (menorLado * 0.22).clamp(64.0, 100.0).toDouble();

    return ConteudoCentralizadoRolavel(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ACHO QUE É…',
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: AladdinTema.destaqueClaro,
            ),
          ),
          const SizedBox(height: 22),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AladdinTema.destaque, width: 4),
              boxShadow: [
                BoxShadow(
                  color: AladdinTema.destaque.withValues(alpha: 0.5),
                  blurRadius: 28,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: raioFoto,
              backgroundColor: AladdinTema.fundoTopo,
              backgroundImage: AssetImage(professor.foto),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            professor.nome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _BotaoPalpite(
                  texto: 'Acertei',
                  icone: Icons.check_circle_outline,
                  cor: const Color(0xFF2E9E5B),
                  onTap: () => _acertou(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BotaoPalpite(
                  texto: 'Errei',
                  icone: Icons.cancel_outlined,
                  cor: const Color(0xFFD2453D),
                  onTap: () => _errei(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BotaoPalpite extends StatelessWidget {
  const _BotaoPalpite({
    required this.texto,
    required this.icone,
    required this.cor,
    required this.onTap,
  });

  final String texto;
  final IconData icone;
  final Color cor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      icon: Icon(icone, size: 20),
      label: Text(
        texto,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: FilledButton.styleFrom(
        backgroundColor: cor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _DialogoAladdin extends StatelessWidget {
  const _DialogoAladdin({
    required this.titulo,
    required this.mensagem,
    required this.acoes,
  });

  final String titulo;
  final String mensagem;
  final List<Widget> acoes;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AladdinTema.fundoTopo, AladdinTema.fundoBase],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AladdinTema.destaque, width: 2),
            boxShadow: [
              BoxShadow(
                color: AladdinTema.destaque.withValues(alpha: 0.45),
                blurRadius: 32,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AladdinTema.destaque.withValues(alpha: 0.15),
                  border: Border.all(color: AladdinTema.destaque, width: 2),
                ),
                child: const Center(
                  child: Text('🧞', style: TextStyle(fontSize: 38)),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AladdinTema.destaqueClaro,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.35,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),
              ...acoes,
            ],
          ),
        ),
      ),
    );
  }
}

class _BotaoDialogo extends StatelessWidget {
  const _BotaoDialogo({
    required this.texto,
    required this.onTap,
    required this.primario,
  });

  factory _BotaoDialogo.primario({
    required String texto,
    required VoidCallback onTap,
  }) => _BotaoDialogo(texto: texto, onTap: onTap, primario: true);

  factory _BotaoDialogo.secundario({
    required String texto,
    required VoidCallback onTap,
  }) => _BotaoDialogo(texto: texto, onTap: onTap, primario: false);

  final String texto;
  final VoidCallback onTap;
  final bool primario;

  @override
  Widget build(BuildContext context) {
    if (primario) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: onTap,
          style: FilledButton.styleFrom(
            backgroundColor: AladdinTema.destaque,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(
            texto,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        child: Text(texto, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
