unit set_form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Math;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    call_path: TEdit;
    cmd_tx: TEdit;
    cmd_lb: TLabel;
    path_name: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  Result: integer;

  snd_ck,ShutDown_ck,Restart_ck,Sleep_ck,call_ck: Boolean;
  snd2_ck,ShutDown2_ck,Restart2_ck,Sleep2_ck,call2_ck: Boolean;
  snd3_ck,ShutDown3_ck,Restart3_ck,Sleep3_ck,call3_ck: Boolean;

implementation
uses cl_Form;

{$R *.lfm}

{ TForm2 }

procedure TForm2.CheckBox2Change(Sender: TObject);
begin
 if CheckBox2.Checked = True then begin

  if CheckBox3.Checked = True then begin
    CheckBox3.Checked := False;
  end;
  if CheckBox4.Checked = True then begin
    CheckBox4.Checked := False;
  end;
  if CheckBox5.Checked = True then begin
    CheckBox5.Checked := False;
  end;
  call_path.Enabled := False;
  path_name.Enabled := False;
 end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if CheckBox1.Checked = True then begin
   cl_Form.snd_ck := True;
   Form2.Tag := 1;
  end;

  if CheckBox2.Checked = True then begin
   cl_Form.ShutDown_ck := True;
   Form2.Tag := 1;
  end else if CheckBox3.Checked = True then begin
   cl_Form.Restart_ck := True;
   Form2.Tag := 1;
  end else if CheckBox4.Checked = True then begin
   cl_Form.Sleep_ck := True;
   Form2.Tag := 1;
  end else if CheckBox5.Checked = True then begin
   cl_Form.call_ck := True;
   Form2.Tag := 1;
  end;

  if Form2.Tag = 1 then begin
    Form2.Tag := 0;


      if cl_Form.Form1.Label1.Tag = 0 then begin
        if (CheckBox1.Checked = True) and (CheckBox5.Checked = True) then begin
         cl_Form.Form1.Label1.Caption := '1. Play alarm sound and call ' + path_name.Text + ' at ' + Edit1.Text + ':' + Edit2.Text;
         snd_ck := True;
         call_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.pr_path1 := call_path.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end else if CheckBox5.Checked = True then begin
         cl_Form.Form1.Label1.Caption := '1. call ' + path_name.Text + ' at ' + Edit1.Text + ':' + Edit2.Text;
         call_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.pr_path1 := call_path.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end else if CheckBox1.Checked = True then begin
         cl_Form.Form1.Label1.Caption := '1. Play alarm sound at ' + Edit1.Text + ':' + Edit2.Text;
         snd_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end;

        if (CheckBox1.Checked = True) and (CheckBox2.Checked = True) then begin
         cl_Form.Form1.Label1.Caption := '1. Play alarm sound and Shut Down PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd_ck := True;
         ShutDown_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end else if (CheckBox1.Checked = True) and (CheckBox3.Checked = True) then begin
         cl_Form.Form1.Label1.Caption := '1. Play alarm sound and Restart PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd_ck := True;
         Restart_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end else if (CheckBox1.Checked = True) and (CheckBox4.Checked = True) then begin
         cl_Form.Form1.Label1.Caption := '1. Play alarm sound and LogOff ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd_ck := True;
         Sleep_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end

        else if CheckBox2.Checked = True then begin
         cl_Form.Form1.Label1.Caption := '1. Shut Down PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         ShutDown_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end else if CheckBox3.Checked = True then begin
         cl_Form.Form1.Label1.Caption := '1. Restart PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         Restart_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end else if CheckBox4.Checked = True then begin
         cl_Form.Form1.Label1.Caption := '1. LogOff ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         Sleep_ck := True;
         cl_Form.alarm1_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label1.Tag := 1;
        end;

        cl_Form.Form1.Label1.Tag := 1;

      end //label 1 end

      else if (cl_Form.Form1.Label1.Tag = 1) and (cl_Form.Form1.Label2.Tag = 0) then begin //label 2
            if ((Edit1.Text + ':' + Edit2.Text) = cl_Form.alarm1_Time) then begin
             if StrToInt(Edit2.Text) = 59 then begin
              Edit1.Tag := StrToInt(Edit1.Text);
              Edit1.Text := IntToStr(Edit1.Tag + 1);
             end;
            Edit2.Tag := StrToInt(Edit2.Text);
            Edit2.Text := IntToStr(Edit2.Tag + 1);
            end;
        if (CheckBox1.Checked = True) and (CheckBox5.Checked = True) then begin
         cl_Form.Form1.Label2.Caption := '2. Play alarm sound and call ' + path_name.Text + ' at ' + Edit1.Text + ':' + Edit2.Text;
         snd2_ck := True;
         call2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.pr_path2 := call_path.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end else if CheckBox5.Checked = True then begin
         cl_Form.Form1.Label2.Caption := '2. call ' + path_name.Text + ' at ' + Edit1.Text + ':' + Edit2.Text;
         call2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.pr_path2 := call_path.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end else if CheckBox1.Checked = True then begin
         cl_Form.Form1.Label2.Caption := '2. Play alarm sound at ' + Edit1.Text + ':' + Edit2.Text;
         snd2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end;

        if (CheckBox1.Checked = True) and (CheckBox2.Checked = True) then begin
         cl_Form.Form1.Label2.Caption := '2. Play alarm sound and Shut Down PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd2_ck := True;
         ShutDown2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end else if (CheckBox1.Checked = True) and (CheckBox3.Checked = True) then begin
         cl_Form.Form1.Label2.Caption := '2. Play alarm sound and Restart PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd2_ck := True;
         Restart2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end else if (CheckBox1.Checked = True) and (CheckBox4.Checked = True) then begin
         cl_Form.Form1.Label2.Caption := '2. Play alarm sound and LogOff ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd2_ck := True;
         Sleep2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end

        else if CheckBox2.Checked = True then begin
         cl_Form.Form1.Label2.Caption := '2. Shut Down PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         ShutDown2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end else if CheckBox3.Checked = True then begin
         cl_Form.Form1.Label2.Caption := '2. Restart PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         Restart2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end else if CheckBox4.Checked = True then begin
         cl_Form.Form1.Label2.Caption := '2. LogOff ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         Sleep2_ck := True;
         cl_Form.alarm2_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label2.Tag := 1;
        end;

        cl_Form.Form1.Label2.Tag := 1;

      end //label 2 end

      else if (cl_Form.Form1.Label1.Tag = 1) and (cl_Form.Form1.Label2.Tag = 1) and (cl_Form.Form1.Label3.Tag = 0) then begin //label 3
            if ((Edit1.Text + ':' + Edit2.Text) = cl_Form.alarm1_Time) or ((Edit1.Text + ':' + Edit2.Text) = cl_Form.alarm2_Time) then begin
             if StrToInt(Edit2.Text) = 59 then begin
              Edit1.Tag := StrToInt(Edit1.Text);
              Edit1.Text := IntToStr(Edit1.Tag + 1);
             end;
            Edit2.Tag := StrToInt(Edit2.Text);
            Edit2.Text := IntToStr(Edit2.Tag + 2);
            end;
        if (CheckBox1.Checked = True) and (CheckBox5.Checked = True) then begin
         cl_Form.Form1.Label3.Caption := '3. Play alarm sound and call ' + path_name.Text + ' at ' + Edit1.Text + ':' + Edit2.Text;
         snd3_ck := True;
         call3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.pr_path3 := call_path.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end else if CheckBox5.Checked = True then begin
         cl_Form.Form1.Label3.Caption := '3. call ' + path_name.Text + ' at ' + Edit1.Text + ':' + Edit2.Text;
         call3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.pr_path3 := call_path.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end else if CheckBox1.Checked = True then begin
         cl_Form.Form1.Label3.Caption := '3. Play alarm sound at ' + Edit1.Text + ':' + Edit2.Text;
         snd3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end;

        if (CheckBox1.Checked = True) and (CheckBox2.Checked = True) then begin
         cl_Form.Form1.Label3.Caption := '3. Play alarm sound and Shut Down PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd3_ck := True;
         ShutDown3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end else if (CheckBox1.Checked = True) and (CheckBox3.Checked = True) then begin
         cl_Form.Form1.Label3.Caption := '3. Play alarm sound and Restart PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd3_ck := True;
         Restart3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end else if (CheckBox1.Checked = True) and (CheckBox4.Checked = True) then begin
         cl_Form.Form1.Label3.Caption := '3. Play alarm sound and LogOff ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         snd3_ck := True;
         Sleep3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end

        else if CheckBox2.Checked = True then begin
         cl_Form.Form1.Label3.Caption := '3. Shut Down PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         ShutDown3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end else if CheckBox3.Checked = True then begin
         cl_Form.Form1.Label3.Caption := '3. Restart PC ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         Restart3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end else if CheckBox4.Checked = True then begin
         cl_Form.Form1.Label3.Caption := '3. LogOff ' + 'at ' + Edit1.Text + ':' + Edit2.Text;
         Sleep3_ck := True;
         cl_Form.alarm3_Time := Edit1.Text + ':' + Edit2.Text;
         cl_Form.Form1.Label3.Tag := 1;
        end;

        cl_Form.Form1.Label3.Tag := 1;

      end; //label 3 end

        Form2.Hide ;
        cl_Form.Form1.Pull_data;
        Edit1.Text := '00';
        Edit2.Text := '00';
        {$IFDEF WINDOWS}
          Randomize;
          Result := RandomRange(1,5);
           if Result = 1 then begin
            call_path.Text := 'C:\Windows\System32\cmd.exe';
            path_name.Text := 'Command Promt';
           end else if Result = 2 then begin
            call_path.Text := 'C:\Windows\System32\cleanmgr.exe';
            path_name.Text := 'Disk Cleanup';
           end else if Result = 3 then begin
            call_path.Text := 'C:\Windows\System32\control.exe';
            path_name.Text := 'Control Panel';
           end else if Result = 4 then begin
            call_path.Text := 'C:\Windows\System32\osk.exe';
            path_name.Text := 'Screen Keyboard';
           end else if Result = 5 then begin
            call_path.Text := 'C:\Windows\System32\Defrag.exe';
            path_name.Text := 'Disk Defragmenter';
           end;
        {$ENDIF}
        CheckBox1.Checked := False;
        CheckBox2.Checked := False;
        CheckBox3.Checked := False;
        CheckBox4.Checked := False;
        CheckBox5.Checked := False;

  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
 h: Byte;
 m: Byte;
 r: Byte;
