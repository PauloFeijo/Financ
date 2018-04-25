unit ucPagRec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, udmFinanc, uCadPadrao, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls,
  IBX.IBQuery, uLib, upCateg, Data.DB, Vcl.ComCtrls, JvExComCtrls,
  JvDateTimePicker, JvDBDateTimePicker, JvExMask, JvToolEdit, JvMaskEdit,
  JvCheckedMaskEdit, JvDatePickerEdit, JvDBDatePickerEdit, JvBaseEdits,
  JvDBControls, Vcl.Samples.Spin, Math;

type
  TcPagRec = class(TcCadPadrao)
    Label1: TLabel;
    DBE_ID_PAGRECEB: TDBEdit;
    Label3: TLabel;
    DBE_ID_CATEG: TDBEdit;
    Label4: TLabel;
    DBE_DS_CATEG: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    DBE_VL_PAGO: TDBEdit;
    Label9: TLabel;
    DBE_NR_DOCTO: TDBEdit;
    Label11: TLabel;
    DBE_DS_DESCRI: TDBEdit;
    Label10: TLabel;
    DBE_DT_VENCTO: TJvDBDatePickerEdit;
    DBE_VL_VALOR: TJvDBCalcEdit;
    gbNrParc: TGroupBox;
    spNrParc: TSpinEdit;
    procedure DBE_ID_CATEGExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure procDivideMultiplicaConta(b_divide : boolean);
  public
    { Public declarations }
    function b_funcValidaCampos: boolean;override;
    procedure procAntesDoPost;override;
    procedure procDepoisDoPost;override;
  end;

var
  cPagRec: TcPagRec;

implementation

{$R *.dfm}

function TcPagRec.b_funcValidaCampos: boolean;
begin
  Result := Inherited;
  if not Result then
    Exit;

  Result := False;

  if dmFinanc.PagarReceberVL_VALOR.AsFloat = 0 then
  begin
    procMsgErro('Informe o valor maior que zero!');
    Exit;
  end;

  Result := True;
end;

procedure TcPagRec.DBE_ID_CATEGExit(Sender: TObject);
  procedure procPesquisaCategoria;
  begin
    TpCateg.funcAbreTela(Self,True,False);
    if not dmFinanc.PesCategoria.IsEmpty then
    begin
      dmFinanc.PagarReceberID_CATEG.AsInteger := dmFinanc.PesCategoriaID_CATEG.AsInteger;
      dmFinanc.PagarReceberDS_CATEG.AsString  := dmFinanc.PesCategoriaDS_CATEG.AsString;
      dmFinanc.PagarReceberFL_TIPO.AsString   := IIF(dmFinanc.PesCategoriaFL_TIPO.AsString = 'R','R','P');
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

      q.ParamByName('CATEG').AsInteger  := dmFinanc.PagarReceberID_CATEG.AsInteger;
      q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
      q.Open;
      dmFinanc.PagarReceberDS_CATEG.AsString := q.FieldByName('DS_CATEG').AsString;
      dmFinanc.PagarReceberFL_TIPO.AsString  := IIF(q.FieldByName('FL_TIPO').AsString = 'R','R','P');
      Result := not q.IsEmpty;
    finally
      FreeAndNil(q);
    end;
  end;
begin
  inherited;
  dmFinanc.PagarReceberDS_CATEG.AsString := EmptyStr;
  if not b_funcRecuperaCategoria then
    procPesquisaCategoria;
end;

procedure TcPagRec.FormShow(Sender: TObject);
begin
  inherited;

  if q_Principal.State <> dsInsert then
  begin
    gbNrParc.Visible   := False;
    DBE_DS_CATEG.Width := 245;
  end;

  procDesabilitaCampos(DBE_ID_PAGRECEB);
  procDesabilitaCampos(DBE_DS_CATEG);
  procDesabilitaCampos(DBE_VL_PAGO);
  procDesabilitaCampos(DBE_NR_DOCTO);

  DBE_VL_VALOR.Color  := corCampoRequerido;
  DBE_DT_VENCTO.Color := corCampoRequerido;
  spNrParc.Color      := corCampoRequerido;
end;

procedure TcPagRec.procAntesDoPost;
begin
  inherited;
  if dmFinanc.PagarReceberNR_DOCTO.IsNull then
    dmFinanc.PagarReceberNR_DOCTO.AsString := IntToStr(dmFinanc.i_funcNextSequence('GEN_DOCPREC'));
end;

procedure TcPagRec.procDepoisDoPost;
begin
  inherited;
  if gbNrParc.Visible and (spNrParc.Value > 1) then
    procDivideMultiplicaConta(
       funcMsgConfirma(
          'Deseja dividir o valor nas parcelas a serem criadas?'+sLineBreak+sLineBreak+
          '[Sim] - Divide o valor para as parcelas'+sLineBreak+
          '[Não] - Gera as parcelas com o valor total informado.')
       );
end;

procedure TcPagRec.procDivideMultiplicaConta(b_divide : boolean);
var i_qtde, i_cont, i_categ : integer;
    f_valor, f_tvalor : double;
    d_base  : TDate;
    s_tipo, s_descri, s_doc : string;
begin
  i_qtde := spNrParc.Value;

  d_base   := dmFinanc.PagarReceberDT_VENCTO.AsDateTime;
  i_categ  := dmFinanc.PagarReceberID_CATEG.AsInteger;
  s_tipo   := dmFinanc.PagarReceberFL_TIPO.AsString;
  s_doc    := dmFinanc.PagarReceberNR_DOCTO.AsString;
  s_descri := dmFinanc.PagarReceberDS_DESCRI.AsString;

  f_tvalor := dmFinanc.PagarReceberVL_VALOR.AsFloat;

  dmFinanc.PagarReceber.Edit;

  if b_divide then
    f_valor := Math.RoundTo(f_tvalor / i_qtde,-2)
  else
    f_valor := f_tvalor;

  dmFinanc.PagarReceberVL_VALOR.AsFloat  := f_valor;
  dmFinanc.PagarReceberNR_DOCTO.AsString := s_doc + '-1';
  dmFinanc.PagarReceber.Post;

  for i_cont := 2 to i_qtde do
  begin
    d_base := IncMonth(d_base);
    dmFinanc.PagarReceber.Append;
    dmFinanc.PagarReceberID_CATEG.AsInteger   := i_categ;
    dmFinanc.PagarReceberDT_VENCTO.AsDateTime := d_base;
    dmFinanc.PagarReceberFL_TIPO.AsString     := s_tipo;
    dmFinanc.PagarReceberNR_DOCTO.AsString    := s_doc + '-'+IntToStr(i_cont);
    dmFinanc.PagarReceberDS_DESCRI.AsString   := s_descri;

    dmFinanc.PagarReceberVL_VALOR.AsFloat  := f_valor;

    dmFinanc.PagarReceber.Post;
  end;

  if b_divide then //se é divisão, desconta a diferenca no ultimo.
  begin
    dmFinanc.PagarReceber.Edit;
    dmFinanc.PagarReceberVL_VALOR.AsFloat  :=  f_valor + f_tvalor - (f_valor * i_qtde);
    dmFinanc.PagarReceber.Post;
  end;
end;

initialization
RegisterClass(TcPagRec);

finalization
UnRegisterClass(TcPagRec);

end.
