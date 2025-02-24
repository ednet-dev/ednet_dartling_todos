// // test/todo/mvc/todo_mvc_test.dart

// import "package:ednet_core/ednet_core.dart";

// import "package:todo_mvc/todo_mvc.dart";

// testTodoMvc(CoreRepository repo, String domainCode, String modelCode) {
//   TodoModels models;
//   DomainSession session;
//   MvcEntries entries;
//   Tasks tasks;
//   int length = 0;
//   Concept concept;
//   group("Testing ${domainCode}.${modelCode}", () {
//     setUp(() {
//       models = repo.getDomainModels(domainCode);
//       session = models.newSession();
//       entries = models.getModelEntries(modelCode);
//       expect(entries, isNotNull);
//       tasks = entries.tasks;
//       expect(tasks.length, equals(length));
//       concept = tasks.concept;
//       expect(concept, isNotNull);
//       expect(concept.attributes.toList(), isNot(isEmpty));

//       var design = new Task(concept);
//       expect(design, isNotNull);
//       design.title = 'design a model';
//       tasks.add(design);
//       expect(tasks.length, equals(++length));

//       var json = new Task(concept);
//       json.title = 'generate json from the model';
//       tasks.add(json);
//       expect(tasks.length, equals(++length));

//       var generate = new Task(concept);
//       generate.title = 'generate code from the json document';
//       tasks.add(generate);
//       expect(tasks.length, equals(++length));
//     });
//     tearDown(() {
//       tasks.clear();
//       expect(tasks.isEmpty, isTrue);
//       length = 0;
//     });
//     test('Empty Entries Test', () {
//       entries.clear();
//       expect(entries.isEmpty, isTrue);
//     });

//     test('From Tasks to JSON', () {
//       var json = tasks.toJson();
//       expect(json, isNotNull);
//       print(json);
//     });
//     test('From Task Model to JSON', () {
//       var json = entries.toJson();
//       expect(json, isNotNull);
//       entries.displayJson();
//     });
//     test('From JSON to Task Model', () {
//       tasks.clear();
//       expect(tasks.isEmpty, isTrue);
//       entries.fromJsonToData();
//       expect(tasks.isEmpty, isFalse);
//       tasks.display(title:'From JSON to Task Model');
//     });

//     test('Add Task Required Title Error', () {
//       var task = new Task(concept);
//       expect(concept, isNotNull);
//       var added = tasks.add(task);
//       expect(added, isFalse);
//       expect(tasks.length, equals(length));
//       expect(tasks.exceptions..length, equals(1));
//       expect(tasks.exceptions..toList()[0].category, equals('required'));
//       tasks.exceptions..display(title:'Add Task Required Title Error');
//     });
//     test('Add Task Pre Validation', () {
//       var task = new Task(concept);
//       task.title =
//           'A new todo task with a long title that cannot be accepted if it is '
//           'longer than 64 characters';
//       var added = tasks.add(task);
//       expect(added, isFalse);
//       expect(tasks.length, equals(length));
//       expect(tasks.exceptions., hasLength(1));
//       expect(tasks.exceptions..toList()[0].category, equals('pre'));
//       tasks.exceptions..display(title:'Add Task Pre Validation');
//     });

//     test('Find Task by New Oid', () {
//       var oid = new Oid.ts(1345648254063);
//       var task = tasks.singleWhereOid(oid);
//       expect(task, isNull);
//     });
//     test('Find Task by Attribute', () {
//       var title = 'generate json from the model';
//       var task = tasks.firstWhereAttribute('title', title);
//       expect(task, isNotNull);
//       expect(task.title, equals(title));
//     });
//     test('Random Task', () {
//       var task1 = tasks.random();
//       expect(task1, isNotNull);
//       task1.display(prefix:'random 1');
//       var task2 = tasks.random();
//       expect(task2, isNotNull);
//       task2.display(prefix:'random 2');
//     });

//     test('Select Tasks by Function', () {
//       Tasks generateTasks = tasks.selectWhere((task) => task.generate);
//       expect(generateTasks.isEmpty, isFalse);
//       expect(generateTasks.length, equals(2));

//       generateTasks.display(title:'Select Tasks by Function');
//     });
//     test('Select Tasks by Function then Add', () {
//       var generateTasks = tasks.selectWhere((task) => task.generate);
//       expect(generateTasks.isEmpty, isFalse);
//       expect(generateTasks.source?.isEmpty, isFalse);

//       var programmingTask = new Task(concept);
//       programmingTask.title = 'ednet_core programming';
//       var added = generateTasks.add(programmingTask);
//       expect(added, isTrue);

