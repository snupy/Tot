unit UnitDocuments;

interface

uses UnitFilesTools, Contnrs, Windows, SysUtils, Math, UnitDocumentsController;

type
  TDocument =class; TDocumentsList = class; TDocumentsListDataSource=class;

  IDocumentsList = interface
    function getDocument(index: integer): TDocument;
    procedure setDocument(index: integer; const Value: TDocument);
    function getDocumentCount: integer;
    procedure DocumentDelete(Document: TDocument);
    function DocumentIndex(Document: TDocument): Integer;
    function DeleteAllDocuments: HRESULT;
    function AddDocument(aDate: TDateTime; aNumber: String): TDocument; overload;
    function AddDocument(aDate: TDateTime; aNumber: String; var index: integer): TDocument; overload;
    property Document[index: integer]: TDocument read getDocument write setDocument;
    property DocumentCount: integer read getDocumentCount;
  end;

  TDocumentData = class
  private
    fDocument: TDocument;
    function getName: String;
    procedure setName(const Value: String);
    function getDocument: TDocument;
  protected

  public
    property name: String read getName write setName;
    property document: TDocument read getDocument;
    constructor Create(aDocument: tDocument);
  published

  end;

  TDocumentScan = class (TDocumentData)
  private
    fScanFiles: TObjectList;
    function getScanFilesList: TObjectList;
  public
    property scanFilesList:TObjectList read getScanFilesList;
    constructor Create;
  end;


  TDocumentFile = class(TDocumentScan)
  private
    aFile: TFile;
    function getFileFullName: string;
  public
    property fileFullName: string read getFileFullName;
    constructor Create;
  published

  end;

  TDocumentsList = class(TInterfacedObject, IDocumentsList,
    IDocumentsListActions)
  private
    fName: String;
    fDocuments: TObjectList;
    fDataSource: TDocumentsListDataSource;
    fDocumentsListEvents: IDocumentsListEvents;
    function getName: String;
    procedure setName(const Value: String);
    function getDocument(index: integer): TDocument;
    procedure setDocument(index: integer; const Value: TDocument);
    function getDocumentCount: integer;
    function getDataSource: TDocumentsListDataSource;
    procedure setDataSource(const Value: TDocumentsListDataSource);
    procedure AddDocumentAction(aDocument: TObject);
    procedure DeleteDocumentAction(aDocument: TObject);
    procedure UpdateDocumentAction(aDocument: TObject);
    procedure RefreshAction();
    function getDocumentsListEvents: IDocumentsListEvents;
    procedure setDocumentsListEvents(const Value: IDocumentsListEvents);
  protected

  public
    procedure DocumentDelete(Document: TDocument);
    function DocumentIndex(Document: TDocument): Integer;
    function DeleteAllDocuments: HRESULT;
    function AddDocument(aDate: TDateTime; aNumber: String): TDocument; overload;
    function AddDocument(aDate: TDateTime; aNumber: String; var index: integer): TDocument; overload;
    property Name: String read getName write setName;
    property Document[index: integer]: TDocument read getDocument write setDocument;
    property DocumentCount: integer read getDocumentCount;
    property DataSource: TDocumentsListDataSource read getDataSource write setDataSource;
    property DocumentsListEvents: IDocumentsListEvents read getDocumentsListEvents write setDocumentsListEvents;  
    constructor Create;
    destructor Destroy;
    function isSender(sendObject: TObject): Boolean;
  end;

  TDocumentsListDataSource = class
  private
    fDocumentsLists: TObjectList;
    function getDocumentsLists: TObjectList;
  protected

  public
    property DocumentsLists: TObjectList read getDocumentsLists;
    procedure Update; virtual; abstract;
    procedure Refresh; virtual; abstract;
    constructor Create;
    destructor Destroy;
  published

  end;

  TDocumentsListDataSourceFileSystem = class(TDocumentsListDataSource)
  private
    fDirectory: TDirectory;
    function getDirectory: TDirectory;
    procedure setDirectory(const Value: TDirectory);
  protected

  public
    function ParseDocumentData(fileName: String; var aDate: TDateTime; var aNumber: String): HRESULT;
    procedure ParseDirectory;
    procedure AddDocumentsForAllDocumnetsList(aDate: TDateTime; aNumber: String);
    procedure EraseDocumentsFromAllDocumnetsList;
    procedure Update;  override;
    procedure Refresh;  override;
    procedure ReParseDirectory;
    property Directory: TDirectory read getDirectory write setDirectory;
    constructor Create;
  published

  end;

  TDocument = class
  private
    fDocumentDatas: TObjectList;      //вот здесь ошибка нужно сохарнить множественность, т.е. нужен объект ObjectsList
    fDocumentsList: TDocumentsList;
    fNumder: String;
    fDate: TDateTime;
    function getDate: TDateTime;
    function getDocumentDatas: TObjectList;
    function getDocumentsList: TDocumentsList;
    function getNumber: String;
    procedure setDate(const Value: TDateTime);
    procedure setDocumentsList(const Value: TDocumentsList);
    procedure setNumber(const Value: String);
    function getDocumentData: TDocumentData;
    procedure setDocumentData(const Value: TDocumentData);
  protected
    property DocumentDatas: TObjectList read getDocumentDatas;
    property DocumentsList: TDocumentsList read getDocumentsList write setDocumentsList;
    property Numder: String read getNumber write setNumber;
    property Date: TDateTime read getDate write setDate;
  public
    constructor Create; overload;
    constructor Create(aDate: TDateTime; aNumber: String); overload;
  published

  end;


