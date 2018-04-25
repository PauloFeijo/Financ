unit ucUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uLib, udmFinanc, IBX.IBQuery, Data.DB;

type
  TcUsuario = class(TForm)
    pnGeral: TPanel;
    paBotoes: TPanel;
    sbCancelar: TSpeedButton;
    sbSalvar: TSpeedButton;
    sbRemover: TSpeedButton;
    gbDadosConta: TGroupBox;
    gbPergunta: TGroupBox;
    gbPadrao: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edSenha: TEdit;
    edLogin: TEdit;
    edNome: TEdit;
    edSenha2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    sbPerg: TSpeedButton;
    edPergunta: TEdit;
    edResposta: TEdit;
    edCCPad: TEdit;
    Label7: TLabel;
    edDsCCPad: TEdit;
    edConPad: TEdit;
    Label8: TLabel;
    edDsConPad: TEdit;
    sbPad: TSpeedButton;
    procedure sbCancelarClick(Sender: TObject);
    procedure sbSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sbPergClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbRemoverClick(Sender: TObject);
    procedure sbPadClick(Sender: TObject);
    procedure edCCPadExit(Sender: TObject);
    procedure edConPadExit(Sender: TObject);
  private
    { Private declarations }
    b_novo : boolean;
    procedure procRecuperaDadosUsuario;
    function funcEncontraCCusto : boolean;
    function funcEncontraConPad : boolean;
  public
    { Public declarations }
    class procedure procAbreTela(b_novo : boolean = True);
  end;

var
  cUsuario: TcUsuario;

implementation

{$R *.dfm}

uses upCCusto, upConta;

procedure TcUsuario.edCCPadExit(Sender: TObject);
  procedure procPesquisaCCusto;
  begin
    TpCCusto.funcAbreTela(Self, True, False);
    edCCPad.Text   := dmFinanc.PesCCustoID_CCUSTO.AsString;
    edDsCCPad.Text := dmFinanc.PesCCustoDS_CCUSTO.AsString;

    if edCCPad.CanFocus then
      edCCPad.SetFocus
  end;
begin
  edDsCCpad.Text := EmptyStr;

  if Trim(edCCPad.Text) = EmptyStr then
    Exit;

  if not funcEncontraCCusto then
    procPesquisaCCusto;
end;

procedure TcUsuario.edConPadExit(Sender: TObject);
  procedure procPesquisaConta;
  begin
    TpConta.funcAbreTela(Self, True, False);
    edConPad.Text   := dmFinanc.ContaID_CONTA.AsString;
    edDsConPad.Text := dmFinanc.ContaDS_CONTA.AsString;

    if edConPad.CanFocus then
      edConPad.SetFocus
  end;
begin
  edDsConPad.Text := EmptyStr;

  if Trim(edConPad.Text) = EmptyStr then
    Exit;

  if not funcEncontraConPad then
    procPesquisaConta;
end;

procedure TcUsuario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F8: sbSalvar.Click;
    VK_ESCAPE: sbCancelar.Click;
  end;
end;

procedure TcUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TcUsuario.FormShow(Sender: TObject);
begin
  edLogin.Enabled    := b_novo;
  sbRemover.Visible := not b_novo;

  if b_novo then
  begin
    gbPadrao.Visible := False;
    Self.Height := 290;
  end
  else
    procRecuperaDadosUsuario;
end;

function TcUsuario.funcEncontraCCusto: boolean;
var q : TIBQuery;
begin
  procCriarQuery(q);
  try
    q.SQL.Text := ' SELECT DS_CCUSTO FROM CCUSTO WHERE ID_CCUSTO = :CCUSTO ';
    q.ParamByName('CCUSTO').AsInteger := StrToIntDef(edCCPad.Text,0);
    q.Open;

    edDsCCpad.Text := q.FieldByName('DS_CCUSTO').AsString;
    Result := not q.IsEmpty;

  finally
    FreeAndNil(q);
  end;
end;

