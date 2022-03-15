import Architectural.ArchWithContracts
import Architectural.proofObligations

@[derive [fintype, decidable_eq]]
inductive PORTS
| fault_LAAPRequest_LACU
| fault_armPositionAngle1_LACU
| fault_LAAPSetpoint_LAAP
| fault_lockingSwitchPosition_LACU
| fault_LAAPRequest_LAAP
| fault_operatorControlLever_LAAP
| fault_operatorControlLever_LACU
| fault_LAAPFlow_armController
| fault_groundSpeed_LACU
| fault_armDeactivated_armController
| fault_input1_armPosition
| fault_output_armPosition
| fault_LAAPFlow_LAAP
| fault_armPositionAngle2_LACU
| fault_armFlow_armController
| fault_LAAPActive_LAAP
| fault_groundSpeed_armController
| fault_operatorConstrolLever_armController
| fault_LAAPSetpoint_LACU
| fault_PWMFlow_LACU
| fault_angleSensor_armController
| fault_input2_armPosition
| fault_LAAPActive_armController
| fault_angleSensor_LAAP
| fault_groundSpeed_LAAP
open PORTS

def LAAP : Component PORTS := {
  ports := 
    ⟨
      [fault_angleSensor_LAAP,
        fault_LAAPRequest_LAAP,
        fault_LAAPSetpoint_LAAP,
        fault_operatorControlLever_LAAP,
        fault_groundSpeed_LAAP,
        fault_LAAPFlow_LAAP,
      fault_LAAPActive_LAAP]
    ,
    by {dec_trivial}⟩
  }

@[reducible]
def LACU : Component PORTS := {
  ports := {
    val := [
      fault_armPositionAngle1_LACU,
      fault_armPositionAngle2_LACU,
      fault_LAAPRequest_LACU,
      fault_LAAPSetpoint_LACU,
      fault_operatorControlLever_LACU,
      fault_groundSpeed_LACU,
      fault_lockingSwitchPosition_LACU,
      fault_PWMFlow_LACU
    ],
    nodup := by {dec_trivial}
  }
}

@[reducible]
def armPosition : Component PORTS := {
  ports := {
    val := [
      fault_input1_armPosition,
      fault_input2_armPosition,
      fault_output_armPosition
    ],
    nodup := by {dec_trivial}
  }
}

@[reducible]
def armController : Component PORTS := {
  ports := {
    val := [
      fault_angleSensor_armController,
      fault_LAAPFlow_armController,
      fault_LAAPActive_armController,
      fault_operatorConstrolLever_armController,
      fault_groundSpeed_armController,
      fault_armDeactivated_armController,
      fault_armFlow_armController
    ],
    nodup := by {dec_trivial}
  }
}

@[reducible]
def LACU_ARCH_MODEL : Architecture LACU := 
{
  subs := [
    armPosition,
    LAAP,
    armController
  ],
  delegation := 
  [
  (fault_armPositionAngle1_LACU, fault_input1_armPosition), 
  (fault_armPositionAngle2_LACU, fault_input2_armPosition),
  (fault_PWMFlow_LACU, fault_armFlow_armController),
  (fault_output_armPosition, fault_angleSensor_LAAP),
  (fault_output_armPosition, fault_angleSensor_armController),
  (fault_LAAPRequest_LACU, fault_LAAPRequest_LAAP),
  (fault_operatorControlLever_LAAP, fault_operatorControlLever_LACU),
  (fault_LAAPActive_armController, fault_LAAPActive_LAAP),
  (fault_LAAPFlow_armController, fault_LAAPFlow_LAAP),
  (fault_operatorConstrolLever_armController, fault_operatorControlLever_LACU)
  ]
}

theorem distinct_1 : armPosition ≠ armController := by {exact of_to_bool_ff rfl,}
theorem distinct_2 : armPosition ≠ LAAP := by {exact of_to_bool_ff rfl,}
theorem distinct_3 : armController ≠ LAAP := by {exact of_to_bool_ff rfl,}