//       generateTasks.display(title:'Select Tasks by Function then Add');
//       tasks.display(title:'All Tasks');
//     });
//     test('Select Tasks by Function then Remove', () {
//       var generateTasks = tasks.selectWhere((task) => task.generate);
//       expect(generateTasks.isEmpty, isFalse);
//       expect(generateTasks.source?.isEmpty, isFalse);

//       var title = 'generate json from the model';
//       var task = generateTasks.firstWhereAttribute('title', title);
//       expect(task, isNotNull);
//       expect(task.title, equals(title));
//       var generatelength = generateTasks.length;
//       generateTasks.remove(task);
//       expect(generateTasks.length, equals(--generatelength));
//       expect(tasks.length, equals(--length));
//     });
//     test('Order Tasks by Title', () {
//       var length = tasks.length;
//       tasks.order();
//       expect(tasks.isEmpty, isFalse);
//       expect(tasks.length, equals(length));
//       tasks.display(title:'Order Tasks by Title');
//     });

//     test('Copy Tasks', () {
//       Tasks copiedTasks = tasks.copy();
//       expect(copiedTasks.isEmpty, isFalse);
//       expect(copiedTasks.length, equals(tasks.length));
//       expect(copiedTasks, isNot(same(tasks)));
//       expect(copiedTasks, equals(tasks));
//       copiedTasks.forEach((ct) {
//         expect(ct, equals(tasks.singleWhereOid(ct.oid)));
//       });
//       copiedTasks.forEach((ct) {
//         expect(ct.oid, equals(tasks.singleWhereOid(ct.oid).oid));
//       });
//       copiedTasks.forEach((ct) {
//         expect(ct, isNot(same(tasks.firstWhereAttribute('title', ct.title))));
//       });
//       copiedTasks.display(title:'Copied Tasks');
//     });
//     test('Copy Equality', () {
//       var task = new Task(concept);
//       expect(task, isNotNull);
//       task.title = 'writing a tutorial on EDNetCore';
//       tasks.add(task);
//       expect(tasks.length, equals(++length));

//       task.display(prefix:'before copy: ');
//       var copiedTask = task.copy();
//       copiedTask.display(prefix:'after copy: ');
//       expect(task, isNot(same(copiedTask)));
//       expect(task, equals(copiedTask));
//       expect(task.oid, equals(copiedTask.oid));
//       expect(task.code, equals(copiedTask.code));
//       expect(task.title, equals(copiedTask.title));
//       expect(task.completed, equals(copiedTask.completed));
//     });

//     test('True for Every Task', () {
//       expect(tasks.every((t) => t.code == null), isTrue);
//       expect(tasks.every((t) => t.title != null), isTrue);
//     });

//     test('Find Task then Set Oid with Failure', () {
//       var title = 'generate json from the model';
//       var task = tasks.firstWhereAttribute('title', title);
//       expect(task, isNotNull);
//       expect(() => task.oid = new Oid.ts(1345648254063), throws);
//     });
//     test('Find Task then Set Oid with Success', () {
//       var title = 'generate json from the model';
//       var task = tasks.firstWhereAttribute('title', title);
//       expect(task, isNotNull);
//       task.display(prefix:'before oid set: ');
//       task.concept.updateOid = true;
//       task.oid = new Oid.ts(1345648254063);
//       task.concept.updateOid = false;
//       task.display(prefix:'after oid set: ');
//     });
//     test('Update New Task Title with Failure', () {
//       var task = new Task(concept);
//       expect(task, isNotNull);
//       task.title = 'writing a tutorial on EDNetCore';
//       tasks.add(task);
//       expect(tasks.length, equals(++length));

//       var copiedTask = task.copy();
//       copiedTask.title = 'writing a paper on EDNetCore';
//       // Entities.update can only be used if oid, code or id set.
//       expect(() => tasks.update(task, copiedTask), throws);
//     });
//     test('Update New Task Oid with Success', () {
//       var task = new Task(concept);
//       expect(task, isNotNull);
//       task.title = 'writing a tutorial on EDNetCore';
//       tasks.add(task);
//       expect(tasks.length, equals(++length));

//       var copiedTask = task.copy();
//       copiedTask.concept.updateOid = true;
//       copiedTask.oid = new Oid.ts(1345648254063);
//       copiedTask.concept.updateOid = false;
//       // Entities.update can only be used if oid, code or id set.
//       tasks.update(task, copiedTask);
//       var foundTask = tasks.firstWhereAttribute('title', task.title);
//       expect(foundTask, isNotNull);
//       expect(foundTask.oid, equals(copiedTask.oid));
//       // Entities.update removes the before update entity and
//       // adds the after update entity,
//       // in order to update oid, code and id entity maps.
//       expect(task.oid, isNot(equals(copiedTask.oid)));
//     });
//     test('Find Task by Attribute then Examine Code and Id', () {
//       var title = 'generate json from the model';
//       var task = tasks.firstWhereAttribute('title', title);
//       expect(task, isNotNull);
//       expect(task.code, isNull);
//       expect(task.id, isNull);
//     });

