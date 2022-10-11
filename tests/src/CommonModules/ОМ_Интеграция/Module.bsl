// @strict-types

#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты
		.ДобавитьТест("ВыполнитьЗапрос")
		.ДобавитьТест("РазобратьURL")
		.ДобавитьТестовыйНабор("РазобратьURL")
		.ДобавитьТест("РазобратьURL2")
			.СПараметрами("Кейс1", "http://jsonplaceholder.typicode.com/", "jsonplaceholder.typicode.com", Ложь, "")
		.ДобавитьТест("РазобратьURL2")
			.СПараметрами("Кейс2", "https://jsonplaceholder.typicode.com/", "jsonplaceholder.typicode.com", Истина, "")
		.ДобавитьТест("РазобратьURL2")
			.СПараметрами("Кейс3", "http://jsonplaceholder.typicode.com/123", "jsonplaceholder.typicode.com", Ложь, "123")
		.ДобавитьТест("РазобратьURL2")
			.СПараметрами("Кейс4", "ftp://jsonplaceholder.typicode.com/", "jsonplaceholder.typicode.com", Ложь, "")
		.ДобавитьТест("РазобратьURL2")
			.СПараметрами("Кейс5", "ftps://jsonplaceholder.typicode.com/", "jsonplaceholder.typicode.com", Ложь, "")
	;
	
КонецПроцедуры

Процедура ВыполнитьЗапрос() Экспорт
	
	Результат = Интеграция.ВыполнитьЗапрос("http://jsonplaceholder.typicode.com/");
	
	ЮТест.ОжидаетЧто(Результат)
		.Свойство("Успешно").ЭтоИстина()
		.Свойство("Тело").Заполнено()
		.Свойство("КодСостояния").Равно(200);
	
КонецПроцедуры

Процедура РазобратьURL() Экспорт
	
	Результат = Интеграция.РазобратьURL("http://jsonplaceholder.typicode.com/");
	
	ЮТест.ОжидаетЧто(Результат)
	.Свойство("ИмяСервера").Равно("jsonplaceholder.typicode.com")
	.Свойство("ЗащищенноеСоединение").ЭтоЛожь()
	.Свойство("Протокол")
	.Свойство("АдресСкрипта").НеЗаполнено();
	
	Варианты = ЮТест.Варианты("Описание, Адрес, ИмяСервера, ЗащищенноеСоединение, АдресСкрипта")
		.Добавить("Кейс1", "http://jsonplaceholder.typicode.com/", "jsonplaceholder.typicode.com", Ложь, "")
		.Добавить("Кейс2", "https://jsonplaceholder.typicode.com/", "jsonplaceholder.typicode.com", Истина, "")
		.Добавить("Кейс3", "http://jsonplaceholder.typicode.com/123", "jsonplaceholder.typicode.com", Ложь, "123")
		.Добавить("Кейс4", "ftp://jsonplaceholder.typicode.com/", "jsonplaceholder.typicode.com", Ложь, "")
		.Добавить("Кейс5", "ftps://jsonplaceholder.typicode.com/", "jsonplaceholder.typicode.com", Ложь, "")
		.СписокВариантов();
		
	Для Каждого Вариант Из Варианты Цикл
		
	Результат = Интеграция.РазобратьURL(Вариант.Адрес);
	ЮТест.ОжидаетЧто(Результат, Вариант.Описание)
		.Свойство("ИмяСервера").Равно(Вариант.ИмяСервера)
		.Свойство("ЗащищенноеСоединение").Равно(Вариант.ЗащищенноеСоединение)
		.Свойство("АдресСкрипта").Равно(Вариант.АдресСкрипта);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура РазобратьURL2(Описание, Адрес, ИмяСервера, ЗащищенноеСоединение, АдресСкрипта) Экспорт
	
	Результат = Интеграция.РазобратьURL(Адрес);
	ЮТест.ОжидаетЧто(Результат, Описание)
		.Свойство("ИмяСервера").Равно(ИмяСервера)
		.Свойство("ЗащищенноеСоединение").Равно(ЗащищенноеСоединение)
		.Свойство("АдресСкрипта").Равно(АдресСкрипта);
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти