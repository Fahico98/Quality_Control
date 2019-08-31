
clc;
clear all;

disp("***** BIENVENIDO AL PROGRAMA DE CONTROL DE CALIDAD *****");

disp(newline + "¿Cuantos parametros se evaluaron?");
paramNumber = input('-> ');

disp(newline + "A continuacion ingrese las ponderaciones de cada parametro.");
disp("Recuerde que la suma de las ponderaciones debe ser igual a 100." + newline);

weighingArray = zeros(1, paramNumber);

while true
    totalWeighing = 0;
    for i = 1 : paramNumber
        mes = ['Parametro ' int2str(i) ': '];
        temp = input(mes);
        weighingArray(i) = temp;
        totalWeighing = totalWeighing + temp;
    end
    if totalWeighing ~= 100
        disp(newline + "La suma de las ponderaciones es igual a " + totalWeighing + "%.");
        disp("Debe ser igual a 100%. Por favor intentelo de nuevo..." + newline);
    else
        break;
    end
end

disp(newline + "Ingrese la escala de calificacion.");
lowerLimit = input ('Calificacion mas baja: ');
higherLimit = input ('Calificacion mas alta: ');

disp(newline + "Ingrese la calificacion del umbral de aprobacion para cada pieza evaluada.");
while true
    itemThreshold = input ('Calificacion humbral: ');
    if itemThreshold > higherLimit || itemThreshold < lowerLimit
        disp(newline + "El valor ingresado esta por fuera del rango de calificacion." + newline + "Intentelo de nuevo...");
    else
        break;
    end
end

disp(newline + "Ingrese la calificacion del umbral de aprobacion para el conjunto de piezas evaluadas.");
while true
   setThreshold = input ('Calificacion humbral: ');
    if setThreshold > higherLimit || setThreshold < lowerLimit
        disp(newline + "El valor ingresado esta por fuera del rango de calificacion." + newline + "Intentelo de nuevo...");
    else
        break;
    end
end


disp(newline + "¿Cuantos piezas se evaluaron?");
itemsNumber = input('-> ');

itemScoreMatrix = zeros(itemsNumber, paramNumber);

disp(newline + "A continuacion ingrese las calaficaciones de los parametros de cada una de las piezas evaluadas.");
for i = 1 : itemsNumber
    disp(newline + "Calificaciones de la pieza " + i + ".");
    tempArray = zeros(1, paramNumber);
    j = 1;
    while j ~= (paramNumber + 1)
        mes = ['   Parametro ' int2str(j) ': '];
        tempValue = input(mes);
        if tempValue > higherLimit || tempValue < lowerLimit
            disp("   La calificacion debe ser mayor o igual a " + itemLowerLimit + " y debe ser menor o igual a " + itemHigherLimit + ".");
        else
            tempArray(j) = tempValue;
            j = j + 1;
        end
    end
    itemScoreMatrix(i, :) = tempArray;
end

finalScoreArray = zeros(1, itemsNumber);

for i = 1 : itemsNumber
    sum = 0;
    for j = 1 : paramNumber
        sum = sum + (itemScoreMatrix(i, j) * weighingArray(j) * 0.01);
    end
    finalScoreArray(i) = sum;
end

disp(newline + "***** RESULTADOS *****");

line = sprintf('\nPieza');
for i = 1 : paramNumber
    line = strcat(line, sprintf('\tParam. %d', i));
end
line = strcat(line, sprintf('\tTotal\tAprobo'));
disp(line);

for i = 1 : itemsNumber
    line = sprintf('  %d', i);
    for j = 1 : paramNumber
        line = strcat(line, sprintf('\t\t %0.2f', itemScoreMatrix(i, j)));
    end
    line = strcat(line, sprintf('\t\t %0.2f', finalScoreArray(i)));
    if finalScoreArray(i) >= itemThreshold
        line = strcat(line, sprintf('\t  si'));
    else
        line = strcat(line, sprintf('\t  no'));
    end
    disp(line);
end

finalSetScore = mean(finalScoreArray);

fprintf('\nLa calificacion final de este conjunto de piezas es %0.2f\n', finalSetScore);
if finalSetScore >= setThreshold
    disp("Este conjunto de piezas SI aprobo la evaluacion...");
else
    disp("Este conjunto de piezas NO aprobo la evaluacion...");
end




















