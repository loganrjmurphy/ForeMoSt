import automation.model 
import automation.rpo_fst_tactic
import Architectural.proofObligations

open LANG PORTS 
local infix ` OR `:50 := LANG.disj 
local infix ` & `:50 := LANG.conj 

meta def delegation : list (expr × expr) := [
    (`(fault_armDeactivated_armController), `(fault_lockingSwitchPosition_LACU)),
    (`(fault_operatorControlLever_LACU), `(fault_operatorControlLever_LAAP)),
    (`(fault_operatorControlLever_LACU), `(fault_operatorControlLever_armController)),
    (`(fault_groundSpeed_LACU), `(fault_groundSpeed_LAAP)),
    (`(fault_LAAPFlow_LAAP), `(fault_LAAPFlow_armController)),
    (`(fault_LAAPActive_LAAP),`(fault_LAAPActive_armController)),
    (`(fault_armPositionAngle1_LACU), `(fault_input1_armPosition)),
    (`(fault_output_armPosition), `(fault_angleSensor_armController)),
    (`(fault_LAAPSetpoint_LACU), `(fault_LAAPSetpoint_LAAP)),
    (`(fault_armFlow_armController), `(fault_PWMFlow_LACU)),
    (`(fault_armPositionAngle2_LACU), `(fault_input2_armPosition)),
    (`(fault_groundSpeed_LACU), `(fault_groundSpeed_armController)),
    (`(fault_LAAPRequest_LACU), `(fault_LAAPRequest_LAAP)),
    (`(fault_output_armPosition), `(fault_angleSensor_LAAP))
  ]


meta def foo' : model_info := { del := delegation, comps := [`(armPosition), `(LAAP), `(armController)]}


-- theorem rpo_snd_lacu : RPO_fst MODEL := 
-- by {solve_rpo_fst_new foo',}


theorem rpo_snd_lacu : RPO_snd MODEL := 
begin


solve_rpo_snd_new foo',
-- all_goals {rw fsadfdsa,
-- split,
-- assumption,
-- rw ← asdff,
-- assumption,},
-- {rw fsadfdsa,
--     split,
--       { -- copied from above
--         apply H1_right_1,},
--       {
--         rw ← asdff, 
--         apply H1_right_2,
--       }},
-- {},
  -- {    -- copied from above,
  --       rw [disj_comm_guarded],
  --       apply H1,
  -- },
  -- { 
  --   rw fsadfdsa,
  --   split,
  --     { -- copied from above
  --       apply H1_right_2,},
  --     {
  --       rw ← asdff, 
  --       apply H1_right_1,
  --     }
  -- },
  -- {
  --   rw fsadfdsa,
  --   split,
  --     { -- copied from above
  --       apply H1_right_2,},
  --     {
  --       rw ← asdff, 
  --       apply H1_right_1,
  --     },
  -- },
end 