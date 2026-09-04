import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agendamento de Evento',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AgendamentoEventoTela(),
    );
  }
}

class AgendamentoEventoTela extends StatefulWidget {
  const AgendamentoEventoTela({super.key});

  @override
  State<AgendamentoEventoTela> createState() => _AgendamentoEventoTelaState();
}

enum Visibilidade { public, private, vip }

class _AgendamentoEventoTelaState extends State<AgendamentoEventoTela> {
 
  static final DateTime _dataPadrao = DateTime.now();
  static const TimeOfDay _horarioPadrao = TimeOfDay(hour: 19, minute: 0);
  static const String _tipoPadrao = 'Aniversário';
  static const double _convidadosPadrao = 50.0;
  static const Visibilidade _visibilidadePadrao = Visibilidade.private;

  
  late DateTime _dataSelecionada;
  late TimeOfDay _horarioSelecionado;
  late String _tipoEventoSelecionado;
  late double _quantidadeConvidados;
  late Visibilidade _visibilidadeSelecionada;

  @override
  void initState() {
    super.initState();
    _resetarValores();
  }

  void _resetarValores() {
    setState(() {
      _dataSelecionada = _dataPadrao;
      _horarioSelecionado = _horarioPadrao;
      _tipoEventoSelecionado = _tipoPadrao;
      _quantidadeConvidados = _convidadosPadrao;
      _visibilidadeSelecionada = _visibilidadePadrao;
    });
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? data = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (data != null && data != _dataSelecionada) {
      setState(() {
        _dataSelecionada = data;
      });
      print(
        '[DEBUG - DatePicker] Data selecionada: ${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}',
      );
    }
  }

  Future<void> _selecionarHorario(BuildContext context) async {
    final TimeOfDay? horario = await showTimePicker(
      context: context,
      initialTime: _horarioSelecionado,
    );

    if (horario != null && horario != _horarioSelecionado) {
      setState(() {
        _horarioSelecionado = horario;
      });
      print(
        '[DEBUG - TimePicker] Horário selecionado: ${_horarioSelecionado.format(context)}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Evento Social'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Text(
              'Data e Horário',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      '${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}',
                    ),
                    onPressed: () => _selecionarData(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(_horarioSelecionado.format(context)),
                    onPressed: () => _selecionarHorario(context),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),

            
            Text(
              'Tipo de Evento',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _tipoEventoSelecionado,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: ['Aniversário', 'Casamento', 'Corporativo', 'Outro']
                  .map(
                    (tipo) => DropdownMenuItem(
                      value: tipo,
                      child: Text(tipo),
                    ),
                  )
                  .toList(),
              onChanged: (novoValor) {
                if (novoValor != null) {
                  setState(() {
                    _tipoEventoSelecionado = novoValor;
                  });
                  print('[DEBUG - Menu] Tipo de evento selecionado: $novoValor');
                }
              },
            ),
            const Divider(height: 32),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantidade de Convidados',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${_quantidadeConvidados.round()} pessoas',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Slider(
              value: _quantidadeConvidados,
              min: 10,
              max: 500,
              divisions: 49,
              label: _quantidadeConvidados.round().toString(),
              onChanged: (novoValor) {
                setState(() {
                  _quantidadeConvidados = novoValor;
                });
                print('[DEBUG - Slider] Quantidade de convidados: ${novoValor.round()}');
              },
            ),
            const Divider(height: 32),

          
            Text(
              'Visibilidade do Evento',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            RadioGroup<Visibilidade>(
              groupValue: _visibilidadeSelecionada,
              onChanged: (Visibilidade? visibilidade) {
                if (visibilidade != null) {
                  setState(() {
                    _visibilidadeSelecionada = visibilidade;
                  });
                  print('[DEBUG - Radio] Visibilidade: $visibilidade');
                }
              },
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Público'),
                    leading: Radio<Visibilidade>(
                      value: Visibilidade.public,
                    ),
                  ),
                  ListTile(
                    title: const Text('Privado'),
                    leading: Radio<Visibilidade>(
                      value: Visibilidade.private,
                    ),
                  ),
                  ListTile(
                    title: const Text('Apenas Convidados'),
                    leading: Radio<Visibilidade>(
                      value: Visibilidade.vip,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
