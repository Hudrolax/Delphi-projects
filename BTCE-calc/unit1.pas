unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, ComCtrls, IdIOHandler, IdIOHandlerSocket,
  IdSSLOpenSSL, IdSocks, gvar, ExtCtrls, IniFiles, Grids;

type
  TForm1 = class(TForm)
    BuyBTC: TEdit;
    Label1: TLabel;
    lbl1: TLabel;
    SellBTC: TEdit;
    CheckGox: TCheckBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    VolBTC: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    http: TIdHTTP;
    IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocket;
    GetPriceOnline: TCheckBox;
    Label7: TLabel;
    Timer1: TTimer;
    Button2: TButton;
    sgAsk: TStringGrid;
    Label8: TLabel;
    Label9: TLabel;
    sgBid: TStringGrid;
    sgBid2: TStringGrid;
    Label10: TLabel;
    sgAsk2: TStringGrid;
    Label11: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GetPriceOnlineClick(Sender: TObject);
    procedure CheckGoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

// Описываем класс для потока
TGetPrice = class(tthread)
private
  { private declarations }
protected
procedure execute; override;
end;

var
  Form1: TForm1;
  HttpErrCount:Integer;
  AvEx1,AvEx2:Real;
  TGetPrice1:TGetPrice;
  ini:TIniFile;
  EXEPath:string;

implementation
procedure AddAsk(Price:Real;Volume:real);
var i,j:Integer;
begin
  Form1.sgAsk.RowCount:=Form1.sgAsk.RowCount+1;
  Form1.sgAsk.Cells[0,Form1.sgAsk.RowCount-1] := IntToStr(Form1.sgAsk.RowCount-1);
  Form1.sgAsk.Cells[1,Form1.sgAsk.RowCount-1] := OkrugStr(FloatToStr(Price),2);
  Form1.sgAsk.Cells[2,Form1.sgAsk.RowCount-1] := OkrugStr(FloatToStr(Volume),5);
  Form1.sgAsk.Cells[3,Form1.sgAsk.RowCount-1] := OkrugStr(FloatToStr(Price*Volume),2);
  Form1.sgAsk.FixedRows:=1;
end;

procedure AddBid(Price:Real;Volume:real);
var i,j:Integer;
begin
  Form1.SgBid.RowCount:=Form1.SgBid.RowCount+1;
  Form1.SgBid.Cells[0,Form1.SgBid.RowCount-1] := IntToStr(Form1.SgBid.RowCount-1);
  Form1.SgBid.Cells[1,Form1.SgBid.RowCount-1] := OkrugStr(FloatToStr(Price),2);
  Form1.SgBid.Cells[2,Form1.SgBid.RowCount-1] := OkrugStr(FloatToStr(Volume),5);
  Form1.SgBid.Cells[3,Form1.SgBid.RowCount-1] := OkrugStr(FloatToStr(Price*Volume),2);
  Form1.SgBid.FixedRows:=1;
end;

procedure AddAsk2(Price:Real;Volume:real);
var i,j:Integer;
begin
  Form1.sgAsk2.RowCount:=Form1.sgAsk2.RowCount+1;
  Form1.sgAsk2.Cells[0,Form1.sgAsk2.RowCount-1] := IntToStr(Form1.sgAsk2.RowCount-1);
  Form1.sgAsk2.Cells[1,Form1.sgAsk2.RowCount-1] := OkrugStr(FloatToStr(Price),2);
  Form1.sgAsk2.Cells[2,Form1.sgAsk2.RowCount-1] := OkrugStr(FloatToStr(Volume),5);
  Form1.sgAsk2.Cells[3,Form1.sgAsk2.RowCount-1] := OkrugStr(FloatToStr(Price*Volume),2);
  Form1.sgAsk2.FixedRows:=1;
end;

procedure AddBid2(Price:Real;Volume:real);
var i,j:Integer;
begin
  Form1.SgBid2.RowCount:=Form1.SgBid2.RowCount+1;
  Form1.SgBid2.Cells[0,Form1.SgBid2.RowCount-1] := IntToStr(Form1.SgBid2.RowCount-1);
  Form1.SgBid2.Cells[1,Form1.SgBid2.RowCount-1] := OkrugStr(FloatToStr(Price),2);
  Form1.SgBid2.Cells[2,Form1.SgBid2.RowCount-1] := OkrugStr(FloatToStr(Volume),5);
  Form1.SgBid2.Cells[3,Form1.SgBid2.RowCount-1] := OkrugStr(FloatToStr(Price*Volume),2);
  Form1.SgBid2.FixedRows:=1;
end;

