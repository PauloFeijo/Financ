unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, IBX.IBQuery, ucUsuario, uSplash, udmFinanc, Data.DB;

type
  Tlogin = class(TForm)
    Panel1: TPanel;
    sbSair: TSpeedButton;
    sbEntrar: TSpeedButton;
    Panel2: TPanel;
    Label2: TLabel;
    edSenha: TEdit;
    edUsuario: TEdit;
    Label1: TLabel;
    lbNovoUsuario: TLabel;
    lbEsqueciSenha: TLabel;
    procedure sbEntrarClick(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edUsuarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbNovoUsuarioClick(Sender: TObject);
    procedure lbEsqueciSenhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure procAbreTela(c_pai : TComponent);
  end;

var
  login: Tlogin;

implementation

uses uPrincipal, uLib;

{$R *.dfm}

procedure Tlogin.edSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN : sbEntrar.Click;
  end;
end;

procedure Tlogin.edUsuarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN : edSenha.SetFocus;
  end;
end;

procedure Tlogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : login.Close;
  end;
end;

procedure Tlogin.FormShow(Sender: TObject);
begin
  Panel1.Color := CorTela;
  Panel2.Color := CorTela;

  {if DebugHook = 1 then
  begin
    edUsuario.Text := 'paulo';
    edSenha.Text := 'paulo';
    sbEntrar.Click;
  end;}
end;

procedure Tlogin.lbEsqueciSenhaClick(Sender: TObject);
var q : TIBQuery;
    s_novaSenha : string;
begin
  if Trim(edUsuario.Text) = EmptyStr then
  begin
    procMsgAtencao('Informe o Usuário!');
    Exit;
  end;

  uLib.procCriarQuery(q);

  try
    q.SQL.Text := 'SELECT DS_PERG, DS_RESP FROM USUARIO WHERE CD_USUARIO = :USUARIO';
    q.ParamByName('USUARIO').AsString := edUsuario.Text;
    q.Open;

    if q.IsEmpty then
    begin
      procMsgErro('Usuário não encontrado! Informe um usuário válido.');
      exit;
    end;

    if Trim(q.FieldByName('DS_PERG').AsString) = EmptyStr then
    begin
      procMsgErro('Desculpe, Usuário informado não possui pergunta secreta!'+sLineBreak+
                  'Não será possível continuar com a recuperação da senha!');
      exit;
    end;

    if uLib.criptografar(Trim(InputBox('Pergunta:',
       q.FieldByName('DS_PERG').AsString,''))) =
       q.FieldByName('DS_RESP').AsString then
    begin
      s_novaSenha := FormatDateTime('DDMMYYYY',funcHoje);

      try
        procExecSql(Format('UPDATE USUARIO              '+
                           '   SET CD_SENHA   = ''%s''  '+
                           ' WHERE CD_USUARIO = ''%s''  ',
                           [uLib.criptografar(s_novaSenha),
                            edUsuario.Text
                           ]));

        procMsgInfo(Format('Usuário %s teve sua senha redefinida para %s. '+sLineBreak+
                           'Anote esta senha, logue no sistema e vá em Configurações -> Conta, e informe uma nova senha para sua segurança.',
                           [edUsuario.Text, s_novaSenha]
                           ));

      Except
        on e : Exception do
        begin
          dmFinanc.tdb.rollback;
          procMsgErro('Erro ao redefinir senha'+sLineBreak+sLineBreak+
                      'Descrição do erro:'+sLineBreak+
                      e.Message);
          Close;
        end;
      end;

    end
    else
      procMsgErro('Sua resposta não condiz com a Pergunta Secreta! Tente novamente.');

  finally
    FreeAndNil(q);
  end;
end;

procedure Tlogin.lbNovoUsuarioClick(Sender: TObject);
begin
  TcUsuario.procAbreTela;
end;

class procedure Tlogin.procAbreTela(c_pai : TComponent);
begin
  login := TLogin.Create(c_pai);
  try
    login.ShowModal;
  finally
    FreeAndNil(login);
  end;
end;

procedure Tlogin.sbEntrarClick(Sender: TObject);
var q_usuario : TIBQuery;
begin
  CD_USUARIO_LOGADO := EmptyStr;
  procCriarQuery(q_usuario);
  try
    q_usuario.SQL.Text := 'SELECT CD_USUARIO,'+
                          '       ID_CCPAD,  '+
                          '       ID_CONPAD  '+
                          ' FROM USUARIO     '+
                          ' WHERE CD_USUARIO = :USUARIO '+
                          '   AND CD_SENHA   = :SENHA   ';

    q_usuario.ParamByName('USUARIO').AsString := edUsuario.Text;
    q_usuario.ParamByName('SENHA').AsString   := uLib.criptografar(edSenha.Text);
    q_usuario.Open;

    if q_usuario.IsEmpty then
      procMsgErro('Usuário e/ou senha inválida(os)')
    else
    begin
      CD_USUARIO_LOGADO := q_usuario.FieldByName('CD_USUARIO').AsString;
      id_CCPad          := q_usuario.FieldByName('ID_CCPAD').AsInteger;
      id_ConPad         := q_usuario.FieldByName('ID_CONPAD').AsInteger;
      self.Close;
    end;

  finally
    FreeAndNil(q_usuario);
  end;
end;

procedure Tlogin.sbSairClick(Sender: TObject);
begin
  self.Close;
end;

end.
