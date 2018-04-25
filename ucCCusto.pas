unit ucCCusto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmFinanc, uCadPadrao, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls,
  uLib, uConst, IBX.IBQuery, Data.DB;

type
  TcCCusto = class(TcCadPadrao)
    Label1: TLabel;
    DBE_ID_CCUSTO: TDBEdit;
    Label3: TLabel;
    DBE_ID_CCPAI: TDBEdit;
    Label4: TLabel;
    DBE_DS_CCUSTO: TDBEdit;
    edDsCCPai: TEdit;
    dbRgAtivo: TDBRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure DBE_ID_CCPAIExit(Sender: TObject);
  private
    { Private declarations }
    function b_funcRecuperaCCusto : boolean;
  public
    { Public declarations }
    class function b_funcAbreTela(c_pai : TComponent; b_final:boolean=true):boolean;
    function b_funcValidaCampos: boolean;override;
  end;

var
  cCCusto: TcCCusto;

implementation

uses upCCusto;

{$R *.dfm}

class function TcCCusto.b_funcAbreTela(c_pai: TComponent; b_final: boolean): boolean;
begin

  cCCusto := TcCCusto.Create(c_pai);
  try
    cCCusto.b_finaliza:= b_final;
    cCCusto.ShowModal;
  finally
    FreeAndNil(cCCusto);
  end;
  result := true;
end;

function TcCCusto.b_funcRecuperaCCusto: boolean;
var q : TIBQuery;
begin
  procCriarQuery(q);
  try
    q.SQL.Text := 'SELECT A.DS_CCUSTO            '+
                  '  FROM CCUSTO A               '+
                  ' WHERE A.ID_CCUSTO = :CCUSTO  '+
                  '   AND A.CD_USUARIO = :USUARIO';

    q.ParamByName('CCUSTO').AsInteger := dmFinanc.CCustoID_CCPAI.AsInteger;
    q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
    q.Open;
    edDsCCPai.Text := q.FieldByName('DS_CCUSTO').AsString;
    Result := not q.IsEmpty;
  finally
    FreeAndNil(q);
  end;
end;

function TcCCusto.b_funcValidaCampos: boolean;
begin
  Result := inherited;

  if Result then
  begin
    Result := not dmFinanc.b_funcTemCCustoHierarquia(
                  dmFinanc.CCustoID_CCUSTO.AsInteger,
                  dmFinanc.CCustoID_CCPAI.AsInteger);
    if not Result then
      procMsgErro('Centro de Custos '+dmFinanc.CCustoID_CCPAI.AsString+
                  ' não pode ser adicionado como Centro de Custos Pai pois faz parte '+
                  'da Hierarquia do Centro de Custos '+dmFinanc.CCustoID_CCUSTO.AsString+'.');
  end;
end;

procedure TcCCusto.DBE_ID_CCPAIExit(Sender: TObject);
  procedure procPesquisaCCusto;
  begin
    TpCCusto.funcAbreTela(Self,True,False);
    if not dmFinanc.PesCCusto.IsEmpty then
    begin
      dmFinanc.CCustoID_CCPAI.AsInteger := dmFinanc.PesCCustoID_CCUSTO.AsInteger;
    end;
    if DBE_ID_CCPAI.CanFocus then
      DBE_ID_CCPAI.SetFocus;
  end;
begin
  inherited;
  edDsCCPai.Text := EmptyStr;

  if Trim(dmFinanc.CCustoID_CCPAI.AsString) = EmptyStr then
    Exit;

  if not b_funcRecuperaCCusto then
    procPesquisaCCusto;
end;

procedure TcCCusto.FormShow(Sender: TObject);
begin
  inherited;
  procDesabilitaCampos(DBE_ID_CCUSTO);
  b_funcRecuperaCCusto;
end;

initialization
RegisterClass(TcCCusto);

finalization
UnRegisterClass(TcCCusto);

end.
