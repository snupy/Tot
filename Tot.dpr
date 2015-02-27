program Tot;

uses
  Forms,
  UnitMainForm in 'Units\UnitMainForm.pas' {MainForm},
  UnitDocuments in 'Units\UnitDocuments.pas',
  UnitFilesTools in 'Units\UnitFilesTools.pas',
  UnitUtils in 'Units\UnitUtils.pas',
  UnitScanUtils in 'Units\UnitScanUtils.pas',
  UnitDocumentsController in 'Units\UnitDocumentsController.pas',
  EZTwain in 'Units\EZTWAIN.PAS',
  UnitImageShow in 'Units\UnitImageShow.pas' {FormImageShow},
  UnitGlobalVariables in 'Units\UnitGlobalVariables.pas';

{$R *.res}

begin
  Application.Initialize;
{  init := TInitialize.Create(Application);
  init.initialize;}
  Application.Title := 'TOT';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormImageShow, FormImageShow);
  Application.Run;
{  init.Destroy;}
end.
