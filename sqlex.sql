
//ЗАДАНИЕ №1
//Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол.
// Вывести: model, speed и hd

SELECT model, speed, hd
FROM PC
WHERE price < 500;


//ЗАДАНИЕ №2
//Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT maker
FROM product
WHERE type = 'Printer';


//ЗАДАНИЕ №3
//Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых 
//превышает 1000 дол.

SELECT model, ram, screen
FROM Laptop
WHERE price > 1000;


//ЗАДАНИЕ №4
//Найдите все записи таблицы Printer для цветных принтеров.

SELECT *
FROM Printer
WHERE color = 'y';


//ЗАДАНИЕ №5 
//Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

SELECT model, speed, hd 
FROM PC 
WHERE (cd = '12x' OR 
cd = '24x') 
AND price < 600;


//ЗАДАНИЕ№6
//Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт,
// найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT DISTINCT Product.maker,Laptop.speed
FROM Product 
JOIN Laptop 
ON Product.model = Laptop.model WHERE Laptop.hd >= 10;


//ЗАДАНИЕ№7
//Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) 
//производителя B (латинская буква).

//Такой код выдаёт правильные значения, но при проверке ругается на
// решение (типа меньше значений чем нужно)
SELECT model, price 
FROM PC 
WHERE model = (SELECT model 
 FROM Product WHERE maker = 'B' AND 
 type = 'PC')
UNION
SELECT model, price 
FROM Laptop  
WHERE model = (SELECT model 
 FROM Product WHERE maker = 'B' AND 
 type = 'Laptop')
UNION
SELECT model, price 
FROM Printer 
WHERE model = (SELECT model 
 FROM Product WHERE maker = 'B' AND 
 type = 'Printer')

//вот такой код с попыткой использовать JOIN выдаёт Ambiguous column name 'model':
SELECT plp.model, plp.price 
FROM (SELECT model, price 
FROM PC JOIN (SELECT model, price 
FROM Laptop JOIN Printer
ON Laptop.model = Printer.model) AS lpr
ON PC.model = lpr.model )
AS plp
JOIN Product ON plp.model = Product.model
WHERE Product.maker = 'B'


//Такой код работает нормально:
SELECT plp.model, plp.price 
FROM (SELECT model, price 
 FROM PC 
 UNION
 SELECT model, price 
  FROM Laptop
 UNION
 SELECT model, price 
 FROM Printer
 ) AS plp
JOIN Product ON plp.model = Product.model WHERE Product.maker = 'B';


//ЗАДАНИЕ №8
//Найдите производителя, выпускающего ПК, но не ПК-блокноты.

//Логически так, но синтаксис не правильный:
SELECT maker
FROM Product 
WHERE type = PC
AND type != Laptop;


//Это решение выводит больше записей чем нужно (всех производителей, т.е. 
//не работает проверка на Laptop):
SELECT maker
FROM Product
WHERE type = 'PC' AND 
type NOT IN ('Laptop');


//Исправил проверку что искомое не находится в значениях Laptop и 
//добавлен DISTINCT чтобы вывести только уникальные значения:
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' 
AND maker NOT IN (
SELECT maker 
FROM Product 
WHERE type = 'Laptop');


//ЗАДАНИЕ №9
//Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

//Выводит больше записей чем нужно и ругается на значение varchar если сделать условие
//type IN и >= '450':
SELECT maker
FROM Product
WHERE type = 'PC'
AND type NOT IN (SELECT speed 
FROM PC
WHERE speed < '450');


//Рабочее решение:
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC'
AND model IN (
SELECT model 
FROM PC
WHERE speed >= 450);

//Решение с JOIN
SELECT maker FROM Product 
LEFT JOIN PC ON PC.model = Product.model
WHERE type = 'pc' AND
speed>=450
GROUP BY maker

//ЗАДАНИЕ №10
//Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

//Первый вариант, но выводит все модели, а нужно только с самой высокой ценой
SELECT model, MAX (price)  
FROM Printer
GROUP BY model;

//Желаемый вариант, но не работает, т.к. нельзя использовать MAX с WHERE (( 
SELECT model, price
FROM Printer
WHERE price = MAX(price);

//Рабочий вариант:
SELECT model, price  
FROM Printer  
WHERE price = (SELECT MAX(price) 
FROM Printer);
