CREATE OR REPLACE FUNCTION yasql_tfun_0022 (sel PLS_INTEGER) RETURN VARCHAR2 IS
BEGIN
  IF    sel=1 THEN RETURN 'Το κλίμα της Θάσου είναι μεσογειακό με ήπιους χειμώνες και θερμά καλοκαίρια.';
  ELSIF sel=2 THEN RETURN 'В 1885 году он совместно с Микшей Дери и Отто Блати получил патент на трансформатор с замкнутым магнитопроводом';
  ELSIF sel=3 THEN RETURN 'árvíztűrő tükörfúrógép';
  ELSE             RETURN 'Falsches Üben von Xylophonmusik quält jeden größeren Zwerg.';
  END IF;
END;
/