begin
 if Edit1.Text = '00' then begin h := 0; end
 else if Edit1.Text = '01' then begin h := 1; end
 else if Edit1.Text = '02' then begin h := 2; end
 else if Edit1.Text = '03' then begin h := 3; end
 else if Edit1.Text = '04' then begin h := 4; end
 else if Edit1.Text = '05' then begin h := 5; end
 else if Edit1.Text = '06' then begin h := 6; end
 else if Edit1.Text = '07' then begin h := 7; end
 else if Edit1.Text = '08' then begin h := 8; end
 else if Edit1.Text = '09' then begin h := 9; end
 else begin
  h := StrToInt(Edit1.Text);
 end;

 if Edit2.Text = '00' then begin m := 0; end
 else if Edit2.Text = '01' then begin m := 1; end
 else if Edit2.Text = '02' then begin m := 2; end
 else if Edit2.Text = '03' then begin m := 3; end
 else if Edit2.Text = '04' then begin m := 4; end
 else if Edit2.Text = '05' then begin m := 5; end
 else if Edit2.Text = '06' then begin m := 6; end
 else if Edit2.Text = '07' then begin m := 7; end
 else if Edit2.Text = '08' then begin m := 8; end
 else if Edit2.Text = '09' then begin m := 9; end
 else begin
  m := StrToInt(Edit2.Text);
 end;

 r := m + 5;

 if r > 59 then begin
  h := h + 1;
  m := r - 60;
   if h = 24 then begin
    h := 0;
   end;

  if h = 0 then begin Edit1.Text := '00'; end
  else if h = 1 then begin Edit1.Text := '01'; end
  else if h = 2 then begin Edit1.Text := '02'; end
  else if h = 3 then begin Edit1.Text := '03'; end
  else if h = 4 then begin Edit1.Text := '04'; end
  else if h = 5 then begin Edit1.Text := '05'; end
  else if h = 6 then begin Edit1.Text := '06'; end
  else if h = 7 then begin Edit1.Text := '07'; end
  else if h = 8 then begin Edit1.Text := '08'; end
  else if h = 9 then begin Edit1.Text := '09'; end
  else begin
   Edit1.Text := IntToStr(h);
  end;

  if m = 0 then begin Edit2.Text := '00'; end
  else if m = 1 then begin Edit2.Text := '01'; end
  else if m = 2 then begin Edit2.Text := '02'; end
  else if m = 3 then begin Edit2.Text := '03'; end
  else if m = 4 then begin Edit2.Text := '04'; end
  else if m = 5 then begin Edit2.Text := '05'; end
  else if m = 6 then begin Edit2.Text := '06'; end
  else if m = 7 then begin Edit2.Text := '07'; end
  else if m = 8 then begin Edit2.Text := '08'; end
  else if m = 9 then begin Edit2.Text := '09'; end
  else begin
   Edit2.Text := IntToStr(m);
  end;
 end else begin
  if r = 0 then begin Edit2.Text := '00'; end
  else if r = 1 then begin Edit2.Text := '01'; end
  else if r = 2 then begin Edit2.Text := '02'; end
  else if r = 3 then begin Edit2.Text := '03'; end
  else if r = 4 then begin Edit2.Text := '04'; end
  else if r = 5 then begin Edit2.Text := '05'; end
  else if r = 6 then begin Edit2.Text := '06'; end
  else if r = 7 then begin Edit2.Text := '07'; end
  else if r = 8 then begin Edit2.Text := '08'; end
  else if r = 9 then begin Edit2.Text := '09'; end
  else begin
   Edit2.Text := IntToStr(r);
  end;
 end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
 h: Byte;
 m: Byte;
 r: Byte;
