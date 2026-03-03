# Lista de Tarefas (Flutter)

Aplicativo simples de lista de tarefas (To-Do) feito em Flutter.
Permite digitar tarefas, adicionar na lista e remover quando quiser.

## Funcionalidades

### 1) Inicialização do App
- O arquivo `main.dart` contém a função `main()`, que chama `runApp(MyApp())`.
- `MyApp` é o widget raiz que cria um `MaterialApp` e define a tela inicial (`home`) como `TodoPage`.

### 2) Tela Principal (TodoPage)
- `TodoPage` é um `StatefulWidget` porque a lista de tarefas muda com o tempo (adiciona/remove itens).
- O estado é controlado por `_TodoPageState`.

### 3) Armazenamento das tarefas
- As tarefas ficam em memória no app dentro da lista:
  - `List<String> todoList`
- Cada tarefa é uma `String`.

### 4) Entrada de texto (TextField)
- O campo de texto usa um `TextEditingController`:
  - `TextEditingController todoController`
- Ele serve para:
  - Ler o texto digitado (`todoController.text`)
  - Limpar o campo após adicionar (`todoController.clear()`)

### 5) Adicionar tarefa (addTodo)
- A função `addTodo()`:
  - Valida se o texto está vazio (ignorando espaços com `trim()`).
  - Se tiver conteúdo, chama `setState()` para:
    - Inserir a tarefa na lista (`todoList.add(...)`)
    - Limpar o campo de texto
- O `setState()` é essencial para o Flutter redesenhar a UI com a lista atualizada.
- A tarefa pode ser adicionada por:
  - Botão "Adicionar"
  - Tecla Enter do teclado (via `onSubmitted` do `TextField`)

### 6) Remover tarefa (removeTodo)
- A função `removeTodo(index)`:
  - Chama `setState()`
  - Remove o item na posição informada (`todoList.removeAt(index)`)

### 7) Exibição da lista (ListView.builder)
- A lista é mostrada usando `ListView.builder`:
  - Melhor para performance em listas maiores (constrói itens sob demanda)
- Cada item:
  - Aparece em um `Card` com `ListTile`
  - Mostra o texto da tarefa
  - Tem um botão de lixeira (`Icons.delete`) para remover o item

### 8) Liberação de recursos (dispose)
- O `TextEditingController` é liberado no método `dispose()`:
  - `todoController.dispose()`
- Evita vazamento de memória (boa prática).

## Como executar
1. Instale o Flutter e configure o ambiente.
2. Crie um projeto Flutter:
   - `flutter create todo_app`
3. Substitua o conteúdo de `lib/main.dart` pelo código deste projeto.
4. Rode:
   - `flutter run`