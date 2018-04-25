unit ucBens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadPadrao, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, JvMaskEdit, JvCheckedMaskEdit,
  JvDatePickerEdit, JvDBDatePickerEdit, JvExMask, JvToolEdit, JvBaseEdits,
  JvDBControls;

type
  TcBens = class(TcCadPadrao)
    Label1: TLabel;
    DBE_ID_BEM: TDBEdit;
    Label2: TLabel;
    DBE_DS_BEM: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBE_VL_AQUISICAO: TJvDBCalcEdit;
    DBE_VL_ATUAL: TJvDBCalcEdit;
    DBE_DT_AQUISICAO: TJvDBDatePickerEdit;
    DBE_DT_VENDA: TJvDBDatePickerEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cBens: TcBens;

implementation

{$R *.dfm}

uses udmFinanc, ULib;

procedure TcBens.FormShow(Sender: TObject);
begin
  inherited;
  procDesabilitaCampos(DBE_ID_BEM);
end;

initialization
RegisterClass(TcBens);

finalization
UnRegisterClass(TcBens);

end.
