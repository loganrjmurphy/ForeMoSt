import LTS

inductive S
| Init
| Infusion_NormalOperation
| BolusRequest
| Wrn_LowReservoir
| Alrm_EmptyReservoir
| ConfirmPause
| InfusionPaused
| PausedStopConfirm
| Alrm_TooLongInfusionPause
| Alrm_LevelTwoHardwareFailure
| ConfirmStop
| CheckDrug
| Alrm_WrongDrug
| ChangeRate
| Alrm_LongWait_ChangeDoseRate
| CheckNewRate
| Alrm_UnsafeNewRate
| InfusionStopped
open S

inductive A
| Cond_2_
| E_RequestBolus_
| Cond_7_1_
| Cond_7_2_
| MCond_6_6_
| No_Label_1
| Cond_6_3_
| E_PauseInfusion_
| E_Cancel__1
| E_ConfirmPauseInfusion_
| E_Cancel__2
| E_ClearAlarm__1
| E_Cancel__3
| E_StopInfusion__1
| x1____MAX_PAUSED_T
| Level_Two_Alarm__1
| Level_Two_Alarm__2
| E_ClearAlarm__2
| E_StopInfusion__2
| E_Cancel__4
| Level_Two_Alarm__3
| E_CheckDrug__1
| Cond_6_5_
| E_CheckDrug__2
| Cond_6_4_
| No_Label_2
| x1____MAX_WAIT_INPUT_T
| E_ChangeDoseRate__1
| E_Cancel__5
| Level_Two_Alarm__4
| Cond_7_4_
| E_ConfirmDoseRate_
| Cond_7_3_
| E_ChangeDoseRate__2
| E_Cancel__6
| Level_Two_Alarm__5
| Cond_6_2__1
| Cond_6_2__2
| E_ConfirmStopInfusion__1
| Level_Two_Alarm__6
| E_StopInfusion__3
| x1____MAX_ALRM_T_1
| E_ConfirmStopInfusion__2
| E_StopInfusion__4
| x1____MAX_ALRM_T_2
| Cond_6_2__3
| Cond_6_2__4
| Cond_6_2__5
| x1____MAX_CHECK_DRUG_T
| E_StopInfusion__5
| E_StopInfusion__6
| E_NewInfusion_
open A

def TR : set (S × A × S) :=
{
  (Init, Cond_2_, Infusion_NormalOperation),
  (Infusion_NormalOperation, E_RequestBolus_, BolusRequest),
  (BolusRequest, Cond_7_1_, Infusion_NormalOperation),
  (BolusRequest, Cond_7_2_, Infusion_NormalOperation),
  (Infusion_NormalOperation, MCond_6_6_, Wrn_LowReservoir),
  (Wrn_LowReservoir, No_Label_1, Infusion_NormalOperation),
  (Infusion_NormalOperation, Cond_6_3_, Alrm_EmptyReservoir),
  (Infusion_NormalOperation, E_PauseInfusion_, ConfirmPause),
  (ConfirmPause, E_Cancel__1, Infusion_NormalOperation),
  (ConfirmPause, E_ConfirmPauseInfusion_, InfusionPaused),
  (InfusionPaused, E_Cancel__2, Infusion_NormalOperation),
  (Alrm_TooLongInfusionPause, E_ClearAlarm__1, Infusion_NormalOperation),
  (PausedStopConfirm, E_Cancel__3, InfusionPaused),
  (InfusionPaused, E_StopInfusion__1, PausedStopConfirm),
  (InfusionPaused, x1____MAX_PAUSED_T, Alrm_TooLongInfusionPause),
  (ConfirmPause, Level_Two_Alarm__1, Alrm_LevelTwoHardwareFailure),
  (Infusion_NormalOperation, Level_Two_Alarm__2, Alrm_LevelTwoHardwareFailure),
  (Alrm_LevelTwoHardwareFailure, E_ClearAlarm__2, Infusion_NormalOperation),
  (Infusion_NormalOperation, E_StopInfusion__2, ConfirmStop),
  (ConfirmStop, E_Cancel__4, Infusion_NormalOperation),
  (ConfirmStop, Level_Two_Alarm__3, Alrm_LevelTwoHardwareFailure),
  (Alrm_EmptyReservoir, E_CheckDrug__1, CheckDrug),
  (CheckDrug, Cond_6_5_, Alrm_WrongDrug),
  (Alrm_WrongDrug, E_CheckDrug__2, CheckDrug),
  (CheckDrug, Cond_6_4_, Infusion_NormalOperation),
  (Alrm_LongWait_ChangeDoseRate, No_Label_2, ChangeRate),
  (ChangeRate, x1____MAX_WAIT_INPUT_T, Alrm_LongWait_ChangeDoseRate),
  (Infusion_NormalOperation, E_ChangeDoseRate__1, ChangeRate),
  (ChangeRate, E_Cancel__5, Infusion_NormalOperation),
  (ChangeRate, Level_Two_Alarm__4, Alrm_LevelTwoHardwareFailure),
  (CheckNewRate, Cond_7_4_, ChangeRate),
  (ChangeRate, E_ConfirmDoseRate_, CheckNewRate),
  (CheckNewRate, Cond_7_3_, Alrm_UnsafeNewRate),
  (Alrm_UnsafeNewRate, E_ChangeDoseRate__2, ChangeRate),
  (Alrm_UnsafeNewRate, E_Cancel__6, Infusion_NormalOperation),
  (Alrm_UnsafeNewRate, Level_Two_Alarm__5, Alrm_LevelTwoHardwareFailure),
  (Alrm_UnsafeNewRate, Cond_6_2__1, InfusionStopped),
  (ConfirmStop, Cond_6_2__2, InfusionStopped),
  (ConfirmStop, E_ConfirmStopInfusion__1, InfusionStopped),
  (InfusionStopped, Level_Two_Alarm__6, Alrm_LevelTwoHardwareFailure),
  (Alrm_LevelTwoHardwareFailure, E_StopInfusion__3, InfusionStopped),
  (Alrm_LevelTwoHardwareFailure, x1____MAX_ALRM_T_1, InfusionStopped),
  (PausedStopConfirm, E_ConfirmStopInfusion__2, InfusionStopped),
  (Alrm_TooLongInfusionPause, E_StopInfusion__4, InfusionStopped),
  (Alrm_TooLongInfusionPause, x1____MAX_ALRM_T_2, InfusionStopped),
  (ConfirmPause, Cond_6_2__3, InfusionStopped),
  (ChangeRate, Cond_6_2__4, InfusionStopped),
  (Infusion_NormalOperation, Cond_6_2__5, InfusionStopped),
  (CheckDrug, x1____MAX_CHECK_DRUG_T, InfusionStopped),
  (Alrm_WrongDrug, E_StopInfusion__5, InfusionStopped),
  (Alrm_EmptyReservoir, E_StopInfusion__6, InfusionStopped),
  (InfusionStopped, E_NewInfusion_, Init)
}

def pump1 : LTS := LTS.mk S A TR

@[instance] def S_to_pump1S : has_coe S (pump1.S) :=⟨id⟩

@[instance] def S_to_form : has_coe pump1.S (formula pump1) :=
⟨λ s, formula.states {s}⟩

@[instance] def S_to_form' : has_coe S (formula pump1) :=
⟨λ s, formula.states {s}⟩

@[instance] def Act_to_form : has_coe A (formula pump1) :=
⟨λ a, formula.acts {a}⟩
