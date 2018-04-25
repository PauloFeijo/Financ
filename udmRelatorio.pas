unit udmRelatorio;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, frxIBXComponents, frxChart,
  uLib, frxChBox, udmFinanc, DB, DBClient, VCLTee.TeEngine,
  VCLTee.DBChart, VCLTee.TeeDBCrossTab, frxCross, fs_ichartrtti, frxExportText,
  frxExportCSV,  frxExportPDF, VCLTee.TeeData, VCLTee.TeeGDIPlus,
  fs_ibasic, fs_ijs, fs_icpp, fs_ipascal, fs_iinterpreter,
  frxExportImage, frxExportHTML, frxRich, frxExportXLSX, frxExportDOCX;

type
  TdmRelatorio = class(TDataModule)
    DB: TfrxIBXComponents;
    fcdsAnalise: TfrxDBDataset;
    frxMovimento: TfrxDBDataset;
    frxPagarReceber: TfrxDBDataset;
    fcdsAnual: TfrxDBDataset;
    Relatorio: TfrxReport;
    frxDOCXExport1: TfrxDOCXExport;
    frxPDFExport1: TfrxPDFExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxXLSXExport1: TfrxXLSXExport;
    frxChartObject1: TfrxChartObject;
    frxRichObject1: TfrxRichObject;
    frxCrossObject1: TfrxCrossObject;
  private
    { Private declarations }
  public
    { Public declarations }
    function  b_funcMostraRelatorio(s_relatorio : string) : boolean;
    function b_funcCarregaRelatorio(s_relatorio : string) : boolean;
    procedure procAtribuirSelect(s_query,s_sql : string);
  end;

var
  dmRelatorio: TdmRelatorio;

implementation

{$R *.dfm}

{ TdmRelatorio }

function TdmRelatorio.b_funcCarregaRelatorio(s_relatorio: string): boolean;
begin
  Result := False;
  if not (FileExists(funcCaminhoRel+s_relatorio))then
  begin
    procMsgErro('Relatorio "'+s_relatorio+'" não encontrado. Verifique.');
    Exit;
  end;
  if not dmRelatorio.Relatorio.LoadFromFile(funcCaminhoRel+s_relatorio) then
    dmRelatorio.Relatorio.LoadFromFile(funcCaminhoRel+s_relatorio);
  Result := True;
end;

function TdmRelatorio.b_funcMostraRelatorio(s_relatorio: string): boolean;
begin
  Result := False;
  if not b_funcCarregaRelatorio(s_relatorio) then
    exit;

  dmRelatorio.Relatorio.ShowReport();
  Result := True;
end;

procedure TdmRelatorio.procAtribuirSelect(s_query, s_sql: string);
begin
  TfrxIbxQuery(dmRelatorio.Relatorio.FindComponent(s_query)).SQL.Text := s_sql;
end;

end.