begin
 if Edit1.Text = '00' then begin h := 0; end
 else if Edit1.Text = '01' then begin h := 1; end
 else if Edit1.Text = '02' then begin h := 2; end
 else if Edit1.Text = '03' then begin h := 3; end
 else if Edit1.Text = '04' then begin h := 4; end
 else if Edit1.Text = '05' then begin h := 5; end
 else if Edit1.Text = '06' then begin h := 6; end
 else if Edit1.Text = '07' then begin h := 7; end
 else if Edit1.Text = '08' then begin h := 8; end
 else if Edit1.Text = '09' then begin h := 9; end
 else begin
  h := StrToInt(Edit1.Text);
 end;

 if Edit2.Text = '00' then begin m := 0; end
 else if Edit2.Text = '01' then begin m := 1; end
 else if Edit2.Text = '02' then begin m := 2; end
 else if Edit2.Text = '03' then begin m := 3; end
 else if Edit2.Text = '04' then begin m := 4; end
 else if Edit2.Text = '05' then begin m := 5; end
 else if Edit2.Text = '06' then begin m := 6; end
 else if Edit2.Text = '07' then begin m := 7; end
 else if Edit2.Text = '08' then begin m := 8; end
 else if Edit2.Text = '09' then begin m := 9; end
 else begin
  m := StrToInt(Edit2.Text);
 end;

 r := m + 15;

 if r > 59 then begin
  h := h + 1;
  m := r - 60;
   if h = 24 then begin
    h := 0;
   end;

  if h = 0 then begin Edit1.Text := '00'; end
  else if h = 1 then begin Edit1.Text := '01'; end
  else if h = 2 then begin Edit1.Text := '02'; end
  else if h = 3 then begin Edit1.Text := '03'; end
  else if h = 4 then begin Edit1.Text := '04'; end
  else if h = 5 then begin Edit1.Text := '05'; end
  else if h = 6 then begin Edit1.Text := '06'; end
  else if h = 7 then begin Edit1.Text := '07'; end
  else if h = 8 then begin Edit1.Text := '08'; end
  else if h = 9 then begin Edit1.Text := '09'; end
  else begin
   Edit1.Text := IntToStr(h);
  end;

  if m = 0 then begin Edit2.Text := '00'; end
  else if m = 1 then begin Edit2.Text := '01'; end
  else if m = 2 then begin Edit2.Text := '02'; end
  else if m = 3 then begin Edit2.Text := '03'; end
  else if m = 4 then begin Edit2.Text := '04'; end
  else if m = 5 then begin Edit2.Text := '05'; end
  else if m = 6 then begin Edit2.Text := '06'; end
  else if m = 7 then begin Edit2.Text := '07'; end
  else if m = 8 then begin Edit2.Text := '08'; end
  else if m = 9 then begin Edit2.Text := '09'; end
  else begin
   Edit2.Text := IntToStr(m);
  end;
 end else begin
  if r = 0 then begin Edit2.Text := '00'; end
  else if r = 1 then begin Edit2.Text := '01'; end
  else if r = 2 then begin Edit2.Text := '02'; end
  else if r = 3 then begin Edit2.Text := '03'; end
  else if r = 4 then begin Edit2.Text := '04'; end
  else if r = 5 then begin Edit2.Text := '05'; end
  else if r = 6 then begin Edit2.Text := '06'; end
  else if r = 7 then begin Edit2.Text := '07'; end
  else if r = 8 then begin Edit2.Text := '08'; end
  else if r = 9 then begin Edit2.Text := '09'; end
  else begin
   Edit2.Text := IntToStr(r);
  end;
 end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
 h: Byte;
 m: Byte;
 r: Byte;
