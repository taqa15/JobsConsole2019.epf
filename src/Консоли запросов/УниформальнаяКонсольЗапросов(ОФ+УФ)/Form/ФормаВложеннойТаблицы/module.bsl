﻿
Перем мУдаляемаяКолонка;
Перем мИмяДоИзменения;

Процедура ОбновитьТаблицуПоКолонкам()
	
	ЕстьИзменения = Ложь;
	инд = ВложеннаяТаблица.Колонки.Количество()-1;
	Если инд>=0 Тогда
		Пока инд>=0 Цикл
			колонкаТЗ = ВложеннаяТаблица.Колонки[инд];
			Если КолонкиТаблицы.Найти(колонкаТЗ.Имя,"Имя") = Неопределено Тогда
				ВложеннаяТаблица.Колонки.Удалить(колонкаТЗ);
				ЕстьИзменения = Истина;
			КонецЕсли;
			инд = инд - 1;
		КонецЦикла;
	КонецЕсли;
	Для каждого строкаКолонка Из КолонкиТаблицы Цикл
		колонкаТЗ = ВложеннаяТаблица.Колонки.Найти(строкаКолонка.Имя);
		Если колонкаТЗ = Неопределено Тогда
			колонкаТЗ = ВложеннаяТаблица.Колонки.Добавить(строкаКолонка.Имя,строкаКолонка.ТипЗначения);
			ЕстьИзменения = Истина;
		КонецЕсли;
		Если колонкаТЗ.ТипЗначения<>строкаКолонка.ТипЗначения Тогда
			служКолонка = ВложеннаяТаблица.Колонки.Добавить("__СлужебнаяКолонкаДляИзмененияТипаЗначения",строкаКолонка.ТипЗначения);
			ВложеннаяТаблица.ЗагрузитьКолонку(ВложеннаяТаблица.ВыгрузитьКолонку(колонкаТЗ),служКолонка);
			ВложеннаяТаблица.Удалить(колонкаТЗ);
			служКолонка.Имя = строкаКолонка.Имя;
		КонецЕсли;
	КонецЦикла;
	Если ЕстьИзменения Тогда
		ЭлементыФормы.ВложеннаяТаблица.СоздатьКолонки();
	КонецЕсли;
	
КонецПроцедуры

Функция ОбработатьТЗПередВыводом(пТаблица)
	
	Для каждого колонка ИЗ пТаблица.Колонки Цикл
		Если колонка.ТипЗначения.СодержитТип(Тип("ТаблицаЗначений")) ИЛИ колонка.ТипЗначения.СодержитТип(Тип("ХранилищеЗначения")) Тогда
			индКолонки = пТаблица.Колонки.Индекс(колонка);
			имяКолонки = колонка.Имя;
			имяКолонкиРасшифровки = имяКолонки+"__СлужебныйРасшифровка__";
			пТаблица.Колонки.Добавить(имяКолонкиРасшифровки);
			массивПредставлений = Новый Массив;
			Для каждого строкаТЗ Из пТаблица Цикл
				тзРезультат = строкаТЗ[имяКолонки];
				Если ТипЗнч(тзРезультат) = Тип("ТаблицаЗначений") Тогда
					строкаТЗ[имяКолонкиРасшифровки] = тзРезультат;
					массивПредставлений.Добавить("ТаблицаЗначений("+тзРезультат.Количество()+")");
				ИначеЕсли ТипЗнч(тзРезультат) = Тип("ХранилищеЗначения") Тогда
					значениеХЗ = тзРезультат.Получить();
					строкаТЗ[имяКолонкиРасшифровки] = значениеХЗ;
					массивПредставлений.Добавить("ХранилищеЗначения("+ТипЗнч(значениеХЗ)+")");
				Иначе
					массивПредставлений.Добавить("");
					строкаТЗ[имяКолонкиРасшифровки] = строкаТЗ[имяКолонки];
				КонецЕсли;
			КонецЦикла;						 
			пТаблица.Колонки.Удалить(колонка);
			пТаблица.Колонки.Вставить(индКолонки,имяКолонки,Новый ОписаниеТипов("Строка"),имяКолонки);
			пТаблица.ЗагрузитьКолонку(массивПредставлений, имяКолонки);
		КонецЕсли;
	КонецЦикла;
	
