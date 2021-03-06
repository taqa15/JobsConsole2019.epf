﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УКО_ФормыКлиентСервер_Заголовок(ЭтаФорма, НСтр("ru = 'Экспорт во внешний отчет'; en = 'Export to external report'"));
	
	Имя = ИмяФайлаВнешнегоОтчета();
	Синоним = Параметры.Имя;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьЭлементыУправления();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	
	Если Не ЗначениеЗаполнено(Настройки["Имя"]) Тогда
		Настройки.Вставить("Имя", ИмяФайлаВнешнегоОтчета());
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИмяПриИзменении(Элемент)
	
	ОбновитьЭлементыУправления();

КонецПроцедуры

&НаКлиенте
Процедура КаталогПриИзменении(Элемент)
	
	ОбновитьЭлементыУправления();
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ДиалогВыбораКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбораКаталога.Каталог = Каталог;
	
	ДиалогВыбораКаталога.Показать(Новый ОписаниеОповещения("ЗавершенВыборКаталога", ЭтаФорма));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Экспортировать(Команда)
	
	ПоляОшибокЗаполнения = ПроверкаЗаполнения();
	Если ЗначениеЗаполнено(ПоляОшибокЗаполнения) Тогда
		
		ТекущийЭлемент = Элементы[ПоляОшибокЗаполнения[0]];
		
	Иначе
		
		Результат = Новый Структура;
		Результат.Вставить("ПолноеИмяФайла", СтрШаблон("%1\%2.%3", Каталог, Имя, "erf"));
		Результат.Вставить("Имя", Имя);
		Результат.Вставить("Синоним", Синоним);
		
		Закрыть(Результат);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновитьЭлементыУправления()
	
	// Ошибки
	ТекстОшибки = "";
	ПоляОшибокЗаполнения = ПроверкаЗаполнения();
	Если ЗначениеЗаполнено(ПоляОшибокЗаполнения) Тогда
		ТекстОшибки = СтрШаблон(НСтр("ru = 'Не заполнен(ы): %1'; en = 'Not filled:%1'"), СтрСоединить(ПоляОшибокЗаполнения, ", "));
	КонецЕсли;
		
	Ошибки = ТекстОшибки;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершенВыборКаталога(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Каталог = Результат[0];
	КаталогПриИзменении(Неопределено);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ИмяФайлаВнешнегоОтчета()
	
	Возврат НСтр("ru = 'ВнешнийОтчет'; en = 'ExternalReport'");
	
КонецФункции

&НаКлиенте
Функция ПроверкаЗаполнения()
	
	Результат = Новый Массив;
	Если Не ЗначениеЗаполнено(Имя) Тогда
		Результат.Добавить(НСтр("ru = 'Имя'; en = 'Name'"));
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Каталог) Тогда
		Результат.Добавить(НСтр("ru = 'Каталог'; en = 'Catalog'"));
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Синоним) Тогда
		Результат.Добавить(НСтр("ru = 'Синоним'; en = 'Synonym'"));
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура СинонимПриИзменении(Элемент)
	
	ОбновитьЭлементыУправления();
	
КонецПроцедуры

#КонецОбласти


&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Обновляет заголовок формы
//
// Параметры:
//  Форма - Форма - Форма
//  Заголовок - Строка - Заголовок формы
//  Дополнение - Булево - Дополнять заголовок названием расширения
//
Процедура УКО_ФормыКлиентСервер_Заголовок(Форма, Заголовок, Дополнение = Ложь) Экспорт
	
	НовыйЗаголовок = Заголовок;
	
	Если Дополнение Тогда
		НовыйЗаголовок = НовыйЗаголовок + " : " + УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения();
	КонецЕсли;
	
	Форма.Заголовок = НовыйЗаголовок;
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Возвращает имя расширения
// Возвращаемое значение:
//   Строка	- Имя расширения
Функция УКО_ОбщегоНазначенияКлиентСервер_ИмяРасширения() Экспорт 
	
	Возврат НСтр("ru = 'Управляемая консоль отчетов'; en = 'Managed reporting console'");
	
КонецФункции