function TcUsuario.funcEncontraConPad: boolean;
var q : TIBQuery;
begin
  procCriarQuery(q);
  try
    q.SQL.Text := ' SELECT DS_CONTA FROM CONTA WHERE ID_CONTA = :CONTA ';
    q.ParamByName('CONTA').AsInteger := StrToIntDef(edConPad.Text,0);
    q.Open;

    edDsConPad.Text := q.FieldByName('DS_CONTA').AsString;
    Result := not q.IsEmpty;

  finally
    FreeAndNil(q);
  end;
end;

class procedure TcUsuario.procAbreTela(b_novo : boolean);
begin
  cUsuario := TcUsuario.Create(nil);
  try
    cUsuario.b_novo := b_novo;
    cUsuario.ShowModal;
  finally
    FreeAndNil(cUsuario);
  end;
end;

procedure TcUsuario.procRecuperaDadosUsuario;
var q : TIBQuery;
begin
  uLib.procCriarQuery(q);
  try
    q.SQL.Text := 'SELECT * FROM USUARIO WHERE CD_USUARIO = :USUARIO';
    q.ParamByName('USUARIO').AsString := CD_USUARIO_LOGADO;
    q.Open;

    edNome.Text     := q.FieldByName('NM_NOME').AsString;
    edLogin.Text    := q.FieldByName('CD_USUARIO').AsString;
    edSenha.Text    := uLib.descriptografar(q.FieldByName('CD_SENHA').AsString);
    edSenha2.Text   := edSenha.Text;
    edPergunta.Text := q.FieldByName('DS_PERG').AsString;
    edResposta.Text := uLib.descriptografar(q.FieldByName('DS_RESP').AsString);
    edCCpad.Text    := q.FieldByName('ID_CCPAD').AsString;
    edConPad.Text   := q.FieldByName('ID_CONPAD').AsString;
    funcEncontraCCusto;
    funcEncontraConPad;
  finally
    FreeAndNil(q);
  end;
end;

procedure TcUsuario.sbCancelarClick(Sender: TObject);
begin
  if dmFinanc.tdb.InTransaction then
    dmFinanc.tdb.Rollback;

  Self.Close;
end;

procedure TcUsuario.sbPadClick(Sender: TObject);
begin
  procMsgInfo('Centro de Custos Padrão e Conta Padrão serão sugeridos ao gerar o Movimento Financeiro.'+sLineBreak+sLineBreak+
              'Utilidade para facilitar e agilizar lançamentos com Centro de Custos e/ou Contas corriqueiras.'+sLineBreak+sLineBreak+
              'Não é obrigatório informar estes campos, apenas para facilitar os lançamentos do Movimento Financeiro.');
end;

procedure TcUsuario.sbPergClick(Sender: TObject);
begin
  procMsgInfo('Pergunta e resposta secreta poderão ser usadas caso esqueça sua senha. '+sLineBreak+sLineBreak+
              'Necessário que seja bem formulada para que não se esqueça, pois ela é sua garantia. '+
              'Não forneça uma pergunta óbvia, pois qualquer pessoa poderá acessar sua conta.');
end;

procedure TcUsuario.sbRemoverClick(Sender: TObject);
begin
  if not sbRemover.Visible then
    Exit;

  if not funcMsgConfirma('Tem certeza que deseja remover esta conta?'+sLineBreak+sLineBreak+
                           'Atenção, ao remover a conta não será mais possível acessar '+
                           'o sistema. Todos os seus dados serão removidos.') then
    Exit;

  try

    procExecSql(Format('DELETE FROM USUARIO WHERE CD_USUARIO = ''%s''',
                       [ CD_USUARIO_LOGADO]));

    CD_USUARIO_LOGADO := EmptyStr;
    Close;

  Except
    on e : Exception do
    begin
      dmFinanc.tdb.rollback;
      procMsgErro('Erro ao remover usuário.'+sLineBreak+sLineBreak+
                  'Descrição do erro:'+sLineBreak+
                  e.Message);
      Close;
    end;
  end;
end;