procedure ClearSg();
var i,j:Integer;
begin
  for i:=0 to form1.sgAsk.ColCount-1 do
    for j:=1 to Form1.sgAsk.RowCount-1 do
      form1.sgAsk.Cells[i,j]:='';
  Form1.sgAsk.RowCount:=1;

  for i:=0 to form1.SgBid.ColCount-1 do
    for j:=1 to Form1.SgBid.RowCount-1 do
      form1.SgBid.Cells[i,j]:='';
  Form1.SgBid.RowCount:=1;

  for i:=0 to form1.SgAsk2.ColCount-1 do
    for j:=1 to Form1.SgAsk2.RowCount-1 do
      form1.SgAsk2.Cells[i,j]:='';
  Form1.SgAsk2.RowCount:=1;

  for i:=0 to form1.SgBid2.ColCount-1 do
    for j:=1 to Form1.SgBid2.RowCount-1 do
      form1.SgBid2.Cells[i,j]:='';
  Form1.SgBid2.RowCount:=1;
end;

procedure Recalc();
var
prib,pribBaks1,pribBaks2:real;
Vol,price1,price2:string;
iVol,iprice1,iprice2:real;
InstantProc,TradeProc1,TradeProc2:Real;
i:Integer;
begin
  if form1.CheckGox.Checked then
  begin
    InstantProc := 1.49;
    TradeProc1 := 0.2;
    TradeProc2 := 0.6;
  end
  else
    begin
      InstantProc := 0;
      TradeProc1 := 0.2;
      TradeProc2 := 0.2;
    end;

  for i:=1 to Length(Form1.BuyBTC.Text) do
    if Copy(Form1.BuyBTC.Text,i,1)='.' then price1:=price1+',' else price1:=price1+Copy(Form1.BuyBTC.Text,i,1);
  for i:=1 to Length(Form1.SellBTC.Text) do
    if Copy(Form1.SellBTC.Text,i,1)='.' then price2:=price2+',' else price2:=price2+Copy(Form1.SellBTC.Text,i,1);
  for i:=1 to Length(Form1.VolBTC.Text) do
    if Copy(Form1.VolBTC.Text,i,1)='.' then Vol:=Vol+',' else Vol:=Vol+Copy(Form1.VolBTC.Text,i,1);

  iprice1:= StrToFloat(price1);
  iprice2:= StrToFloat(price2);
  iVol:=StrToFloat(Vol);
  if form1.CheckGox.Checked then
    prib:=(ivol-0.01) // Комиссия за вывод с BTC-E
  else prib:=ivol;

  prib:=prib*iprice2*(100-TradeProc2)/100; //Продажа BTC MT-GOX
  prib:=prib*(100-InstantProc)/100; // Перевод через BitInstant
  prib:=prib/iprice1*(100-TradeProc1)/100; // Покупка BTC

  prib:=prib-iVol; // Вычисляем прибыль в BTC
  pribBaks1:=prib*iprice1*(100-TradeProc1)/100;
  pribBaks2:=prib*iprice2*(100-TradeProc2)/100;

  Form1.lbl3.Caption := FloatToStr(prib);
  if prib<0 then Form1.lbl3.Font.Color := clRed else Form1.lbl3.Font.Color := clGreen;

  Form1.Label4.Caption := FloatToStr(pribBaks1);
  if pribBaks1<0 then Form1.Label4.Font.Color := clRed else Form1.Label4.Font.Color := clGreen;

  Form1.Label6.Caption := FloatToStr(pribBaks2);
  if pribBaks2<0 then Form1.Label6.Font.Color := clRed else Form1.Label6.Font.Color := clGreen;
end;

