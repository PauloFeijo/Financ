program Financ;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {Principal},
  uLogin in 'uLogin.pas' {login},
  udmFinanc in 'udmFinanc.pas' {dmFinanc: TDataModule},
  ucUsuario in 'ucUsuario.pas' {cUsuario},
  upConta in 'upConta.pas' {pConta},
  ucConta in 'ucConta.pas' {cConta},
  uConst in 'uConst.pas',
  upMovFin in 'upMovFin.pas' {pMovFin},
  ucMovFin in 'ucMovFin.pas' {cMovFin},
  upCateg in 'upCateg.pas' {pCateg},
  ucCateg in 'ucCateg.pas' {cCateg},
  upTransf in 'upTransf.pas' {pTransf},
  ucTransf in 'ucTransf.pas' {cTransf},
  udmRelatorio in 'udmRelatorio.pas' {dmRelatorio: TDataModule},
  urAnalise in 'urAnalise.pas' {rAnalise},
  uSplash in 'uSplash.pas' {Splash},
  upPagRec in 'upPagRec.pas' {pPagRec},
  ucPagRec in 'ucPagRec.pas' {cPagRec},
  Vcl.Themes,
  Vcl.Styles,
  urAnual in 'urAnual.pas' {rAnual},
  ucCCusto in 'ucCCusto.pas' {cCCusto},
  upCCusto in 'upCCusto.pas' {pCCusto},
  upPlano in 'upPlano.pas' {pPlano},
  ufrmCateg in 'ufrmCateg.pas' {frmCateg: TFrame},
  ufrmCCusto in 'ufrmCCusto.pas' {frmCCusto: TFrame},
  ufrmConta in 'ufrmConta.pas' {frmConta: TFrame},
  ufrmPeriodo in 'ufrmPeriodo.pas' {frmPeriodo: TFrame},
  ucPlano in 'ucPlano.pas' {cPlano},
  urPlano in 'urPlano.pas' {rPlano},
  uPesqPadrao in 'uPesqPadrao.pas' {pPesqPadrao},
  uCadPadrao in 'uCadPadrao.pas' {cCadPadrao},
  ULib in 'ULib.pas',
  upBens in 'upBens.pas' {pBens},
  ucBens in 'ucBens.pas' {cBens};

{$R *.res}

begin
  Application.Initialize;
  Splash := TSplash.Create(Application);
  Splash.max := 4;
  Splash.Show;
  Splash.Update;

  Application.Title := 'Financ - Sistema Financeito Pessoal';

  Application.CreateForm(TdmFinanc, dmFinanc);
  Application.CreateForm(TdmRelatorio, dmRelatorio);
  Splash.progresso := Splash.progresso +1;

  Application.CreateForm(TdmRelatorio, dmRelatorio);
  Splash.progresso := Splash.progresso +1;

  Application.CreateForm(TPrincipal, Principal);
  Splash.progresso := Splash.progresso +1;

  Application.Run;
end.
