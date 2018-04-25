unit ucTransf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmFinanc, uCadPadrao, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls,
  uLib, IBX.IBQuery, DB, IBX.IBCustomDataset, upConta, JvExMask, JvToolEdit,
  JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit, JvDBDatePickerEdit,
  JvBaseEdits, JvDBControls;

type
  TcTransf = class(TcCadPadrao)
    Label1: TLabel;
    DBE_ID_TRANSFER: TDBEdit;
    Label2: TLabel;
    DBE_ID_MOVDEB: TDBEdit;
    Label3: TLabel;
    DBE_ID_MOVCRE: TDBEdit;
    Label4: TLabel;
    DBE_DS_TRANSF: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBE_DS_CDEB: TDBEdit;
    Label8: TLabel;
    DBE_ID_CDEB: TDBEdit;
    Label9: TLabel;
    DBE_NR_CDEB: TDBEdit;
    Label10: TLabel;
    DBE_ID_CCRED: TDBEdit;
    Label11: TLabel;
    DBE_DS_CCRED: TDBEdit;
    Label12: TLabel;
    DBE_NR_CCRED: TDBEdit;
    DBE_DT_TRANSF: TJvDBDatePickerEdit;
    DBE_VL_TRANSF: TJvDBCalcEdit;
    procedure FormShow(Sender: TObject);
    procedure DBE_ID_CDEBExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function b_funcValidaCampos: boolean;override;
    procedure procAntesDoPost;override;
  end;

var
  cTransf: TcTransf;

implementation

{$R *.dfm}

function TcTransf.b_funcValidaCampos: boolean;
begin
  Result := Inherited;
  if not Result then
    Exit;

  Result := False;

  if dmFinanc.TransferenciaVL_TRANSF.AsFloat <= 0 then
  begin
    procMsgErro('Informe o valor maior que zero!');
    Exit;
  end;

  if dmFinanc.TransferenciaID_CDEB.AsInteger = dmFinanc.TransferenciaID_CCRED.AsInteger then
  begin
    procMsgErro('Conta de Débito e Conta de Crédito devem ser diferentes.');
    Exit;
  end;

  Result := True;
end;

procedure TcTransf.DBE_ID_CDEBExit(Sender: TObject);
var FIdConta, FNrConta : TIntegerField;
    FDsConta : TIBStringField;

  function funcRecuperaConta : boolean;
  var q : TIBQuery;
  begin
    procCriarQuery(q);
    try
      q.SQL.Text :=
        'SELECT A.NR_CONTA,             '+
        '       A.DS_CONTA              '+
        '  FROM CONTA A                 '+
        ' WHERE A.ID_CONTA   = :CONTA   '+
        '   AND A.CD_USUARIO = :USUARIO '+
        '   AND A.FL_ATIVO   = ''A''    ';

      q.ParamByName('CONTA').AsInteger  := FIdConta.AsInteger;
      q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
      q.Open;

      FNrConta.AsInteger := q.FieldByName('NR_CONTA').AsInteger;
      FDsConta.AsString  := q.FieldByName('DS_CONTA').AsString;

      Result := not q.IsEmpty;
    finally
      FreeAndNil(q);
    end;
  end;

  procedure procPesquisaConta;
  begin
    if not TpConta.funcAbreTela(Self,True,False) then
      Exit;

    FIdConta.Clear;

    if not dmFinanc.Conta.IsEmpty then
    begin
      FIdConta.AsInteger := dmFinanc.ContaID_CONTA.AsInteger;
      FNrConta.AsInteger := dmFinanc.ContaNR_CONTA.AsInteger;
      FDsConta.AsString  := dmFinanc.ContaDS_CONTA.AsString;
    end;

    if TDBEdit(Sender).CanFocus then
      TDBEdit(Sender).SetFocus;
  end;
begin
  inherited;

  if Sender = DBE_ID_CDEB then
  begin
    FIdConta := dmFinanc.TransferenciaID_CDEB;
    FNrConta := dmFinanc.TransferenciaNR_CDEB;
    FDsConta := dmFinanc.TransferenciaDS_CDEB;
  end
  else
  begin
    FIdConta := dmFinanc.TransferenciaID_CCRED;
    FNrConta := dmFinanc.TransferenciaNR_CCRED;
    FDsConta := dmFinanc.TransferenciaDS_CCRED;
  end;

  FNrConta.Clear;
  FDsConta.Clear;

  if not funcRecuperaConta then
    procPesquisaConta;
end;

procedure TcTransf.FormShow(Sender: TObject);
begin
  inherited;
  procDesabilitaCampos(DBE_ID_TRANSFER);
  procDesabilitaCampos(DBE_ID_MOVDEB);
  procDesabilitaCampos(DBE_ID_MOVCRE);
  procDesabilitaCampos(DBE_NR_CDEB);
  procDesabilitaCampos(DBE_DS_CDEB);
  procDesabilitaCampos(DBE_NR_CCRED);
  procDesabilitaCampos(DBE_DS_CCRED);
  DBE_DT_TRANSF.Color := corCampoRequerido;
  DBE_VL_TRANSF.Color := corCampoRequerido;
end;

procedure TcTransf.procAntesDoPost;
begin
  inherited;
  if id_ccpad = 0 then
    raise Exception.Create(
      'Erro ao gerar Transferência!'+sLineBreak+sLineBreak+
      'Descrição do erro: Não será possível gerar as Movimentações de Débito e Crédito, motivo de não ter Centro de Custos Padrão configurado.'+sLineBreak+sLineBreak+
      'Solução: Configure em contas do usuário, o Centro de Custos Padrão.'
    );

  //Débito
  dmFinanc.procCriaAtualizaMovimento(
    dmFinanc.TransferenciaID_MOVDEB.AsInteger,
    dmFinanc.TransferenciaID_CDEB.AsInteger,
    dmFinanc.TransferenciaVL_TRANSF.AsFloat,
    dmFinanc.TransferenciaDS_TRANSF.AsString,'R',
    dmFinanc.i_funcCategPadrao('D'),
    dmFinanc.TransferenciaDT_TRANSF.AsDateTime,
    id_ccpad
  );

  dmFinanc.TransferenciaID_MOVDEB.AsInteger := dmFinanc.MovimentoID_MOVIM.AsInteger;

  //Crédito
  dmFinanc.procCriaAtualizaMovimento(
    dmFinanc.TransferenciaID_MOVCRE.AsInteger,
    dmFinanc.TransferenciaID_CCRED.AsInteger,
    dmFinanc.TransferenciaVL_TRANSF.AsFloat,
    dmFinanc.TransferenciaDS_TRANSF.AsString,'D',
    dmFinanc.i_funcCategPadrao('R'),
    dmFinanc.TransferenciaDT_TRANSF.AsDateTime,
    id_ccpad
  );

  dmFinanc.TransferenciaID_MOVCRE.AsInteger := dmFinanc.MovimentoID_MOVIM.AsInteger;

end;

initialization
RegisterClass(TcTransf);

finalization
UnRegisterClass(TcTransf);

end.
