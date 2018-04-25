unit uConst;

interface

uses uLib, SysUtils;
const
  SQL_CONTA =
    'SELECT A.*, '+sLineBreak+
    '       (SELECT CAST(SUM(B.VL_MOVIM ) AS VL_08_02) '+sLineBreak+
    '          FROM MOVIMENTO B '+sLineBreak+
    '         WHERE B.ID_CONTA = A.ID_CONTA) VL_SALDO '+sLineBreak+
    '  FROM CONTA A ';

  SQL_MOVIMENTO =
    'SELECT DISTINCT A.*, '+sLineBreak+
    '       A.VL_MOVIM + '+sLineBreak+
    '       IIF (A.VL_MOVIM < 0, '+sLineBreak+
    '          A.VL_JUROS - A.VL_DESCON, '+sLineBreak+
    '          - A.VL_JUROS + A.VL_DESCON) '+sLineBreak+
    '       VL_BRUTO, '+sLineBreak+
    '       B.NR_CONTA, '+sLineBreak+
    '       B.DS_CONTA, '+sLineBreak+
    '       E.DS_CCUSTO, '+sLineBreak+
    '       CASE A.ID_MOVIM '+sLineBreak+
    '          WHEN D.ID_MOVDEB THEN ( '+sLineBreak+
    '             SELECT ''[''||F.DS_CONTA||'']'' '+sLineBreak+
    '               FROM MOVIMENTO E '+sLineBreak+
    '              INNER JOIN CONTA F ON F.ID_CONTA = E.ID_CONTA'+sLineBreak+
    '              WHERE E.ID_MOVIM = D.ID_MOVCRE) '+sLineBreak+
    '          WHEN D.ID_MOVCRE THEN ( '+sLineBreak+
    '             SELECT ''[''||F.DS_CONTA||'']'' '+sLineBreak+
    '               FROM MOVIMENTO E '+sLineBreak+
    '              INNER JOIN CONTA F ON F.ID_CONTA = E.ID_CONTA'+sLineBreak+
    '              WHERE E.ID_MOVIM = D.ID_MOVDEB) '+sLineBreak+
    '          ELSE C.DS_CATEG '+sLineBreak+
    '       END DS_CATEG '+sLineBreak+
    '  FROM MOVIMENTO A '+sLineBreak+
    ' INNER JOIN CONTA B ON B.ID_CONTA = A.ID_CONTA '+sLineBreak+
    ' INNER JOIN CATEGORIA C ON C.ID_CATEG = A.ID_CATEG '+sLineBreak+
    '  LEFT JOIN TRANSFERENCIA D ON (D.ID_MOVDEB = A.ID_MOVIM '+sLineBreak+
    '                             OR D.ID_MOVCRE = A.ID_MOVIM) '+sLineBreak+
    ' INNER JOIN CCUSTO E ON E.ID_CCUSTO = A.ID_CCUSTO ';

  SQL_CATEGORIA =
    'SELECT A.*         '+sLineBreak+
    '  FROM CATEGORIA A ';

  SQL_TRANSFERENCIA =
    'SELECT A.*, '+sLineBreak+
    '       E.ID_CONTA ID_CDEB, '+sLineBreak+
    '       E.DS_CONTA DS_CDEB, '+sLineBreak+
    '       E.NR_CONTA NR_CDEB, '+sLineBreak+
    '       D.ID_CONTA ID_CCRED, '+sLineBreak+
    '       D.DS_CONTA DS_CCRED, '+sLineBreak+
    '       D.NR_CONTA NR_CCRED '+sLineBreak+
    '  FROM TRANSFERENCIA A '+sLineBreak+
    ' INNER JOIN MOVIMENTO B ON B.ID_MOVIM = A.ID_MOVCRE '+sLineBreak+
    ' INNER JOIN CONTA     D ON D.ID_CONTA = B.ID_CONTA '+sLineBreak+
    ' INNER JOIN MOVIMENTO C ON C.ID_MOVIM = A.ID_MOVDEB '+sLineBreak+
    ' INNER JOIN CONTA     E ON E.ID_CONTA = C.ID_CONTA ';

  SQL_PAGAR_RECEBER =
    'SELECT A.*, '+sLineBreak+
    '       B.DS_CATEG, '+sLineBreak+
    '       (SELECT COALESCE(SUM(IIF(C.FL_TIPO = ''R'', -C.VL_MOVIM, C.VL_MOVIM)),0)'+sLineBreak+
    '                FROM MOVIMENTO C '+sLineBreak+
    '               WHERE C.ID_PAGRECEB = A.ID_PAGRECEB) VL_PAGO '+sLineBreak+
    '  FROM PAGRECEB A '+sLineBreak+
    ' INNER JOIN CATEGORIA B ON B.ID_CATEG = A.ID_CATEG ';

  SQL_CCUSTO = ' SELECT A.* FROM CCUSTO A ';

  SQL_PLANO =
    'SELECT A.*,'+sLineBreak+
    '       B.DS_CATEG, '+sLineBreak+
    '       C.DS_CCUSTO, '+sLineBreak+
    '       IIF(A.FL_ALERTA = ''A'', ''Alerta'', ''Barra'') DS_ACAO'+sLineBreak+
    '  FROM PLANO A '+sLineBreak+
    '  LEFT JOIN CATEGORIA B ON B.ID_CATEG  = A.ID_CATEG '+sLineBreak+
    '  LEFT JOIN CCUSTO    C ON C.ID_CCUSTO = A.ID_CCUSTO ';

implementation

end.
