import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { TRABALHO, DESCANSO }

abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
  int minutos = 2;

  @observable
  int segundos = 0;

  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  int segundosMultiplicador = 1;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  Timer? cronometro;

  @action
  void incrementTempoTrabalho() {
    tempoTrabalho++;
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void decrementTempoTrabalho() {
    if (tempoTrabalho > 1) {
      tempoTrabalho--;
      if (estaTrabalhando()) {
        reiniciar();
      }
    }
  }

  @action
  void incrementTempoDescanso() {
    tempoDescanso++;
    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  void decrementTempoDescanso() {
    if(tempoDescanso > 1){
      tempoDescanso--;
      if (estaDescansando()) {
        reiniciar();
      }
    }
  }

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(Duration(seconds: segundosMultiplicador), (timer) {
      if (minutos == 0 && segundos == 0) {
        _trocarTipoIntevalo();
      } else if (segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  bool estaTrabalhando() => tipoIntervalo == TipoIntervalo.TRABALHO;

  bool estaDescansando() => tipoIntervalo == TipoIntervalo.DESCANSO;

  @action
  void _trocarTipoIntevalo() {
    if (estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.TRABALHO;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }
}
