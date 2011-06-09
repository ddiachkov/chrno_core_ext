# Описание
__chrno_core_ext__ -- некоторые полезные (и не очень) расширения для базовых классов Ruby.

## Hash

* __#assert_key_presence__ -- проверяет наличие заданных ключей в хеше и, в
  случае отсутствия любого, кидает исключение.

    hash = { a: 1, b: 2 }
    hash.assert_key_presence :a, :c  --> ArgumentError

* __#build__, __.build__ -- удобный интерфейс для создание и редактирования хешей.

    hash = Hash.build do |h|
      h.a = 1
      h.b = 2
      h.c.d = 3
      h[ "some_string" ] = 4
    end

    hash  #=> { a: 1, b: 2, c: { d: 3 }, "some string": 4 }

    hash.build do |h|
      h.c = 8
    end

    hash  #=> { a: 1, b: 2, c: 8, "some string": 4 }

## String

* __#present_participle__ -- возвращает «ing'овую» форму глагола.

    "tag".present_participle   #=> "tagging"
    "build".present_participle #=> "building"

* __#to_b__ -- преобразует строку в булевое значение.

    "true".to_b         #=> true
    "some string".to_b  #=> false
    "".to_b             #=> false
    "1".to_b            #=> true
    "yes".to_b          #=> true
    "no".to_b           #=> false