{TGetPrice}
procedure TGetPrice.execute;
var GetStr:WideString;
s1,s:string;
i,j:Integer;
begin
   // _______ Получение LestPrice с BTC-E ____________________
   s1:='';
   s:='';
   GetStr:='0';
   try
    GetStr:=Form1.http.Get('https://btc-e.com/api/2/btc_usd/ticker');
   except
    HttpErrCount:=HttpErrCount+1;
    if HttpErrCount >= 10 then
    begin
      HttpErrCount := 0;
      //ShowMessage('Ошибка подключения к серверу котировок!');
    end;
    Exit
    end;

  for i:=1 to Length(GetStr) do
    if Copy(GetStr,i,7)='"last":' then // нашли позицию Last Price
      begin
       for j:=i+7 to Length(GetStr) do
         if Copy(GetStr,j,1) <> ',' then s1:=s1+Copy(GetStr,j,1) else Break;
       Break;
      end;
  for i:=1 to Length(s1) do
   if Copy(s1,i,1)='.' then s:=s+',' else s:=s+Copy(s1,i,1);

  if IsDigit(s) then AvEx1:=StrToFloat(s);
  // _______ Получение LestPrice с MT-GOX ____________________
  s1:='';
  s:='';
  GetStr:='0';
   try
    GetStr:=Form1.http.Get('https://mtgox.com/api/1/BTCUSD/ticker');
   except
    HttpErrCount:=HttpErrCount+1;
    if HttpErrCount >= 10 then
    begin
      HttpErrCount := 0;
     // ShowMessage('Ошибка подключения к серверу котировок!');
    end;
    Exit
      end;

  for i:=1 to Length(GetStr) do
    if Copy(GetStr,i,16)='"last":{"value":' then // нашли позицию Last Price
      begin
       for j:=i+17 to Length(GetStr) do
         if Copy(GetStr,j,1) <> '"' then s1:=s1+Copy(GetStr,j,1) else Break;
       Break
      end;
  for i:=1 to Length(s1) do
   if Copy(s1,i,1)='.' then s:=s+',' else s:=s+Copy(s1,i,1);

  if IsDigit(s) then AvEx2:=StrToFloat(s);

  Form1.BuyBTC.Text:= FloatToStr(AvEx1);
  Form1.SellBTC.Text:= FloatToStr(AvEx2);
  Recalc();
end;

{$R *.dfm}
procedure GetDepth();
var GetStr:WideString;
sCen,sVol:string;
i,j,k,m:Integer;
begin
//__________________________________ Ордера с BTC-E.COM ______________________________________
  GetStr:='';
  try
    GetStr:=Form1.http.Get('https://btc-e.com/api/2/btc_usd/depth');
   except
    HttpErrCount:=HttpErrCount+1;
    if HttpErrCount >= 10 then
    begin
      HttpErrCount := 0;
      ShowMessage('Ошибка подключения к серверу котировок!');
    end;
    Exit;
    end;
  for i:=1 to Length(GetStr) do
    if Copy(GetStr,i,7) = '"asks":' then // Ордера на продажу
     begin
      SetLength(Ex1Ask,0); // Очистим массив ордеров
      for m:=i+8 to Length(GetStr) do
       if Copy(GetStr,m,1) = '[' then // Новый ордер
         begin
          sCen := '';
          sVol := '';
          for j:=m+1 to Length(GetStr) do // Читаем цену
           if Copy(GetStr,j,1) <> ',' then sCen:=sCen+To4kToZap(Copy(GetStr,j,1))
           else
            begin
             for k:=j+1 to Length(GetStr) do
              if Copy(GetStr,k,1) <> ']' then
               sVol:=sVol+To4kToZap(Copy(GetStr,k,1))
              else Break;
              Break
            end;
          SetLength(Ex1Ask,Length(Ex1Ask)+1);

          if IsDigit(sCen) and IsDigit(sVol) then
          begin
            Ex1Ask[Length(Ex1Ask)-1].price := StrToFloat(sCen);
            Ex1Ask[Length(Ex1Ask)-1].vol   := StrToFloat(sVol);
          end
         end;
     end
    else if Copy(GetStr,i,7) = '"bids":' then
    begin
      SetLength(Ex1Bid,0); // Очистим массив ордеров
      for m:=i+8 to Length(GetStr) do
       if Copy(GetStr,m,1) = '[' then // Новый ордер
         begin
          sCen := '';
          sVol := '';
          for j:=m+1 to Length(GetStr) do // Читаем цену
           if Copy(GetStr,j,1) <> ',' then sCen:=sCen+To4kToZap(Copy(GetStr,j,1))
           else
            begin
             for k:=j+1 to Length(GetStr) do
              if Copy(GetStr,k,1) <> ']' then
               sVol:=sVol+To4kToZap(Copy(GetStr,k,1))
              else Break;
              Break
            end;
          SetLength(Ex1Bid,Length(Ex1Bid)+1);

          if IsDigit(sCen) and IsDigit(sVol) then
          begin
            Ex1Bid[Length(Ex1Bid)-1].price := StrToFloat(sCen);
            Ex1Bid[Length(Ex1Bid)-1].vol   := StrToFloat(sVol);
          end
         end;
    end;

