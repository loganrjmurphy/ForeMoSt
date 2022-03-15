import Architectural.lang 
import Architectural.LACU

open LANG PORTS 

local infix `OR`:50 := LANG.disj 
local infix `&`:50 := LANG.conj  

def LACU_Contract : Contract LANG PORTS := 
{ 
  
  A := always 
       ((neg (atom fault_armPositionAngle1_LACU)) OR
       (neg (atom fault_armPositionAngle2_LACU))) & 
       (neg (atom fault_LAAPRequest_LACU)) & 
       (neg (atom fault_operatorControlLever_LACU)) & 
       (neg (atom fault_groundSpeed_LACU)),


  G := always (neg (atom fault_PWMFlow_LACU)),
  
  }

def LACU_with_Contract : ComponentWithContract LANG PORTS := 
{ports := LACU.ports, C := LACU_Contract}