var

 mainDocumentsList: TDocumentsList;


implementation

uses Classes;

function IsMaskedConsignationNote(FileName: String): Boolean;
var
  s: String;
  i: integer;
  log: Boolean;
begin
  s := ExtractFileName(FileName);
  result := ExtractFileExt(s)='.jpg';
  if not Result then
    exit;
  for i:=1 to 8 do
  begin
    if not (s[i] in ['0'..'9']) then
    begin
      Result := false;
      exit;
    end;
  end;
  result := result and (s[9]='_');
end;


{ TDocumentFile }

constructor TDocumentFile.Create;
begin
  inherited;

end;

function TDocumentFile.getFileFullName: string;
begin
  Result := aFile.FileFullName;
end;

{ TDocumentsData }

constructor TDocumentData.Create(aDocument: tDocument);
begin
  fDocument := aDocument;
end;

function TDocumentData.getDocument: TDocument;
begin
  Result := fDocument;
end;


function TDocumentData.getName: String;
begin

end;


procedure TDocumentData.setName(const Value: String);
begin

end;



{ TDocument }

constructor TDocument.Create;
begin

end;

constructor TDocument.Create(aDate: TDateTime; aNumber: String);
begin
  Create();
  Date := aDate;
  Numder := aNumber;
end;

function TDocument.getDate: TDateTime;
begin

end;

function TDocument.getDocumentData: TDocumentData;
begin

end;

function TDocument.getDocumentDatas: TObjectList;
begin
  // значит объект документа еще не создан и мы его создадим
  if Assigned(fDocumentDatas) then
    fDocumentDatas := TObjectList.Create(True);

  result := fDocumentDatas;
end;

function TDocument.getDocumentsList: TDocumentsList;
begin

end;

function TDocument.getNumber: String;
begin

end;

procedure TDocument.setDate(const Value: TDateTime);
begin

end;

procedure TDocument.setDocumentData(const Value: TDocumentData);
begin

end;

procedure TDocument.setDocumentsList(const Value: TDocumentsList);
begin
  if Value <> fDocumentsList then
  begin
    fDocumentsList.DocumentDelete(self);
    fDocumentsList := Value;
  end;
end;

procedure TDocument.setNumber(const Value: String);
begin
  fNumder := Value;
end;

{ TDocumentsList }

constructor TDocumentsList.Create;
begin
  fDocuments :=  TObjectList.Create(true);
end;

procedure TDocumentsList.DocumentDelete(Document: TDocument);
begin
  fDocuments.Delete(DocumentIndex(Document));
end;

function TDocumentsList.getDocument(index: integer): TDocument;
var
  doc: TObject;
begin
  doc := fDocuments.Items[index];
  if doc is TDocument then
    result:= fDocuments.Items[index] as TDocument
  else
    Result := nil;
end;

function TDocumentsList.DocumentIndex(Document: TDocument): Integer;
begin
  Result := fDocuments.IndexOf(Document);
end;

function TDocumentsList.getName: String;
begin
  Result := fName;
end;

procedure TDocumentsList.setDocument(index: integer;
  const Value: TDocument);
begin
  fDocuments.Items[index] := Value;
end;

procedure TDocumentsList.setName(const Value: String);
begin
  fName := Value;
end;

{ TDocumentsDataDir }

procedure TDocumentsListDataSourceFileSystem.AddDocumentsForAllDocumnetsList(
  aDate: TDateTime; aNumber: String);
var
  i: Integer;
begin
  for i:= 0 to DocumentsLists.Count - 1 do
  begin
    (DocumentsLists[i] as TDocumentsList).AddDocument(aDate, aNumber);
  end;
end;

constructor TDocumentsListDataSourceFileSystem.Create;
begin
  inherited Create;
  fDirectory := TDirectory.Create('');
end;

procedure TDocumentsListDataSourceFileSystem.EraseDocumentsFromAllDocumnetsList;
var
  i, j: Integer;
begin
  for i:= 0 to DocumentsLists.Count - 1 do
  begin
    (DocumentsLists[i] as TDocumentsList).DeleteAllDocuments;
  end;
end;

function TDocumentsListDataSourceFileSystem.getDirectory: TDirectory;
begin
  Result := fDirectory;
end;

procedure TDocumentsListDataSourceFileSystem.ParseDirectory;
var
  sr: TSearchRec;
  aDate: TDateTime;
  aNumber: String;
