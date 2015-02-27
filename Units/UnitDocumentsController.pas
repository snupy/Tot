unit UnitDocumentsController;

interface

uses ComCtrls;

type
IDocumentsListActions = Interface
  procedure AddDocumentAction(aDocument: TObject);
  procedure DeleteDocumentAction(aDocument: TObject);
  procedure UpdateDocumentAction(aDocument: TObject);
  procedure RefreshAction();
  function isSender(sendObject: TObject): Boolean;
end;

IDocumentsListEvents = Interface
  procedure SetAddDocument(aDocument: TObject; Sender: TObject);
  procedure SetDeleteDocument(aDocument: TObject; Sender: TObject);
  procedure SetUpdateDocument(aDocument: TObject; Sender: TObject);
  procedure SetRefresh(Sender: TObject);
//  function isSender(sendObject: TObject): Boolean;
end;


TDocumentsListController =class(TInterfacedObject,IDocumentsListEvents)
private
  fDocumentList: IDocumentsListActions;
  fViewList: IDocumentsListActions;
  procedure SetAddDocument(aDocument: TObject; Sender: TObject);
  procedure SetDeleteDocument(aDocument: TObject; Sender: TObject);
  procedure SetUpdateDocument(aDocument: TObject; Sender: TObject);
  procedure SetRefresh( Sender: TObject);
  function isSender(sendObject: TObject): Boolean;
  function getDocumentList: IDocumentsListActions;
  function getViewList: IDocumentsListActions;
  procedure setDocumentList(const Value: IDocumentsListActions);
  procedure setViewList(const Value: IDocumentsListActions);
public
  property DocumentList: IDocumentsListActions read getDocumentList write setDocumentList;
  property ViewList: IDocumentsListActions read getViewList write setViewList;
end;

var
  mainDocumentsListController: TDocumentsListController;
implementation

{ TDocumentsListController }

function TDocumentsListController.getDocumentList: IDocumentsListActions;
begin
  Result := fDocumentList;
end;

function TDocumentsListController.getViewList: IDocumentsListActions;
begin
  Result := fViewList;
end;

function TDocumentsListController.isSender(sendObject: TObject): Boolean;
begin
  Result := Self = sendObject;
end;

procedure TDocumentsListController.SetAddDocument(aDocument: TObject;
  Sender: TObject);
begin
  if (fDocumentList <> nil) and not fDocumentList.isSender(Sender) then
    fDocumentList.AddDocumentAction(aDocument);
  if (fViewList <>nil) and not fViewList.isSender(Sender) then
    fViewList.AddDocumentAction(aDocument);
end;

procedure TDocumentsListController.SetDeleteDocument(aDocument: TObject;
  Sender: TObject);
begin
  if (fDocumentList <> nil) and not fDocumentList.isSender(Sender) then
    fDocumentList.DeleteDocumentAction(aDocument);
  if (fViewList <>nil) and not fViewList.isSender(Sender) then
    fViewList.DeleteDocumentAction(aDocument);
end;

procedure TDocumentsListController.setDocumentList(
  const Value: IDocumentsListActions);
begin
  fDocumentList := Value;
end;

procedure TDocumentsListController.SetRefresh(Sender: TObject);
begin
  if (fDocumentList <> nil) and not fDocumentList.isSender(Sender) then
    fDocumentList.RefreshAction();
  if (fViewList <>nil) and not fViewList.isSender(Sender) then
    fViewList.RefreshAction();
end;

procedure TDocumentsListController.SetUpdateDocument(aDocument: TObject;
  Sender: TObject);
begin
  if (fDocumentList <> nil) and not fDocumentList.isSender(Sender) then
    fDocumentList.UpdateDocumentAction(aDocument);
  if (fViewList <>nil) and not fViewList.isSender(Sender) then
    fViewList.UpdateDocumentAction(aDocument);
end;

procedure TDocumentsListController.setViewList(
  const Value: IDocumentsListActions);
begin
  // проверим новый ли?
  if fViewList <> Value then
  begin
    fViewList := Value;
    fViewList.RefreshAction;
  end;
end;

end.
