// @strict-types

#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты
		.ВТранзакции()
		.ДобавитьТест("АктивныеНастройкиОбмена")
		.ДобавитьТест("ВыполнитьОбмены")
	;
	
КонецПроцедуры

Процедура АктивныеНастройкиОбмена() Экспорт
	
	ТестовыеДанныеИнтеграция.СоздатьНастройкуИнтеграции();
	ТестовыеДанныеИнтеграция.СоздатьНастройкуИнтеграции();
	ТестовыеДанныеИнтеграция.СоздатьНастройкуИнтеграции(Истина);
	
	Результат = ИнтеграцияМагазин.АктивныеНастройкиОбмена();
	
	ЮТест.ОжидаетЧто(Результат)
	.ИмеетТип("ТаблицаЗначений")
	.Свойство("Колонки.Адрес")
	.Свойство("Колонки.Ссылка")
	.Свойство("Колонки.Пользователь")
	.Объект()
	.ИмеетДлину(2);
	
КонецПроцедуры

Процедура ВыполнитьОбмены() Экспорт
	
	Настройки = ЮТОбщий.ЗначениеВМассиве(
		ТестовыеДанныеИнтеграция.ОписаниеНастройкиИнтеграции(),
		ТестовыеДанныеИнтеграция.ОписаниеНастройкиИнтеграции(),
		ТестовыеДанныеИнтеграция.ОписаниеНастройкиИнтеграции()
	);
	
	Мокито.Обучение(ИнтеграцияМагазин)
		.Когда(ИнтеграцияМагазин.АктивныеНастройкиОбмена()).Вернуть(Настройки)
		.Когда("ВыполнитьОбмен", Мокито.МассивПараметров(Настройки[1])).ВыброситьИсключение("Упади")
		.Когда("ВыполнитьОбмен").Пропустить()
		
		;
		
	Мокито.Прогон();
	
	ИнтеграцияМагазин.ВыполнитьОбмены();
	
	Мокито.Проверить(ИнтеграцияМагазин)
		.КоличествоВызовов("ВыполнитьОбмен").Равно(3)
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти