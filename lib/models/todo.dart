class Todo {
  final String title;
  final bool isDone;

  Todo({required this.title, this.isDone = false});

  factory Todo.fromString(String str) {
    final parts = str.split('|');
    return Todo(title: parts[0], isDone: parts.length > 1 && parts[1] == '1');
  }

  @override
  String toString() => '$title|${isDone ? '1' : '0'}';

  Todo copyWith({String? title, bool? isDone}) {
    return Todo(title: title ?? this.title, isDone: isDone ?? this.isDone);
  }
}
