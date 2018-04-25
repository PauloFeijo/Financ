unit ucPlano;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadPadrao, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Mask, Vcl.Buttons, IBX.IBQuery, Data.DB, JvExMask, JvToolEdit,
  JvBaseEdits, JvDBControls;

type
  TcPlano = class(TcCadPadrao)
    Label1: TLabel;
    DBE_ID_PLANO: TDBEdit;
    Label3: TLabel;
    DBE_ID_CATEG: TDBEdit;
    Label4: TLabel;
    DBE_ID_CCUSTO: TDBEdit;
    Label5: TLabel;
    Label7: TLabel;
    DBE_DS_PLANO: TDBEdit;
    Label8: TLabel;
    DBE_DS_CATEG: TDBEdit;
    Label9: TLabel;
    DBE_DS_CCUSTO: TDBEdit;
    DBR_FL_ALERTA: TDBRadioGroup;
    DBE_VL_VALOR: TJvDBCalcEdit;
    procedure FormShow(Sender: TObject);
    procedure DBE_ID_CATEGExit(Sender: TObject);
    procedure DBE_ID_CCUSTOExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function b_funcValidaCampos: boolean;override;
  end;

var
  cPlano: TcPlano;

implementation

{$R *.dfm}

uses udmFinanc, uLib, upCateg, upCCusto;

function TcPlano.b_funcValidaCampos: boolean;

  function funcJaTemPlano : boolean;
  var q : TIBQuery;
      c_ccustoCateg : string;
  begin

    c_ccustoCateg := EmptyStr;

    if dmFinanc.PlanoID_CATEG.AsInteger > 0 then
      c_ccustoCateg := ' A.ID_CATEG = '+dmFinanc.PlanoID_CATEG.AsString;

    if dmFinanc.PlanoID_CCUSTO.AsInteger > 0 then
    begin
      if c_ccustoCateg <> EmptyStr then
        c_ccustoCateg := c_ccustoCateg + ' OR ';
      c_ccustoCateg := ' A.ID_CCUSTO = '+dmFinanc.PlanoID_CCUSTO.AsString;
    end;

    if c_ccustoCateg <> EmptyStr then
        c_ccustoCateg := ' AND ('+c_ccustoCateg + ') ';


    procCriarQuery(q);
    try
      q.SQL.Text :=
        'SELECT A.DS_PLANO             '+
        '  FROM PLANO A                '+
        ' WHERE A.CD_USUARIO = :USUARIO'+
        ' AND A.ID_PLANO  <> :ESTEPLANO'+
        c_ccustoCateg;
      q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
      q.ParamByName('ESTEPLANO').AsInteger := dmFinanc.PlanoID_PLANO.AsInteger;
      q.Open;
      Result := not q.IsEmpty;
      if result then
        procMsgErro('Já existe um plano para a Categoria/Centro de Custos informado.'+sLineBreak+
                    'Descrição do Plano: '+q.FieldByName('DS_PLANO').AsString+'.');
    finally
      FreeAndNil(q);
    end;
  end;
begin
  Result := Inherited;
  if not Result then
    Exit;

  Result := False;

  if dmFinanc.PlanoVL_VALOR.AsFloat = 0 then
  begin
    procMsgErro('Informe o valor maior que zero!');
    Exit;
  end;

  if (dmFinanc.PlanoID_CATEG.AsInteger = 0) and
     (dmFinanc.PlanoID_CCUSTO.AsInteger = 0) then
  begin
    procMsgErro('Informe uma Categoria ou um Centro de Custos!');
    Exit;
  end;

  if funcJaTemPlano then
    Exit;

  Result := True;
end;

procedure TcPlano.DBE_ID_CATEGExit(Sender: TObject);

  procedure procPesquisaCategoria;
  begin
    TpCateg.funcAbreTela(Self,True,False,'D');
    if not dmFinanc.PesCategoria.IsEmpty then
    begin
      dmFinanc.PlanoID_CATEG.AsInteger := dmFinanc.PesCategoriaID_CATEG.AsInteger;
      dmFinanc.PlanoDS_CATEG.AsString  := dmFinanc.PesCategoriaDS_CATEG.AsString;
    end;
    if DBE_ID_CATEG.CanFocus then
      DBE_ID_CATEG.SetFocus;
  end;

  function b_funcRecuperaCategoria: boolean;
  var q : TIBQuery;
  begin
    procCriarQuery(q);
    try
      q.SQL.Text :=
        'SELECT A.DS_CATEG             '+
        '  FROM CATEGORIA A            '+
        ' WHERE A.ID_CATEG   = :CATEG  '+
        '   AND A.CD_USUARIO = :USUARIO'+
        '   AND A.FL_TIPO    = ''D''   '+
        '   AND A.FL_ATIVO   = ''A''   ';

      q.ParamByName('CATEG').AsInteger := dmFinanc.PlanoID_CATEG.AsInteger;
      q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
      q.Open;

      dmFinanc.PlanoDS_CATEG.AsString := q.FieldByName('DS_CATEG').AsString;

      Result := not q.IsEmpty;
    finally
      FreeAndNil(q);
    end;
  end;

begin
  inherited;
  dmFinanc.PlanoDS_CATEG.AsString := EmptyStr;
  if Trim(dmFinanc.PlanoID_CATEG.AsString) <> EmptyStr then
    if not b_funcRecuperaCategoria then
      procPesquisaCategoria;
end;

procedure TcPlano.DBE_ID_CCUSTOExit(Sender: TObject);

  procedure procPesquisaCCusto;
  begin
    TpCCusto.funcAbreTela(Self,True,False);
    if not dmFinanc.PesCCusto.IsEmpty then
    begin
      dmFinanc.PlanoID_CCUSTO.AsInteger := dmFinanc.PesCCustoID_CCUSTO.AsInteger;
      dmFinanc.PlanoDS_CCUSTO.AsString  := dmFinanc.PesCCustoDS_CCUSTO.AsString;
    end;
    if DBE_ID_CCUSTO.CanFocus then
      DBE_ID_CCUSTO.SetFocus;
  end;

  function b_funcRecuperaCCusto: boolean;
  var q : TIBQuery;
  begin
    procCriarQuery(q);
    try
      q.SQL.Text := 'SELECT A.DS_CCUSTO            '+
                    '  FROM CCUSTO A               '+
                    ' WHERE A.ID_CCUSTO  = :CCUSTO '+
                    '   AND A.CD_USUARIO = :USUARIO'+
                    '   AND A.FL_ATIVO   = ''A''   ';

      q.ParamByName('CCUSTO').AsInteger := dmFinanc.PlanoID_CCUSTO.AsInteger;
      q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
      q.Open;

      dmFinanc.PlanoDS_CCUSTO.AsString := q.FieldByName('DS_CCUSTO').AsString;

      Result := not q.IsEmpty;
    finally
      FreeAndNil(q);
    end;
  end;

begin
  inherited;
  dmFinanc.PlanoDS_CCUSTO.AsString := EmptyStr;
  if Trim(dmFinanc.PlanoID_CCUSTO.AsString) <> EmptyStr then
    if not b_funcRecuperaCCusto then
      procPesquisaCCusto;
end;

procedure TcPlano.FormShow(Sender: TObject);
begin
  inherited;
  procDesabilitaCampos(DBE_ID_PLANO);
  procDesabilitaCampos(DBE_DS_CATEG);
  procDesabilitaCampos(DBE_DS_CCUSTO);
  DBE_VL_VALOR.Color := corCampoRequerido;
end;

initialization
RegisterClass(TcPlano);

finalization
UnRegisterClass(TcPlano);

end.
