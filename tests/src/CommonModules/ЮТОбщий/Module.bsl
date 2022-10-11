//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2022 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции, предназначенные для использования другими 
// объектами конфигурации или другими программами
///////////////////////////////////////////////////////////////////////////////// 
#Область ПрограммныйИнтерфейс

#Область Строки

// ДобавитьСтроку
//  Конкатенирует строки, разделяя их разделителем
//
// Параметры:
//  ИсходнаяСтрока		 - Строка	 - Исходная строка
//  ДополнительнаяСтрока - Строка	 - Добавляемая строка
//  Разделитель			 - Строка	 - Строка разделитель, любой набор символов - разделитель между подстроками
// 
// Возвращаемое значение:
//  Строка - Результат конкатенации строк
//
Функция ДобавитьСтроку(Знач ИсходнаяСтрока, Знач ДополнительнаяСтрока, Знач Разделитель = ";") Экспорт
	
	Если Не ПустаяСтрока(ДополнительнаяСтрока) Тогда
		
		Если Не ПустаяСтрока(ИсходнаяСтрока) Тогда
			
			Возврат Строка(ИсходнаяСтрока) + Разделитель + Строка(ДополнительнаяСтрока);
			
		Иначе
			
			Возврат Строка(ДополнительнаяСтрока);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Строка(ИсходнаяСтрока);
	
КонецФункции

// РазложитьСтрокуВМассивПодстрок
// Возвращает массив на основании строки
//
// Параметры:
//  Значение - Строка - преобразуемая строка
//  Разделитель - Строка - строка-разделитель
//  УдалятьКонцевыеПробелы - Булево - удалять или нет концевые пробелы между элементами в строке
//  Фиксированный - Булево - возвращать фиксированный или обычный массив
// 
// Возвращаемое значение:
//  Массив, ФиксированныйМассив - массив строк
//
Функция РазложитьСтрокуВМассивПодстрок(Знач Значение, Разделитель = ";", УдалятьКонцевыеПробелы = Ложь,
	Фиксированный = Ложь) Экспорт
	
	Результат = Новый Массив;
	
	КодУниверсальногоРазделителя = 5855;
	УниверсальныйРазделитель = Символ(КодУниверсальногоРазделителя);
	МодифицированнаяСтрока = СтрЗаменить(Значение, Разделитель, УниверсальныйРазделитель);
	
	МассивСтрок = ?(МодифицированнаяСтрока = "", Новый Массив, СтрРазделить(МодифицированнаяСтрока,
		УниверсальныйРазделитель));
	
	Если УдалятьКонцевыеПробелы Тогда
		
		Для Индекс = 0 По МассивСтрок.ВГраница() Цикл
			
			МассивСтрок[Индекс] = СокрЛП(МассивСтрок[Индекс]);
			
		КонецЦикла;
		
	КонецЕсли;
		
	Если Фиксированный Тогда
		
		Результат = Новый ФиксированныйМассив(МассивСтрок);
		
	Иначе
		
		Результат =  МассивСтрок;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область Коллекции

// ЗначениеСтруктуры
// Возвращает требуемое поле структуры. В случае отсутствия поля возвращает значение по умолчанию
// 
// Параметры:
//  ИсходнаяСтруктура - Структура - Исходная структура
//  ИмяПоля - Строка - Имя поля структуры
//  ЗначениеПоУмолчанию - Произвольный - Значение, которое будет возвращено, если поля в структуре нет
//  ПроверятьЗаполненность - Булево - Необходимость проверять значение на заполненность. Если не заполнено,
// то возвращается значение по умолчанию
// 
// Возвращаемое значение:
//  Произвольный -- Значение искомого поля структуры
Функция ЗначениеСтруктуры(Знач ИсходнаяСтруктура, ИмяПоля, Знач ЗначениеПоУмолчанию = Неопределено,	ПроверятьЗаполненность = Ложь) Экспорт
	
	Если ПустаяСтрока(ИмяПоля) Тогда
		
		Возврат ЗначениеПоУмолчанию;
		
	КонецЕсли;
	
	ЗначениеПоля = Неопределено;
	Если ИсходнаяСтруктура.Свойство(ИмяПоля, ЗначениеПоля) Тогда
		Если ПроверятьЗаполненность И ЗначениеЗаполнено(ЗначениеПоля) Или Не ПроверятьЗаполненность Тогда
			Возврат ЗначениеПоля;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ЗначениеПоУмолчанию;
	
КонецФункции

// ЗначениеСоответствия
//  Возвращает требуемое поле соответствия. В случае отсутствия поля возвращает значение по умолчанию
//
// Параметры:
//  ИсходноеСоответствие - Соответствие	 - Исходное соответствия
//  ИмяПоля				 - Строка		 - Имя поля соответствия
//  ЗначениеПоУмолчанию	 - Произвольный	 - Значение, которое будет возвращено, если поля в соответствии нет
// 
// Возвращаемое значение:
//  Произвольный - Значение искомого поля структуры
//
Функция ЗначениеСоответствия(Знач ИсходноеСоответствие, ИмяПоля, Знач ЗначениеПоУмолчанию = Неопределено) Экспорт
	
	Если ПустаяСтрока(ИмяПоля) Тогда
		
		Возврат ЗначениеПоУмолчанию;
		
	КонецЕсли;
	
	ЗначениеПоля = ИсходноеСоответствие.Получить(ИмяПоля);
	Если ЗначениеПоля <> Неопределено Тогда
		
		Возврат ЗначениеПоля;
		
	КонецЕсли;
	
	Возврат ЗначениеПоУмолчанию;
	
КонецФункции

// ОбъединитьВСтруктуру
//  Функция, объединяющая две коллекции( с типами Структура или Соответствие) в одну структуру, если это возможно
//
// Параметры:
//  Коллекция1						 - Соответствие, Структура	 - Коллекция с типом структура или соответствие
//  Коллекция2						 - Соответствие, Структура	 - Коллекция с типом структура или соответствие
//  РезультатВФиксированнуюКоллекцию - Булево					 - Признак фиксированной коллекции, необязательный, по умолчанию Ложь,
//  																если Истина, возвращает фиксированная коллекция
// 
// Возвращаемое значение:
//  Структура - Результат объединения двух коллекций
//
Функция ОбъединитьВСтруктуру(Знач Коллекция1, Коллекция2, РезультатВФиксированнуюКоллекцию = Ложь) Экспорт
	
	Если ТипЗнч(Коллекция1) <> Тип("Структура") Тогда
	
		Коллекция1 = СкопироватьСтруктуру(Коллекция1);
	
	КонецЕсли;
	
	СтруктураРезультат = ДобавитьКлючИЗначениеВКоллекцию(Коллекция1, Коллекция2);
	
	Возврат ?(РезультатВФиксированнуюКоллекцию, Новый ФиксированнаяСтруктура(СтруктураРезультат), СтруктураРезультат);
	
КонецФункции

// СкопироватьРекурсивно
//  Создает копию экземпляра указанного объекта.
//  Примечание:
//  Функцию нельзя использовать для объектных типов (СправочникОбъект, ДокументОбъект и т.п.).
//
// Параметры:
//  Источник						 - Произвольный	 - объект, который необходимо скопировать.
//  ФиксированнаяКоллекцияВОбычную	 - Булево		 - Если значение равно Истина, то из Фиксированной коллекции формируется обычная
// 
// Возвращаемое значение:
//  Произвольный - копия объекта, переданного в параметре Источник.
//
Функция СкопироватьРекурсивно(Знач Источник, ФиксированнаяКоллекцияВОбычную = Ложь) Экспорт
	
	Перем Приемник;
	
	СкопироватьПрисвоением = Ложь;
	
	ТипИсточника = ТипЗнч(Источник);
	Если ТипИсточника = Тип("Структура") Или ТипИсточника = Тип("ФиксированнаяСтруктура") Тогда
	
		Приемник = СкопироватьСтруктуру(Источник, ФиксированнаяКоллекцияВОбычную);
	
	ИначеЕсли ТипИсточника = Тип("Соответствие") Или ТипИсточника = Тип("ФиксированноеСоответствие") Тогда
	
		Приемник = СкопироватьСоответствие(Источник, ФиксированнаяКоллекцияВОбычную);
	
	ИначеЕсли ТипИсточника = Тип("Массив") Или ТипИсточника = Тип("ФиксированныйМассив") Тогда
	
		Приемник = СкопироватьМассив(Источник, ФиксированнаяКоллекцияВОбычную);
	
	ИначеЕсли ТипИсточника = Тип("СписокЗначений") Тогда
	
		Приемник = СкопироватьСписокЗначений(Источник, ФиксированнаяКоллекцияВОбычную);
	
	Иначе
	
		СкопироватьПрисвоением = Истина;
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
		Если ТипИсточника = Тип("ТаблицаЗначений") Или ТипИсточника = Тип("ДеревоЗначений") Тогда
			
			СкопироватьПрисвоением = Ложь;
			Приемник = Источник.Скопировать();
			
		КонецЕсли;
#КонецЕсли
	
	КонецЕсли;
	
	Если СкопироватьПрисвоением Тогда
	
		Приемник = Источник;
	
	КонецЕсли;
	
	Возврат Приемник;
	
КонецФункции

// СкопироватьСтруктуру
//  Создает копию значения типа Структура
//
// Параметры:
//  СтруктураИсточник				 - Структура - копируемая структура
//  ФиксированнаяКоллекцияВОбычную	 - Булево	 - Если значение равно Истина, то из Фиксированной коллекции формируется обычная
// 
// Возвращаемое значение:
//  Структура - копия исходной структуры.
//
Функция СкопироватьСтруктуру(СтруктураИсточник, ФиксированнаяКоллекцияВОбычную = Ложь) Экспорт
	
	СтруктураРезультат = Новый Структура;
	
	Для Каждого КлючИЗначение Из СтруктураИсточник Цикл
	
		СтруктураРезультат.Вставить(КлючИЗначение.Ключ, СкопироватьРекурсивно(КлючИЗначение.Значение,
			ФиксированнаяКоллекцияВОбычную));
	
	КонецЦикла;
	
	Если ТипЗнч(СтруктураИсточник) = Тип("ФиксированнаяСтруктура") И Не ФиксированнаяКоллекцияВОбычную Тогда
	
		СтруктураРезультат = Новый ФиксированнаяСтруктура(СтруктураРезультат);
	
	КонецЕсли;
	
	Возврат СтруктураРезультат;
	
КонецФункции

// СкопироватьСоответствие
//  Создает копию значения типа Соответствие.
//
// Параметры:
//  СоответствиеИсточник			 - Соответствие	 - соответствие, копию которого необходимо получить.
//  ФиксированнаяКоллекцияВОбычную	 - Булево		 - Если значение равно Истина, то из Фиксированной коллекции формируется обычная
// 
// Возвращаемое значение:
//  Соответствие - копия исходного соответствия.
//
Функция СкопироватьСоответствие(СоответствиеИсточник, ФиксированнаяКоллекцияВОбычную = Ложь) Экспорт

	СоответствиеРезультат = Новый Соответствие;

	Для Каждого КлючИЗначение Из СоответствиеИсточник Цикл

		СоответствиеРезультат.Вставить(СкопироватьРекурсивно(КлючИЗначение.Ключ, ФиксированнаяКоллекцияВОбычную),
			СкопироватьРекурсивно(КлючИЗначение.Значение, ФиксированнаяКоллекцияВОбычную));

	КонецЦикла;

	Если ТипЗнч(СоответствиеИсточник) = Тип("ФиксированноеСоответствие") И Не ФиксированнаяКоллекцияВОбычную Тогда

		СоответствиеРезультат = Новый ФиксированноеСоответствие(СоответствиеРезультат);

	КонецЕсли;

	Возврат СоответствиеРезультат;

