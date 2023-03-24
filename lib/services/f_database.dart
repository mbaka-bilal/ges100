import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FDatabase {
  ///Handle all database functions
  ///
  ///

  Future<bool> tableExists(String tableName) async {
    /// Check if table exists
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [tableName]);

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkIfTableExists(String tableName) async {
    if (await tableExists(tableName)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> createDatabaseAndTables(String tableName) async {
    ///Create the required database and tables.
    try {
      String path = await getDatabasesPath();
      String finalPath = join(path, 'questions.db');
      final db = await openDatabase(finalPath);

      await db.execute('CREATE TABLE $tableName ('
          'id INTEGER AUTO INCREMENT PRIMARY KEY, '
          'question TEXT NOT NULL,'
          'answer TEXT NOT NULL,'
          'options TEXT NOT NULL,'
          'answerIndex TEXT NOT NULL'
          ')');
      // return false;
    } catch (e) {
      print("Error creating table or database $e");
      // return false;
    }
  }

  Future<void> addQuestionsToTable(String tableName) async {
    ///Add the questions to the table
    ///
    ///

    try {
      String path = await getDatabasesPath();
      String finalPath = join(path, 'questions.db');
      final db = await openDatabase(finalPath);
      Batch batch = db.batch();

      batch.insert(
          tableName,
          {
            'question': 'Drawings of an area of the earth are referred to as',
            'answer': 'Maps',
            'options': 'Maps|Directives|Atlas|Handbooks',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Books published yearly which carry information on various events for the coming year are called',
            'answer': 'Almanacs',
            'options': 'Year book|Annual book|Almanacs|Hand book',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'what holds the parts of the book together and makes them easy to handle',
            'answer': 'Binding',
            'options': 'Preliminary pages|Binding|Tight book|Surran tight',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'In which of the section of the library can we find the dictionary?',
            'answer': 'Reference',
            'options': 'Research section|Reference|Acquisition|None',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'The short description on the cover of a book is referred to as _______',
            'answer': 'Blurb',
            'options': 'Balb|Babule|Back print|Blurb',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Never allow ______ days to elapse without making up the notes taken in class',
            'answer': 'Three',
            'options': 'Four|Two|Three|Five',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Always consult other _______ when making up your notes',
            'answer': 'Books',
            'options': 'Lecturers|Books|Students|Notes',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '_______ is the modification or amplification of notes taken during lectures',
            'answer': 'Note making',
            'options': 'Note books|Note making|Note taking|Long memory',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '________ is a technique of outlining in note taking and note making',
            'answer': 'Sentence outline',
            'options':
                'Text book format|Pattern|Sentence outline|Course outline',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Division of an outline can be done by the use of _________',
            'answer': 'Numbers',
            'options': 'Note books|Text books|Lecture notes|Numbers',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Flexibility in reading can be achieved through the following reading strategies',
            'answer': 'Skimming and scanning',
            'options':
                'Listening and speaking|Reading and writing|Skimming and scanning|None',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'We skim because we want to make utmost use of our _________',
            'answer': 'Notes',
            'options': 'Text books|Note books|Lecture notes|Notes',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': '_______ is also known as preview reading',
            'answer': 'Pre-reading',
            'options': 'Pre-reading|Over-view|Review|Skim reading',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'Which is not required in speed reading',
            'answer': 'Active reading',
            'options':
                'Context clues|Proper eye movement|Active reading|Knowledge of one’s speed',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'Which is of great relevance in summarizing a text',
            'answer': 'Topic sentence',
            'options':
                'Connotative sentences|Semantic fields|Meaningful clusters of words|Topic sentence',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'Inferential comprehension requires',
            'answer': 'Making personal corrections',
            'options':
                'Making personal corrections|Collocation|Sub-vocalization|Evaluation information',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'Which is a context clue?',
            'answer': 'Definitional sentence',
            'options':
                'Inferences|Chronological order|Writer’s purpose|Definitional sentence',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'Connectives and determiners enable us to',
            'answer': 'Identify the functions of details',
            'options':
                'Identify background knowledge|Identify the functions of details|Determines the writer’s purpose|None of the above',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': "Which can shape a writer’s arguments",
            'answer': 'All of the above',
            'options':
                'Educational background|Experiences|Environment|All of the above',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'A major comprehension skill is',
            'answer': 'Deductive comprehension',
            'options':
                'Armchair travelling|Strategic comprehension|Deductive comprehension|Flexibility',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'A good paragraph must contain the following in which order',
            'answer': 'Purpose, Unity, coherence, completeness and order',
            'options':
                'Purpose, Unity, coherence, completeness and order|Coherence, completeness, unity, purpose and order|Order, unity, purpose, coherence and completeness|Topic sentence, connectives, beginning, middle and ending',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Lots of people have problems writing conclusions because',
            'answer': 'They forget that the conclusion is the conclusion',
            'options':
                'They do not know what to say|They do not know how much to say|They forget that the conclusion is the conclusion|They sum up all the steps of the argument they have',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'There are three stages in paragraph development',
            'answer': 'Pre-writing, writing and post-writing',
            'options':
                'The beginning, the middle and the conclusion|Pre-writing, writing and post-writing|Parallelism, antecedent and recapitulation|What, how and why',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'There are three basic types of paragraph',
            'answer': 'Introductory, transitory and the concluding paragraph',
            'options':
                'The narrative, descriptive and argumentative paragraph|ntroductory, transitory and the concluding paragraph|The expository, persuasive and structural paragraph|The response, research and assessment paragraph',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'A fast and effective reader makes',
            'answer': 'Very few eye movement',
            'options':
                'Very few eye movement|Rapid eye movement|No eye movement|Persistent eye movemen',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'A fast and effective reader makes',
            'answer': 'Study pace reading',
            'options':
                'Rapid reading|Study pace reading|Retrogression|Peripheral',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': '________ is not a figure of speech',
            'answer': 'Ellipsis',
            'options': 'Apostrophe|Ellipsis|Irony|Bathos',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '________ uses a part of something to represent the whole',
            'answer': 'Synecdoche',
            'options': 'Methonymy|Euphemism|Synecdoche|Oxymoron',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The opposite of bathos is ________',
            'answer': 'Climax',
            'options': 'Litotes|Climax|Dathos|Oxymoron',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'We are unaware of the devices of the enemy” is an example of _______',
            'answer': 'Litotes',
            'options': 'Climax|Litotes|Euphemism|Unlitotes',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '“The pen is mightier than the sword” This statement is',
            'answer': 'Paradoxical',
            'options': 'Paradoxical|Ironical|Sarcastic|Metonymical',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '“He is an eloquent dumb man” us an example of ________',
            'answer': 'Allusion',
            'options': 'Allusion|Pun|Euphemism|Oxymoron',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '“To Nigeria will I steal and there I’ll steal” is an example of',
            'answer': 'Pun',
            'options': 'Allusion|Pun|Euphemism|Oxymoron',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Based on their mode of operation in the process of communication, figures of speech are classified into _______ basic types',
            'answer': 'Two',
            'options': 'Three|Four|Two|Twelve',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Figures of speech can _______ the reader for better understanding',
            'answer': 'Persuade',
            'options': 'Persuade|Factorize|Delude|None of the above',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': '_________ is regarded as the basic unit of language',
            'answer': 'The word',
            'options': 'The alphabet|The sentence|The phrase|The word',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '_______ is a board concept which refer to words and their various connections and collocations',
            'answer': 'Lexis',
            'options': 'Vocabulary|Dictionary|Encyclopedia|Lexis',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Words that have the same spelling, same pronunciation but different meaning are called',
            'answer': 'Homonyms',
            'options': 'Homophones|Homographs|Homonyms|Homomorphs',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'The process of word formation that is most productive is',
            'answer': 'Derivative',
            'options': 'Compounding|Conversion|Derivative|Clipping',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The plural form of “Corrigendum” is',
            'answer': 'Corrigenda',
            'options': 'Corrigandums|Corrigenda|Corrgendae|Corrigendi',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'One of these is not an irregular noun',
            'answer': 'Girl',
            'options': 'Sheep|Syllable|Girl|Stadium',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'All of these are examples of neuter nouns except one',
            'answer': 'Hippopotamus',
            'options': 'Phenomenon|Hippopotamus|Criterion|Stadium',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'The plural formation that requires the addition of "e" as in formulae is called',
            'answer': 'Complex',
            'options': 'Feminine|Neuter|Masculine|Complex',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'A process of word formation by combining parts of two or more already existing words in the same language is referred to as',
            'answer': 'Blending',
            'options': 'Clipping|Back of formation|Coinage|Blending',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': '"He is a goat" is an example of ________ meaning',
            'answer': 'Connotative',
            'options': 'Connotative|Denotative|Contextual|Reflexive',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'A _______ is a group of words without a finite verb',
            'answer': 'Phrase',
            'options': 'Sentence|Clause|Phrase|Paragraph',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'All these are structural types of phrases except one',
            'answer': 'Adverbial phrase',
            'options':
                'Adverbial phrase|Gerundial phrase|Participial phrase|Infinitival phrase',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '________ is not the part of the sentence that is modified',
            'answer': 'Absolute phrase',
            'options':
                'Adverbial phrase|Absolute phrase|Participial phrase|Infinitival phrase',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'All but one belongs to the open word class in English',
            'answer': 'And',
            'options': 'Eat|Man|And|Fine',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'Please ______ on this point',
            'answer': 'Expatiate',
            'options': 'Expantiate|Expertiate|Expatiate|Expartiate',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The party has only just ________',
            'answer': 'None',
            'options': 'Began|Being began|Commence|None',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'This is just the tip of the _________',
            'answer': 'None',
            'options': 'Ice|Ice breaker|Ice bag|None',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The player was _______ side',
            'answer': 'Off',
            'options': 'Up|Of|Off|On the',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'We are going on a three _________ holiday',
            'answer': 'week',
            'options': "weeks|Weeks|week|Weeks",
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'There is ______ poverty in Nigeria',
            'answer': 'Abject',
            'options': 'Abject|Object|Ground|Grounded',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'Adjourn collocates _________',
            'answer': 'Matter',
            'options': 'Cult|Matter|Quarrel|Magistrate',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'To persevere means to __________',
            'answer': 'None',
            'options': 'Preserve|Moan|Cajole|None',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The past tense of burst is _________',
            'answer': 'None',
            'options': 'Bursts|None|Bursted|Busted',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'You are nothing but a _______ weather friend',
            'answer': 'None',
            'options': 'Fear|Fare|Sphere|None',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The building was _______ to borrow from the bank',
            'answer': 'Razed',
            'options': 'Raze|Razed|Erase|Erased',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'We needed a ________ to borrow from the bank',
            'answer': 'Collateral',
            'options': 'Surety|Guarantee|Collateral|Mortgage',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'I know the _______ of the word',
            'answer': 'Pronunciation',
            'options':
                'Pronounciation|Pronunciation|Pronunsation|Pronountiation',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The police action was very swift and _________',
            'answer': 'Decisive',
            'options': 'Determined|Positive|Possible|Decisive',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'The president with his wife and five body guards ________ attending a meeting in Paris',
            'answer': 'Is',
            'options': 'Are|Is|Were|Will',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The houses with their garden _______ sold',
            'answer': 'Were',
            'options': 'Was|Were|Is being|Was being',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The ________ hut is the one I built',
            'answer': 'Little white mud',
            'options':
                'Little white mud|White little mud|White mud little|None',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'The room is out of ________',
            'answer': 'None',
            'options': 'Bonds|Bond|Bound|None',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question': 'Tom used to be the best behaved student, _______',
            'answer': "Wasn’t he",
            'options': "Wasn’t he|Aren’t him?|Weren’t he?|Weren’t him?",
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Each morning and evening ______ another problem for the commuter',
            'answer': 'Presents',
            'options': 'Presented|Present|Presents|Presenting',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'If you go travelling without permission, you may ______ your job',
            'answer': 'None',
            'options': 'Loose|Loss|Be losing|None',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '“l cant bear to see the child suffer” is ________ phrase',
            'answer': 'Infinitive',
            'options': 'Gerundic|Infinitive|Participial|None',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                '“Being humble is his greatest desire” is ________ phrase',
            'answer': 'Gerund',
            'options': 'Gerund|Infinitive|Participial|Absolute',
            'answerIndex': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'Waiting for the bride’s arrival, the bride’s-groom prayed silently is ________ phrase',
            'answer': 'Participial',
            'options': 'Gerund|Infinitive|Participial|Absolute',
            'answerIndex': 2,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'The most handsome boy has won the pageant is a ________ phrase',
            'answer': 'Noun phrase',
            'options':
                'Adverbial phrase|Prepositional phrase|Adjectival phrase|Noun phrase',
            'answerIndex': 3,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      batch.insert(
          tableName,
          {
            'question':
                'The man "who showed me the way" is a kind is a ________ clause',
            'answer': 'Adjectival clause',
            'options': 'Adverbial clause|Adjectival clause|Noun clause|None',
            'answerIndex': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      var results = await batch.commit();
      // return true;
    } catch (e) {
      // print('Error inserting questions to the table $e');
      // return false;
    }
  }

  static Future<int> countQuestions(String tableName) async {
    ///Count the number of questions in the table
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    try {
      List<Map<String, dynamic>> numberOfQuestions =
          await db.rawQuery('SELECT COUNT(*) FROM $tableName');
      // print("the result is ${numberOfQuestions[0]['COUNT(*)']}");
      return numberOfQuestions[0]['COUNT(*)'];
    } catch (e) {
      print("Error counting the number of questions $e");
      return 0;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchQuestions(
      String tableName) async {
    ///Fetch all questions from the specific table
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    try {
      List<Map<String, dynamic>> questions = await db.query(tableName);
      // print("the questions is $questions");
      return questions;
    } catch (e) {
      print("Error fetching questions from the table $e");
      return [];
    }
  }

  // static Future<bool> checkAnswer(int chosenIndex)
}
