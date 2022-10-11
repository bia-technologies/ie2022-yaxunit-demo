Процедура ПриНачалеРаботыСистемы() Экспорт
	
	Если НЕ СистемаВзаимодействия.ИнформационнаяБазаЗарегистрирована() Тогда
		Возврат;
	КонецЕсли;
	
	Обработчик = Новый ОписаниеОповещения("ОбработкаДействияСообщения", ЭтотОбъект);
	СистемаВзаимодействия.ПодключитьОбработчикДействияСообщения(Обработчик);

КонецПроцедуры

Процедура ОбработкаДействияСообщения(Сообщение, Действие, ДопПараметры) Экспорт
	
	Если Действие = "Settings" Тогда
		ОткрытьФорму("ОбщаяФорма.НастройкаПомощникаНеотработанныхЗаказов");
		Возврат;
	КонецЕсли;
	
	Если Действие = "CheckNow" Тогда
		Помощник.ПомощникНеотработанныеЗаказы();
		Возврат;
	КонецЕсли;
	
КонецПроцедуры