КонецФункции

// СкопироватьМассив
//  Создает копию значения типа Массив.
//
// Параметры:
//  МассивИсточник					 - Массив	 - массив, копию которого необходимо получить
//  ФиксированнаяКоллекцияВОбычную	 - Булево	 - Если значение равно Истина, то из Фиксированной коллекции формируется обычная
// 
// Возвращаемое значение:
//  Массив - копия исходного массива.
//
Функция СкопироватьМассив(МассивИсточник, ФиксированнаяКоллекцияВОбычную = Ложь) Экспорт
	
	МассивРезультат = Новый Массив;
	
	Для Каждого Элемент Из МассивИсточник Цикл
	
		МассивРезультат.Добавить(СкопироватьРекурсивно(Элемент, ФиксированнаяКоллекцияВОбычную));
	
	КонецЦикла;
	
	Если ТипЗнч(МассивИсточник) = Тип("ФиксированныйМассив") И Не ФиксированнаяКоллекцияВОбычную Тогда
	
		МассивРезультат = Новый ФиксированныйМассив(МассивРезультат);
	
	КонецЕсли;
	
	Возврат МассивРезультат;
	
КонецФункции

// СкопироватьСписокЗначений
//  Создает копию значения типа СписокЗначений.
//
// Параметры:
//  СписокИсточник					 - СписокЗначений	 - список значений, копию которого необходимо получить
//  ФиксированнаяКоллекцияВОбычную	 - Булево			 - Если значение равно Истина, то из Фиксированной коллекции формируется обычная
// 
// Возвращаемое значение:
//  СписокЗначений - копия исходного списка значений
//
Функция СкопироватьСписокЗначений(СписокИсточник, ФиксированнаяКоллекцияВОбычную = Ложь) Экспорт
	
	СписокРезультат = Новый СписокЗначений;
	
	Для Каждого ЭлементСписка Из СписокИсточник Цикл
	
		СписокРезультат.Добавить(
			СкопироватьРекурсивно(ЭлементСписка.Значение, ФиксированнаяКоллекцияВОбычную), ЭлементСписка.Представление,
			ЭлементСписка.Пометка, ЭлементСписка.Картинка);
	
	КонецЦикла;
	
	Возврат СписокРезультат;
	
КонецФункции

// СтруктурыРавны
// 	Выполняет сравнение структур между собой
// Параметры:
//  Структура1 - Структура - Первая структура
//  Структура2 - Структура - Вторая структура
//  СравниватьТолькоКлючи - Булево - Сравнивать только ключи либо и значения
// 
// Возвращаемое значение:
//  Булево - Равнозначность структур
Функция СтруктурыРавны(Структура1, Структура2, СравниватьТолькоКлючи = Истина) Экспорт
	Если Структура1.Количество() <> Структура2.Количество() Тогда
		Возврат Ложь;
	Иначе
		Для Каждого Свойство Из Структура1 Цикл
			Если Не Структура2.Свойство(Свойство.Ключ) Или Не СравниватьТолькоКлючи И ЗначениеСтруктуры(Структура2,
				Свойство.Ключ) <> Свойство.Значение Тогда
				Возврат Ложь;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	Возврат Истина;
КонецФункции

