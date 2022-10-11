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

///////////////////////////////////////////////////////////////////
// ПрограммныйИнтерфейс
// Экспортные процедуры и функции для прикладного использования 
/////////////////////////////////////////////////////////////////// 
#Область ПрограммныйИнтерфейс

// Обучение.
// Начинает обучение мокито для регистрации правил подмены вызовов методов
// 
// Параметры:
//  Объект - Произвольный - Объект, методы которого хотим подменить
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция Обучение(Объект) Экспорт
	
	УстановитьПараметрыОбучения(Объект);
	
	Возврат МокитоОбучение;
	
КонецФункции

// Наблюдать.
// 
// Параметры:
//  ИмяМетода - Строка - Имя метода обучаемого объекта
//            - Произвольный - Вызов метода обучаемого объекта
//  ПараметрыВызова - Массив из Произвольный - Параметры вызова метода обучаемого объекта
// Варианты вызова:
//  Мокито.Обучение(Произвольный).Когда(Строка, Массив); // Вызов через указание имени метода и параметров
//  Мокито.Обучение(Произвольный).Когда(Произвольный); // Вызов через явное выполнение наблюдаемого метода
// 
// Возвращаемое значение:
//  ОбщийМодуль
// Пример:
//  Мокито.Обучение(ОбщегоНазначения).Наблюдать("ЭтоДопустимоеИмяПеременной", Мокито.МассивПараметров(""));
//  Мокито.Обучение(ОбщегоНазначения).Наблюдать(ОбщегоНазначения.ЭтоДопустимоеИмяПеременной(""));
Функция Наблюдать(ИмяМетода, ПараметрыВызова = Неопределено) Экспорт
	
	ЗарегистрироватьПерехватВыражения(ИмяМетода, ПараметрыВызова);
	
	Возврат МокитоОбучение;
	
КонецФункции

// Когда.
// 
// Параметры:
//  ИмяМетода - Строка - Имя метода обучаемого объекта
//            - Произвольный - Вызов метода обучаемого объекта
//  ПараметрыВызова - Массив из Произвольный - Параметры вызова метода обучаемого объекта
// Варианты вызова:
//  Мокито.Обучение(Произвольный).Когда(Строка, Массив); // Вызов через указание имени метода и параметров
//  Мокито.Обучение(Произвольный).Когда(Произвольный); // Вызов через явное выполнение наблюдаемого метода
// 
// Возвращаемое значение:
//  ОбщийМодуль
// Пример:
//  Мокито.Обучение(ОбщегоНазначения).Когда("ЭтоДопустимоеИмяПеременной", Мокито.МассивПараметров(""));
//  Мокито.Обучение(ОбщегоНазначения).Когда(ОбщегоНазначения.ЭтоДопустимоеИмяПеременной(""));
Функция Когда(ИмяМетода, ПараметрыВызова = Неопределено) Экспорт
	
	Возврат Наблюдать(ИмяМетода, ПараметрыВызова);
	
КонецФункции

// Вернуть.
//  Указывает, что при соблюдении условий метод должен вернуть переданное значение
// Параметры:
//  Результат - Произвольный - Результат, который должен вернуть метод
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция Вернуть(Результат) Экспорт
	
	ЗарегистрироватьРеакцию(Новый Структура("ТипДействия, Результат", МокитоСлужебный.ТипыДействийРеакций().ВернутьРезультат, Результат));
	
	Возврат МокитоОбучение;
	
КонецФункции

// Выбросить исключение.
//  Указывает, что при соблюдении условий метод должен выбросить исключение
// 
// Параметры:
//  ТекстИсключения - Строка
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция ВыброситьИсключение(ТекстИсключения) Экспорт
	
	ЗарегистрироватьРеакцию(Новый Структура("ТипДействия, Ошибка", МокитоСлужебный.ТипыДействийРеакций().ВыброситьИсключение, ТекстИсключения));
	
	Возврат МокитоОбучение;
	
КонецФункции

// Пропустить.
//  Указывает, что при соблюдении условий метод не должен выполняться, его вызов пропускается
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция Пропустить() Экспорт
	
	ЗарегистрироватьРеакцию(Новый Структура("ТипДействия", МокитоСлужебный.ТипыДействийРеакций().Пропустить));
	
	Возврат МокитоОбучение;
	
КонецФункции

