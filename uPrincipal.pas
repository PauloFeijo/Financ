unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, Menus, StdCtrls, ExtCtrls, Mask,
  ActnList, ActnCtrls, Ribbon, ToolWin, ActnMan, ActnMenus, RibbonActnMenus,
  RibbonLunaStyleActnCtrls, pngimage, Buttons, DB, DBGrids, DBClient, frxClass,
  TeCanvas, IdBaseComponent, IdNetworkCalculator, RibbonObsidianStyleActnCtrls,
  RibbonSilverStyleActnCtrls, uLib, uLogin, upConta, upMovFin, upCateg,
  upTransf, urAnalise, uSplash, upPagRec, ucUsuario, System.Actions,
  JvExExtCtrls, JvExtComponent, JvClock;

type
  TPrincipal = class(TForm)
    paStatus: TPanel;
    lbStatus: TLabel;
    acMan: TActionManager;
    pnGeral: TPanel;
    Ribbon1: TRibbon;
    rbCadastros: TRibbonPage;
    Label2: TLabel;
    rgCadastros: TRibbonGroup;
    SpeedButton1: TSpeedButton;
    sbMovimentos: TSpeedButton;
    sbCategoria: TSpeedButton;
    sbContas: TSpeedButton;
    sbTransferencia: TSpeedButton;
    rbRelatorios: TRibbonPage;
    rgRelatorios: TRibbonGroup;
    sbRelAnalise: TSpeedButton;
    Image1: TImage;
    sbPagReceb: TSpeedButton;
    rbConfiguracoes: TRibbonPage;
    acUsuario: TAction;
    acTrocaUsuario: TAction;
    acSair: TAction;
    rgConfiguracoes: TRibbonGroup;
    sbRelAnaliseAnual: TSpeedButton;
    sbCCusto: TSpeedButton;
    sbPlano: TSpeedButton;
    sbRelPlano: TSpeedButton;
    sbBens: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure Action12Execute(Sender: TObject);
    procedure sbMovimentosClick(Sender: TObject);
    procedure sbContasClick(Sender: TObject);
    procedure sbCategoriaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbTransferenciaClick(Sender: TObject);
    procedure sbRelAnaliseClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sbPagRecebClick(Sender: TObject);
    procedure acUsuarioExecute(Sender: TObject);
    procedure acTrocaUsuarioExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure sbRelAnaliseAnualClick(Sender: TObject);
    procedure sbCCustoClick(Sender: TObject);
    procedure sbPlanoClick(Sender: TObject);
    procedure sbRelPlanoClick(Sender: TObject);
    procedure sbBensClick(Sender: TObject);
  private
    { Private declarations }
    procedure procAbreLogin;
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation


{$R *.dfm}

uses urAnual, upCCusto, upPlano, urPlano, upBens;

procedure TPrincipal.acSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TPrincipal.Action12Execute(Sender: TObject);
begin
  procAbreLogin;
end;

procedure TPrincipal.sbPagRecebClick(Sender: TObject);
begin
  TpPagRec.funcAbreTela(Self);
end;

procedure TPrincipal.sbPlanoClick(Sender: TObject);
begin
  TpPlano.funcAbreTela(Self);
end;

procedure TPrincipal.acTrocaUsuarioExecute(Sender: TObject);
begin
  TLogin.procAbreTela(Self);
  lbStatus.Caption:= 'Usuário: '+CD_USUARIO_LOGADO+'  Data: '+DateToStr(funcHoje)+'  ';
end;

procedure TPrincipal.acUsuarioExecute(Sender: TObject);
begin
  TcUsuario.procAbreTela(False);

  if CD_USUARIO_LOGADO = EmptyStr then
    Close;
end;

procedure TPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift) or (ssCtrl in Shift) or (ssShift in Shift) then
    Exit;

  if Ribbon1.ActivePage = rbCadastros then
  begin
    case Key of
      VK_F2:sbCategoria.Click;
      VK_F3:sbCCusto.Click;
      VK_F4:sbMovimentos.Click;
      VK_F5:sbContas.Click;
      VK_F6:sbTransferencia.Click;
      VK_F7:sbPagReceb.Click;
      VK_F8:sbPlano.Click;
      VK_F9:sbBens.Click;
    end;
  end
  else if Ribbon1.ActivePage = rbRelatorios then
  begin
    case Key of
      VK_F2:sbRelAnalise.Click;
      VK_F3:sbRelAnaliseAnual.Click;
      VK_F4:sbRelPlano.Click;
      //VK_F5:sbTransferencia.Click;
    end;
  end
  else if Ribbon1.ActivePage = rbConfiguracoes then
  begin
    case Key of
      VK_F2:acUsuario.Execute;
      VK_F3:acTrocaUsuario.Execute;
      //VK_F4:sbContas.Click;
      //VK_F5:sbTransferencia.Click;
    end;
  end;

end;

procedure TPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if AnsiUpperCase(Key) = 'C' then
    Ribbon1.ActivePage := rbCadastros

  else if AnsiUpperCase(Key) = 'R' then
     Ribbon1.ActivePage := rbRelatorios

  else if AnsiUpperCase(Key) = 'N' then
     Ribbon1.ActivePage := rbConfiguracoes;
end;

procedure TPrincipal.FormShow(Sender: TObject);
begin
  procabreLogin;
  Splash.Close;
  FreeAndNil(Splash);
  TpPagRec.funcAbreTela(Self,False,True,True);
end;

procedure TPrincipal.procAbreLogin;
begin
  Tlogin.procAbreTela(Self);
  if CD_USUARIO_LOGADO = EmptyStr then
    Close;

  lbStatus.Caption:= 'Usuário: '+CD_USUARIO_LOGADO+'  Data: '+DateToStr(funcHoje)+'  ';
end;


procedure TPrincipal.sbBensClick(Sender: TObject);
begin
  TpBens.funcAbreTela(Self);
end;

procedure TPrincipal.sbCategoriaClick(Sender: TObject);
begin
  Tpcateg.funcAbreTela(Self);
end;

procedure TPrincipal.sbCCustoClick(Sender: TObject);
begin
  TPCCusto.funcAbreTela(Self);
end;

procedure TPrincipal.sbContasClick(Sender: TObject);
begin
  TpConta.funcAbreTela(Self);
end;

procedure TPrincipal.sbMovimentosClick(Sender: TObject);
begin
  TpMovFin.funcAbreTela(Self);
end;

procedure TPrincipal.sbRelAnaliseClick(Sender: TObject);
begin
  TrAnalise.b_funcAbreTela(Self);
end;

procedure TPrincipal.sbRelPlanoClick(Sender: TObject);
begin
   TrPlano.b_funcAbreTela(Self);
end;

procedure TPrincipal.sbRelAnaliseAnualClick(Sender: TObject);
begin
  TrAnual.b_funcAbreTela(Self);
end;

procedure TPrincipal.sbTransferenciaClick(Sender: TObject);
begin
  TpTransf.funcAbreTela(Self);
end;

end.