Функция ВыгрузитьЗначения(Знач Коллекция, Знач ИмяРеквизита) Экспорт
	
	Результат = Новый Массив();
	
	Для Каждого ЭлементКоллекции Из Коллекция Цикл
		
		Результат.Добавить(ЭлементКоллекции[ИмяРеквизита]);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ПересечениеМассивов(Коллекция1, Коллекция2) Экспорт
	
	Результат = Новый Массив;
	
	Для Каждого Элемент Из Коллекция1 Цикл
		
		Если Коллекция2.Найти(Элемент) <> Неопределено Тогда
			Результат.Добавить(Элемент);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ЗначениеВМассиве(Значение,
							Значение2 = "_!%*",
							Значение3 = "_!%*",
							Значение4 = "_!%*",
							Значение5 = "_!%*",
							Значение6 = "_!%*",
							Значение7 = "_!%*",
							Значение8 = "_!%*",
							Значение9 = "_!%*",
							Значение10 = "_!%*") Экспорт
	
	Массив = Новый Массив;
	Массив.Добавить(Значение);
	
	ФлагОкончания = "_!%*";
	
	Значения = Новый Массив;
	
	Если Значение <> ФлагОкончания Тогда
		Значения.Добавить(Значение);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение2 <> ФлагОкончания Тогда
		Значения.Добавить(Значение2);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение3 <> ФлагОкончания Тогда
		Значения.Добавить(Значение3);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение4 <> ФлагОкончания Тогда
		Значения.Добавить(Значение4);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение5 <> ФлагОкончания Тогда
		Значения.Добавить(Значение5);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение6 <> ФлагОкончания Тогда
		Значения.Добавить(Значение6);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение7 <> ФлагОкончания Тогда
		Значения.Добавить(Значение7);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение8 <> ФлагОкончания Тогда
		Значения.Добавить(Значение8);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение9 <> ФлагОкончания Тогда
		Значения.Добавить(Значение9);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Если Значение10 <> ФлагОкончания Тогда
		Значения.Добавить(Значение10);
	Иначе
		Возврат Значения;
	КонецЕсли;
	
	Возврат Значения;
	
КонецФункции

Процедура ДополнитьМассив(Приемник, Источник) Экспорт
	
	Для Каждого Элемент Из Источник Цикл
		
		Приемник.Добавить(Элемент);
		
	КонецЦикла;
	
КонецПроцедуры

// КоллекцияВСоответствие
// 	Возвращает соответствие элементов переданной коллекции, в качестве ключей выступают значения указанного поля элементов коллекции.
// 
// Параметры:
// 	Коллекция - Произвольный - значение, для которого определен итератор, и возможно обращение к полям элементов через квадратные скобки.
// 	ИмяПоляКлюча - Строка - имя поля элемента коллекции, которое будет ключом соответствия.
// 	ИмяПоляЗначения - Строка - если указан, значениями результата будут не элементы, а значения соответствующих полей элементов коллекции.
// Возвращаемое значение:
// 	Соответствие - полученное соответствие.
Функция КоллекцияВСоответствие(Коллекция, ИмяПоляКлюча, ИмяПоляЗначения = Неопределено) Экспорт
	
	Результат = Новый Соответствие();
	
	Для Каждого ЭлементКоллекции Из Коллекция Цикл
		
		Значение = ?(ИмяПоляЗначения = Неопределено, ЭлементКоллекции, ЭлементКоллекции[ИмяПоляЗначения]);
		
		Результат.Вставить(ЭлементКоллекции[ИмяПоляКлюча], Значение);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область ЧтениеДанных

Функция ДанныеТекстовогоФайла(ИмяФайла) Экспорт
	
#Если НЕ ВебКлиент Тогда
	Чтение = Новый ЧтениеТекста;
	Чтение.Открыть(ИмяФайла, "UTF-8");
	Текст = Чтение.Прочитать();
	Чтение.Закрыть();
	
	Возврат Текст;
#Иначе
	ВызватьИсключение "Чтение данных текстовых файлов в веб-клиенте не поддерживается";
#КонецЕсли
	
КонецФункции

Функция ЗначениеИзJSON(СтрокаJSON) Экспорт
	
#Если НЕ ВебКлиент Тогда
	Чтение = Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(СтрокаJSON);
	Значение = ПрочитатьJSON(Чтение);
	Чтение.Закрыть();
	Возврат Значение;
#Иначе
	ВызватьИсключение "Разбор JSON строки в веб-клиенте не поддерживается";
#КонецЕсли
	
КонецФункции

#КонецОбласти

