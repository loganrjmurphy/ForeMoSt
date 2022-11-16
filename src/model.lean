import lacu
import Architectural.lang

open LANG PORTS tactic 

local infix ` OR `:50 := LANG.disj 
local infix ` & `:50 := LANG.conj 

@[reducible]
def MODEL : ArchitectureWithContracts LANG LACU :=
 { subs := LACU_ARCH_MODEL.subs,
  delegation := LACU_ARCH_MODEL.delegation,
  parent := {Contract .
                A := ((atom fault_armPositionAngle1_LACU).neg OR(atom fault_armPositionAngle2_LACU).neg&(atom
                               fault_LAAPRequest_LACU).neg&(atom fault_operatorControlLever_LACU).neg&(atom
                           fault_groundSpeed_LACU).neg).always,
                G := (atom fault_PWMFlow_LACU).neg.always},
  contracts := toMap
                    [(armPosition,
                       {Contract .
                        A := ((atom fault_input2_armPosition).neg OR(atom fault_input1_armPosition).neg).always,
                        G := (atom fault_output_armPosition).neg.always}), (armController,
                       {Contract .
                        A := ((atom fault_angleSensor_armController).neg&(atom fault_LAAPActive_armController).neg&(atom
                                     fault_LAAPFlow_armController).neg&(atom
                                   fault_operatorControlLever_armController).neg).always,
                        G := (atom fault_armFlow_armController).neg.always}), (LAAP,
                       {Contract .
                        A := ((atom fault_LAAPRequest_LAAP).neg&(atom fault_operatorControlLever_LAAP).neg).always,
                        G := ((atom fault_LAAPFlow_LAAP).neg&(atom fault_LAAPActive_LAAP).neg).always})],
     all_components := by {unfold LACU_ARCH_MODEL, auto_all_comps,},
  all_components := by {unfold LACU_ARCH_MODEL, auto_all_comps,}}

