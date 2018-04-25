unit ucMovFin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmFinanc, uCadPadrao, StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons,
  uLib, upConta, IBX.IBQuery, Menus, upCateg, Data.DB, JvExMask,
  JvToolEdit, JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit,
  JvDBDatePickerEdit, JvBaseEdits, JvDBControls;

type
  TcMovFin = class(TcCadPadrao)
    Label1: TLabel;
    DBE_ID_MOVIM: TDBEdit;
    Label2: TLabel;
    DBE_ID_CONTA: TDBEdit;
    Label3: TLabel;
    DBE_NR_CONTA: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBE_DS_MOVIM: TDBEdit;
    Label10: TLabel;
    DBE_DS_CONTA: TDBEdit;
    Label4: TLabel;
    DBE_ID_CATEG: TDBEdit;
    Label8: TLabel;
    DBE_DS_CATEG: TDBEdit;
    Label9: TLabel;
    Label11: TLabel;
    DBE_ID_CCUSTO: TDBEdit;
    DBE_DS_CCUSTO: TDBEdit;
    DBE_DT_MOVIM: TJvDBDatePickerEdit;
    DBE_VL_BRUTO: TJvDBCalcEdit;
    Label12: TLabel;
    DBE_VL_MOVIM: TDBEdit;
    Label13: TLabel;
    DBE_VL_JUROS: TJvDBCalcEdit;
    Label14: TLabel;
    DBE_VL_DESCON: TJvDBCalcEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DBE_ID_CONTAExit(Sender: TObject);
    procedure DBE_ID_CATEGExit(Sender: TObject);
    procedure DBE_ID_CCUSTOExit(Sender: TObject);
  private
    { Private declarations }
    function b_funcRecuperaCCusto : boolean;
    function b_funcEncontraConta : boolean;
  public
    { Public declarations }
    function b_funcValidaCampos: boolean;override;
    class function b_funcAbreTela(Pai               : TComponent;
                                  b_finaliza        : boolean = True;
                                  b_somentePesquisa : boolean = False;
                                  b_categ           : boolean = True) : boolean;
  end;

var
  cMovFin: TcMovFin;

implementation

{$R *.dfm}

uses upCCusto;

class function TcMovFin.b_funcAbreTela(Pai: TComponent; b_finaliza, b_somentePesquisa,
  b_categ: boolean): boolean;
begin
  cMovFin := TcMovFin.Create(Pai);
  try
    cMovFin.DBE_ID_CATEG.Enabled := b_categ;
    cMovFin.ShowModal;
  finally
    FreeAndNil(cMovFin);
  end;
  Result := True;
end;

function TcMovFin.b_funcEncontraConta: boolean;
var q_conta : TIBQuery;
begin
  result := false;
  procCriarQuery(q_conta);
  try
    q_conta.SQL.Text := 'SELECT A.NR_CONTA,A.DS_CONTA  '+
                        '  FROM CONTA A                '+
                        ' WHERE A.ID_CONTA   = :CONTA  '+
                        '   AND A.CD_USUARIO = :USUARIO'+
                        '   AND A.FL_ATIVO   = ''A''   ';

    q_conta.ParamByName('CONTA').AsInteger := dmFinanc.MOVIMENTOID_CONTA.AsInteger;
    q_conta.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
    q_conta.Open;
    if not q_conta.IsEmpty then
    begin
      dmFinanc.MOVIMENTONR_CONTA.AsString := q_conta.FieldByName('NR_CONTA').AsString;
      dmFinanc.MOVIMENTODS_CONTA.AsString := q_conta.FieldByName('DS_CONTA').AsString;
      result := true;
    end;
  finally
    FreeAndNil(q_conta);
  end;
end;

function TcMovFin.b_funcRecuperaCCusto: boolean;
var q : TIBQuery;
begin
  procCriarQuery(q);
  try
    q.SQL.Text := 'SELECT A.DS_CCUSTO            '+
                  '  FROM CCUSTO A               '+
                  ' WHERE A.ID_CCUSTO  = :CCUSTO '+
                  '   AND A.CD_USUARIO = :USUARIO'+
                  '   AND A.FL_ATIVO   = ''A''   ';

    q.ParamByName('CCUSTO').AsInteger := dmFinanc.MovimentoID_CCUSTO.AsInteger;
    q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
    q.Open;
    dmFinanc.MovimentoDS_CCUSTO.AsString := q.FieldByName('DS_CCUSTO').AsString;
    Result := not q.IsEmpty;
  finally
    FreeAndNil(q);
  end;
end;

function TcMovFin.b_funcValidaCampos: boolean;
begin
  Result := Inherited;
  if not Result then
    Exit;

  Result := False;

  if dmFinanc.MovimentoVL_MOVIM.AsFloat = 0 then
  begin
    procMsgErro('Valor Líquido deve ser maior que zero!');
    Exit;
  end;

  if (dmFinanc.MovimentoFL_TIPO.AsString = 'R') and
      not dmFinanc.funcValidaMovimentoDentroDoPlano(
      dmFinanc.MovimentoID_MOVIM.AsInteger,
      dmFinanc.MovimentoID_CCUSTO.AsInteger,
      dmFinanc.MovimentoID_CATEG.AsInteger,

      IIF(dmFinanc.MovimentoVL_MOVIM.AsFloat < 0,
          -dmFinanc.MovimentoVL_MOVIM.AsFloat,
          dmFinanc.MovimentoVL_MOVIM.AsFloat),

      dmFinanc.MovimentoDT_MOVIM.AsDateTime) then
    Exit;

  Result := True;