// МетодМодуляСуществует
// Проверяет существование публичного (экспортного) метода у объекта
// 
// Параметры:
//  ИмяМодуля - Строка - Имя модуля, метод которого нужно поискать
//  ИмяМетода - Строка - Имя метода, который ищем
//  КоличествоПараметров - Число - Количество параметров метода, увы это никак не влияет на проверку
//  Кешировать - Булево - Признак кеширования результата проверки
// 
// Возвращаемое значение:
//  Булево -- Метод найден
Функция МетодМодуляСуществует(ИмяМодуля, ИмяМетода, КоличествоПараметров = 0, Кешировать = Истина) Экспорт
	
	Если Кешировать Тогда
		Возврат ЮТПовторногоИспользования.МетодМодуляСуществует(ИмяМодуля, ИмяМетода, КоличествоПараметров);
	КонецЕсли;
	
	Алгоритм = СтрШаблон("%1.%2(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,)", ИмяМодуля, ИмяМетода);
	
	Ошибка = ВыполнитьМетод(Алгоритм);
	МетодСуществует = СтрНайти(НРег(Ошибка.Описание), "(" + НРег(ИмяМетода) + ")") = 0;
	
	Возврат МетодСуществует;
	
КонецФункции

Функция ВыполнитьМетод(ПолноеИмяМетода, Параметры = Неопределено) Экспорт
	
	Если СтрЗаканчиваетсяНа(ПолноеИмяМетода, ")") Тогда
		
		Алгоритм = ПолноеИмяМетода;
		
	ИначеЕсли НЕ ЗначениеЗаполнено(Параметры) Тогда
		
		Алгоритм = ПолноеИмяМетода + "()";
		
	Иначе
		
		Алгоритм = "";
		Для Инд = 0 По Параметры.ВГраница() Цикл
			
			Алгоритм = ДобавитьСтроку(Алгоритм, СтрШаблон("Параметры[%1]", Инд), ", ");
			
		КонецЦикла;
		
		Алгоритм = СтрШаблон("%1(%2)", ПолноеИмяМетода, Алгоритм);
		
	КонецЕсли;
	
	Попытка
		Выполнить(Алгоритм);
	Исключение
		Возврат ИнформацияОбОшибке();
	КонецПопытки;
	
	Возврат Неопределено;
	
КонецФункции

// ПеременнаяСодержитСвойство
//  функция проверяет наличие свойства у значения любого типа данных. Если передано НЕОПРЕДЕЛЕНО, то ф-ия всегда вернет Ложь
//
// Параметры:
//  Переменная	 - Произвольный	 - переменная любого типа, для которой необходимо проверить наличие свойства
//  ИмяСвойства	 - Строка		 - переменная типа "Строка", содержащая искомое свойства
// 
// Возвращаемое значение:
//  Булево - признак наличия свойства у значения
//
Функция ПеременнаяСодержитСвойство(Переменная, ИмяСвойства) Экспорт
	
	Если Переменная = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	// Инициализируем структуру для теста с ключом (значение переменной "ИмяСвойства") и значением произвольного GUID'а
	GUIDПроверка = Новый УникальныйИдентификатор;
	СтруктураПроверка = Новый Структура;
	СтруктураПроверка.Вставить(ИмяСвойства, GUIDПроверка);
	// Заполняем созданную структуру из переданного значения переменной
	ЗаполнитьЗначенияСвойств(СтруктураПроверка, Переменная);
	// Если значение для свойства структуры осталось GUIDПроверка, то искомое свойство не найдено, и наоборот.
	Возврат СтруктураПроверка[ИмяСвойства] <> GUIDПроверка;
	
КонецФункции