procedure TcUsuario.sbSalvarClick(Sender: TObject);

  function funcValidacoes : boolean;
  begin
    Result := False;

    if (Trim(edLogin.Text)  = EmptyStr) or
       (Trim(edSenha.Text)  = EmptyStr) or
       (Trim(edSenha2.Text) = EmptyStr) or
       (Trim(edNome.Text)   = EmptyStr) then
    begin
       procMsgAtencao('Nome, Login, Senha e Repita a Senha são obrigatórios. Favor informá-los!');
       Exit;
    end;

    if Trim(edSenha.Text) <>  Trim(edSenha2.Text) then
      begin
       procMsgAtencao('Senha diferente de Repita a Senha. Favor imformar ambos iguais!');
       Exit;
    end;

    if ((Trim(edPergunta.Text) = EmptyStr) and (Trim(edResposta.Text) <> EmptyStr))or
        (Trim(edPergunta.Text) <> EmptyStr) and (Trim(edResposta.Text) = EmptyStr) then
    begin
       procMsgAtencao('Se informado a Pergunta Secreta, obrigatoriamente deve ser informado a '+
                      'Resposta Secreta e vice-versa.');
       Exit;
    end;

    if (Trim(edPergunta.Text) = EmptyStr) and
      funcMsgConfirma('Não foi informado a Pergunta Secreta. Ela é sua garantia caso esqueça sua senha. '+sLineBreak+
                        'Deseja informar a Pergunta e Resposta Secreta antes de continuar?')  then
      Exit;


    Result := True;
  end;

  procedure procIncluiUsuario;
  begin
    if funcSelect(Format('SELECT NM_NOME FROM USUARIO '+
                           ' WHERE CD_USUARIO = ''%s''',
                           [edLogin.Text])) <> '' then
    begin
      procMsgErro('Já existe um usuario cadastrado com o login "'+edLogin.Text+'". Favor informe outro login.');
      Exit;
    end;

    try
      procExecSql(Format('INSERT INTO USUARIO (CD_USUARIO, CD_SENHA, NM_NOME, DS_PERG, DS_RESP )'+
                         'VALUES(''%s'', ''%s'', ''%s'', ''%s'', ''%s'')',
                         [edLogin.Text,
                          uLib.criptografar(edSenha.Text),
                          edNome.Text,
                          edPergunta.Text,
                          uLib.criptografar(edResposta.Text)
                         ]));
      Close;
    Except
      on e : Exception do
      begin
        dmFinanc.tdb.rollback;
        procMsgErro('Erro ao inserir usuário.'+sLineBreak+sLineBreak+
                    'Descrição do erro:'+sLineBreak+
                    e.Message);
        Close;
      end;
    end;
  end;

  procedure procAlteraUsuario;
  begin
    try
      procExecSql(Format('UPDATE USUARIO              '+
                         '   SET CD_SENHA   = ''%s'', '+
                         '       NM_NOME    = ''%s'', '+
                         '       DS_PERG    = ''%s'', '+
                         '       DS_RESP    = ''%s'', '+
                         '       ID_CCPAD   =   %s,   '+
                         '       ID_CONPAD  =   %s    '+
                         ' WHERE CD_USUARIO = ''%s''  ',
                         [uLib.criptografar(edSenha.Text),
                          edNome.Text,
                          edPergunta.Text,
                          uLib.criptografar(edResposta.Text),
                          IIF(Trim(edCCPad.Text)  <> EmptyStr, edCCPad.Text, 'NULL'),
                          IIF(Trim(edConPad.Text) <> EmptyStr, edConPad.Text, 'NULL'),
                          CD_USUARIO_LOGADO
                         ]));

      id_CCPad  := StrToIntDef(edCCPad.Text,0);
      id_ConPad := StrToIntDef(edConPad.Text,0);

      Close;
    Except
      on e : Exception do
      begin
        dmFinanc.tdb.rollback;
        procMsgErro('Erro ao alterar usuário.'+sLineBreak+sLineBreak+
                    'Descrição do erro:'+sLineBreak+
                    e.Message);
        Close;
      end;
    end;
  end;

begin

  procSairCampo(Self);

  if not funcValidacoes then
    Exit;

  if b_novo then
    procIncluiUsuario
  else
    procAlteraUsuario;
end;

end.
