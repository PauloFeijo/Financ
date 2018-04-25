unit ufrmPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, Buttons, JvExMask, JvToolEdit, JvMaskEdit,
  JvCheckedMaskEdit, JvDatePickerEdit;

type
  TfrmPeriodo = class(TFrame)
    Label1: TLabel;
    Label2: TLabel;
    meDtIni: TJvDatePickerEdit;
    meDtFin: TJvDatePickerEdit;
    procedure meDtIniExit(Sender: TObject);
    procedure meDtFinExit(Sender: TObject);
  private
    { Private declarations }
    function getDtIniSql : string;
    function getDtFinSql : string;
    function getDtHrIniSql : string;
    function getDtHrFinSql : string;
    procedure setDtIni(d_ini : TDateTime);
    procedure setDtFin(d_fin : TDateTime);
    function getDtIni : TDateTime;
    function getDtFin : TDateTime;
  public
    { Public declarations }
    property dtIniSql : string read getDtIniSql;
    property dtFinSql : string read getDtFinSql;
    property dtHrIniSql : string read getDtHrIniSql;
    property dtHrFinSql : string read getDtHrFinSql;
    property dtIni : TDateTime read getDtIni write setDtIni;
    property dtFin : TDateTime read getDtFin write setDtFin;
  end;

implementation

uses uLib;

{$R *.dfm}

{ TfrmPeriodo }

function TfrmPeriodo.getDtFin: TDateTime;
begin
  Result := meDtFin.Date;
end;

function TfrmPeriodo.getDtFinSql: string;
begin
  Result := QuotedStr(FormatDateTime('DD.MM.YYYY',meDtFin.Date));
end;

function TfrmPeriodo.getDtHrFinSql: string;
begin
  Result:= QuotedStr(FormatDateTime('DD.MM.YYYY',meDtFin.Date)+' 00:00:00');
end;

function TfrmPeriodo.getDtHrIniSql: string;
begin
  Result:= QuotedStr(FormatDateTime('DD.MM.YYYY',meDtIni.Date)+' 00:00:00');
end;

function TfrmPeriodo.getDtIni: TDateTime;
begin
  Result := meDtIni.Date;
end;

function TfrmPeriodo.getDtIniSql: string;
begin
  Result := QuotedStr(FormatDateTime('DD.MM.YYYY',meDtIni.Date));
end;


procedure TfrmPeriodo.meDtFinExit(Sender: TObject);
begin
  if (meDtIni.Date <> 0) and
     (meDtFin.Date <> 0) and
     (meDtIni.Date > meDtFin.Date) then
  begin
    procMsgErro('Data final não pode ser menor que inicial');
    meDtFin.SetFocus;
  end;
end;

procedure TfrmPeriodo.meDtIniExit(Sender: TObject);
begin
  if (meDtIni.Date <> 0) and
     (meDtFin.Date <> 0) and
     (meDtIni.Date > meDtFin.Date) then
  begin
    procMsgErro('Data inicial não pode ser maior que final');
    meDtIni.SetFocus;
  end;
end;
procedure TfrmPeriodo.setDtFin(d_fin: TDateTime);
begin
  meDtFin.Date := d_fin;
end;

procedure TfrmPeriodo.setDtIni(d_ini: TDateTime);
begin
  meDtIni.Date := d_ini;
end;

end.
