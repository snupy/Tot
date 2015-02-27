unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzListVw, RzTreeVw, RzPanel, StdCtrls, RzLabel,
  ExtCtrls, UnitDocumentsController, UnitDocuments, EZTwain, ActnList,
  XPStyleActnCtrls, ActnMan, RzButton, RzRadChk, RzCmboBx, RzEdit, Mask, Printers,
  JPEG;

type
  TDocumentsListViewer= class;
  TMainForm = class(TForm)
    RzLabel1: TRzLabel;
    edDocNumber: TRzEdit;
    RzLabel2: TRzLabel;
    edDocDate: TRzDateTimeEdit;
    RzLabel3: TRzLabel;
    cbDocType: TRzComboBox;
    RzCheckBox1: TRzCheckBox;
    RzBitBtn1: TRzBitBtn;
    ActionManager1: TActionManager;
    acScanImage: TAction;
    acScannigPreview: TAction;
    RzBitBtn2: TRzBitBtn;
    acChangeScan: TAction;
    acPrinterSetup: TAction;
    RzBitBtn3: TRzBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    acAutoPrintScan: TAction;
    RzCheckBox2: TRzCheckBox;
    RzCheckBox3: TRzCheckBox;
    acDobleNumbersTest: TAction;
    procedure acScanImageExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acScannigPreviewExecute(Sender: TObject);
    procedure edDocNumberChange(Sender: TObject);
    procedure acChangeScanExecute(Sender: TObject);
    procedure acPrinterSetupExecute(Sender: TObject);
    procedure acAutoPrintScanExecute(Sender: TObject);
    procedure acDobleNumbersTestExecute(Sender: TObject);
  private
    DocumentsListViewer: tDocumentsListViewer;
    LastScanDocNumber: String;
    LastScanDocDate: TDateTime;
    function getSaveFileName(dirName: String): String;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDocumentsListViewer= class(TInterfacedObject, IDocumentsListActions)
  private
    procedure AddDocumentAction(aDocument: TObject);
    procedure DeleteDocumentAction(aDocument: TObject);
    procedure UpdateDocumentAction(aDocument: TObject);
    procedure RefreshAction();
  public
    function isSender(sendObject: TObject): Boolean;
    constructor Create();
  end;
var
  MainForm: TMainForm;

implementation

uses Math, UnitImageShow;

{$R *.dfm}

{ TDocumentsListViewer }



{ TDocumentsListViewer }

procedure TDocumentsListViewer.AddDocumentAction(aDocument: TObject);
begin
  MainForm.Caption := '112';
end;

constructor TDocumentsListViewer.Create;
begin
  inherited Create;
   mainDocumentsListController.ViewList := Self;
end;

procedure TDocumentsListViewer.DeleteDocumentAction(aDocument: TObject);
begin

end;

function TDocumentsListViewer.isSender(sendObject: TObject): Boolean;
begin
  Result := sendObject = Self;
end;

procedure TDocumentsListViewer.RefreshAction;
begin
  
end;

procedure TDocumentsListViewer.UpdateDocumentAction(aDocument: TObject);
begin

end;

{ TMainForm }

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  DocumentsListViewer := TDocumentsListViewer.Create;
end;

procedure TMainForm.acScanImageExecute(Sender: TObject);
var
  dat: hBitMap;
  PInfo: PBitMapInfoHeader;
  Height,Width:integer;
  MyBitMap: TBitmap;
  SaveJpeg: TJpegImage;
  f: TextFile;
  fileName: String;
  function stp2(s:byte):longint;
  begin
   stp2:=1 shl (s);
  end;

