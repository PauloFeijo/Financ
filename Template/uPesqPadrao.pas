unit uPesqPadrao;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, Grids, DBGrids, Buttons, ExtCtrls, ComCtrls, StdCtrls, DB,
   Menus, System.UITypes, IBQuery;

type

   TLocate = (tlChave, tlLocate);

   TpPesqPadrao = class(TForm)
      paBotoes: TPanel;
      dbgPesq: TDBGrid;
      gbFiltro: TGroupBox;
      psFiltros: TPageScroller;
      paFiltros: TPanel;
      pmPad: TPopupMenu;
      SalvarConfiguraodaGrade1: TMenuItem;
      RestaurarConfiguraodaGrade1: TMenuItem;
      sbAlterar: TSpeedButton;
      sbRemover: TSpeedButton;
      sbSair: TSpeedButton;
      sbRelatorio: TSpeedButton;
      sbAdicionar: TSpeedButton;
      sbPesquisar: TSpeedButton;
      ExportardadosparaPlanilhaExcel1: TMenuItem;
      procedure FormActivate(Sender: TObject);
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure sbAdicionarClick(Sender: TObject);
      procedure sbPesquisarClick(Sender: TObject);
      procedure sbRemoverClick(Sender: TObject);
      procedure sbAlterarClick(Sender: TObject);
      procedure sbSairClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure dbgPesqDrawColumnCell(Sender: TObject; const Rect: TRect;
         DataCol: Integer; Column: TColumn; State: TGridDrawState);
      procedure dbgPesqKeyDown(Sender: TObject; var Key: Word;
         Shift: TShiftState);
      procedure dbgPesqTitleClick(Column: TColumn);
      procedure sbRelatorioClick(Sender: TObject);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure SalvarConfiguraodaGrade1Click(Sender: TObject);
      procedure RestaurarConfiguraodaGrade1Click(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);
      procedure procTelaFilho;
      procedure ExportardadosparaPlanilhaExcel1Click(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
      q_Principal: TIBQuery;
      s_filho: string;
      s_chave: string;
      s_valorChave: string;
      s_Where: string;
      s_Ordem: string;
      slOrdem: TStrings;
      b_somentePesquisa: boolean;
      b_finaliza: boolean;
      procedure procMontaWhere; dynamic;
      procedure procAntesDoDelete; dynamic;
      procedure procHabilitaBotoes; dynamic;
      procedure procRecupera; dynamic;
      procedure procLocate(tipo: TLocate);
      procedure procOrdena(Column: TColumn);
      class function funcAbreTela(pai: TComponent; b_pesquisa: boolean = False;
         b_final: boolean = True): boolean; overload; dynamic;
   end;

var
   pPesqPadrao: TpPesqPadrao;

implementation

uses uCadPadrao, uLib;
{$R *.dfm}

procedure TpPesqPadrao.dbgPesqDrawColumnCell(Sender: TObject; const Rect: TRect;
   DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   procgridZebra(TDBGrid(Sender), Rect, DataCol, Column, State);
end;

procedure TpPesqPadrao.dbgPesqKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   if Key = VK_RETURN then
      self.Close;
end;

procedure TpPesqPadrao.dbgPesqTitleClick(Column: TColumn);
begin
   procOrdena(Column);
end;

procedure TpPesqPadrao.ExportardadosparaPlanilhaExcel1Click(Sender: TObject);
begin
   uLib.procExportarExcel(dbgPesq);
end;

procedure TpPesqPadrao.FormActivate(Sender: TObject);
begin
   procHabilitaBotoes;
end;

procedure TpPesqPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if b_finaliza and q_Principal.Transaction.Active then
      q_Principal.Transaction.Rollback;
end;

procedure TpPesqPadrao.FormCreate(Sender: TObject);
begin
   if not Assigned(q_Principal) then
      q_Principal := TIBQuery(dbgPesq.DataSource.DataSet);

   Assert(Assigned(q_Principal), 'Não encontrada a query principal para a tela '
      + self.Name);

   if not q_Principal.Transaction.Active then
      q_Principal.Transaction.StartTransaction;

   slOrdem := TStringList.Create;
   slOrdem.StrictDelimiter := True;
end;

procedure TpPesqPadrao.FormDestroy(Sender: TObject);
begin
   FreeAndNil(slOrdem);
end;

procedure TpPesqPadrao.procHabilitaBotoes;
begin
   sbAdicionar.Enabled := not b_somentePesquisa;
   sbAlterar.Enabled := not q_Principal.IsEmpty;
   sbRemover.Enabled := (not b_somentePesquisa) and (not q_Principal.IsEmpty);
end;

procedure TpPesqPadrao.procLocate(tipo: TLocate);
begin
   if tipo = tlChave then
      procCampoValorChave(q_Principal, s_chave, s_valorChave)
   else
      q_Principal.Locate(s_chave, s_valorChave, [loCaseInsensitive]);
end;

procedure TpPesqPadrao.FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
begin
   case Key of
      VK_F2:
         sbAdicionar.Click;
      VK_F3:
         sbAlterar.Click;
      VK_F4:
         sbRemover.Click;
      VK_F5:
         sbPesquisar.Click;
      VK_F6:
         sbRelatorio.Click;
      VK_ESCAPE:
         sbSair.Click;
   end;
end;

procedure TpPesqPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   end;
end;

procedure TpPesqPadrao.FormShow(Sender: TObject);
begin
   self.Color := corTela;
   paBotoes.Color := corTela;
   paFiltros.Color := corTela;
   psFiltros.Color := corTela;
   gbFiltro.Color := corTela;

   if FileExists(funcCaminhoConf + self.Name + 'Grid' + '_' + CD_USUARIO_LOGADO)
   then
   begin
      try
         dbgPesq.Columns.LoadFromFile(funcCaminhoConf + self.Name + 'Grid' + '_'
            + CD_USUARIO_LOGADO);
      Except
      end;
   end;
   procRecupera;
end;

{class function TpPesqPadrao.funcAbreTela(pai: TComponent;
   b_pesquisa, b_final: boolean): boolean;
var
   Form: TForm;
begin
   TpPesqPadrao(Form) := self.Create(pai);
   try
      TpPesqPadrao(Form).b_somentePesquisa := b_pesquisa;
      TpPesqPadrao(Form).b_finaliza := b_final;
      TpPesqPadrao(Form).ShowModal;
   finally
      FreeAndNil(Form);
   end;
   result := True;
end;}

class function TpPesqPadrao.funcAbreTela(pai: TComponent;
   b_pesquisa, b_final: boolean): boolean;
begin
   with self.Create(pai) do
   try
      b_somentePesquisa := b_pesquisa;
      b_finaliza := b_final;
      ShowModal;
   finally
      Free;
   end;
   result := True;
end;

procedure TpPesqPadrao.sbAdicionarClick(Sender: TObject);
   procedure procErroAoAdicionar(c_msgErro: string);
   begin
      if b_finaliza and q_Principal.Transaction.Active then
         q_Principal.Transaction.Rollback;
      procMsgErro('Erro ao adicionar registro.' + sLineBreak + sLineBreak +
         'Causa: ' + c_msgErro);
   end;

begin
   if not sbAdicionar.Enabled then
      exit;

   try
      q_Principal.Append;
      procLocate(tlChave);
      procTelaFilho;
   except
      on e: Exception do
         procErroAoAdicionar(e.Message);
   end;
   procRecupera;
   procLocate(tlLocate);
   procHabilitaBotoes;
end;

procedure TpPesqPadrao.procAntesDoDelete;
begin
   // nada
end;

procedure TpPesqPadrao.sbAlterarClick(Sender: TObject);
   procedure procErroAoEditar(c_msgErro: string);
   begin
      if b_finaliza and q_Principal.Transaction.Active then
         q_Principal.Transaction.Rollback;
      procMsgErro('Erro ao editar registro.' + sLineBreak + sLineBreak +
         'Causa: ' + c_msgErro);
   end;

begin
   if not sbAlterar.Enabled then
      exit;

   try
      q_Principal.Edit;
      procLocate(tlChave);
      procTelaFilho;

   except
      on e: Exception do
         procErroAoEditar(e.Message);
   end;
   procRecupera;
   procLocate(tlLocate);
end;

procedure TpPesqPadrao.sbPesquisarClick(Sender: TObject);
begin
   if not sbPesquisar.Enabled then
      exit;
   procRecupera;
end;

procedure TpPesqPadrao.procRecupera;
   procedure procErroAoRecuperar(c_msgErro: string);
   begin
      if b_finaliza and q_Principal.Transaction.Active then
         q_Principal.Transaction.Rollback;
      procMsgErro('Erro ao recuperar informações.' + sLineBreak + sLineBreak +
         'Causa: ' + c_msgErro + sLineBreak + sLineBreak +
         'Feche o Form e tente novamente.');
   end;

begin
   try
      procMontaWhere;
      if s_Ordem <> EmptyStr then
         s_Where := s_Where + ' ORDER BY ' + s_Ordem;

      q_Principal.Close;
      q_Principal.SQL.Text := s_Where;
      q_Principal.Open;

   except
      on e: Exception do
         procErroAoRecuperar(e.Message);
   end;

   procHabilitaBotoes;
end;

procedure TpPesqPadrao.procTelaFilho;
begin
   Assert(Trim(s_filho) <> EmptyStr, 'Não foi informado a classe filha na tela '
      + self.Name);

   with TFormClass(getClass(s_filho)).Create(self) do
   begin
      try
         b_finaliza := Self.b_finaliza;
         ShowModal;
      finally
         Free;
      end;
   end;

   {TFilho := TFormClass(getClass(s_filho)).Create(self);
   TcCadPadrao(TFilho).b_finaliza := b_finaliza;
   try
      TFilho.ShowModal;
   finally
      FreeAndNil(TFilho);
   end; }
end;

procedure TpPesqPadrao.RestaurarConfiguraodaGrade1Click(Sender: TObject);
begin
   try
      DeleteFile(funcCaminhoConf + self.Name + 'Grid' + '_' +
         CD_USUARIO_LOGADO);
   except
   end;
   dbgPesq.Columns.RebuildColumns;
end;

procedure TpPesqPadrao.SalvarConfiguraodaGrade1Click(Sender: TObject);
begin
   dbgPesq.Columns.SaveToFile(funcCaminhoConf + self.Name + 'Grid' + '_' +
      CD_USUARIO_LOGADO);
end;

procedure TpPesqPadrao.procMontaWhere;
begin
   s_Where := EmptyStr;
end;

procedure TpPesqPadrao.procOrdena(Column: TColumn);
var
   s_ord: string;
begin
   s_ord := EmptyStr;

   if slOrdem.IndexOf(Column.FieldName + ' ASC') >= 0 then
      slOrdem.Delete(slOrdem.IndexOf(Column.FieldName + ' ASC'));

   if slOrdem.IndexOf(Column.FieldName + ' DESC') >= 0 then
      slOrdem.Delete(slOrdem.IndexOf(Column.FieldName + ' DESC'));

   if Column.Title.Font.Style = [] then
   begin
      Column.Title.Font.Style := [fsBold];
      s_ord := Column.FieldName + ' ASC'
   end
   else if Column.Title.Font.Style = [fsBold] then
   begin
      Column.Title.Font.Style := [fsBold, fsUnderline];
      s_ord := Column.FieldName + ' DESC'
   end
   else if Column.Title.Font.Style = [fsBold, fsUnderline] then
      Column.Title.Font.Style := [];

   if Trim(s_ord) <> EmptyStr then
      slOrdem.Add(s_ord);

   procLocate(tlChave);
   s_Ordem := slOrdem.CommaText;
   procRecupera;
   procLocate(tlLocate);

end;

procedure TpPesqPadrao.sbRelatorioClick(Sender: TObject);
begin
   if not sbRelatorio.Enabled then
      exit;
end;

procedure TpPesqPadrao.sbRemoverClick(Sender: TObject);
   procedure procErroAoDeletar(c_msgErro: string);
   begin
      if b_finaliza and q_Principal.Transaction.Active then
         q_Principal.Transaction.Rollback;
      procMsgErro('Não foi possível excluir o registro.' + sLineBreak +
         sLineBreak + 'Causa: ' + c_msgErro);
   end;

begin
   if not sbRemover.Enabled then
      exit;

   if funcMsgConfirma('Deseja Realmente Excluir?') then
   begin
      try
         procAntesDoDelete;
         q_Principal.Delete;
         if b_finaliza and q_Principal.Transaction.Active then
            q_Principal.Transaction.Commit;
      except
         on e: EDatabaseError do
         begin
            if (pos('lock', e.Message) > 0) then
               procErroAoDeletar
                  ('Registro atual está sendo editado por outro usuário.')
            else if (pos('FOREIGN', e.Message) > 0) then
               procErroAoDeletar('Registro possui relacionamentos.')
            else
               procErroAoDeletar(e.Message);
         end;

         on e: Exception do
            procErroAoDeletar(e.Message);
      end;
   end;
   procRecupera;
   procHabilitaBotoes;
end;

procedure TpPesqPadrao.sbSairClick(Sender: TObject);
begin
   self.Close;
end;

end.
