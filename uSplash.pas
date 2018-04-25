unit uSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, GIFImg, jpeg, Gauges, ComCtrls;

type
  TSplash = class(TForm)
    Image1: TImage;
    barraProgresso: TProgressBar;
  private
    procedure setProgresso(const Value: integer);
    procedure setMax(const Value: integer);
    function getProgresso: integer;
    { Private declarations }
  public
    { Public declarations }
    property progresso : integer read getProgresso write setProgresso ;
    property max : integer write setMax;
  end;

var
  Splash: TSplash;

implementation

{$R *.dfm}

{ TSplash }


{ TSplash }

function TSplash.getProgresso: integer;
begin
  Result := barraProgresso.Position;
end;

procedure TSplash.setMax(const Value: integer);
begin
  barraProgresso.Max := Value;
end;

procedure TSplash.setProgresso(const Value: integer);
begin
  barraProgresso.Position := Value;
end;

end.