begin
  if (acDobleNumbersTest.Checked) and
    (LastScanDocDate = edDocDate.Date) and (LastScanDocNumber = edDocNumber.Text) and
    (MessageDlg('Вы не поменяли ни номер, ни дату с прошлого сканирования! Вы сейчас сканируете последующие листы документа?',
    mtConfirmation, mbYesNoCancel, 0) <> mrYes) then
  begin
    // значит забыли понять номер или дату документа
    exit;
  end;

  {устанавливаем устройтсво}
  TWAIN_OpenDefaultSource();

  {ставим дефолтовые разшение в 200 dpi. 0 - означает дюйм}
  TWAIN_SetCurrentUnits(0);
  TWAIN_SetCurrentResolution(200);

  {скрываем пользовательский интерфейс}
  TWAIN_SetHideUI(1);
  {Получаем указатель на графические данные}
  dat:=TWAIN_AcquireNative(Handle,0);
  if dat <> 0 then
  begin
    MyBitMap := TBitmap.Create;
    try
      try
        {Получаем указатель на область памяти содержащей DIB
         данные и блокируем область памяти}
        PInfo:=GlobalLock(dat);
        {Анализируем полученные данные}
        Height:=PInfo.biHeight ;
        Width:=PInfo.biWidth ;

        {Узнаем размер полученного изображения в сантиметрах}
        (*  Wcm.Caption :=floatToStrF(100/PInfo.biXPelsPerMeter*Width,ffNumber,8,3)+' cm';
        Hcm.Caption :=floatToStrF(100/PInfo.biYPelsPerMeter*Height,ffNumber,8,3)+' cm';
        {Определяем число цветов в изображении}
        Colors.Caption := floatToStrF(stp2(PInfo.biBitCount),ffNumber,8,0)+ ' цветов';*)

        {Разблокируем память}
        GlobalUnlock(dat);

        {Передаем в битовую матрицу графические данные}
        {И устанавливаем перехват ошибок}
        try
         MyBitMap.Palette :=TWAIN_CreateDibPalette(dat);
         MyBitMap.Width := Width;
         MyBitMap.Height := Height;
         TWAIN_DrawDibToDC(MyBitMap.Canvas.Handle,0,0,Width,Height,dat,0,0);
        except
         {Обрабатываем наиболее вероятную ошибку связанную с не хваткой ресурсов
            для загрузки изображения}
         on EOutOFResources do
                             MessageDlg('TBitMap: Нет ресурсов для загрузки изображения!',
                                         mtError,[mbOk],0);  (**)
        end;
      finally
        TWAIN_FreeNative(dat);
      end;

      if acScannigPreview.Checked then
      begin
        FormImageShow.showPicture(MyBitMap);
      end;

      if acAutoPrintScan.Checked then
      begin
        with printer do
        begin
          BeginDoc;
          try
            Printer.Canvas.StretchDraw(Canvas.ClipRect,MyBitMap);
            EndDoc;
          except
            Abort;
          end;
        end;
      end;
      SaveJpeg := TjpegImage.Create;
      try
        SaveJpeg.Assign(MyBitMap);
        SaveJpeg.CompressionQuality := 100; // От этого значения тоже зависит вес, но и качество
        SaveJpeg.PixelFormat := jf24Bit;
        SaveJpeg.Compress;
        fileName := getSaveFileName( ExtractFilePath(Application.ExeName)+'\'+cbDocType.Values[cbDocType.ItemIndex]);
        SaveJpeg.SaveToFile(fileName);
        LastScanDocNumber := edDocNumber.Text;
        LastScanDocDate := edDocDate.Date;

        AssignFile(f, ExtractFilePath(Application.ExeName)+'data\data.txt');
        try
          Append(f);
          Writeln(f,'NewData');
          Writeln(f,DateToStr(LastScanDocDate));
          Writeln(f,LastScanDocNumber);
          Writeln(f,fileName);
        finally
          CloseFile(f);
        end;

      finally
        SaveJpeg.Free;
      end;
    finally
      MyBitMap.Free;
    end;
  end;
end;

function TMainForm.getSaveFileName(dirName: String): String;
var
  fs : TFormatSettings;
  i: Integer;
  docNumber: String;
begin
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, fs);
  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  docNumber := edDocNumber.EditText;
  for i:=1 to length(docNumber) do
  begin
    if pos(docNumber[i],'\/:*?"<>|')>0 then docNumber[i]:=' ';
  end;
  Result := dirName;
  Result := Result + '\' + DateTimeToStr(edDocDate.Date, fs);
  Result := Result + '_' + docNumber;
  i := 1;
  while(FileExists(Result + '_' + IntToStr(i) +'.jpg')) do
  begin
    inc(i);
  end;
  Result := Result + '_' + IntToStr(i) +'.jpg';
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  sr: TSearchRec;
  FileAttrs: Integer;
begin
  FileAttrs := faDirectory;

  if FindFirst(ExtractFilePath(Application.ExeName) + '\data\*', FileAttrs, sr) = 0 then
  begin
    repeat
      If not((sr.Attr and FileAttrs) = FileAttrs) or (sr.Name = '') or (sr.Name = '.') or (sr.Name = '..') then
        continue;
      cbDocType.AddItemValue(sr.Name, 'Data\'+sr.Name);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;

  edDocDate.Date := Now;
  cbDocType.ItemIndex := 0;
end;

procedure TMainForm.acScannigPreviewExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.edDocNumberChange(Sender: TObject);
begin
  acScanImage.Enabled := TEdit(Sender).Text <>'';
end;

procedure TMainForm.acChangeScanExecute(Sender: TObject);
begin
  TWAIN_SelectImageSource(Handle);
end;

procedure TMainForm.acPrinterSetupExecute(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TMainForm.acAutoPrintScanExecute(Sender: TObject);
begin
  //
end;

procedure TMainForm.acDobleNumbersTestExecute(Sender: TObject);
begin
//
end;

end.