// СообщитьПользователю
//  Формирует и выводит сообщение, которое может быть связано с элементом
//  управления формы.
//
// Параметры:
//  ТекстСообщенияПользователю	 - Строка	 - текст сообщения.
//  Поле						 - Строка	 - наименование реквизита формы
//  ПутьКДанным					 - Строка	 - путь к данным (путь к реквизиту формы)
//  ОбъектИлиСсылка				 - Объект, Ссылка	 - Ссылка на объект ИБ или объект
//  ИдентификаторНазначения		 - Строка, УникальныйИдентификатор	 - Уникальный идентификатор экземпляра формы 
//  	к которой должно быть "привязано" сообщение
//
Процедура СообщитьПользователю(ТекстСообщенияПользователю = "", Поле = "",
		ПутьКДанным = "", ОбъектИлиСсылка = Неопределено,
		Знач ИдентификаторНазначения = "") Экспорт
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = СокрЛП(ТекстСообщенияПользователю);
	Сообщение.Поле = Поле;
	
	Если ЗначениеЗаполнено(ИдентификаторНазначения) Тогда
		
		Если ТипЗнч(ИдентификаторНазначения) = Тип("Строка") Тогда
			
			ИдентификаторНазначения = Новый УникальныйИдентификатор(ИдентификаторНазначения);
			
		КонецЕсли;
		
		Сообщение.ИдентификаторНазначения = ИдентификаторНазначения;
		
	КонецЕсли;
	
	Если Не ПустаяСтрока(ПутьКДанным) Тогда
		
		Сообщение.ПутьКДанным = ПутьКДанным;
		
	КонецЕсли;
	
	Если ОбъектИлиСсылка <> Неопределено Тогда
		
		Сообщение.УстановитьДанные(ОбъектИлиСсылка);
		
	КонецЕсли;
	
	Сообщение.Сообщить();
	
КонецПроцедуры

Функция СтрокаJSON(Значение) Экспорт
	
	ЗаписьJSON = Новый ЗаписьJSON();
	ЗаписьJSON.УстановитьСтроку();
	СериализаторXDTO.ЗаписатьJSON(ЗаписьJSON, Значение);
	
	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции // СтрокаJSON

Функция ПредставлениеЗначения(Значение) Экспорт
	
	Попытка
		Возврат СтрокаJSON(Значение);
	Исключение
		Возврат Строка(Значение);
	КонецПопытки;
	
КонецФункции

Функция ПредставлениеТипа(Тип) Экспорт
	
	ТипXML = СериализаторXDTO.XMLТип(Тип);
	
	Если ТипXML = Неопределено Тогда
		Возврат "<unknown>";
	Иначе
		Возврат ТипXML.ИмяТипа;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныйПрограммныйИнтерфейс

Функция ОписаниеТиповЛюбаяСсылка() Экспорт
	
	Возврат ЮТОбщийВызовСервера.ОписаниеТиповЛюбаяСсылка();
	
КонецФункции

Процедура ВызовУстаревшегоМетода(УстаревшийМетод, РекомендуемыйМетод = Неопределено) Экспорт
	
	Сообщение = СтрШаблон("Используется устаревший метод '%1'. В следующий релизах метод будет удален", УстаревшийМетод);
	
	Если ЗначениеЗаполнено(РекомендуемыйМетод) Тогда
		Сообщение = СтрШаблон("%1. Рекомендуется использовать '%2'", Сообщение, РекомендуемыйМетод);
	КонецЕсли;
	
	СообщитьПользователю(Сообщение);
	
КонецПроцедуры

Функция УстановленБезопасныйРежим() Экспорт
	
	Возврат ЮТОбщийВызовСервера.УстановленБезопасныйРежим();
	
КонецФункции

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныеПроцедурыИФункции

Функция ДобавитьКлючИЗначениеВКоллекцию(КоллекцияРезультат, Коллекция)

	Для Каждого Элемент Из Коллекция Цикл

		КоллекцияРезультат.Вставить(Элемент.Ключ, Элемент.Значение);

	КонецЦикла;

	Возврат КоллекцияРезультат;

КонецФункции

Функция Модуль(ИмяМодуля) Экспорт
	
	Возврат Вычислить(ИмяМодуля);
	
КонецФункции

#КонецОбласти