//     test('Add Task Undo and Redo', () {
//       var task = new Task(concept);
//       expect(task, isNotNull);
//       task.title = 'writing a tutorial on EDNetCore';

//       var action = new AddCommand(session, tasks, task);
//       action.doIt();
//       expect(tasks.length, equals(++length));

//       action.undo();
//       expect(tasks.length, equals(--length));

//       action.redo();
//       expect(tasks.length, equals(++length));
//     });
//     test('Remove Task Undo and Redo', () {
//       var title = 'generate json from the model';
//       var task = tasks.firstWhereAttribute('title', title);
//       expect(task, isNotNull);

//       var action = new RemoveCommand(session, tasks, task);
//       action.doIt();
//       expect(tasks.length, equals(--length));

//       action.undo();
//       expect(tasks.length, equals(++length));

//       action.redo();
//       expect(tasks.length, equals(--length));
//     });
//     test('Add Task Undo and Redo with Session', () {
//       var task = new Task(concept);
//       expect(task, isNotNull);
//       task.title = 'writing a tutorial on EDNetCore';

//       var action = new AddCommand(session, tasks, task);
//       action.doIt();
//       expect(tasks.length, equals(++length));

//       session.past.undo();
//       expect(tasks.length, equals(--length));

//       session.past.redo();
//       expect(tasks.length, equals(++length));
//     });
//     test('Undo and Redo Update Task Title', () {
//       var title = 'generate json from the model';
//       var task = tasks.firstWhereAttribute('title', title);
//       expect(task, isNotNull);
//       expect(task.title, equals(title));

//       var action =
//           new SetAttributeCommand(session, task, 'title',
//               'generate from model to json');
//       action.doIt();

//       session.past.undo();
//       expect(task.title, equals(action.before));

//       session.past.redo();
//       expect(task.title, equals(action.after));
//     });
//     test('Undo and Redo Transaction', () {
//       var task1 = new Task(concept);
//       task1.title = 'data modeling';
//       var action1 = new AddCommand(session, tasks, task1);

//       var task2 = new Task(concept);
//       task2.title = 'database design';
//       var action2 = new AddCommand(session, tasks, task2);

//       var transaction = new Transaction('two adds on tasks', session);
//       transaction.add(action1);
//       transaction.add(action2);
//       transaction.doIt();
//       length = length + 2;
//       expect(tasks.length, equals(length));
//       tasks.display(title:'Transaction Done');

//       session.past.undo();
//       length = length - 2;
//       expect(tasks.length, equals(length));
//       tasks.display(title:'Transaction Undone');

//       session.past.redo();
//       length = length + 2;
//       expect(tasks.length, equals(length));
//       tasks.display(title:'Transaction Redone');
//     });

//     test('Reactions to Task Commands', () {
//       var reaction = new Reaction();
//       expect(reaction, isNotNull);

//       models.startCommandReaction(reaction);
//       var task = new Task(concept);
//       task.title = 'validate ednet_core documentation';

//       var session = models.newSession();
//       var addCommand = new AddCommand(session, tasks, task);
//       addCommand.doIt();
//       expect(tasks.length, equals(++length));
//       expect(reaction.reactedOnAdd, isTrue);

//       var title = 'documenting ednet_core';
//       var setAttributeCommand =
//           new SetAttributeCommand(session, task, 'title', title);
//       setAttributeCommand.doIt();
//       expect(reaction.reactedOnUpdate, isTrue);
//       models.cancelCommandReaction(reaction);
//     });

//   });
// }

// class Reaction implements CommandReactionApi {

//   bool reactedOnAdd = false;
//   bool reactedOnUpdate = false;

//   react(BasicCommand action) {
//     if (action is EntitiesCommand) {
//       reactedOnAdd = true;
//     } else if (action is EntityCommand) {
//       reactedOnUpdate = true;
//     }
//   }

// }

// testTodoData(TodoRepo todoRepo) {
//   testTodoMvc(todoRepo, TodoRepo.todoDomainCode,
//       TodoRepo.todoMvcModelCode);
// }

// void main() {
//   var todoRepo = new TodoRepo();
//   testTodoData(todoRepo);
// }

