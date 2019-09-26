﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.КартинкаВопрос.Картинка = Элементы.БиблиотекаКартинокУКО_Вопрос64.Картинка;
	
	Заголовок = Параметры.Заголовок;
	Кнопки = Параметры.Кнопки;
	КнопкаПоУмолчанию = УКО_ОбщегоНазначенияКлиентСервер_ЗначениеСвойстваСтруктуры(Параметры, "КнопкаПоУмолчанию");
	
	Элементы.ТекстВопроса.Заголовок = Параметры.Текст;
	
	ИмяНастройкиБольшеНеПоказывать = УКО_ОбщегоНазначенияКлиентСервер_ЗначениеСвойстваСтруктуры(Параметры, "ИмяНастройкиБольшеНеПоказывать");
	Элементы.БольшеНеПоказывать.Видимость = Параметры.Свойство("ИмяНастройкиБольшеНеПоказывать");
	
	СоздатьКнопки();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура БольшеНеПоказыватьПриИзменении(Элемент)
	
	УКО_НастройкиПользователяВызовСервера_ЗаписатьЗначение(ИмяНастройкиБольшеНеПоказывать, БольшеНеПоказывать);
	Оповестить("ИзмененыНастройки", ИмяНастройкиБольшеНеПоказывать);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаКнопки(Команда)

	ИндексКнопки = УКО_СтрокиКлиентСервер_РазборПрочитатьЦелоеЧисло(Команда.Имя,,НаправлениеПоиска.СКонца);
	Закрыть(Кнопки[ИндексКнопки].Значение);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СоздатьКнопки()
	
	ИндексКнопки = 0;
	Для Каждого ЭлементКнопка Из Кнопки Цикл 
		
		ИмяКоманды = СтрШаблон("Команда%1", ИндексКнопки);
		
		НоваяКоманда = Команды.Добавить(ИмяКоманды);
		НоваяКоманда.Заголовок = ЭлементКнопка.Представление;
		НоваяКоманда.Действие = "КомандаКнопки";
		
		НоваяКнопка = Элементы.Добавить("Кнопка" + ИндексКнопки, Тип("КнопкаФормы"), Элементы.ГруппаКоманднаяПанель);
		НоваяКнопка.ИмяКоманды = ИмяКоманды;
		НоваяКнопка.КнопкаПоУмолчанию = (КнопкаПоУмолчанию = ЭлементКнопка.Значение);
		
		Если НоваяКнопка.КнопкаПоУмолчанию Тогда
			НоваяКнопка.АктивизироватьПоУмолчанию = Истина;
		КонецЕсли;
		
		ИндексКнопки = ИндексКнопки + 1;
		
	КонецЦикла;

КонецПроцедуры

#КонецОбласти



&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
&НаКлиентеНаСервереБезКонтекста
// Чтение целого число из строки
//
// Параметры:
//   Строка - Строка - Разбираемая строка
//   НачальныйИндекс - Число - Начальный индекс
//   Направление - НаправлениеПоиска - Направление поиска (по умолчанию: НаправлениеПоиска.СНачала)
//   СмещатьИндекс - Булево - Смещать индекс (по умолчанию: Истина)
//
// Возвращаемое значение:
//   Число	- Прочитанное целое число
//
Функция УКО_СтрокиКлиентСервер_РазборПрочитатьЦелоеЧисло(Строка, НачальныйИндекс = Неопределено, Направление = Неопределено, СмещатьИндекс = Истина) Экспорт
	
	Если Направление = НаправлениеПоиска.СКонца Тогда
		
		Если НачальныйИндекс = Неопределено Тогда
			НачальныйИндекс = СтрДлина(Строка);
		КонецЕсли;
		
		Индекс = НачальныйИндекс;
		Пока Индекс > 0 Цикл 
			
			Если Не СтрНайти(УКО_СтрокиКлиентСервер_НаборСимволовЦифры(), Сред(Строка, Индекс, 1)) Тогда 
				Прервать;
			КонецЕсли;
			
			Индекс = Индекс - 1;
		КонецЦикла;
		
		Результат = Сред(Строка, Индекс + 1, НачальныйИндекс - Индекс); 
		
	Иначе
		
		Если НачальныйИндекс = Неопределено Тогда
			НачальныйИндекс = 1;
		КонецЕсли;
		
		Для Индекс = НачальныйИндекс По СтрДлина(Строка) Цикл 
			
			Если Не СтрНайти(УКО_СтрокиКлиентСервер_НаборСимволовЦифры(), Сред(Строка, Индекс, 1)) Тогда 
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Результат = Сред(Строка, НачальныйИндекс, Индекс - НачальныйИндекс); 
		
	КонецЕсли;
	
	Если СмещатьИндекс Тогда
		НачальныйИндекс = Индекс;
	КонецЕсли;
	
	Возврат Число(Результат);
	
КонецФункции
&НаСервере
// Записывает значение настройки
//
// Параметры:
//  Имя  - Строка - Имя настройки
//  Значение  - Произвольный - Значение настройки
//
Процедура УКО_НастройкиПользователяВызовСервера_ЗаписатьЗначение(Имя, Значение) Экспорт
	
	ОбъектОбработки().УКО_НастройкиПользователя_ЗаписатьЗначение(Имя, Значение);
	
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
// Получает значение свойства структуры
// Параметры:
//   Структура - Структура - Структура
//   Имя - Строка - Имя свойства
//   ЗначениеПоУмолчанию - Произвольный - Значение по умолчанию, когда в данной структуре нет этого свойства
// Возвращаемое значение:
//   Произвольный - Значение свойства структуры
Функция УКО_ОбщегоНазначенияКлиентСервер_ЗначениеСвойстваСтруктуры(Структура = Неопределено, Имя = Неопределено, ЗначениеПоУмолчанию = Неопределено) Экспорт
	
	Значение = ЗначениеПоУмолчанию;
	
	Если (ТипЗнч(Структура) = Тип("Структура")
				ИЛИ ТипЗнч(Структура) = Тип("ДанныеФормыСтруктура"))
			И Структура.Свойство(Имя) Тогда
		
		Значение = Структура[Имя];
		
	КонецЕсли;
	
	Возврат Значение;
	
КонецФункции
&НаКлиентеНаСервереБезКонтекста

Функция УКО_СтрокиКлиентСервер_НаборСимволовЦифры()
	
	Возврат "0123456789";
	
КонецФункции