end;

procedure TcMovFin.DBE_ID_CATEGExit(Sender: TObject);
  procedure procPesquisaCategoria;
  begin
    TpCateg.funcAbreTela(Self,True,False);
    if not dmFinanc.PesCategoria.IsEmpty then
    begin
      dmFinanc.MovimentoID_CATEG.AsInteger := dmFinanc.PesCategoriaID_CATEG.AsInteger;
      dmFinanc.MovimentoDS_CATEG.AsString  := dmFinanc.PesCategoriaDS_CATEG.AsString;
      dmFinanc.MovimentoFL_TIPO.AsString   := IIF(dmFinanc.PesCategoriaFL_TIPO.AsString = 'R','D','R');
    end;
    if DBE_ID_CATEG.CanFocus then
      DBE_ID_CATEG.SetFocus;
  end;
  function b_funcRecuperaCategoria: boolean;
  var q : TIBQuery;
  begin
    procCriarQuery(q);
    try
      q.SQL.Text := 'SELECT A.DS_CATEG, A.FL_TIPO  '+
                    '  FROM CATEGORIA A            '+
                    ' WHERE A.ID_CATEG   = :CATEG  '+
                    '   AND A.CD_USUARIO = :USUARIO'+
                    '   AND A.FL_ATIVO   = ''A''   ';

      q.ParamByName('CATEG').AsInteger := dmFinanc.MovimentoID_CATEG.AsInteger;
      q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
      q.Open;
      dmFinanc.MovimentoDS_CATEG.AsString := q.FieldByName('DS_CATEG').AsString;
      dmFinanc.MovimentoFL_TIPO.AsString  := IIF(q.FieldByName('FL_TIPO').AsString = 'R','D','R');
      Result := not q.IsEmpty;
    finally
      FreeAndNil(q);
    end;
  end;
begin
  inherited;
  dmFinanc.MovimentoDS_CATEG.AsString := EmptyStr;
  if not b_funcRecuperaCategoria then
    procPesquisaCategoria;
end;

procedure TcMovFin.DBE_ID_CCUSTOExit(Sender: TObject);
  procedure procPesquisaCCusto;
  begin
    TpCCusto.funcAbreTela(Self,True,False);
    if not dmFinanc.PesCCusto.IsEmpty then
    begin
      dmFinanc.MovimentoID_CCUSTO.AsInteger := dmFinanc.PesCCustoID_CCUSTO.AsInteger;
      dmFinanc.MovimentoDS_CCUSTO.AsString  := dmFinanc.PesCCustoDS_CCUSTO.AsString;
    end;
    if DBE_ID_CCUSTO.CanFocus then
      DBE_ID_CCUSTO.SetFocus;
  end;
begin
  inherited;
  dmFinanc.MovimentoDS_CCUSTO.AsString := EmptyStr;
  if not b_funcRecuperaCCusto then
    procPesquisaCCusto;
end;

procedure TcMovFin.DBE_ID_CONTAExit(Sender: TObject);
  procedure procPesquisaConta;
  begin
    dmFinanc.MOVIMENTOID_CONTA.Clear;
    if TpConta.funcAbreTela(Self,True,False) then
    begin
      if dmFinanc.CONTAID_CONTA.AsInteger > 0 then
      begin
        dmFinanc.MOVIMENTOID_CONTA.AsString := dmFinanc.CONTAID_CONTA.AsString;
        dmFinanc.MOVIMENTONR_CONTA.AsString := dmFinanc.CONTANR_CONTA.AsString;
        dmFinanc.MOVIMENTODS_CONTA.AsString := dmFinanc.CONTADS_CONTA.AsString;
      end;
    end;
    DBE_ID_CONTA.SetFocus;
  end;
begin
  inherited;
  dmFinanc.MOVIMENTONR_CONTA.Clear;
  dmFinanc.MOVIMENTODS_CONTA.Clear;

  if dmFinanc.MOVIMENTOID_CONTA.IsNull then
    procPesquisaConta
  else
    if not b_funcEncontraConta then
      procPesquisaConta;
end;

procedure TcMovFin.FormShow(Sender: TObject);
begin
  inherited;
  procDesabilitaCampos(DBE_ID_MOVIM);
  procDesabilitaCampos(DBE_NR_CONTA);
  procDesabilitaCampos(DBE_DS_CONTA);
  procDesabilitaCampos(DBE_DS_CATEG);
  procDesabilitaCampos(DBE_DS_CCUSTO);
  procDesabilitaCampos(DBE_VL_MOVIM);

  DBE_DT_MOVIM.Color  := corCampoRequerido;
  DBE_VL_BRUTO.Color  := corCampoRequerido;
  DBE_VL_JUROS.Color  := corCampoRequerido;
  DBE_VL_DESCON.Color := corCampoRequerido;

  b_funcRecuperaCCusto;
  b_funcEncontraConta;
end;

initialization
RegisterClass(TCMovFin);

finalization
UnRegisterClass(TCMovFin);

end.
