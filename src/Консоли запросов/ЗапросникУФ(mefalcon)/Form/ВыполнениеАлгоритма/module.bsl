﻿Перем ИмяФайла,ИмяПути;

Перем КоличествоСтрокВРезультате;

Перем СтрокаДереваЗапросов Экспорт;  //строка дерева запросов для которой вызвали выполнение алгоритма 

//////////////////////////////////////////////////////////////////////////
/// ВЫПОЛНЕНИЕ АЛГОРИТМА --->                                                

Процедура КнопкаВыполнитьНажатие(Кнопка)
	
	ВыполнениеНачало = ТекущаяДата();
	
	Если ВыполнятьВТранзакции Тогда
		НачатьТранзакцию();
	КонецЕсли; 
	
	ЭлементыФормы.НадписьПрерватьВыполнение.Заголовок = "Ctrl + Break - прервать выполнение";
	ЭлементыФормы.Индикатор.Видимость = Истина;
	
	Попытка
		
		Выполнить(ЭлементыФормы.ТекстАлгоритма.ПолучитьТекст());
		
	Исключение
		
		Сообщить(ОписаниеОшибки());
		
		Если ВыполнятьВТранзакции Тогда
			
			ОтменитьТранзакцию();
			
		КонецЕсли; 
		
	КонецПопытки; 
	
	ЭлементыФормы.НадписьПрерватьВыполнение.Заголовок = "алгоритм выполнен";
	ЭлементыФормы.КнопкаВыполнить.Заголовок = "Выполнить алгоритм";
	
	Если ВыполнятьВТранзакции Тогда
		ЗафиксироватьТранзакцию();
	КонецЕсли; 
	
	ВыполнениеКонец = ТекущаяДата();
	ВремяВыполненияВСекундах = ВыполнениеКонец - ВыполнениеНачало;
	ЭлементыФормы.НадписьВремяВыполнения.Заголовок = "(" + СокрЛП(ВремяВыполненияВСекундах) + " сек.)";
	
КонецПроцедуры

Процедура КнопкаСкопироватьВБуферНажатие(Элемент)
	
	Окно = ВладелецФормы.ЭлементыФормы.ПолеHTMLДокументаДляБуфераОбмена.Документ.ParentWindow;
	Окно.ClipboardData.SetData("Text",ЭлементыФормы.ТекстАлгоритма.ПолучитьТекст());
	
КонецПроцедуры

Процедура КнопкаОчиститьАлгоритмНажатие(Элемент)
	УстановитьНачальныйТекстАлгоритма();
КонецПроцедуры

// <--- ВЫПОЛНЕНИЕ АЛГОРИТМА                                                                   
////////////////////////////////////////////////////////////////////////// 

//
//
Процедура УстановитьНачальныйТекстАлгоритма()

		//устанавливаем дефолтный текст
		
		ТекстАлгоритма = "//данный код сформирован автоматически, но скорее всего он Вам пригодится";
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + "сч = 1;";
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + "Для Каждого СтрокаРезультата Из РезультатТаблица Цикл";
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + "   //алгоритм обработки строки результата - начало ------>";
		
		Если СтруктураРезультата.Найти("Ссылка","Поле")<>Неопределено Тогда
			//если в списке колонок есть колонка с именем Ссылка, то можно предположить, 
			//что алгоритм будет по изменению объекта по этой ссылке
			//дадим заготовку
			
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.Таб + "Объект = СтрокаРезультата.Ссылка.ПолучитьОбъект();";
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.Таб + "//примеры кода:";
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.Таб + "//Объект.Комментарий = ПараметрыАлгоритма[0].Значение;";
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.Таб + "//Объект.ПометкаУдаления = Истина;";
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.Таб + "//Объект.ОбменДанными.Загрузка = Истина;";
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
			ТекстАлгоритма = ТекстАлгоритма + Символы.Таб + "Объект.Записать();";
			
		КонецЕсли; 
		
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + "   //алгоритм обработки строки результата - конец <------";
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + "   сч = сч + 1;";
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + "   ЭлементыФормы.Индикатор.Значение = сч;";
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + "   ОбработкаПрерыванияПользователя();";
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		ТекстАлгоритма = ТекстАлгоритма + "КонецЦикла;";
		ТекстАлгоритма = ТекстАлгоритма + Символы.ПС;
		
		ЭлементыФормы.ТекстАлгоритма.УстановитьТекст(ТекстАлгоритма);