begin
 if Edit1.Text = '00' then begin h := 0; end
 else if Edit1.Text = '01' then begin h := 1; end
 else if Edit1.Text = '02' then begin h := 2; end
 else if Edit1.Text = '03' then begin h := 3; end
 else if Edit1.Text = '04' then begin h := 4; end
 else if Edit1.Text = '05' then begin h := 5; end
 else if Edit1.Text = '06' then begin h := 6; end
 else if Edit1.Text = '07' then begin h := 7; end
 else if Edit1.Text = '08' then begin h := 8; end
 else if Edit1.Text = '09' then begin h := 9; end
 else begin
  h := StrToInt(Edit1.Text);
 end;

 if Edit2.Text = '00' then begin m := 0; end
 else if Edit2.Text = '01' then begin m := 1; end
 else if Edit2.Text = '02' then begin m := 2; end
 else if Edit2.Text = '03' then begin m := 3; end
 else if Edit2.Text = '04' then begin m := 4; end
 else if Edit2.Text = '05' then begin m := 5; end
 else if Edit2.Text = '06' then begin m := 6; end
 else if Edit2.Text = '07' then begin m := 7; end
 else if Edit2.Text = '08' then begin m := 8; end
 else if Edit2.Text = '09' then begin m := 9; end
 else begin
  m := StrToInt(Edit2.Text);
 end;

 r := m + 45;

 if r > 59 then begin
  h := h + 1;
  m := r - 60;
   if h = 24 then begin
    h := 0;
   end;

  if h = 0 then begin Edit1.Text := '00'; end
  else if h = 1 then begin Edit1.Text := '01'; end
  else if h = 2 then begin Edit1.Text := '02'; end
  else if h = 3 then begin Edit1.Text := '03'; end
  else if h = 4 then begin Edit1.Text := '04'; end
  else if h = 5 then begin Edit1.Text := '05'; end
  else if h = 6 then begin Edit1.Text := '06'; end
  else if h = 7 then begin Edit1.Text := '07'; end
  else if h = 8 then begin Edit1.Text := '08'; end
  else if h = 9 then begin Edit1.Text := '09'; end
  else begin
   Edit1.Text := IntToStr(h);
  end;

  if m = 0 then begin Edit2.Text := '00'; end
  else if m = 1 then begin Edit2.Text := '01'; end
  else if m = 2 then begin Edit2.Text := '02'; end
  else if m = 3 then begin Edit2.Text := '03'; end
  else if m = 4 then begin Edit2.Text := '04'; end
  else if m = 5 then begin Edit2.Text := '05'; end
  else if m = 6 then begin Edit2.Text := '06'; end
  else if m = 7 then begin Edit2.Text := '07'; end
  else if m = 8 then begin Edit2.Text := '08'; end
  else if m = 9 then begin Edit2.Text := '09'; end
  else begin
   Edit2.Text := IntToStr(m);
  end;
 end else begin
  if r = 0 then begin Edit2.Text := '00'; end
  else if r = 1 then begin Edit2.Text := '01'; end
  else if r = 2 then begin Edit2.Text := '02'; end
  else if r = 3 then begin Edit2.Text := '03'; end
  else if r = 4 then begin Edit2.Text := '04'; end
  else if r = 5 then begin Edit2.Text := '05'; end
  else if r = 6 then begin Edit2.Text := '06'; end
  else if r = 7 then begin Edit2.Text := '07'; end
  else if r = 8 then begin Edit2.Text := '08'; end
  else if r = 9 then begin Edit2.Text := '09'; end
  else begin
   Edit2.Text := IntToStr(r);
  end;
 end;