КонецФункции

Процедура ОбновитьПриИзмененииРежимаТабДока()
	Если РежимТабдока Тогда
		ЭлементыФормы.ПанельРежимТабДока.ТекущаяСтраница = ЭлементыФормы.ПанельРежимТабДока.Страницы.СтраницаТабДок;
		ЭлементыФормы.ПолеТабличногоДокумента.Очистить();
		Построитель = Новый ПостроительОтчета;
		Построитель.ИсточникДанных = Новый ОписаниеИсточникаДанных(ВложеннаяТаблица);
		Построитель.ЗаполнитьНастройки();
		Построитель.ВыводитьЗаголовокОтчета = Ложь;
		Построитель.ВыводитьПодвалОтчета = Ложь;
		Построитель.ВыводитьПодвалТаблицы = Ложь;
		Построитель.АвтоДетальныеЗаписи = Ложь;

		Макет = Новый ТабличныйДокумент;		
		инд = 1;
		Для каждого колонка Из ВложеннаяТаблица.Колонки Цикл
			индСтрокой = Формат(инд,"ЧГ=0");
			Секция = Макет.Область("R1C"+индСтрокой);
			заголовок = колонка.Заголовок;
			Если Не ЗначениеЗаполнено(заголовок) Тогда
				заголовок = колонка.Имя;	
			КонецЕсли;
			Секция.Текст = заголовок;
			Если колонка.Ширина>0 Тогда
				Секция.ШиринаКолонки = колонка.Ширина;
			КонецЕсли;
			Секция.Шрифт = Новый Шрифт(Секция.Шрифт,,,Истина);
			Секция.ЦветФона = Новый Цвет(244,236,197);
			Секция.ГраницаСнизу = Новый Линия(ТипЛинииЯчейкиТабличногоДокумента.Сплошная);
			Секция.Защита = Истина;
			СекцияПараметр = Макет.Область("R2C"+индСтрокой);;
			СекцияПараметр.Заполнение = ТипЗаполненияОбластиТабличногоДокумента.Параметр;
			СекцияПараметр.Параметр = колонка.Имя;
			//СекцияПараметр.Защита = Ложь;
			инд = инд + 1;
		КонецЦикла;
		Макет.Область("R1").Имя = "ШапкаТаблицы";
		Макет.Область("R2").Имя = "Детали";
		
		//Макет.Показать();
		Построитель.Макет = Макет;
		Построитель.Вывести(ЭлементыФормы.ПолеТабличногоДокумента);
		//ЭлементыФормы.ПолеТабличногоДокумента.Область("R1").Защита = Истина;
		//ЭлементыФормы.ПолеТабличногоДокумента.Область("R1").РежимИзмененияРазмераКолонки = Истина;
	Иначе		
		ЭлементыФормы.ПанельРежимТабДока.ТекущаяСтраница = ЭлементыФормы.ПанельРежимТабДока.Страницы.СтраницаТЗ;
		ТабДокумент = ЭлементыФормы.ПолеТабличногоДокумента;
		ПоследняяСтрока = ТабДокумент.ВысотаТаблицы;
		ПоследняяКолонка = ТабДокумент.ШиринаТаблицы;
		ОбластьЯчеек = ТабДокумент.Область(1, 1, ПоследняяСтрока, ПоследняяКолонка); 
		// Создаем описание источника данных на основании области ячеек табличного документа.
		ИсточникДанных = Новый ОписаниеИсточникаДанных(ОбластьЯчеек);  
		// Создаем объект для интеллектуального построения отчетов,
		// указываем источник данных и выполняем построение отчета.
		ПостроительОтчета = Новый ПостроительОтчета; 
		ПостроительОтчета.ИсточникДанных = ИсточникДанных;
		ПостроительОтчета.Выполнить();
		// Результат выгружаем в таблицу значений.
		ТабЗначений = ПостроительОтчета.Результат.Выгрузить();
		//ТабЗначений.ВыбратьСтроку();
		ПреобразоватьРезультатПостроителя(ТабЗначений);
	КонецЕсли;