//__________________________________ Ордера с MTGOX.COM ______________________________________

  GetStr:='';
  try
    GetStr:=Form1.http.Get('https://mtgox.com/api/1/BTCUSD/depth');
   except
    HttpErrCount:=HttpErrCount+1;
    if HttpErrCount >= 10 then
    begin
      HttpErrCount := 0;
      ShowMessage('Ошибка подключения к серверу котировок!');
    end;
    Exit;
    end;
  for i:=1 to Length(GetStr) do
    if Copy(GetStr,i,7) = '"asks":' then // Ордера на продажу
     begin
      SetLength(Ex2Ask,0); // Очистим массив ордеров
      for m:=i+9 to Length(GetStr) do if Copy(GetStr,m,1) = '{' then // Новый Ордер
      begin
       sCen := '';
       sVol := '';
       for j:=m+9 to Length(GetStr) do
       if Copy(GetStr,j,1) <> ',' then sCen:=sCen+To4kToZap(Copy(GetStr,j,1)) // Цену получаем
       else
        begin
         for k:=j+10 to Length(GetStr) do
         if Copy(GetStr,k,1) <> ',' then // Объем получаем
          sVol:=sVol+To4kToZap(Copy(GetStr,k,1))
         else Break;
         Break
        end;
       SetLength(Ex2Ask,Length(Ex2Ask)+1);

       if IsDigit(sCen) and IsDigit(sVol) then
       begin
        Ex2Ask[Length(Ex2Ask)-1].price := StrToFloat(sCen);
        Ex2Ask[Length(Ex2Ask)-1].vol   := StrToFloat(sVol);
       end
      end
     end
    else if Copy(GetStr,i,7) = '"bids":' then // Ордера на покупку
    begin
     SetLength(Ex2Bid,0); // Очистим массив ордеров
     for m:=i+9 to Length(GetStr) do if Copy(GetStr,m,1) = '{' then // Новый Ордер
      begin
       sCen := '';
       sVol := '';
       for j:=m+9 to Length(GetStr) do
       if Copy(GetStr,j,1) <> ',' then sCen:=sCen+To4kToZap(Copy(GetStr,j,1)) // Цену получаем
       else
        begin
         for k:=j+10 to Length(GetStr) do
         if Copy(GetStr,k,1) <> ',' then // Объем получаем
          sVol:=sVol+To4kToZap(Copy(GetStr,k,1))
         else Break;
         Break
        end;
       SetLength(Ex2Bid,Length(Ex2Bid)+1);

       if IsDigit(sCen) and IsDigit(sVol) then
       begin
        Ex2Bid[Length(Ex2Bid)-1].price := StrToFloat(sCen);
        Ex2Bid[Length(Ex2Bid)-1].vol   := StrToFloat(sVol);
       end
      end
    end;
    ClearSg();
    for i:=0 to Length(Ex1Ask)-1 do AddAsk(Ex1Ask[i].price,Ex1Ask[i].vol);
    for i:=0 to Length(Ex1Bid)-1 do AddBid(Ex1Bid[i].price,Ex1Bid[i].vol);

    for i:=0 to Length(Ex2Ask)-1 do AddAsk2(Ex2Ask[i].price,Ex2Ask[i].vol);
    for i:=0 to Length(Ex2Bid)-1 do AddBid2(Ex2Bid[i].price,Ex2Bid[i].vol);
end;

procedure StartGet();
begin
 try
    TGetPrice1:= TGetPrice.create(true);
    TGetPrice1.freeonterminate := true;
    TGetPrice1.priority := tplowest;
    TGetPrice1.Resume;
    except
      Showmessage('Не удалось запустить процесс GetPrice!');
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Recalc();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
GetDepth()
end;

procedure CheackBoxClick();
begin
 with Form1 do
 begin
 if GetPriceOnline.Checked then
  begin
    Label7.Caption := 'Online';
    Label7.Font.Color := clGreen;
    Timer1.Enabled := True;
  end
 else
  begin
    Label7.Caption := 'Offline';
    Label7.Font.Color := clRed;
    Timer1.Enabled := False;
    try
      TGetPrice1.Terminate;
      except
        end;
  end
 end
end;

procedure TForm1.GetPriceOnlineClick(Sender: TObject);
begin
 CheackBoxClick();
end;

procedure TForm1.CheckGoxClick(Sender: TObject);
begin
  if not CheckGox.Checked then GetPriceOnline.Checked := false;
 CheackBoxClick();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EXEPath:=extractfilepath(paramstr(0));
  Ini:=TiniFile.Create(EXEPath+'config.ini');
  VolBTC.Text:=ini.ReadString('BTC','Volume','2');
  Ini.Free;

  sgAsk.Cells[0,0]:='#';
  sgAsk.Cells[1,0]:='Price';
  sgAsk.Cells[2,0]:='BTC';
  sgAsk.Cells[3,0]:='USD';

  SgBid.Cells[0,0]:='#';
  SgBid.Cells[1,0]:='Price';
  SgBid.Cells[2,0]:='BTC';
  SgBid.Cells[3,0]:='USD';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  StartGet();
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Ini:=TiniFile.Create(EXEPath+'config.ini');
  ini.WriteString('BTC','Volume',VolBTC.Text);
  Ini.Free;
end;

end.