end;

procedure TForm2.CheckBox3Change(Sender: TObject);
begin
 if CheckBox3.Checked = True then begin

  if CheckBox2.Checked = True then begin
    CheckBox2.Checked := False;
  end;
  if CheckBox4.Checked = True then begin
    CheckBox4.Checked := False;
  end;
  if CheckBox5.Checked = True then begin
    CheckBox5.Checked := False;
  end;
  call_path.Enabled := False;
  path_name.Enabled := False;
 end;
end;

procedure TForm2.CheckBox4Change(Sender: TObject);
begin
 if CheckBox4.Checked = True then begin

  if CheckBox2.Checked = True then begin
    CheckBox2.Checked := False;
  end;
  if CheckBox3.Checked = True then begin
    CheckBox3.Checked := False;
  end;
  if CheckBox5.Checked = True then begin
    CheckBox5.Checked := False;
  end;
  call_path.Enabled := False;
  path_name.Enabled := False;
 end;
end;

procedure TForm2.CheckBox5Change(Sender: TObject);
begin
 if CheckBox5.Checked = True then begin

  if CheckBox2.Checked = True then begin
    CheckBox2.Checked := False;
  end;
  if CheckBox3.Checked = True then begin
    CheckBox3.Checked := False;
  end;
  if CheckBox4.Checked = True then begin
    CheckBox4.Checked := False;
  end;
  call_path.Enabled := True;
  path_name.Enabled := True;
 end else begin
    call_path.Enabled := False;
    path_name.Enabled := False;
 end;
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
 if not (Edit1.Text = '') then begin
  Edit1.Tag := StrToInt(Edit1.Text);
    if Edit1.Tag > 23 then begin Edit1.Text := '00' end;
 end;
