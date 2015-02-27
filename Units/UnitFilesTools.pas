unit UnitFilesTools;

interface

uses SysUtils, Contnrs;

type

  TFile = class;

  TDirectory = class
    private
      aDirFullName: String;
      fFiles: TObjectList;
      function getDirFullName: string;
      function GetterFile(Index: integer): TFile;
    public
      Property File_[Index : integer] : TFile read GetterFile;
      property DirFullName: string read getDirFullName;
      constructor Create(dirAddr: String);// override;
  end;

  TFile = class
    private
      aFileFullName: String;
      fDirectory: TDirectory;
      function getFileFullName: string;
      function getDirectory: TDirectory;
    public
      property Directory: TDirectory read getDirectory;
      property FileFullName: string read getFileFullName;
      constructor Create(fileAddr: String);// override;
    published

  end;



implementation


{ TDirectory }

constructor TDirectory.Create(dirAddr: String);
begin
  if not DirectoryExists(dirAddr) then CreateDir(dirAddr);
  aDirFullName := dirAddr;
end;

function TDirectory.getDirFullName: string;
begin
  Result := aDirFullName;
end;

function TDirectory.GetterFile(Index: Integer): TFile;
begin
  Result := fFiles.Items[index] as TFile;
end;

{ TFile }

constructor TFile.Create(fileAddr: String);
begin
  if not FileExists(fileAddr) then FileCreate(fileAddr);
  aFileFullName := fileAddr;
end;

function TFile.getDirectory: TDirectory;
begin
  Result := directory;
end;

function TFile.getFileFullName: string;
begin
  Result := aFileFullName;
end;

end.
