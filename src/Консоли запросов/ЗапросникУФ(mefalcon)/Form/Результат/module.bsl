﻿
Процедура ТаблицаРезультатаПриВыводеСтроки(Элемент, ОформлениеСтроки, ДанныеСтроки)
	
	обОформитьСтрокуТаблицыРезультата(ОформлениеСтроки);
	
КонецПроцедуры

Процедура ТаблицаРезультатаПриАктивизацииЯчейки(Элемент)
	
	Если ЭлементыФормы.ТаблицаРезультата.ТекущаяКолонка = Неопределено ИЛИ 
		ЭлементыФормы.ТаблицаРезультата.ТекущиеДанные = Неопределено Тогда
		Возврат;	
	КонецЕсли;  
	
	СодержимоеЯчейки = ЭлементыФормы.ТаблицаРезультата.ТекущиеДанные[ЭлементыФормы.ТаблицаРезультата.ТекущаяКолонка.Имя];	
	
	ЭлементыФормы.НадписьТипЗначенияТекущейЯчейки.Заголовок =  ТипЗнч(СодержимоеЯчейки);
	
КонецПроцедуры

Процедура ТаблицаРезультатаВыбор(Элемент, ВыбраннаяСтрока, Колонка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
    СодержимоеЯчейки = ВыбраннаяСтрока[Колонка.Имя];

    обПоказатьЗначение(СодержимоеЯчейки,Колонка.Имя);
	
КонецПроцедуры
