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
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныйПрограммныйИнтерфейс

// Варианты.
// 
// Параметры:
//  Реквизиты - Строка - Реквизиты
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция Варианты(Реквизиты) Экспорт
	
	Варианты = Новый Структура("Реквизиты, Варианты, КоличествоРеквизитов", Реквизиты, Новый Массив());
	Вариант = Новый Структура(Реквизиты);
	Варианты.КоличествоРеквизитов = Вариант.Количество();
	
	ЮТКонтекст.УстановитьЗначениеКонтекста(КлючКонтекста(), Варианты);
	
	Возврат ЮТКонструкторВариантов;
	
КонецФункции

Функция Добавить(Параметр1, Параметр2 = Неопределено, Параметр3 = Неопределено, Параметр4 = Неопределено, Параметр5 = Неопределено) Экспорт
	
	Варианты = ЮТКонтекст.ЗначениеКонтекста(КлючКонтекста());
	
	Если Варианты.КоличествоРеквизитов = 1 Тогда
		Вариант = Новый Структура(Варианты.Реквизиты, Параметр1);
	ИначеЕсли Варианты.КоличествоРеквизитов = 2 Тогда
		Вариант = Новый Структура(Варианты.Реквизиты, Параметр1, Параметр2);
	ИначеЕсли Варианты.КоличествоРеквизитов = 3 Тогда
		Вариант = Новый Структура(Варианты.Реквизиты, Параметр1, Параметр2, Параметр3);
	ИначеЕсли Варианты.КоличествоРеквизитов = 4 Тогда
		Вариант = Новый Структура(Варианты.Реквизиты, Параметр1, Параметр2, Параметр3, Параметр4);
	ИначеЕсли Варианты.КоличествоРеквизитов = 5 Тогда
		Вариант = Новый Структура(Варианты.Реквизиты, Параметр1, Параметр2, Параметр3, Параметр4, Параметр5);
	КонецЕсли;
	
	Варианты.Варианты.Добавить(Вариант);
	
	Возврат ЮТКонструкторВариантов;
	
КонецФункции

// Список вариантов.
// 
// Возвращаемое значение:
//  Массив из Структура
Функция СписокВариантов() Экспорт
	
	Возврат ЮТКонтекст.ЗначениеКонтекста(КлючКонтекста()).Варианты;
	
КонецФункции

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 
#Область СлужебныеПроцедурыИФункции

Функция КлючКонтекста()
	
	Возврат "ВариантыТеста";
	
КонецФункции

#КонецОбласти
