# Agendamento de Evento Social

Aplicativo em Flutter desenvolvido para gerenciar o agendamento de eventos sociais, permitindo ao usuário definir data, horário, tipo de evento, estimativa de convidados, visibilidade, serviços adicionais, restrições alimentares e envio de lembretes.

## Resumo do Desenvolvimento

### 1) Qual o nome do componente Slider? Qual a variável responsável por armazenar o valor padrão do Slider?
* **Nome do componente:** `Slider`.
* **Variável do valor padrão:** `_convidadosPadrao` (que define o valor inicial de `50.0`).

---
### 2) Porque em um dos botões um está marcado como “OutlinedButton” e o outro como “ElevatedButton”? Qual a diferença visual entre eles? Possuem parâmetros diferentes? Quais?
* **Motivo:** Para criar uma hierarquia visual. O botão principal chama mais atenção, enquanto o secundário fica mais discreto.
* **Diferença visual:** O `ElevatedButton` tem fundo colorido e uma leve sombra (parece "saltado"). Já o `OutlinedButton` tem fundo transparente e apenas uma linha em volta (borda).
* **Parâmetros diferentes:** Ambos recebem `onPressed` e `child`, mas mudam nas opções de estilo (`styleFrom`). O `ElevatedButton` aceita propriedades como `elevation` e `shadowColor`, enquanto o `OutlinedButton` usa o parâmetro `side` (`BorderSide`) para customizar a borda.

---
### 3) Qual a finalidade do método setState() dentro do RadioGroup?
* **Finalidade:** Avisar o Flutter que uma opção foi selecionada. O `setState()` faz a tela ser redesenhada na hora para que a bolinha do Radio apareça marcada para o usuário.

---
### 4) Explique para uma criança de 10 anos o que faz o método “.map” na lista de itens do dropdown.
Sabe quando você tem uma lista de nomes no papel e quer transformar cada um em um crachá? O `.map` faz exatamente isso! Ele pega cada palavra da sua lista (como "Aniversário" ou "Casamento") e transforma, uma por uma, em uma opção bonitinha pro menu do aplicativo.

---
### 5) Como é controlado as tags selecionadas do usuário do tipo Chip (FilterChip)? Onde eu faço isso?
* **Como é controlado:** Através de uma lista chamada `_tagsSelecionadas`. O parâmetro `onSelected` do `FilterChip` avisa se a tag foi marcada ou desmarcada. Se for marcada, adicionamos o item na lista (`_tagsSelecionadas.add(tag)`). Se for desmarcada, removemos (`_tagsSelecionadas.remove(tag)`).
* **Onde fazer:** Dentro do evento `onSelected` de cada `FilterChip`, usando o `setState()` no arquivo `lib/main.dart`.