КонецПроцедуры //УстановитьНачальныйТекстАлгоритма
 

//////////////////////////////////////////////////////////////////////////
/// СОБЫТИЯ ФОРМЫ --->                                                

Процедура ПередОткрытием(Отказ, СтандартнаяОбработка)
	
	СтруктураРезультата.Колонки.Добавить("Значение",,"Пример значения");
	
	Для каждого Колонка Из РезультатТаблица.Колонки Цикл
		
		НовСтрока = СтруктураРезультата.Добавить();
		НовСтрока.Поле = Колонка.Имя;
		НовСтрока.Значение = РезультатТаблица[0][НовСтрока.Поле];
		
	КонецЦикла; 
	
	ЭлементыФормы.СтруктураРезультата.СоздатьКолонки();
	
	КоличествоСтрокВРезультате = РезультатТаблица.Количество();
	
	ЭлементыФормы.НадписьСтрокВРезультате.Заголовок = "кол. строк в результате: " + СокрЛП(КоличествоСтрокВРезультате);
	
	ЭлементыФормы.Индикатор.МаксимальноеЗначение = КоличествоСтрокВРезультате;
	
	//восстанавливаем текст алгоритма
	Если СтрокаДереваЗапросов.ТекстАлгоритма <> Неопределено Тогда
		
		ЭлементыФормы.ТекстАлгоритма.УстановитьТекст(СтрокаДереваЗапросов.ТекстАлгоритма);
		
		Если СтрокаДереваЗапросов.ПараметрыАлгоритма<>Неопределено Тогда
			ПараметрыАлгоритма = СтрокаДереваЗапросов.ПараметрыАлгоритма;
			ЭлементыФормы.ПараметрыАлгоритма.СоздатьКолонки();
		КонецЕсли;//  
		
	Иначе 
		
		УстановитьНачальныйТекстАлгоритма();
		
	КонецЕсли; 
	
	ВыполнятьВТранзакции = Истина;
	
КонецПроцедуры

Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	//сохраняем текст алгоритма в строке дерева запросов
	СтрокаДереваЗапросов.ТекстАлгоритма = ЭлементыФормы.ТекстАлгоритма.ПолучитьТекст();
	СтрокаДереваЗапросов.ПараметрыАлгоритма = ПараметрыАлгоритма.Скопировать();
	//если алгоритм модифицирован - установим модифицированность и в основной форме
	ВладелецФормы.Модифицированность = Модифицированность;
	
КонецПроцедуры

// <--- СОБЫТИЯ ФОРМЫ                                                                   
////////////////////////////////////////////////////////////////////////// 


Процедура ПараметрыАлгоритмаПриАктивизацииСтроки(Элемент)
	
	ТекДанные = ЭлементыФормы.ПараметрыАлгоритма.ТекущиеДанные;
	
	Если ТекДанные = Неопределено Тогда Возврат	КонецЕсли; 
	
	ПараметрАлгоритмаТекстДляМодуля = "ПараметрыАлгоритма[" + СокрЛП(ПараметрыАлгоритма.Индекс(ТекДанные))+"].Значение;";
	
КонецПроцедуры

Процедура КнопкаПараметрАлгоритмаТекстДляМодуляСкопироватьНажатие(Элемент)
	
	Окно = ВладелецФормы.ЭлементыФормы.ПолеHTMLДокументаДляБуфераОбмена.Документ.ParentWindow;
	Окно.ClipboardData.SetData("Text",ПараметрАлгоритмаТекстДляМодуля);
	
КонецПроцедуры

Процедура СтруктураРезультатаПриАктивизацииСтроки(Элемент)
	
	ТекДанные = ЭлементыФормы.СтруктураРезультата.ТекущиеДанные;
	
	Если ТекДанные = Неопределено Тогда Возврат	КонецЕсли; 
	
	ПолеРезультатаТекстДляМодуля = "СтрокаРезультата." + СокрЛП(ТекДанные.Поле) + ";";
	
