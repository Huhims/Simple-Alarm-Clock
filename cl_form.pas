unit cl_Form;

{$mode objfpc}{$H+}

interface

uses {$IFDEF Linux} Unix, bass, LazFileUtils, {$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  {$IFDEF WINDOWS} MMSystem, {$ENDIF} Process;


type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    clk_lb: TLabel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DATE_lb: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    msg_lb: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure FormatTM;
    procedure Load_CFG;
    procedure Save_CFG;
    {$IFDEF Linux} procedure PlaySound; {$ENDIF}
  public
    procedure Pull_data;
  end;

var
  Form1: TForm1;
  RunProgram: TProcess;
  lStrings : TStringList;
  input_data: String;
  h,m,s: integer;
  hh,mm,ss: String;
  linux_logoff_cmd: String = 'cinnamon-session-quit --logout --force';

  TimeZone: integer = 12;

  snd_ck,ShutDown_ck,Restart_ck,Sleep_ck,call_ck: Boolean;
  snd2_ck,ShutDown2_ck,Restart2_ck,Sleep2_ck,call2_ck: Boolean;
  snd3_ck,ShutDown3_ck,Restart3_ck,Sleep3_ck,call3_ck: Boolean;
  alarm1_Time, alarm2_Time, alarm3_Time: String;
  pr_path1, pr_path2, pr_path3: String;

  //bass.so
  Tr_1: Cardinal;

implementation
 uses {$IFDEF WINDOWS} ExitWinNT, {$ENDIF} set_form;

{$R *.lfm}

{$IFDEF Linux}
procedure TForm1.PlaySound;
var
  AudioFile: TStream;
  DIM: Pointer;
  linux_USER_Path: String;
begin
  linux_USER_Path := (GetUserDir + '/.local/share/alclock');

 AudioFile := TFileStream.Create(linux_USER_Path + '/alarm_beep.wav', fmOpenRead);
 GetMem(DIM, AudioFile.Size);
 AudioFile.Read(DIM^, AudioFile.Size);
 BASS_Init(1, 44100, 0, DIM, nil);

 Tr_1 := BASS_StreamCreateFile(True, DIM, 0, AudioFile.Size, 0);
 BASS_ChannelPlay(Tr_1, False);
 AudioFile.Free;
end;
{$ENDIF}

procedure TForm1.Pull_data;
begin

   if set_form.snd_ck = True then begin snd_ck := True; end else begin snd_ck := False; end;
   if set_form.ShutDown_ck = True then begin ShutDown_ck := True; end else begin ShutDown_ck := False; end;
   if set_form.Restart_ck = True then begin Restart_ck := True; end else begin Restart_ck := False; end;
   if set_form.Sleep_ck = True then begin Sleep_ck := True; end else begin Sleep_ck := False; end;
   if set_form.call_ck = True then begin call_ck := True; end else begin call_ck := False; end;

   if set_form.snd2_ck = True then begin snd2_ck := True; end else begin snd2_ck := False; end;
   if set_form.ShutDown2_ck = True then begin ShutDown2_ck := True; end else begin ShutDown2_ck := False; end;
   if set_form.Restart2_ck = True then begin Restart2_ck := True; end else begin Restart2_ck := False; end;
   if set_form.Sleep2_ck = True then begin Sleep2_ck := True; end else begin Sleep2_ck := False; end;
   if set_form.call2_ck = True then begin call2_ck := True; end else begin call2_ck := False; end;

   if set_form.snd3_ck = True then begin snd3_ck := True; end else begin snd3_ck := False; end;
   if set_form.ShutDown3_ck = True then begin ShutDown3_ck := True; end else begin ShutDown3_ck := False; end;
   if set_form.Restart3_ck = True then begin Restart3_ck := True; end else begin Restart3_ck := False; end;
   if set_form.Sleep3_ck = True then begin Sleep3_ck := True; end else begin Sleep3_ck := False; end;
   if set_form.call3_ck = True then begin call3_ck := True; end else begin call3_ck := False; end;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
 set_form.Form2.Edit1.Text := IntToStr(h);

  if m > 55 then begin
    set_form.Form2.Edit1.Text := IntToStr(h+1);
      if m = 56 then begin set_form.Form2.Edit2.Text := '00' end
      else if m = 57 then begin set_form.Form2.Edit2.Text := '01' end
      else if m = 58 then begin set_form.Form2.Edit2.Text := '02' end
      else if m = 59 then begin set_form.Form2.Edit2.Text := '03' end;
  end else begin
    set_form.Form2.Edit2.Text := IntToStr(m+4);
  end;

  if set_form.Form2.Edit1.Text = '' then begin set_form.Form2.Edit1.Text := '00'; end
  else if set_form.Form2.Edit1.Text = '0' then begin set_form.Form2.Edit1.Text := '00'; end
  else if set_form.Form2.Edit1.Text = '1' then begin set_form.Form2.Edit1.Text := '01'; end
  else if set_form.Form2.Edit1.Text = '2' then begin set_form.Form2.Edit1.Text := '02'; end
  else if set_form.Form2.Edit1.Text = '3' then begin set_form.Form2.Edit1.Text := '03'; end
  else if set_form.Form2.Edit1.Text = '4' then begin set_form.Form2.Edit1.Text := '04'; end
  else if set_form.Form2.Edit1.Text = '5' then begin set_form.Form2.Edit1.Text := '05'; end
  else if set_form.Form2.Edit1.Text = '6' then begin set_form.Form2.Edit1.Text := '06'; end
  else if set_form.Form2.Edit1.Text = '7' then begin set_form.Form2.Edit1.Text := '07'; end
  else if set_form.Form2.Edit1.Text = '8' then begin set_form.Form2.Edit1.Text := '08'; end
  else if set_form.Form2.Edit1.Text = '9' then begin set_form.Form2.Edit1.Text := '09'; end;

  if set_form.Form2.Edit2.Text = '' then begin set_form.Form2.Edit2.Text := '00'; end
  else if set_form.Form2.Edit2.Text = '0' then begin set_form.Form2.Edit2.Text := '00'; end
  else if set_form.Form2.Edit2.Text = '1' then begin set_form.Form2.Edit2.Text := '01'; end
  else if set_form.Form2.Edit2.Text = '2' then begin set_form.Form2.Edit2.Text := '02'; end
  else if set_form.Form2.Edit2.Text = '3' then begin set_form.Form2.Edit2.Text := '03'; end
  else if set_form.Form2.Edit2.Text = '4' then begin set_form.Form2.Edit2.Text := '04'; end
  else if set_form.Form2.Edit2.Text = '5' then begin set_form.Form2.Edit2.Text := '05'; end
  else if set_form.Form2.Edit2.Text = '6' then begin set_form.Form2.Edit2.Text := '06'; end
  else if set_form.Form2.Edit2.Text = '7' then begin set_form.Form2.Edit2.Text := '07'; end
  else if set_form.Form2.Edit2.Text = '8' then begin set_form.Form2.Edit2.Text := '08'; end
  else if set_form.Form2.Edit2.Text = '9' then begin set_form.Form2.Edit2.Text := '09'; end;

 {$IFDEF Linux}
 if set_form.Form2.cmd_lb.Tag = 0 then begin
  set_form.Form2.cmd_lb.Top := 160; set_form.Form2.cmd_tx.Top := 153;
  set_form.Form2.cmd_lb.Left := 32; set_form.Form2.cmd_tx.Left := 120;
  set_form.Form2.cmd_lb.Visible := True; set_form.Form2.cmd_tx.Visible := True; set_form.Form2.cmd_tx.TabOrder := 9;

  set_form.Form2.CheckBox5.TabOrder := 10;
  set_form.Form2.CheckBox5.Top := 195;
  set_form.Form2.call_path.TabOrder := 11;
  set_form.Form2.call_path.Top := 216;
  set_form.Form2.Label2.Top := 251;
  set_form.Form2.path_name.TabOrder := 12;
  set_form.Form2.path_name.Top := 247;
  set_form.Form2.Button1.TabOrder := 13;
  set_form.Form2.Button1.Top := 299;
  Form2.Height := 338;

  if set_form.Form2.CheckBox5.Caption = 'call "????.exe"' then begin
   set_form.Form2.CheckBox5.Caption := 'call linux "application"';
   set_form.Form2.CheckBox5.TabOrder := 10;
  end;

  set_form.Form2.cmd_tx.Text := linux_logoff_cmd;
  set_form.Form2.call_path.Text := 'firefox';
  set_form.Form2.path_name.Text := 'Firefox';
  set_form.Form2.cmd_lb.Tag := 1;
 end;
 {$ENDIF}
 set_form.Form2.Show;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 set_form.snd_ck := False;      set_form.snd2_ck := False;      set_form.snd3_ck := False;
 set_form.ShutDown_ck := False; set_form.ShutDown2_ck := False; set_form.ShutDown3_ck := False;
 set_form.Restart_ck := False;  set_form.Restart2_ck := False;  set_form.Restart3_ck := False;
 set_form.Sleep_ck := False;    set_form.Sleep2_ck := False;    set_form.Sleep3_ck := False;
 set_form.call_ck := False;     set_form.call2_ck := False;     set_form.call3_ck := False;

 snd_ck := False;      snd2_ck := False;      snd3_ck := False;
 ShutDown_ck := False; ShutDown2_ck := False; ShutDown3_ck := False;
 Restart_ck := False;  Restart2_ck := False;  Restart3_ck := False;
 Sleep_ck := False;    Sleep2_ck := False;    Sleep3_ck := False;
 call_ck := False;     call2_ck := False;     call3_ck := False;

 Label1.Caption := '1. _________________________';
 Label1.Tag := 0;
 Label2.Caption := '2. _________________________';
 Label2.Tag := 0;
 Label3.Caption := '3. _________________________';
 Label3.Tag := 0;

 alarm1_time := ''; alarm2_time := ''; alarm3_time := '';
 pr_path1 := ''; pr_path2 := ''; pr_path3 := '';
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 TimeZone := ComboBox1.ItemIndex;
 ComboBox1.Tag := 1;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Save_CFG;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 ComboBox1.Left := DATE_lb.Left + DATE_lb.Width + 13;
 Load_CFG;

  clk_lb.Caption := TimeToStr(Time);
  DATE_lb.Caption := FormatDateTime('DDDD, dd MMMM YYYY', Now);

  ComboBox1.Items.Add('- 12:00');
  ComboBox1.Items.Add('- 11:00');
  ComboBox1.Items.Add('- 10:00');
  ComboBox1.Items.Add('- 09:00');
  ComboBox1.Items.Add('- 08:00');
  ComboBox1.Items.Add('- 07:00');
  ComboBox1.Items.Add('- 06:00');
  ComboBox1.Items.Add('- 05:00');
  ComboBox1.Items.Add('- 04:00');
  ComboBox1.Items.Add('- 03:00');
  ComboBox1.Items.Add('- 02:00');
  ComboBox1.Items.Add('- 01:00');
  ComboBox1.Items.Add('00:00');
  ComboBox1.Items.Add('+ 01:00');
  ComboBox1.Items.Add('+ 02:00');
  ComboBox1.Items.Add('+ 03:00');
  ComboBox1.Items.Add('+ 04:00');
  ComboBox1.Items.Add('+ 05:00');
  ComboBox1.Items.Add('+ 06:00');
  ComboBox1.Items.Add('+ 07:00');
  ComboBox1.Items.Add('+ 08:00');
  ComboBox1.Items.Add('+ 09:00');
  ComboBox1.Items.Add('+ 10:00');
  ComboBox1.Items.Add('+ 11:00');
  ComboBox1.Items.Add('+ 12:00');

  if TimeZone = 12 then begin
    ComboBox1.ItemIndex := 12;
  end else begin
     ComboBox1.ItemIndex := TimeZone;
  end;

  Timer1.Enabled := True;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

 ComboBox1.Left := DATE_lb.Left + DATE_lb.Width + 14;
 ComboBox1.Visible := True;
  if ComboBox1.Tag > 0 then begin
    ComboBox1.Tag := ComboBox1.Tag + 1;
      if ComboBox1.Tag = 5 then begin
       ComboBox1.Tag := 0;
       ComboBox1.Enabled := False;
       ComboBox1.Enabled := True;
      end;
  end;

 input_data := TimeToStr(Time);

 lStrings := TStringList.Create;
   lStrings.Delimiter := ':';
   lStrings.DelimitedText := input_data;
   h := StrToInt(lStrings.Strings[0]);
   m := StrToInt(lStrings.Strings[1]);
   s := StrToInt(lStrings.Strings[2]);
 lStrings.Free;

 if not (TimeZone = 12) then begin

   if TimeZone = 0 then begin
    h := h - 12; // -12:00
   end else if TimeZone = 1 then begin
    h := h - 11; // -11:00
   end else if TimeZone = 2 then begin
    h := h - 10; // -10:00
   end else if TimeZone = 3 then begin
    h := h - 9;  // -09:00
   end else if TimeZone = 4 then begin
    h := h - 8;  // -08:00
   end else if TimeZone = 5 then begin
    h := h - 7;  // -07:00
   end else if TimeZone = 6 then begin
    h := h - 6;  // -06:00
   end else if TimeZone = 7 then begin
    h := h - 5;  // -05:00
   end else if TimeZone = 8 then begin
    h := h - 4;  // -04:00
   end else if TimeZone = 9 then begin
    h := h - 3;  // -03:00
   end else if TimeZone = 10 then begin
    h := h - 2;  // -02:00
   end else if TimeZone = 11 then begin
    h := h - 1;  // -01:00
   end else if TimeZone = 13 then begin
    h := h + 1;  // +01:00
   end else if TimeZone = 14 then begin
    h := h + 2;  // +02:00
   end else if TimeZone = 15 then begin
    h := h + 3;  // +03:00
   end else if TimeZone = 16 then begin
    h := h + 4;  // +04:00
   end else if TimeZone = 17 then begin
    h := h + 5;  // +05:00
   end else if TimeZone = 18 then begin
    h := h + 6;  // +06:00
   end else if TimeZone = 19 then begin
    h := h + 7;  // +07:00
   end else if TimeZone = 20 then begin
    h := h + 8;  // +08:00
   end else if TimeZone = 21 then begin
    h := h + 9;  // +09:00
   end else if TimeZone = 22 then begin
    h := h + 10; // +10:00
   end else if TimeZone = 23 then begin
    h := h + 11; // +11:00
   end else if TimeZone = 24 then begin
    h := h + 12; // +12:00
   end;

        if h < 0 then begin

          if h = -12 then begin
            h := 12;
          end else if h = -11 then begin
            h := 13;
          end else if h = -10 then begin
            h := 14;
          end else if h = -9 then begin
            h := 15;
          end else if h = -8 then begin
            h := 16;
          end else if h = -7 then begin
            h := 17;
          end else if h = -6 then begin
            h := 18;
          end else if h = -5 then begin
            h := 19;
          end else if h = -4 then begin
            h := 20;
          end else if h = -3 then begin
            h := 21;
          end else if h = -2 then begin
            h := 22;
          end else if h = -1 then begin
            h := 23;
          end;

        end else if h > 23 then begin

          if h = 24 then begin
            h := 0;
          end else if h = 25 then begin
            h := 1;
          end else if h = 26 then begin
            h := 2;
          end else if h = 27 then begin
            h := 3;
          end else if h = 28 then begin
            h := 4;
          end else if h = 29 then begin
            h := 5;
          end else if h = 30 then begin
            h := 6;
          end else if h = 31 then begin
            h := 7;
          end else if h = 32 then begin
            h := 8;
          end else if h = 33 then begin
            h := 9;
          end else if h = 34 then begin
            h := 10;
          end else if h = 35 then begin
            h := 11;
          end;

        end;

 end;

 FormatTM;

 if Timer1.Tag = 0 then begin
  clk_lb.Caption := hh + ' ' + mm + ' ' + ss;
  Timer1.Tag := 1;
 end else begin
  clk_lb.Caption := hh + ':' + mm + ':' + ss;
  Timer1.Tag := 0;
 end;

 {alarm_chk}

 if Label1.Tag = 1 then begin
   if ((hh + ':' + mm) = alarm1_Time) then begin
      if msg_lb.Tag = 0 then begin msg_lb.Tag := 1; end;
    if (msg_lb.Tag = 1) and (snd_ck = True) and (call_ck = True) then begin //Sound & Call
      msg_lb.Tag := 2;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 2 then begin
      msg_lb.Tag := 3;
      msg_lb.Caption := 'starting ... 2';
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 3 then begin
      msg_lb.Tag := 4;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 4 then begin
      msg_lb.Tag := 5;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 5 then begin
      msg_lb.Tag := 6;
      msg_lb.Caption := 'starting ... 5';
              RunProgram := TProcess.Create(nil);
               RunProgram.CommandLine := pr_path1;
               RunProgram.Execute;
              RunProgram.Free;
    end else if msg_lb.Tag = 6 then begin
      msg_lb.Tag := 7;
      msg_lb.Caption := 'Done!';
    end else if msg_lb.Tag = 7 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       snd_ck := False;
       call_ck := False;
       alarm1_Time := '';
       pr_path1 := '';
       Save_CFG;
    end //Sound & Call END.

    else if (msg_lb.Tag = 1) and (call_ck = True) then begin //call
      msg_lb.Tag := 11;
      msg_lb.Caption := 'looking for app...';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 11 then begin
      msg_lb.Tag := 12;
      msg_lb.Visible := False;
           RunProgram := TProcess.Create(nil);
            RunProgram.CommandLine := pr_path1;
            RunProgram.Execute;
           RunProgram.Free;
    end else if msg_lb.Tag = 12 then begin
      msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       call_ck := False;
       alarm1_Time := '';
       pr_path1 := '';
       Save_CFG;
    end //call END.

    else if (msg_lb.Tag = 1) and (ShutDown_ck = True) and (snd_ck = True) then begin //Sound & Shut Down
      msg_lb.Tag := 13;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 13 then begin
      msg_lb.Tag := 14;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 14 then begin
      msg_lb.Tag := 15;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 15 then begin
      msg_lb.Tag := 16;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 16 then begin
      msg_lb.Tag := 17;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 17 then begin
      msg_lb.Tag := 18;
      msg_lb.Caption := 'Shuting Down!';
    end else if msg_lb.Tag = 18 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       snd_ck := False;
       ShutDown_ck := False;
       alarm1_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(ShutDown); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -P now'); {$ENDIF}
    end //Sound & Shut Down END.

    else if (msg_lb.Tag = 1) and (Restart_ck = True) and (snd_ck = True) then begin //Sound & Restart
      msg_lb.Tag := 19;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 19 then begin
      msg_lb.Tag := 20;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 20 then begin
      msg_lb.Tag := 21;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 21 then begin
      msg_lb.Tag := 22;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 22 then begin
      msg_lb.Tag := 23;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 23 then begin
      msg_lb.Tag := 24;
      msg_lb.Caption := 'Rebooting!';
    end else if msg_lb.Tag = 24 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       snd_ck := False;
       Restart_ck := False;
       alarm1_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(Reboot); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -r now'); {$ENDIF}
    end //Sound & Restart END.

    else if (msg_lb.Tag = 1) and (Sleep_ck = True) and (snd_ck = True) then begin //Sound & Sleep
      msg_lb.Tag := 43;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 43 then begin
      msg_lb.Tag := 44;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 44 then begin
      msg_lb.Tag := 45;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 45 then begin
      msg_lb.Tag := 46;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 46 then begin
      msg_lb.Tag := 47;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 47 then begin
      msg_lb.Tag := 48;
      msg_lb.Caption := 'LogOFF...';
    end else if msg_lb.Tag = 48 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       snd_ck := False;
       Sleep_ck := False;
       alarm1_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(LogOff); {$ENDIF}
       {$IFDEF Linux} fpSystem(set_form.Form2.cmd_tx.Text); {$ENDIF}
    end //Sound & Sleep END.

    else if (msg_lb.Tag = 1) and (ShutDown_ck = True) then begin //Shut Down
      msg_lb.Tag := 25;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 25 then begin
      msg_lb.Tag := 26;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 26 then begin
      msg_lb.Tag := 27;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 27 then begin
      msg_lb.Tag := 28;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 28 then begin
      msg_lb.Tag := 29;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 29 then begin
      msg_lb.Tag := 30;
      msg_lb.Caption := 'Shuting Down!';
    end else if msg_lb.Tag = 30 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       snd_ck := False;
       ShutDown_ck := False;
       alarm1_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(ShutDown); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -P now'); {$ENDIF}
    end //Shut Down END.

    else if (msg_lb.Tag = 1) and (Restart_ck = True) then begin //Restart
      msg_lb.Tag := 31;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 31 then begin
      msg_lb.Tag := 32;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 32 then begin
      msg_lb.Tag := 33;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 33 then begin
      msg_lb.Tag := 34;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 34 then begin
      msg_lb.Tag := 35;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 35 then begin
      msg_lb.Tag := 36;
      msg_lb.Caption := 'Rebooting!';
    end else if msg_lb.Tag = 36 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       snd_ck := False;
       Restart_ck := False;
       alarm1_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(Reboot); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -r now'); {$ENDIF}
    end //Restart END.

    else if (msg_lb.Tag = 1) and (Sleep_ck = True) then begin //Sleep
      msg_lb.Tag := 37;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 37 then begin
      msg_lb.Tag := 38;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 38 then begin
      msg_lb.Tag := 39;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 39 then begin
      msg_lb.Tag := 40;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 40 then begin
      msg_lb.Tag := 41;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 41 then begin
      msg_lb.Tag := 42;
      msg_lb.Caption := 'LogOFF';
    end else if msg_lb.Tag = 42 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       snd_ck := False;
       Sleep_ck := False;
       alarm1_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(LogOff); {$ENDIF}
       {$IFDEF Linux} fpSystem(set_form.Form2.cmd_tx.Text); {$ENDIF}
    end //Sleep END.

    else if (msg_lb.Tag = 1) and (snd_ck = True) then begin //Sound
      msg_lb.Tag := 8;
      msg_lb.Caption := 'Beep !';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 8 then begin
      msg_lb.Tag := 9;
      msg_lb.Visible := False;
    end else if msg_lb.Tag = 9 then begin
      msg_lb.Tag := 10;
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 10 then begin
      msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label1.Caption := '1. _________________________';
       Label1.Tag := 0;
       snd_ck := False;
       alarm1_Time := '';
       Save_CFG;
    end; //Sound END.
   end; //alarm 1 end

 end else if Label2.Tag = 1 then begin
   if ((hh + ':' + mm) = alarm2_Time) then begin
      if msg_lb.Tag = 0 then begin msg_lb.Tag := 1; end;
    if (msg_lb.Tag = 1) and (snd2_ck = True) and (call2_ck = True) then begin //Sound & Call
      msg_lb.Tag := 2;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 2 then begin
      msg_lb.Tag := 3;
      msg_lb.Caption := 'starting ... 2';
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 3 then begin
      msg_lb.Tag := 4;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 4 then begin
      msg_lb.Tag := 5;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 5 then begin
      msg_lb.Tag := 6;
      msg_lb.Caption := 'starting ... 5';
              RunProgram := TProcess.Create(nil);
               RunProgram.CommandLine := pr_path2;
               RunProgram.Execute;
              RunProgram.Free;
    end else if msg_lb.Tag = 6 then begin
      msg_lb.Tag := 7;
      msg_lb.Caption := 'Done!';
    end else if msg_lb.Tag = 7 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       snd2_ck := False;
       call2_ck := False;
       alarm2_Time := '';
       pr_path2 := '';
       Save_CFG;
    end //Sound & Call END.

    else if (msg_lb.Tag = 1) and (call2_ck = True) then begin //call
      msg_lb.Tag := 11;
      msg_lb.Caption := 'looking for app...';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 11 then begin
      msg_lb.Tag := 12;
      msg_lb.Visible := False;
           RunProgram := TProcess.Create(nil);
            RunProgram.CommandLine := pr_path2;
            RunProgram.Execute;
           RunProgram.Free;
    end else if msg_lb.Tag = 12 then begin
      msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       call2_ck := False;
       alarm2_Time := '';
       pr_path2 := '';
       Save_CFG;
    end //call END.

    else if (msg_lb.Tag = 1) and (ShutDown2_ck = True) and (snd2_ck = True) then begin //Sound & Shut Down
      msg_lb.Tag := 13;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 13 then begin
      msg_lb.Tag := 14;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 14 then begin
      msg_lb.Tag := 15;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 15 then begin
      msg_lb.Tag := 16;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 16 then begin
      msg_lb.Tag := 17;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 17 then begin
      msg_lb.Tag := 18;
      msg_lb.Caption := 'Shuting Down!';
    end else if msg_lb.Tag = 18 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       snd2_ck := False;
       ShutDown2_ck := False;
       alarm2_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(ShutDown); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -P now'); {$ENDIF}
    end //Sound & Shut Down END.

    else if (msg_lb.Tag = 1) and (Restart2_ck = True) and (snd2_ck = True) then begin //Sound & Restart
      msg_lb.Tag := 19;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 19 then begin
      msg_lb.Tag := 20;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 20 then begin
      msg_lb.Tag := 21;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 21 then begin
      msg_lb.Tag := 22;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 22 then begin
      msg_lb.Tag := 23;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 23 then begin
      msg_lb.Tag := 24;
      msg_lb.Caption := 'Rebooting!';
    end else if msg_lb.Tag = 24 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       snd2_ck := False;
       Restart2_ck := False;
       alarm2_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(Reboot); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -r now'); {$ENDIF}
    end //Sound & Restart END.

    else if (msg_lb.Tag = 1) and (Sleep2_ck = True) and (snd2_ck = True) then begin //Sound & Sleep
      msg_lb.Tag := 43;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 43 then begin
      msg_lb.Tag := 44;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 44 then begin
      msg_lb.Tag := 45;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 45 then begin
      msg_lb.Tag := 46;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 46 then begin
      msg_lb.Tag := 47;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 47 then begin
      msg_lb.Tag := 48;
      msg_lb.Caption := 'LogOFF...';
    end else if msg_lb.Tag = 48 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       snd2_ck := False;
       Sleep2_ck := False;
       alarm2_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(LogOff); {$ENDIF}
       {$IFDEF Linux} fpSystem(set_form.Form2.cmd_tx.Text); {$ENDIF}
    end //Sound & Sleep END.

    else if (msg_lb.Tag = 1) and (ShutDown2_ck = True) then begin //Shut Down
      msg_lb.Tag := 25;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 25 then begin
      msg_lb.Tag := 26;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 26 then begin
      msg_lb.Tag := 27;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 27 then begin
      msg_lb.Tag := 28;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 28 then begin
      msg_lb.Tag := 29;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 29 then begin
      msg_lb.Tag := 30;
      msg_lb.Caption := 'Shuting Down!';
    end else if msg_lb.Tag = 30 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       snd2_ck := False;
       ShutDown2_ck := False;
       alarm2_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(ShutDown); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -P now'); {$ENDIF}
    end //Shut Down END.

    else if (msg_lb.Tag = 1) and (Restart2_ck = True) then begin //Restart
      msg_lb.Tag := 31;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 31 then begin
      msg_lb.Tag := 32;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 32 then begin
      msg_lb.Tag := 33;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 33 then begin
      msg_lb.Tag := 34;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 34 then begin
      msg_lb.Tag := 35;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 35 then begin
      msg_lb.Tag := 36;
      msg_lb.Caption := 'Rebooting!';
    end else if msg_lb.Tag = 36 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       snd2_ck := False;
       Restart2_ck := False;
       alarm2_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(Reboot); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -r now'); {$ENDIF}
    end //Restart END.

    else if (msg_lb.Tag = 1) and (Sleep2_ck = True) then begin //Sleep
      msg_lb.Tag := 37;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 37 then begin
      msg_lb.Tag := 38;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 38 then begin
      msg_lb.Tag := 39;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 39 then begin
      msg_lb.Tag := 40;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 40 then begin
      msg_lb.Tag := 41;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 41 then begin
      msg_lb.Tag := 42;
      msg_lb.Caption := 'LogOFF';
    end else if msg_lb.Tag = 42 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       snd2_ck := False;
       Sleep2_ck := False;
       alarm2_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(LogOff); {$ENDIF}
       {$IFDEF Linux} fpSystem(set_form.Form2.cmd_tx.Text); {$ENDIF}
    end //Sleep END.

    else if (msg_lb.Tag = 1) and (snd2_ck = True) then begin //Sound
      msg_lb.Tag := 8;
      msg_lb.Caption := 'Beep !';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 8 then begin
      msg_lb.Tag := 9;
      msg_lb.Visible := False;
    end else if msg_lb.Tag = 9 then begin
      msg_lb.Tag := 10;
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 10 then begin
      msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label2.Caption := '2. _________________________';
       Label2.Tag := 0;
       snd2_ck := False;
       alarm2_Time := '';
       Save_CFG;
    end; //Sound END.
   end; //alarm 2 end

 end else if Label3.Tag = 1 then begin
   if ((hh + ':' + mm) = alarm3_Time) then begin
      if msg_lb.Tag = 0 then begin msg_lb.Tag := 1; end;
    if (msg_lb.Tag = 1) and (snd3_ck = True) and (call3_ck = True) then begin //Sound & Call
      msg_lb.Tag := 2;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 2 then begin
      msg_lb.Tag := 3;
      msg_lb.Caption := 'starting ... 2';
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 3 then begin
      msg_lb.Tag := 4;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 4 then begin
      msg_lb.Tag := 5;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 5 then begin
      msg_lb.Tag := 6;
      msg_lb.Caption := 'starting ... 5';
              RunProgram := TProcess.Create(nil);
               RunProgram.CommandLine := pr_path3;
               RunProgram.Execute;
              RunProgram.Free;
    end else if msg_lb.Tag = 6 then begin
      msg_lb.Tag := 7;
      msg_lb.Caption := 'Done!';
    end else if msg_lb.Tag = 7 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       snd3_ck := False;
       call3_ck := False;
       alarm3_Time := '';
       pr_path3 := '';
       Save_CFG;
    end //Sound & Call END.

    else if (msg_lb.Tag = 1) and (call3_ck = True) then begin //call
      msg_lb.Tag := 11;
      msg_lb.Caption := 'looking for app...';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 11 then begin
      msg_lb.Tag := 12;
      msg_lb.Visible := False;
           RunProgram := TProcess.Create(nil);
            RunProgram.CommandLine := pr_path3;
            RunProgram.Execute;
           RunProgram.Free;
    end else if msg_lb.Tag = 12 then begin
      msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       call3_ck := False;
       alarm3_Time := '';
       pr_path3 := '';
       Save_CFG;
    end //call END.

    else if (msg_lb.Tag = 1) and (ShutDown3_ck = True) and (snd3_ck = True) then begin //Sound & Shut Down
      msg_lb.Tag := 13;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 13 then begin
      msg_lb.Tag := 14;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 14 then begin
      msg_lb.Tag := 15;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 15 then begin
      msg_lb.Tag := 16;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 16 then begin
      msg_lb.Tag := 17;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 17 then begin
      msg_lb.Tag := 18;
      msg_lb.Caption := 'Shuting Down!';
    end else if msg_lb.Tag = 18 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       snd3_ck := False;
       ShutDown3_ck := False;
       alarm3_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(ShutDown); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -P now'); {$ENDIF}
    end //Sound & Shut Down END.

    else if (msg_lb.Tag = 1) and (Restart3_ck = True) and (snd3_ck = True) then begin //Sound & Restart
      msg_lb.Tag := 19;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 19 then begin
      msg_lb.Tag := 20;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 20 then begin
      msg_lb.Tag := 21;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 21 then begin
      msg_lb.Tag := 22;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 22 then begin
      msg_lb.Tag := 23;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 23 then begin
      msg_lb.Tag := 24;
      msg_lb.Caption := 'Rebooting!';
    end else if msg_lb.Tag = 24 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       snd3_ck := False;
       Restart3_ck := False;
       alarm3_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(Reboot); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -r now'); {$ENDIF}
    end //Sound & Restart END.

    else if (msg_lb.Tag = 1) and (Sleep3_ck = True) and (snd3_ck = True) then begin //Sound & Sleep
      msg_lb.Tag := 43;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 43 then begin
      msg_lb.Tag := 44;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 44 then begin
      msg_lb.Tag := 45;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 45 then begin
      msg_lb.Tag := 46;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 46 then begin
      msg_lb.Tag := 47;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 47 then begin
      msg_lb.Tag := 48;
      msg_lb.Caption := 'LogOFF...';
    end else if msg_lb.Tag = 48 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       snd3_ck := False;
       Sleep3_ck := False;
       alarm3_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(LogOff); {$ENDIF}
       {$IFDEF Linux} fpSystem(set_form.Form2.cmd_tx.Text); {$ENDIF}
    end //Sound & Sleep END.

    else if (msg_lb.Tag = 1) and (ShutDown3_ck = True) then begin //Shut Down
      msg_lb.Tag := 25;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 25 then begin
      msg_lb.Tag := 26;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 26 then begin
      msg_lb.Tag := 27;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 27 then begin
      msg_lb.Tag := 28;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 28 then begin
      msg_lb.Tag := 29;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 29 then begin
      msg_lb.Tag := 30;
      msg_lb.Caption := 'Shuting Down!';
    end else if msg_lb.Tag = 30 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       snd3_ck := False;
       ShutDown3_ck := False;
       alarm3_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(ShutDown); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -P now'); {$ENDIF}
    end //Shut Down END.

    else if (msg_lb.Tag = 1) and (Restart3_ck = True) then begin //Restart
      msg_lb.Tag := 31;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 31 then begin
      msg_lb.Tag := 32;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 32 then begin
      msg_lb.Tag := 33;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 33 then begin
      msg_lb.Tag := 34;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 34 then begin
      msg_lb.Tag := 35;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 35 then begin
      msg_lb.Tag := 36;
      msg_lb.Caption := 'Rebooting!';
    end else if msg_lb.Tag = 36 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       snd3_ck := False;
       Restart3_ck := False;
       alarm3_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(Reboot); {$ENDIF}
       {$IFDEF Linux} fpSystem('/sbin/shutdown -r now'); {$ENDIF}
    end //Restart END.

    else if (msg_lb.Tag = 1) and (Sleep3_ck = True) then begin //Sleep
      msg_lb.Tag := 37;
      msg_lb.Caption := 'starting ... 1';
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 37 then begin
      msg_lb.Tag := 38;
      msg_lb.Caption := 'starting ... 2';
    end else if msg_lb.Tag = 38 then begin
      msg_lb.Tag := 39;
      msg_lb.Caption := 'starting ... 3';
    end else if msg_lb.Tag = 39 then begin
      msg_lb.Tag := 40;
      msg_lb.Caption := 'starting ... 4';
    end else if msg_lb.Tag = 40 then begin
      msg_lb.Tag := 41;
      msg_lb.Caption := 'starting ... 5';
    end else if msg_lb.Tag = 41 then begin
      msg_lb.Tag := 42;
      msg_lb.Caption := 'LogOFF';
    end else if msg_lb.Tag = 42 then begin
       msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       snd3_ck := False;
       Sleep3_ck := False;
       alarm3_Time := '';
       Save_CFG;
       {$IFDEF WINDOWS} ExitWin(LogOff); {$ENDIF}
       {$IFDEF Linux} fpSystem(set_form.Form2.cmd_tx.Text); {$ENDIF}
    end //Sleep END.

    else if (msg_lb.Tag = 1) and (snd3_ck = True) then begin //Sound
      msg_lb.Tag := 8;
      msg_lb.Caption := 'Beep !';
      msg_lb.Visible := True;
      {$IFDEF WINDOWS} sndPlaySound('alarm_beep.wav', snd_Async); {$ENDIF}
      {$IFDEF Linux} PlaySound; {$ENDIF}
    end else if msg_lb.Tag = 8 then begin
      msg_lb.Tag := 9;
      msg_lb.Visible := False;
    end else if msg_lb.Tag = 9 then begin
      msg_lb.Tag := 10;
      msg_lb.Visible := True;
    end else if msg_lb.Tag = 10 then begin
      msg_lb.Visible := False;
       msg_lb.Tag := 0;
       Label3.Caption := '3. _________________________';
       Label3.Tag := 0;
       snd3_ck := False;
       alarm3_Time := '';
       Save_CFG;
    end; //Sound END.
   end; //alarm 3 end
 end;

end;

procedure TForm1.FormatTM;
begin
 if (h >= 0) and (h < 10) then begin
  hh := '0' + IntToStr(h);
 end else begin
   hh := IntToStr(h);
 end;

 if (m >= 0) and (m < 10) then begin
  mm := '0' + IntToStr(m);
 end else begin
   mm := IntToStr(m);
 end;

 if (s >= 0) and (s < 10) then begin
  ss := '0' + IntToStr(s);
 end else begin
   ss := IntToStr(s);
 end;
end;

procedure TForm1.Load_CFG;
var
  F: TextFile;
  S: String;
  linux_USER_Path: String;
begin
 linux_USER_Path := (GetUserDir + '/.local/share/alclock');

  if FileExists({$IFDEF WINDOWS}'config.txt'{$ENDIF} {$IFDEF Linux} linux_USER_Path + '/config.file' {$ENDIF}) then
   begin
    AssignFile(F, {$IFDEF WINDOWS}'config.txt'{$ENDIF} {$IFDEF Linux} linux_USER_Path + '/config.file' {$ENDIF});
    Reset(F);

    ReadLn(F, S);
      if S = '[0 Time]' then begin TimeZone := 12; end
      else if S = '[+1 Time]' then begin TimeZone := 13; end
      else if S = '[+2 Time]' then begin TimeZone := 14; end
      else if S = '[+3 Time]' then begin TimeZone := 15; end
      else if S = '[+4 Time]' then begin TimeZone := 16; end
      else if S = '[+5 Time]' then begin TimeZone := 17; end
      else if S = '[+6 Time]' then begin TimeZone := 18; end
      else if S = '[+7 Time]' then begin TimeZone := 19; end
      else if S = '[+8 Time]' then begin TimeZone := 20; end
      else if S = '[+9 Time]' then begin TimeZone := 21; end
      else if S = '[+10 Time]' then begin TimeZone := 22; end
      else if S = '[+11 Time]' then begin TimeZone := 23; end
      else if S = '[+12 Time]' then begin TimeZone := 24; end
      else if S = '[-1 Time]' then begin TimeZone := 11; end
      else if S = '[-2 Time]' then begin TimeZone := 10; end
      else if S = '[-3 Time]' then begin TimeZone := 9; end
      else if S = '[-4 Time]' then begin TimeZone := 8; end
      else if S = '[-5 Time]' then begin TimeZone := 7; end
      else if S = '[-6 Time]' then begin TimeZone := 6; end
      else if S = '[-7 Time]' then begin TimeZone := 5; end
      else if S = '[-8 Time]' then begin TimeZone := 4; end
      else if S = '[-9 Time]' then begin TimeZone := 3; end
      else if S = '[-10 Time]' then begin TimeZone := 2; end
      else if S = '[-11 Time]' then begin TimeZone := 1; end
      else if S = '[-12 Time]' then begin TimeZone := 0; end
      else begin ShowMessage('TimeZone data err..'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin snd_ck := True; Label1.Tag := 1; end else if (StrToInt(S) = 0) then begin snd_ck := False; end else begin ShowMessage('Alarm 1 Sound line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin ShutDown_ck := True; Label1.Tag := 1; end else if (StrToInt(S) = 0) then begin ShutDown_ck := False; end else begin ShowMessage('Alarm 1 ShutDown line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin Restart_ck := True; Label1.Tag := 1; end else if (StrToInt(S) = 0) then begin Restart_ck := False; end else begin ShowMessage('Alarm 1 Restart line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin Sleep_ck := True; Label1.Tag := 1; end else if (StrToInt(S) = 0) then begin Sleep_ck := False; end else begin ShowMessage('Alarm 1 LogOff line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin call_ck := True; Label1.Tag := 1; end else if (StrToInt(S) = 0) then begin call_ck := False; end else begin ShowMessage('Alarm 1 call line err...'); end;

    ReadLn(F, S);
      Label1.Caption := S;
    ReadLn(F, S);
      pr_path1 := S;

   // Alarm 1 Liste END.

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin snd2_ck := True; Label2.Tag := 1; end else if (StrToInt(S) = 0) then begin snd2_ck := False; end else begin ShowMessage('Alarm 2 Sound line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin ShutDown2_ck := True; Label2.Tag := 1; end else if (StrToInt(S) = 0) then begin ShutDown2_ck := False; end else begin ShowMessage('Alarm 2 ShutDown line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin Restart2_ck := True; Label2.Tag := 1; end else if (StrToInt(S) = 0) then begin Restart2_ck := False; end else begin ShowMessage('Alarm 2 Restart line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin Sleep2_ck := True; Label2.Tag := 1; end else if (StrToInt(S) = 0) then begin Sleep2_ck := False; end else begin ShowMessage('Alarm 2 LogOff line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin call2_ck := True; Label2.Tag := 1; end else if (StrToInt(S) = 0) then begin call2_ck := False; end else begin ShowMessage('Alarm 2 call line err...'); end;

    ReadLn(F, S);
      Label2.Caption := S;
    ReadLn(F, S);
      pr_path2 := S;

   // Alarm 2 Liste END.

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin snd3_ck := True; Label3.Tag := 1; end else if (StrToInt(S) = 0) then begin snd3_ck := False; end else begin ShowMessage('Alarm 3 Sound line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin ShutDown3_ck := True; Label3.Tag := 1; end else if (StrToInt(S) = 0) then begin ShutDown3_ck := False; end else begin ShowMessage('Alarm 3 ShutDown line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin Restart3_ck := True; Label3.Tag := 1; end else if (StrToInt(S) = 0) then begin Restart3_ck := False; end else begin ShowMessage('Alarm 3 Restart line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin Sleep3_ck := True; Label3.Tag := 1; end else if (StrToInt(S) = 0) then begin Sleep3_ck := False; end else begin ShowMessage('Alarm 3 LogOff line err...'); end;

    ReadLn(F, S);
      if (StrToInt(S) = 1) then begin call3_ck := True; Label3.Tag := 1; end else if (StrToInt(S) = 0) then begin call3_ck := False; end else begin ShowMessage('Alarm 3 call line err...'); end;

    ReadLn(F, S);
      Label3.Caption := S;
    ReadLn(F, S);
      pr_path3 := S;

   // Alarm 3 Liste END.

    ReadLn(F, S);
     alarm1_Time := S;
    ReadLn(F, S);
     alarm2_Time := S;
    ReadLn(F, S);
     alarm3_Time := S;

    CloseFile(F);
   end
  else begin
    {$IFDEF WINDOWS} ShowMessage('config.txt file not found'); {$ENDIF}
    {$IFDEF Linux} ShowMessage('config.file file not found'); {$ENDIF}
  end;

 { ===================== }

 if FileExists({$IFDEF WINDOWS}'clock_cfg.txt'{$ENDIF} {$IFDEF Linux} linux_USER_Path + '/clock_cfg.file' {$ENDIF}) then
   begin
    AssignFile(F, {$IFDEF WINDOWS}'clock_cfg.txt'{$ENDIF} {$IFDEF Linux} linux_USER_Path + '/clock_cfg.file' {$ENDIF});

    Reset(F);
    ReadLn(F, S);
    if S = '[cl_ver.1]' then begin
     ReadLn(F, S);  //form coordinates:

     ReadLn(F, S);
     Form1.Top := StrToInt(S);
     ReadLn(F, S);
     Form1.Left := StrToInt(S);


     {$IFDEF Linux}
     ReadLn(F, S);  //linux logoff command:

     ReadLn(F, S);
     linux_logoff_cmd := S;
     {$ENDIF}
    end else begin
       AssignFile(F, {$IFDEF WINDOWS}'clock_cfg.txt'{$ENDIF} {$IFDEF Linux} linux_USER_Path + '/clock_cfg.file' {$ENDIF});
        Rewrite(F);
        WriteLn(F, '[cl_ver.1]');
        WriteLn(F, 'form coordinates:');
        WriteLn(F, '25');
        WriteLn(F, '40');  {$IFDEF Linux}
        WriteLn(F, 'linux logoff command:');
        WriteLn(F, linux_logoff_cmd); {$ENDIF}
       CloseFile(F);
    end;

    CloseFile(F);
   end
  else begin
    {$IFDEF WINDOWS} ShowMessage('clock_cfg.txt file not found'); {$ENDIF}
    {$IFDEF Linux} ShowMessage('clock_cfg.file file not found'); {$ENDIF}

       AssignFile(F, {$IFDEF WINDOWS}'clock_cfg.txt'{$ENDIF} {$IFDEF Linux} linux_USER_Path + '/clock_cfg.file' {$ENDIF});
        Rewrite(F);
        WriteLn(F, '[cl_ver.1]');
        WriteLn(F, 'form coordinates:');
        WriteLn(F, '25');
        WriteLn(F, '40');  {$IFDEF Linux}
        WriteLn(F, 'linux logoff command:');
        WriteLn(F, linux_logoff_cmd); {$ENDIF}
       CloseFile(F);
  end;
end;

procedure TForm1.Save_CFG;
var
  F: TextFile;
  S: String;
  linux_USER_Path: String;
begin
 linux_USER_Path := (GetUserDir + '/.local/share/alclock');

 AssignFile(F, {$IFDEF WINDOWS}'config.txt'{$ENDIF} {$IFDEF Linux} linux_USER_Path + '/config.file' {$ENDIF});
   Rewrite(F);

   if TimeZone = 12 then begin S := '[0 Time]'; end
   else if TimeZone = 13 then begin S := '[+1 Time]'; end
   else if TimeZone = 14 then begin S := '[+2 Time]'; end
   else if TimeZone = 15 then begin S := '[+3 Time]'; end
   else if TimeZone = 16 then begin S := '[+4 Time]'; end
   else if TimeZone = 17 then begin S := '[+5 Time]'; end
   else if TimeZone = 18 then begin S := '[+6 Time]'; end
   else if TimeZone = 19 then begin S := '[+7 Time]'; end
   else if TimeZone = 20 then begin S := '[+8 Time]'; end
   else if TimeZone = 21 then begin S := '[+9 Time]'; end
   else if TimeZone = 22 then begin S := '[+10 Time]'; end
   else if TimeZone = 23 then begin S := '[+11 Time]'; end
   else if TimeZone = 24 then begin S := '[+12 Time]'; end
   else if TimeZone = 11 then begin S := '[-1 Time]'; end
   else if TimeZone = 10 then begin S := '[-2 Time]'; end
   else if TimeZone = 9 then begin S := '[-3 Time]'; end
   else if TimeZone = 8 then begin S := '[-4 Time]'; end
   else if TimeZone = 7 then begin S := '[-5 Time]'; end
   else if TimeZone = 6 then begin S := '[-6 Time]'; end
   else if TimeZone = 5 then begin S := '[-7 Time]'; end
   else if TimeZone = 4 then begin S := '[-8 Time]'; end
   else if TimeZone = 3 then begin S := '[-9 Time]'; end
   else if TimeZone = 2 then begin S := '[-10 Time]'; end
   else if TimeZone = 1 then begin S := '[-11 Time]'; end
   else if TimeZone = 0 then begin S := '[-12 Time]'; end;
   WriteLn(F, S);

   if snd_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if ShutDown_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if Restart_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if Sleep_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if call_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
    S := Label1.Caption;
   WriteLn(F, S);
    S := pr_path1;
   WriteLn(F, S);

   if snd2_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if ShutDown2_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if Restart2_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if Sleep2_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if call2_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
    S := Label2.Caption;
   WriteLn(F, S);
    S := pr_path2;
   WriteLn(F, S);

   if snd3_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if ShutDown3_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if Restart3_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if Sleep3_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
   if call3_ck = True then begin S := '1'; end else begin S := '0'; end;
   WriteLn(F, S);
    S := Label3.Caption;
   WriteLn(F, S);
    S := pr_path3;
   WriteLn(F, S);

    S := alarm1_Time;
   WriteLn(F, S);
    S := alarm2_Time;
   WriteLn(F, S);
    S := alarm3_Time;
   WriteLn(F, S);

 CloseFile(F);

 AssignFile(F, {$IFDEF WINDOWS}'clock_cfg.txt'{$ENDIF} {$IFDEF Linux} linux_USER_Path + '/clock_cfg.file' {$ENDIF});
  Rewrite(F);
  WriteLn(F, '[cl_ver.1]');
  WriteLn(F, 'form coordinates:');
  WriteLn(F, IntToStr(Form1.Top));
  WriteLn(F, IntToStr(Form1.Left)); {$IFDEF Linux}
  WriteLn(F, 'linux logoff command:');
  WriteLn(F, set_form.Form2.cmd_tx.Text); {$ENDIF}
 CloseFile(F);
end;

end.