end;

procedure TForm2.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text = '' then begin Edit1.Text := '00'; end
  else if Edit1.Text = '0' then begin Edit1.Text := '00'; end
  else if Edit1.Text = '1' then begin Edit1.Text := '01'; end
  else if Edit1.Text = '2' then begin Edit1.Text := '02'; end
  else if Edit1.Text = '3' then begin Edit1.Text := '03'; end
  else if Edit1.Text = '4' then begin Edit1.Text := '04'; end
  else if Edit1.Text = '5' then begin Edit1.Text := '05'; end
  else if Edit1.Text = '6' then begin Edit1.Text := '06'; end
  else if Edit1.Text = '7' then begin Edit1.Text := '07'; end
  else if Edit1.Text = '8' then begin Edit1.Text := '08'; end
  else if Edit1.Text = '9' then begin Edit1.Text := '09'; end;
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
 if not (Edit2.Text = '') then begin
  Edit2.Tag := StrToInt(Edit2.Text);
    if Edit2.Tag > 59 then begin Edit2.Text := '00' end;
 end;
end;

procedure TForm2.Edit2Exit(Sender: TObject);
begin
  if Edit2.Text = '' then begin Edit2.Text := '00'; end
  else if Edit2.Text = '0' then begin Edit2.Text := '00'; end
  else if Edit2.Text = '1' then begin Edit2.Text := '01'; end
  else if Edit2.Text = '2' then begin Edit2.Text := '02'; end
  else if Edit2.Text = '3' then begin Edit2.Text := '03'; end
  else if Edit2.Text = '4' then begin Edit2.Text := '04'; end
  else if Edit2.Text = '5' then begin Edit2.Text := '05'; end
  else if Edit2.Text = '6' then begin Edit2.Text := '06'; end
  else if Edit2.Text = '7' then begin Edit2.Text := '07'; end
  else if Edit2.Text = '8' then begin Edit2.Text := '08'; end
  else if Edit2.Text = '9' then begin Edit2.Text := '09'; end;
end;

end.