КонецПроцедуры

Процедура ПреобразоватьРезультатПостроителя(пТЗ)
	обработкаКолонок = Новый Массив;
	Для каждого колонка Из ВложеннаяТаблица.Колонки Цикл
		струкОбрабКол = Новый Структура();
		струкОбрабКол.Вставить("Имя",колонка.Имя);
		струкОбрабКол.Вставить("Тип",колонка.ТипЗначения);
		массивТипов = колонка.ТипЗначения.Типы();
		индNULL = массивТипов.Найти(NULL);
		Если индNULL <> Неопределено Тогда
			массивТипов.Удалить(индNULL);
		КонецЕсли;
		типКолонки = массивТипов[0];
		мета = Метаданные.НайтиПоТипу(типКолонки);
		Если мета<>Неопределено Тогда			
			//Если мета.ВводПоСтроке.Количество()>0 Тогда
				имяПоля = мета.ВводПоСтроке[0].Имя;
				полноеИмя = мета.ПолноеИмя();
				Если Строка(мета.ОсновноеПредставление) = "ВВидеКода" Тогда
					струкОбрабКол.Вставить("Обработка","НайтиПоКоду(""ПолеПоиска"")");
				Иначе
					струкОбрабКол.Вставить("Обработка","НайтиПоНаименованию(""ПолеПоиска"",Истина)");
				КонецЕсли;
				//Если имяПоля = "Код" Тогда
				//	струкОбрабКол.Вставить("Обработка","НайтиПоКоду(""ПолеПоиска"")");
				//ИначеЕсли имяПоля = "Наименование" Тогда
				//	струкОбрабКол.Вставить("Обработка","НайтиПоНаименованию(""ПолеПоиска"")");
				//Иначе
				//	струкОбрабКол.Вставить("Обработка","НайтиПоРеквизиту("+имяПоля+",""ПолеПоиска"")");
				//КонецЕсли;
				струкОбрабКол.Вставить("Менеджер",ПолучитьМенеджераПоМетаданным(мета));
			//КонецЕсли;
		//этоСсылочныйТип = Ложь;
		//Для каждого элТип Из массивТипов Цикл
		//	Если Найти(элТип,"Ссылка")>0 Тогда
		//		этоСсылочныйТип = Истина;		
		//	КонецЕсли;
		//КонецЦикла;
			//ПолучитьМетаданныеПоТипу(типКолонки);
			обработкаКолонок.Добавить(струкОбрабКол);
		КонецЕсли;
		
	КонецЦикла;
	ВложеннаяТаблица.Очистить();
	Для каждого строкаТЗ ИЗ пТЗ Цикл
		новСтрока = ВложеннаяТаблица.Добавить();
		ЗаполнитьЗначенияСвойств(новСтрока,строкаТЗ);
		Для каждого колонка ИЗ обработкаКолонок Цикл
			кодЗамены = СтрЗаменить(колонка.Обработка,"ПолеПоиска",строкаТЗ[колонка.Имя]);
			Выполнить("новСтрока[колонка.Имя] = колонка.Менеджер."+кодЗамены+";");
			//новСтрока[колонка.Имя] = строкаТЗ[колонка.Имя] = 		
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

