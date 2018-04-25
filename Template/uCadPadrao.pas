unit uCadPadrao;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, DB, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Menus, IBQuery;

type
   TcCadPadrao = class(TForm)
      paBotoes: TPanel;
      pnGeral: TPanel;
      sbCancelar: TSpeedButton;
      sbSalvar: TSpeedButton;
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure sbSalvarClick(Sender: TObject);
      procedure sbCancelarClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure procCamposObrigatorios;
      procedure FormShow(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
   private
      { Private declarations }
   public
      { Public declarations }
      q_Principal: TIBQuery;
      b_finaliza: boolean;
      b_somentePesquisa: boolean;
      procedure procAntesDoPost; dynamic;
      procedure procDepoisDoPost; dynamic;
      function b_funcValidaCampos: boolean; dynamic;
   end;

var
   cCadPadrao: TcCadPadrao;

implementation

uses uLib;
{$R *.dfm}

procedure TcCadPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   q_Principal.Cancel;
   if b_finaliza and q_Principal.Transaction.Active then
      q_Principal.Transaction.Rollback;
end;

procedure TcCadPadrao.FormCreate(Sender: TObject);
   function getQuery: TIBQuery;
   var c: TComponent;
   begin
      Result := nil;
      for c in Self do
      begin
         if (c.ClassType = TDBEdit) and (Assigned(TDBEdit(c).DataSource.DataSet))
         then
         begin
            Result := TIBQuery(TDBEdit(c).DataSource.DataSet);
            Break;
         end;
      end;
      Assert(Assigned(Result), 'Não encontrada a query principal para a tela '+Self.Name);
   end;

begin
   if not Assigned(q_Principal) then
      q_Principal := getQuery;

   if not q_principal.Transaction.Active then
      q_principal.Transaction.StartTransaction;

   b_finaliza        := True;
   b_somentePesquisa := False;
end;

procedure TcCadPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
      VK_F8: sbSalvar.Click;
      VK_ESCAPE: sbCancelar.Click;
   end;
end;

procedure TcCadPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TcCadPadrao.FormShow(Sender: TObject);
begin
   Self.Color := corTela;
   Self.paBotoes.Color := corTela;
   Self.pnGeral.Color := corTela;
   procCamposObrigatorios;

   sbSalvar.Enabled := not b_somentePesquisa;
end;

procedure TcCadPadrao.sbCancelarClick(Sender: TObject);
begin
   paBotoes.SetFocus;
   Self.Close;
end;

procedure TcCadPadrao.sbSalvarClick(Sender: TObject);
   procedure procErroAoSalvar(c_msgErro: string);
   begin
      if b_finaliza and q_Principal.Transaction.Active then
         q_Principal.Transaction.Rollback;
      procMsgErro(
         'Erro ao salvar informações.' +sLineBreak+sLineBreak+
         'Causa: ' + c_msgErro+sLineBreak+sLineBreak +
         'Feche o Form e tente novamente.');
   end;

begin
   if not sbSalvar.Enabled then
      exit;

   procSairCampo(Self);

   if b_funcValidaCampos then
   begin
      try
         procAntesDoPost;
         q_Principal.Post;
         procDepoisDoPost;

         if b_finaliza and q_Principal.Transaction.Active then
            q_Principal.Transaction.Commit;
      Except
         on e: EDatabaseError do
         begin
            if (pos('lock', e.Message) > 0) then
               procErroAoSalvar('Registro atual está sendo editado por outro usuário.')
            else if (pos('UNIQUE KEY', e.Message) > 0) then
               procErroAoSalvar('Existe um registro cadastrado no sistema com mesmo código.')
            else
               procErroAoSalvar(e.Message);
         end;

         on e: Exception do
            procErroAoSalvar(e.Message);
      end;
      Self.Close
   end;
end;

function TcCadPadrao.b_funcValidaCampos: boolean;
begin
   Result := funcValidaCamposObrigatorios(q_Principal);
end;

procedure TcCadPadrao.procAntesDoPost;
begin
   // nada
end;

procedure TcCadPadrao.procCamposObrigatorios;
var
   iCont: integer;
begin
   for iCont := 0 to Self.ComponentCount - 1 do
   begin
      // dbedit
      if Self.Components[iCont].ClassType = TDBEdit then
      begin
         if (TDBEdit(Self.Components[iCont]).DataSource.DataSet.FieldByName
            (TDBEdit(Self.Components[iCont]).DataField).Required) and
             TDBEdit(Self.Components[iCont]).Enabled then
         begin
            TDBEdit(Self.Components[iCont]).Color := corCampoRequerido;
         end;
      end;
      // dbMemo
      if Self.Components[iCont].ClassType = TDBMemo then
      begin
         if (TDBMemo(Self.Components[iCont]).DataSource.DataSet.FieldByName
            (TDBMemo(Self.Components[iCont]).DataField).Required) and
             TDBMemo(Self.Components[iCont]).Enabled then
         begin
            TDBMemo(Self.Components[iCont]).Color := corCampoRequerido;
         end;
      end;
   end;
end;

procedure TcCadPadrao.procDepoisDoPost;
begin
   // nada
end;

initialization

RegisterClass(TcCadPadrao);

finalization

UnRegisterClass(TcCadPadrao);

end.
