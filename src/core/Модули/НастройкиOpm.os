
#Использовать json
#Использовать logos

Перем мНастройки;
Перем мПутьФайлаНастроек;
Перем Лог;


Функция ПолучитьНастройки() Экспорт
	Возврат мНастройки;
КонецФункции

Процедура УстановитьНастройкиПроксиСервера(Знач Сервер, Знач Порт = 0 , Знач Пользователь = "", Знач Пароль = "", Знач ИспользоватьАутентификациюОС = Ложь)
	
	НастройкиПрокси = Новый ИнтернетПрокси();
	НастройкиПрокси.Установить("http",Сервер, Порт, Пользователь, Пароль, ИспользоватьАутентификациюОС);
	НастройкиПрокси.НеИспользоватьПроксиДляЛокальныхАдресов = Истина;
	
	мНастройки.НастройкиПрокси = НастройкиПрокси;

	мНастройки.ИспользоватьПрокси = Истина;

КонецПроцедуры

Процедура УстановитьСистемныеНастройкиПроксиСервера(Знач Пользователь = "", Знач Пароль = "")
	
	НастройкиПрокси = Новый ИнтернетПрокси(Истина);
	НастройкиПрокси.НеИспользоватьПроксиДляЛокальныхАдресов = Истина;

	Если Не ПустаяСтрока(Пользователь) Тогда
		НастройкиПрокси.Пользователь(Пользователь)
	КонецЕсли;

	Если Не ПустаяСтрока(Пароль) Тогда
		НастройкиПрокси.Пароль(Пароль)
	КонецЕсли;
	
	мНастройки.НастройкиПрокси = НастройкиПрокси;
	мНастройки.ИспользоватьПрокси = Истина;

КонецПроцедуры

Функция НастройкиСервераПакетов(Знач Имя, Знач Сервер, Знач ПутьНаСервере, Знач Порт, Знач Приоритет)
	
	Результат = Новый Структура;
	Результат.Вставить("Имя", Имя);
	Результат.Вставить("Сервер", Сервер);
	Результат.Вставить("ПутьНаСервере", ПутьНаСервере);
	Результат.Вставить("Порт", Порт);
	Результат.Вставить("Приоритет", Приоритет);
	
	Возврат Результат;

КонецФункции //

Процедура ДобавитьСерверПакетов(Знач Имя, Знач Сервер, Знач ПутьНаСервере = "", Знач Порт = 80, Знач Приоритет = Неопределено) Экспорт

	мНастройки.СервераПакетов.Добавить(НастройкиСервераПакетов(Имя, Сервер, ПутьНаСервере, Порт, Приоритет));

КонецПроцедуры

Процедура Инициализация()

	мНастройки = Новый Структура();
	мНастройки.Вставить("ИспользоватьПрокси", Ложь);
	мНастройки.Вставить("НастройкиПрокси", Неопределено);
	мНастройки.Вставить("СоздаватьShСкриптЗапуска", Ложь);
	мНастройки.Вставить("СервераПакетов", Новый Массив);

	// Сервера пакетов по умолчанию
	ДобавитьСерверПакетов("ОсновнойСерверПакетов", КонстантыOpm.СерверУдаленногоХранилища, КонстантыOpm.ПутьВХранилище, 80, 0);
	ДобавитьСерверПакетов("ЗапаснойСерверПакетов", КонстантыOpm.СерверЗапасногоХранилища, КонстантыOpm.ПутьВЗапасномХранилище, 80, 1);
	
КонецПроцедуры

Инициализация();

Лог = Логирование.ПолучитьЛог("oscript.app.opm");