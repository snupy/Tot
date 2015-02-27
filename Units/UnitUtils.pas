unit UnitUtils;

interface

uses Forms, IniFiles, Sysutils, UnitDocuments, UnitFilesTools, UnitDocumentsController, StrUtils;

type

  TSettings = class
  private
    settingsFileAddr: String;
  public
    procedure LoadSettings();
    constructor Create(fileAddr: String);
    destructor Destroy(save: Boolean = true);
  published

  end;

  TInitialize = class
  private
    fAppl: TApplication;
    settings: TSettings;
  public
    procedure initialize();
    constructor Create(appl: TApplication);
  end;

const
  settingFile = 'settings\settings.ini';

var
  init: TInitialize;

implementation

{ init }

constructor TInitialize.Create(appl: TApplication);
begin
  inherited Create;
  fAppl := appl;
end;

procedure TInitialize.initialize();
var
  ds: TDocumentsListDataSourceFileSystem;
  ii, ii2: IDocumentsListActions;
begin
  mainDocumentsList := TDocumentsList.Create;
  ds := TDocumentsListDataSourceFileSystem.Create;
  mainDocumentsList.DataSource := ds;
  ds.DocumentsLists.Add(mainDocumentsList);

  mainDocumentsListController := TDocumentsListController.Create;
  mainDocumentsListController.DocumentList := mainDocumentsList;

  ii := mainDocumentsList;
  ii2 := mainDocumentsList;
  mainDocumentsList.DocumentsListEvents := mainDocumentsListController;

  settings := TSettings.Create(ExtractFilePath(fAppl.ExeName)+settingFile);
  settings.LoadSettings;


end;

{ TSettings }

constructor TSettings.Create(fileAddr: String);
begin
  settingsFileAddr := fileAddr;
end;

destructor TSettings.Destroy(save: Boolean);
begin
  //
end;

procedure TSettings.LoadSettings;
var
  IniFile: TIniFile;
  ds: TDocumentsListDataSourceFileSystem;
begin
  IniFile := TIniFile.Create(settingsFileAddr);
  //IniFile.WriteString('MainDocumentsDirectory', 'DirectoryAddr','c');

  ds := mainDocumentsList.DataSource as TDocumentsListDataSourceFileSystem;
  ds.Directory := TDirectory.Create(ifThen(IniFile.ReadBool('MainDocumentsDirectory', 'AbsoluteAddr', True),'',ExtractFilePath(Application.ExeName)) + IniFile.ReadString('MainDocumentsDirectory', 'DirectoryAddr',''));

  ds.Update;
//  (mainDocumentsCatalog as TDocumentCatalogDirectory).directoryAddr := IniFile.ReadString('MainDocumentsCatalog', 'DirectoryAddr','');

end;

end.
