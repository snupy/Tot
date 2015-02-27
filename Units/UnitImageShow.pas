unit UnitImageShow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TFormImageShow = class(TForm)
    Image1: TImage;
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
  private
    { Private declarations }
  public
    imProportion: Double; // width / height
    function showPicture(bmp: TBitmap): Integer;
  end;

var
  FormImageShow: TFormImageShow;

implementation

{$R *.dfm}

procedure TFormImageShow.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var
  aNewWidth, aNewHeight: Integer;
begin
  aNewWidth := trunc(NewHeight * imProportion);
  aNewHeight := trunc(NewWidth / imProportion);
  if abs(aNewWidth- NewWidth)>abs(aNewHeight- NewHeight) then
    NewHeight := aNewHeight else
  NewWidth := aNewWidth;
end;

function TFormImageShow.showPicture(bmp: TBitmap): Integer;
begin
  Image1.Picture.Graphic := bmp;
  imProportion := bmp.Width / bmp.Height;
  Self.ShowModal;
end;

end.