КонецПроцедуры

Процедура ПолеРезультатаТекстДляМодуляСкопироватьНажатие(Элемент)
	
	Окно = ВладелецФормы.ЭлементыФормы.ПолеHTMLДокументаДляБуфераОбмена.Документ.ParentWindow;
	Окно.ClipboardData.SetData("Text",ПолеРезультатаТекстДляМодуля);
	
КонецПроцедуры

//////////////////////////////////////////////////////////////////////////
/// РАБОТА С ФАЙЛАМИ --->                                                

Процедура КоманднаяПанельДействияСохранитьФайл(Кнопка)
	
	СохранитьАлгоритмВФайл();
	
КонецПроцедуры

Процедура КоманднаяПанельДействияСохранитьКак(Кнопка)
	СохранитьАлгоритмВФайл(Истина);
КонецПроцедуры

Процедура СохранитьАлгоритмВФайл(НовыйФайл = Ложь)
	
	Если Не ЗначениеЗаполнено(ИмяФайла) Тогда
		НовыйФайл = Истина;
	КонецЕсли; 
	
	Если НовыйФайл Тогда
		
		Длг = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
		
		Длг.ПолноеИмяФайла = ИмяФайла;
		Длг.Каталог = ИмяПути;
		Длг.Заголовок = "Укажите файл";
		Длг.Фильтр = "Файлы запросов (*.alg)|*.alg|Все файлы (*.*)|*.*";
		Длг.Расширение = "alg";
		
		Если Длг.Выбрать() Тогда
			ИмяФайла = Длг.ПолноеИмяФайла;
			ИмяПути = Длг.Каталог;
		Иначе
			Возврат;
		КонецЕсли;
		
	КонецЕсли; 
	
	Попытка
		
		СтруктураСохранения = Новый Структура("ТекстАлгоритма,ПараметрыАлгоритма");
		СтруктураСохранения.ТекстАлгоритма = ЭлементыФормы.ТекстАлгоритма.ПолучитьТекст();
		СтруктураСохранения.ПараметрыАлгоритма = ПараметрыАлгоритма.Скопировать();
		
		ЗначениеВФайл(ИмяФайла, СтруктураСохранения);
		
	Исключение
		
		обСообщитьПользователюНаКлиенте(ОписаниеОшибки());
		Возврат;
		
	КонецПопытки;
	
	Модифицированность = Ложь;
	
	Заголовок = ИмяФайла;
	
КонецПроцедуры //СохранитьАлгоритмВФайл



Процедура КоманднаяПанельДействияОткрытьФайл(Кнопка)
	
	Длг = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	Длг.ПолноеИмяФайла = ИмяФайла;
	Длг.Каталог = ИмяПути;
	Длг.Заголовок = "Выберите файл со списком запросов";
	Длг.Фильтр = "Файлы запросов (*.alg)|*.alg|Все файлы (*.*)|*.*";
	Длг.Расширение = "alg";
	
	Если Длг.Выбрать() Тогда
		ИмяФайла = Длг.ПолноеИмяФайла;
		ИмяПути = Длг.Каталог;
		ЗагрузитьИзФайла();
	КонецЕсли;
		
КонецПроцедуры

Процедура ЗагрузитьИзФайла()

	//Проверим существование файла.
	ФайлЗначения = Новый Файл(ИмяФайла);
	ПолученноеЗначение = ?(ФайлЗначения.Существует(), ЗначениеИзФайла(ИмяФайла), Неопределено);

	Если ТипЗнч(ПолученноеЗначение) = Тип("Структура") Тогда

		ЭлементыФормы.ТекстАлгоритма.УстановитьТекст(ПолученноеЗначение.ТекстАлгоритма);
		ПараметрыАлгоритма = ПолученноеЗначение.ПараметрыАлгоритма;
		
		Модифицированность = Ложь;

	Иначе // Формат файла не опознан

		Возврат;
		
	КонецЕсли;

	Заголовок = ИмяФайла;

КонецПроцедуры // ЗагрузитьИзФайла()


// <--- РАБОТА С ФАЙЛАМИ                                                                   
////////////////////////////////////////////////////////////////////////// 