Функция ПолучитьМенеджераПоМетаданным(пМета)
	полноеИмя = пМета.ПолноеИмя();
	индТочки = Найти(полноеИмя,".");
	видОбъекта = Лев(полноеИмя,индТочки-1);
	имяОбъекта = пМета.Имя; 
		Если видОбъекта = "Справочник" Тогда
      

    		Возврат Справочники[ИмяОбъекта];
      

    	ИначеЕсли видОбъекта = "Документ" Тогда
      

    		Возврат Документы[ИмяОбъекта];
      

    	ИначеЕсли видОбъекта = "БизнесПроцесс" Тогда
      

    		Возврат БизнесПроцессы[ИмяОбъекта];
      

    	ИначеЕсли видОбъекта = "ПланВидовХарактеристик" Тогда
      

    		Возврат ПланыВидовХарактеристик[ИмяОбъекта];
      

    	ИначеЕсли видОбъекта = "ПланСчетов" Тогда
      

    		Возврат ПланыСчетов[ИмяОбъекта];
      

    	ИначеЕсли видОбъекта = "ПланВидовРасчета" Тогда
      

    		Возврат ПланыВидовРасчета[ИмяОбъекта];
      

    	ИначеЕсли видОбъекта = "Задача" Тогда
      

    		Возврат Задачи[ИмяОбъекта];
      

    	ИначеЕсли видОбъекта = "ПланОбмена" Тогда
      

    		Возврат ПланыОбмена[ИмяОбъекта];
      

    	ИначеЕсли видОбъекта = "Перечисление" Тогда
      

    		Возврат Перечисления[ИмяОбъекта];
      

    	Иначе
      

    		Возврат НеОпределено;
      

    	КонецЕсли;
		
КонецФункции

//============================= Обработка событий ================================

// Обработка выбора значения в таблице
//
Процедура ВложеннаяТаблицаВыбор(Элемент, ВыбраннаяСтрока, Колонка, СтандартнаяОбработка)

	Если НЕ РежимРедактирования Тогда
		//СтандартнаяОбработка = Ложь;
		//СодержимоеЯчейки = ВыбраннаяСтрока[Колонка.Имя];
		//ОткрытьЗначение(СодержимоеЯчейки);
		СтандартнаяОбработка = Ложь;
		
	    СодержимоеЯчейки = ВыбраннаяСтрока[Колонка.Имя];	
		Попытка
			СодержимоеЯчейки = ВыбраннаяСтрока[Колонка.Имя+"__СлужебныйРасшифровка__"];
		Исключение
		КонецПопытки;

		Попытка
			имяТаблицы = ВыбраннаяСтрока.НаименованиеТаблицы;
		Исключение
			номерСтроки = ВложеннаяТаблица.Индекс(ВыбраннаяСтрока);
			имяТаблицы = Колонка.Имя + ", строка " + Формат(номерСтроки+1,"ЧГ=0");
		КонецПопытки;

		Если ТипЗнч(СодержимоеЯчейки) = Тип("ХранилищеЗначения") Тогда
			СодержимоеЯчейки = СодержимоеЯчейки.Получить();
		КонецЕсли;
		
		Если ТипЗнч(СодержимоеЯчейки) = Тип("ТаблицаЗначений") Тогда	
			ФормаВложеннойТаблицы = ОбработкаОбъект.ПолучитьФорму("ФормаВложеннойТаблицы", ЭтаФорма);
			ФормаВложеннойТаблицы.Заголовок = Заголовок+": "+имяТаблицы;
			ФормаВложеннойТаблицы.ВложеннаяТаблица = СодержимоеЯчейки;
			ФормаВложеннойТаблицы.ЭлементыФормы.ВложеннаяТаблица.СоздатьКолонки();
			ФормаВложеннойТаблицы.Открыть();
		Иначе
			ОткрытьЗначение(СодержимоеЯчейки);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры // ВложеннаяТаблицаВыбор

Процедура ПриОткрытии()
	Если РежимРедактирования Тогда
		Для каждого колонка Из ВложеннаяТаблица.Колонки Цикл
			новСтрока = КолонкиТаблицы.Добавить();
			новСтрока.Имя = колонка.Имя;
			новСтрока.ТипЗначения = колонка.ТипЗначения;
		КонецЦикла;
		ЭлементыФормы.КолонкиТаблицы.Видимость = Истина;
		ЭлементыФормы.Разделитель1.Видимость = Истина;
		ЭлементыФормы.КоманднаяПанельТаблицы.УстановитьПривязку(ГраницаЭлементаУправления.Верх,ЭлементыФормы.Разделитель1,ГраницаЭлементаУправления.Низ);
		текВерх = ЭлементыФормы.Разделитель1.Верх+ЭлементыФормы.Разделитель1.Высота+1;
		ЭлементыФормы.КоманднаяПанельТаблицы.Верх = текВерх;
		//ЭлементыФормы.КоманднаяПанельТаблицы.Высота = Высота - ЭлементыФормы.КоманднаяПанельТаблицы.Верх - 8;
		ЭлементыФормы.ПанельРежимТабДока.Верх = текВерх + ЭлементыФормы.КоманднаяПанельТаблицы.Высота;
		//ЭлементыФормы.ВложеннаяТаблица.УстановитьПривязку(ГраницаЭлементаУправления.Верх,ЭлементыФормы.Разделитель1,ГраницаЭлементаУправления.Низ);
		//ЭлементыФормы.ВложеннаяТаблица.Верх = ЭлементыФормы.Разделитель1.Верх+ЭлементыФормы.Разделитель1.Высота+1;
		//ЭлементыФормы.ВложеннаяТаблица.Высота = Высота - ЭлементыФормы.ВложеннаяТаблица.Верх - 8;
	Иначе
		ЭлементыФормы.КолонкиТаблицы.Видимость = Ложь;
		ЭлементыФормы.Разделитель1.Видимость = Ложь;
		//ЭлементыФормы.ВложеннаяТаблица.УстановитьПривязку(ГраницаЭлементаУправления.Верх,Неопределено); 
		//ЭлементыФормы.ВложеннаяТаблица.Верх = 8;
		//ЭлементыФормы.ВложеннаяТаблица.Высота = Высота - ЭлементыФормы.ВложеннаяТаблица.Верх - 8;
		ЭлементыФормы.КоманднаяПанельТаблицы.УстановитьПривязку(ГраницаЭлементаУправления.Верх,Неопределено); 
		ЭлементыФормы.КоманднаяПанельТаблицы.Верх = 8;
		//ЭлементыФормы.КоманднаяПанельТаблицы.Высота = Высота - ЭлементыФормы.ВложеннаяТаблица.Верх - 8;
		ЭлементыФормы.ПанельРежимТабДока.Верх = 8 + ЭлементыФормы.КоманднаяПанельТаблицы.Высота;
		ЭлементыФормы.ПанельРежимТабДока.Высота = ЭтаФорма.Высота-ЭлементыФормы.ПанельРежимТабДока.Верх-8;
		
		ОбработатьТЗПередВыводом(ВложеннаяТаблица);
		ЭлементыФормы.ВложеннаяТаблица.Данные = "ВложеннаяТаблица";
		ЭлементыФормы.ВложеннаяТаблица.СоздатьКолонки();
		индКолонки = ЭлементыФормы.ВложеннаяТаблица.Колонки.Количество()-1;
		Пока индКолонки>=0 Цикл
			колонкаТЗ = ЭлементыФормы.ВложеннаяТаблица.Колонки[индКолонки];
			Если Найти(колонкаТЗ.Имя,"__СлужебныйРасшифровка__")<>0 Тогда
				ЭлементыФормы.ВложеннаяТаблица.Колонки.Удалить(колонкаТЗ);
			КонецЕсли;
			индКолонки = индКолонки - 1;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Процедура КолонкиТаблицыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	текСтрока = ЭлементыФормы.КолонкиТаблицы.ТекущаяСтрока;
	действие = ?(НоваяСтрока,"Добавить","Изменить");
	ИзменитьКолонку(мИмяДоИзменения,текСтрока.Имя,текСтрока.ТипЗначения,действие);
	