// Выполнить метод.
//  Указывает, что при соблюдении условий метод должен выполняться
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция ВыполнитьМетод() Экспорт
	
	ЗарегистрироватьРеакцию(Новый Структура("ТипДействия", МокитоСлужебный.ТипыДействийРеакций().ВызватьОсновнойМетод));
	
	Возврат МокитоОбучение;
	
КонецФункции

// Прогон
//  Переводит мокито в режим прогона тестов
//  Вызов этого метода обязателен перед выполнением тестового прогона метода 
Процедура Прогон() Экспорт
	
	Мокито.Прогон();
	
КонецПроцедуры

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныеПроцедурыИФункции

Процедура ЗарегистрироватьПерехватВыражения(ИмяМетода, ПараметрыВызова)
	
	Объект = ОбучаемыйОбъект();
	ДанныеПерехвата = МокитоСлужебный.ДанныеПерехвата(Объект);
	
	Если ДанныеПерехвата = Неопределено Тогда
		Сообщение = СтрШаблон("Не найдены настройки перехвата для %1. Необходимо предварительно вызвать метод Мокито.Обучение(Объект)", Объект);
		ВызватьИсключение Сообщение;
	КонецЕсли;
	
	Если МокитоСлужебный.ЭтоСтруктураВызоваМетода(ИмяМетода) Тогда
		СтруктураВызоваМетода = ИмяМетода;
	Иначе
		СтруктураВызоваМетода = МокитоСлужебный.СтруктураВызоваМетода(Объект, ИмяМетода, ПараметрыВызова);
	КонецЕсли;
	
	Методы = ДанныеПерехвата.Методы;
	
	Если НЕ Методы.Свойство(СтруктураВызоваМетода.ИмяМетода) Тогда
		Методы.Вставить(СтруктураВызоваМетода.ИмяМетода, ОписаниеПараметровПерехватаМетода());
	КонецЕсли;
	
	Реакция = СоздатьОписаниеУсловнойРеакции(СтруктураВызоваМетода);
	
	Методы[СтруктураВызоваМетода.ИмяМетода].Реакции.Добавить(Реакция);
	
	ПараметрыОбучения().РеакцияТекущегоВыражения = Реакция;
	
КонецПроцедуры

Функция ОписаниеПараметровПерехватаМетода()
	
	Возврат Новый Структура("Реакции", Новый Массив);
	
КонецФункции

#Область Реакции

Функция СоздатьОписаниеУсловнойРеакции(СтруктураВызоваМетода)
	
	Возврат Новый Структура("УсловиеРеакции, Действие", УсловиеРеакции(СтруктураВызоваМетода), Неопределено);
	
КонецФункции

Функция УсловиеРеакции(СтруктураВызоваМетода)
	
	Параметры = СтруктураВызоваМетода.Параметры;
	
	Если Параметры = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Условия = Новый Массив;
	
	Для Каждого Параметр Из Параметры Цикл
		
		Если МокитоСлужебный.ЭтоМаскаПарамера(Параметр) Тогда
			
			Условия.Добавить(Параметр);
			
		Иначе
			
			Условия.Добавить(Новый Структура("Режим, Значение, Приоритет", "Значение", Параметр, 10));
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Условия;
	
КонецФункции

#КонецОбласти

#Область Параметры

Функция ОбучаемыйОбъект()
	
	ПараметрыОбучения = ПараметрыОбучения();
	
	Возврат ПараметрыОбучения.ОбучаемыйОбъект;
	
КонецФункции

Функция ПараметрыОбучения()
	
	Параметры = МокитоСлужебный.Настройки().ПараметрыОбучения;
	
	Возврат Параметры;
	
КонецФункции

Процедура УстановитьПараметрыОбучения(Объект)
	
	ПараметрыОбучения = Новый Структура("ОбучаемыйОбъект, РеакцияТекущегоВыражения", Объект, Неопределено);
	
	МокитоСлужебный.Настройки().ПараметрыОбучения = ПараметрыОбучения;
	МокитоСлужебный.ЗарегистрироватьПерехватОбъекта(Объект);
	
КонецПроцедуры

Процедура ЗарегистрироватьРеакцию(Действие)
	
	Действие.Вставить("Обработано", Ложь);
	
	ПараметрыОбучения().РеакцияТекущегоВыражения.Действие = Действие;

КонецПроцедуры

#КонецОбласти

#КонецОбласти
