{
Sorry you must use the sendmessage API to do this.
use the winsight32 to spy this message !.
you can find in compsit.pas a new component witch send a TAB key
when you press ENTER

Best regards

Pierre

pmarmet@mnet.fr
}

unit compsit;
//*******************************************
// Classe TDBedite
// avec gestion de la touche ENTREE
// (c)SIT 8/5/1996 MARMET Pierre
//*******************************************


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,DBCtrls;

type
  TDBEdite = class(TDBEdit)

  private
  Tentree: integer;
  varia: boolean;
  oldvalue: string;            {memorise l'ancienne valeur du composant}

  function getpierre: integer;
  procedure setpierre (param1: integer);
  procedure WndProc(var Message: TMessage) ;override;
    { D�clarations priv�es }
  protected
    { D�clarations prot�g�es }


  public
  constructor Create(AOwner: TComponent); override;

   { D�clarations publiques }
  published
  //property ENTREE: Boolean read Getpierre write Setpierre default True;
  / property ENTERKey: integer read getpierre write setpierre default 1;
  property DoEnterKey: boolean read varia write varia;
    { D�clarations publi�es }
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Exemples', [TDBEdite]);
end;

Constructor TDBEdite.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
//     ENTERKey := 1;
     varia:=True;
end;

function TDBEdite.getpierre: integer;
begin
     result := Tentree;
end;

procedure TDBEdite.setpierre(param1: integer);
begin
     if param1 > 1 then param1:=1;
     Tentree:=param1;
end;



procedure TDBEdite.WndProc(var Message: TMessage);
begin

  if (message.msg = WM_CHAR) then

     begin

     // La touche ENTREE provoque une tabulation sur le controle
     if (message.WParam = 13) and ( varia = True ) then
          begin
              sendmessage(self.Handle,WM_USER+$B900,9,$F0001);
              exit;
          end;
     end;

  inherited WndProc(Message);        { r�partition normale }
end;



end.