КонецПроцедуры

Процедура ИзменитьКолонку(пИмяКолонки,пНовоеИмяКолонки = "",пТипЗначения = Неопределено,Действие = "Изменить")

	Если Действие = "Добавить" Тогда
		ВложеннаяТаблица.Колонки.Добавить(пНовоеИмяКолонки,пТипЗначения);			
	ИначеЕсли Действие = "Изменить" Тогда
		колонкаТЗ = ВложеннаяТаблица.Колонки.Найти(пИмяКолонки);
		Если пИмяКолонки<>пНовоеИмяКолонки Тогда
			колонкаТЗ.Имя = пНовоеИмяКолонки;
			колонкаТЗ.Заголовок = пНовоеИмяКолонки;			
		КонецЕсли;
		Если колонкаТЗ.ТипЗначения<>пТипЗначения Тогда
			служКолонка = ВложеннаяТаблица.Колонки.Добавить("__СлужебнаяКолонкаДляИзмененияТипаЗначения",пТипЗначения);
			ВложеннаяТаблица.ЗагрузитьКолонку(ВложеннаяТаблица.ВыгрузитьКолонку(колонкаТЗ),служКолонка);
			ВложеннаяТаблица.Колонки.Удалить(колонкаТЗ);
			служКолонка.Имя = пНовоеИмяКолонки;
		КонецЕсли;
	ИначеЕсли Действие = "Удалить" Тогда
		ВложеннаяТаблица.Колонки.Удалить(пИмяКолонки);
	КонецЕсли;
	ЭлементыФормы.ВложеннаяТаблица.СоздатьКолонки();
	
КонецПроцедуры

Процедура КолонкиТаблицыПослеУдаления(Элемент)
	ИзменитьКолонку(мУдаляемаяКолонка,,,"Удалить");
КонецПроцедуры

Процедура КолонкиТаблицыПередУдалением(Элемент, Отказ)
	текСтрока = ЭлементыФормы.КолонкиТаблицы.ТекущаяСтрока;
	мУдаляемаяКолонка = текСтрока.Имя;
КонецПроцедуры

Процедура КолонкиТаблицыПередНачаломИзменения(Элемент, Отказ)
	текСтрока = ЭлементыФормы.КолонкиТаблицы.ТекущаяСтрока;
	мИмяДоИзменения = текСтрока.Имя;
КонецПроцедуры

Процедура КолонкиТаблицыПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	текСтрока = ЭлементыФормы.КолонкиТаблицы.ТекущаяСтрока;
	Если НЕ ОтменаРедактирования И ПустаяСтрока(текСтрока.Имя) Тогда
		Отказ = Истина;	
	КонецЕсли;
КонецПроцедуры

Процедура КоманднаяПанельТаблицыРежимТабДока(Кнопка)
	РежимТабдока = Не РежимТабдока;
	ЭлементыФормы.КоманднаяПанельТаблицы.Кнопки.РежимТабДока.Пометка = РежимТабдока;
	ОбновитьПриИзмененииРежимаТабДока();
КонецПроцедуры



Процедура ПолеТабличногоДокументаВыбор(Элемент, Область, СтандартнаяОбработка)

	Если ЭлементыФормы.ПолеТабличногоДокумента.ТекущаяОбласть.Верх = 1 Тогда
		ЭлементыФормы.ПолеТабличногоДокумента.Защита = Истина;	
	Иначе
		ЭлементыФормы.ПолеТабличногоДокумента.Защита = Ложь;
	КонецЕсли;

КонецПроцедуры