begin
  // пусть пока будет колхозна€ маска подбора файлов
  if FindFirst(fDirectory.DirFullName+'*.jpg', faAnyFile , sr) = 0 then

  begin
    repeat
      // сначала проверил удаетс€ ли получить документые данные из этого файла.
      if Succeeded(ParseDocumentData(sr.Name, aDate, aNumber)) then
      begin
        // добавим дл€ каждого подцепленного списка документов.
        AddDocumentsForAllDocumnetsList(aDate, aNumber);
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;

end;

function TDocumentsListDataSourceFileSystem.ParseDocumentData(fileName: String;
  var aDate: TDateTime; var aNumber: String): HRESULT;
var
  i: Integer;
  s: String;
  fs: TFormatSettings;
begin
  // только в самом конце у нас результат примет положительное значение.
  Result := E_FAIL;

  fileName := ExtractFileName(fileName);
  // найдем адрес нашего первого терминатора
  i := pos('_',fileName);
  s := copy(fileName, 1, i-1);
  // немного подправим дл€ себ€ формат записи времени
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, fs);

  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'yyyy-mm-dd';

  // проверил можно ли прочитать дату. ≈сли нет, то у нас будет немедленный выход.
  if (not TryStrToDateTime(s, aDate, fs)) then Exit;

  delete(fileName, 1, i);

  // найдем адрес нашего второго терминатора
  i := pos('_',fileName);
  s := copy(fileName, 1, i-1);
  aNumber := s;

  Result := S_OK
end;

procedure TDocumentsListDataSourceFileSystem.Refresh;
begin
  inherited;
  ReParseDirectory;
end;

procedure TDocumentsListDataSourceFileSystem.ReParseDirectory;
begin
  { € конечно понимаю, что лучше всего это было бы сделать не путем полного
    перепарсинга файлов.. Ќќ лень =(}

  EraseDocumentsFromAllDocumnetsList;
  ParseDirectory;
end;

procedure TDocumentsListDataSourceFileSystem.setDirectory(const Value: TDirectory);
begin
  if fDirectory.DirFullName <> Value.DirFullName then
  begin
    fDirectory := Value;
    ParseDirectory;
  end
  else
    fDirectory := Value;
end;

{ TDocumentsListData }

constructor TDocumentsListDataSource.Create;
begin
  inherited Create;
  fDocumentsLists := TObjectList.Create(false);
end;

procedure TDocumentsListDataSourceFileSystem.Update;
begin
  inherited;
  ReParseDirectory;
end;

function TDocumentsList.AddDocument(aDate: TDateTime;
  aNumber: String; var index: integer): TDocument;
begin
  Result := nil;

  result := TDocument.Create(aDate, aNumber);
  try
    index := fDocuments.Add(Result);
  except
    result := nil;
  end;
  DocumentsListEvents.SetAddDocument(Result, self);
end;

function TDocumentsList.AddDocument(aDate: TDateTime;
  aNumber: String): TDocument;
var i:integer;
begin
  Result := AddDocument(aDate, aNumber, i);
end;

function TDocumentsList.getDocumentCount: integer;
begin
  Result := fDocuments.Count;
end;

function TDocumentsList.DeleteAllDocuments: HRESULT;
var
  i: Integer;
begin
  for i := 0 to fDocuments.Count - 1 do
  begin
    fDocuments.Delete(i);
  end;
end;

destructor TDocumentsList.Destroy;
begin
  fDocuments.Free;
end;

function TDocumentsList.getDataSource: TDocumentsListDataSource;
begin
  Result := fDataSource;
end;

procedure TDocumentsList.setDataSource(
  const Value: TDocumentsListDataSource);
begin
  fDataSource := Value;
end;


procedure TDocumentsList.AddDocumentAction(aDocument: TObject);
begin

end;

procedure TDocumentsList.DeleteDocumentAction(aDocument: TObject);
begin

end;

procedure TDocumentsList.RefreshAction;
begin
  DataSource.Refresh;
end;

procedure TDocumentsList.UpdateDocumentAction(aDocument: TObject);
begin

end;

function TDocumentsList.getDocumentsListEvents: IDocumentsListEvents;
begin
  Result := fDocumentsListEvents;
end;

procedure TDocumentsList.setDocumentsListEvents(
  const Value: IDocumentsListEvents);
begin
  fDocumentsListEvents := Value;
end;

function TDocumentsList.isSender(sendObject: TObject): Boolean;
begin
  result := Self = sendObject;
end;

{ TDocumentScan }

constructor TDocumentScan.Create;
begin
  fScanFiles := TObjectList.Create(true);
end;

function TDocumentScan.getScanFilesList: TObjectList;
begin
  Result := fScanFiles;
end;

destructor TDocumentsListDataSource.Destroy;
begin
  fDocumentsLists.Free;
end;

function TDocumentsListDataSource.getDocumentsLists: TObjectList;
begin
  Result := fDocumentsLists;
end;

end.
